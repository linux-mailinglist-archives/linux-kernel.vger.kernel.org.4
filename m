Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3386E1B76
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDNFI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNFIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:08:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321CE49C7;
        Thu, 13 Apr 2023 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qLEgxMN6ICWDkmhEIOtkKRgN1aQApj5a/RWNN7sAccc=; b=C37AIqag26MylchCjtcpx9snbv
        wBteBntA0l6QU0vxB9jmY3eJDBs267i5o/HDCU3lG4GuLxJ3bigGdysrGmLoqkCjl0b7UVqZjnbpZ
        FIraSErwhnGaJki8zoWzye4i3HXoNXYm69S/Ho+gKPASSEv3rHrqNz5u+mbTJ13E+Ui++HDpk/XG1
        feNePXCFzO3F7VZyou5mNjSYLbVunw0zfh0KrkhUTmZrvniDJwkeLzDdXlBDJV2kvN7IU/hzRBTqK
        ItpygBp1+cWa3fujjqmv6GevTtfoONvbrkmdrjps47/uesTahEEAzGIFqLlmVhOtxFiX2UAOpnlAq
        lG7Rgm8Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBfq-008KKP-02;
        Fri, 14 Apr 2023 05:08:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [PATCH v3 4/4] module: avoid allocation if module is already present and ready
Date:   Thu, 13 Apr 2023 22:08:36 -0700
Message-Id: <20230414050836.1984746-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414050836.1984746-1-mcgrof@kernel.org>
References: <20230414050836.1984746-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The finit_module() system call can create unnecessary virtual memory
pressure for duplicate modules. This is because load_module() can in
the worse case allocate more than twice the size of a module in virtual
memory. This saves at least a full size of the module in wasted vmalloc
space memory by trying to avoid duplicates as soon as we can validate
the module name in the read module structure.

This can only be an issue if a system is getting hammered with userspace
loading modules. There are two ways to load modules typically on systems,
one is the kernel moduile auto-loading (*request_module*() calls in-kernel)
and the other is things like udev. The auto-loading is in-kernel, but that
pings back to userspace to just call modprobe. We already have a way to
restrict the amount of concurrent kernel auto-loads in a given time, however
that still allows multiple requests for the same module to go through
and force two threads in userspace racing to call modprobe for the same
exact module. Even though libkmod which both modprobe and udev does check
if a module is already loaded prior calling finit_module() races are
still possible and this is clearly evident today when you have multiple
CPUs.

To avoid memory pressure for such stupid cases put a stop gap for them.
The *earliest* we can detect duplicates from the modules side of things
is once we have blessed the module name, sadly after the first vmalloc
allocation. We can check for the module being present *before* a secondary
vmalloc() allocation.

There is a linear relationship between wasted virtual memory bytes and
the number of CPU counts. The reason is that udev ends up racing to call
tons of the same modules for each of the CPUs.

We can see the different linear relationships between wasted virtual
memory and CPU count during after boot in the following graph:

         +----------------------------------------------------------------------------+
    14GB |-+          +            +            +           +           *+          +-|
         |                                                          ****              |
         |                                                       ***                  |
         |                                                     **                     |
    12GB |-+                                                 **                     +-|
         |                                                 **                         |
         |                                               **                           |
         |                                             **                             |
         |                                           **                               |
    10GB |-+                                       **                               +-|
         |                                       **                                   |
         |                                     **                                     |
         |                                   **                                       |
     8GB |-+                               **                                       +-|
waste    |                               **                             ###           |
         |                             **                           ####              |
         |                           **                      #######                  |
     6GB |-+                     ****                    ####                       +-|
         |                      *                    ####                             |
         |                     *                 ####                                 |
         |                *****              ####                                     |
     4GB |-+            **               ####                                       +-|
         |            **             ####                                             |
         |          **           ####                                                 |
         |        **         ####                                                     |
     2GB |-+    **      #####                                                       +-|
         |     *    ####                                                              |
         |    * ####                                                   Before ******* |
         |  **##      +            +            +           +           After ####### |
         +----------------------------------------------------------------------------+
         0            50          100          150         200          250          300
                                          CPUs count

On the y-axis we can see gigabytes of wasted virtual memory during boot
due to duplicate module requests which just end up failing. Trying to
infer the slope this ends up being about ~463 MiB per CPU lost prior
to this patch. After this patch we only loose about ~230 MiB per CPU, for
a total savings of about ~233 MiB per CPU. This is all *just on bootup*!

On a 8vcpu 8 GiB RAM system using kdevops and testing against selftests
kmod.sh -t 0008 I see a saving in the *highest* side of memory
consumption of up to ~ 84 MiB with the Linux kernel selftests kmod
test 0008. With the new stress-ng module test I see a 145 MiB difference
in max memory consumption with 100 ops. The stress-ng module ops tests can be
pretty pathalogical -- it is not realistic, however it was used to
finally successfully reproduce issues which are only reported to happen on
system with over 400 CPUs [0] by just usign 100 ops on a 8vcpu 8 GiB RAM
system. Running out of virtual memory space is no surprise given the
above graph, since at least on x86_64 we're capped at 128 MiB, eventually
we'd hit a series of errors and once can use the above graph to
guestimate when. This of course will vary depending on the features
you have enabled. So for instance, enabling KASAN seems to make this
much worse.

The results with kmod and stress-ng can be observed and visualized below.
The time it takes to run the test is also not affected.

The kmod tests 0008:

The gnuplot is set to a range from 400000 KiB (390 Mib) - 580000 (566 Mib)
given the tests peak around that range.

cat kmod.plot
set term dumb
set output fileout
set yrange [400000:580000]
plot filein with linespoints title "Memory usage (KiB)"

Before:
root@kmod ~ # /data/linux-next/tools/testing/selftests/kmod/kmod.sh -t 0008
root@kmod ~ # free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > log-0008-before.txt ^C
root@kmod ~ # sort -n -r log-0008-before.txt | head -1
528732

So ~516.33 MiB

After:

root@kmod ~ # /data/linux-next/tools/testing/selftests/kmod/kmod.sh -t 0008
root@kmod ~ # free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > log-0008-after.txt ^C

root@kmod ~ # sort -n -r log-0008-after.txt | head -1
442516

So ~432.14 MiB

That's about 84 ~MiB in savings in the worst case. The graphs:

root@kmod ~ # gnuplot -e "filein='log-0008-before.txt'; fileout='graph-0008-before.txt'" kmod.plot
root@kmod ~ # gnuplot -e "filein='log-0008-after.txt';  fileout='graph-0008-after.txt'"  kmod.plot

root@kmod ~ # cat graph-0008-before.txt

  580000 +-----------------------------------------------------------------+
         |       +        +       +       +       +        +       +       |
  560000 |-+                                    Memory usage (KiB) ***A***-|
         |                                                                 |
  540000 |-+                                                             +-|
         |                                                                 |
         |        *A     *AA*AA*A*AA          *A*AA    A*A*A *AA*A*AA*A  A |
  520000 |-+A*A*AA  *AA*A           *A*AA*A*AA     *A*A     A          *A+-|
         |*A                                                               |
  500000 |-+                                                             +-|
         |                                                                 |
  480000 |-+                                                             +-|
         |                                                                 |
  460000 |-+                                                             +-|
         |                                                                 |
         |                                                                 |
  440000 |-+                                                             +-|
         |                                                                 |
  420000 |-+                                                             +-|
         |       +        +       +       +       +        +       +       |
  400000 +-----------------------------------------------------------------+
         0       5        10      15      20      25       30      35      40

root@kmod ~ # cat graph-0008-after.txt

  580000 +-----------------------------------------------------------------+
         |       +        +       +       +       +        +       +       |
  560000 |-+                                    Memory usage (KiB) ***A***-|
         |                                                                 |
  540000 |-+                                                             +-|
         |                                                                 |
         |                                                                 |
  520000 |-+                                                             +-|
         |                                                                 |
  500000 |-+                                                             +-|
         |                                                                 |
  480000 |-+                                                             +-|
         |                                                                 |
  460000 |-+                                                             +-|
         |                                                                 |
         |          *A              *A*A                                   |
  440000 |-+A*A*AA*A  A       A*A*AA    A*A*AA*A*AA*A*AA*A*AA*AA*A*AA*A*AA-|
         |*A           *A*AA*A                                             |
  420000 |-+                                                             +-|
         |       +        +       +       +       +        +       +       |
  400000 +-----------------------------------------------------------------+
         0       5        10      15      20      25       30      35      40

The stress-ng module tests:

This is used to run the test to try to reproduce the vmap issues
reported by David:

  echo 0 > /proc/sys/vm/oom_dump_tasks
  ./stress-ng --module 100 --module-name xfs

Prior to this commit:
root@kmod ~ # free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > baseline-stress-ng.txt
root@kmod ~ # sort -n -r baseline-stress-ng.txt | head -1
5046456

After this commit:
root@kmod ~ # free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > after-stress-ng.txt
root@kmod ~ # sort -n -r after-stress-ng.txt | head -1
4896972

5046456 - 4896972
149484
149484/1024
145.98046875000000000000

So this commit using stress-ng reveals saving about 145 MiB in memory
using 100 ops from stress-ng which reproduced the vmap issue reported.

cat kmod.plot
set term dumb
set output fileout
set yrange [4700000:5070000]
plot filein with linespoints title "Memory usage (KiB)"

root@kmod ~ # gnuplot -e "filein='baseline-stress-ng.txt'; fileout='graph-stress-ng-before.txt'"  kmod-simple-stress-ng.plot
root@kmod ~ # gnuplot -e "filein='after-stress-ng.txt'; fileout='graph-stress-ng-after.txt'"  kmod-simple-stress-ng.plot

root@kmod ~ # cat graph-stress-ng-before.txt

           +---------------------------------------------------------------+
  5.05e+06 |-+     + A     +       +       +       +       +       +     +-|
           |         *                          Memory usage (KiB) ***A*** |
           |         *                             A                       |
     5e+06 |-+      **                            **                     +-|
           |        **                            * *    A                 |
  4.95e+06 |-+      * *                          A  *   A*               +-|
           |        * *      A       A           *  *  *  *             A  |
           |       *  *     * *     * *        *A   *  *  *      A      *  |
   4.9e+06 |-+     *  *     * A*A   * A*AA*A  A      *A    **A   **A*A  *+-|
           |       A  A*A  A    *  A       *  *      A     A *  A    * **  |
           |      *      **      **         * *              *  *    * * * |
  4.85e+06 |-+   A       A       A          **               *  *     ** *-|
           |     *                           *               * *      ** * |
           |     *                           A               * *      *  * |
   4.8e+06 |-+   *                                           * *      A  A-|
           |     *                                           * *           |
  4.75e+06 |-+  *                                            * *         +-|
           |    *                                            **            |
           |    *  +       +       +       +       +       + **    +       |
   4.7e+06 +---------------------------------------------------------------+
           0       5       10      15      20      25      30      35      40

root@kmod ~ # cat graph-stress-ng-after.txt

           +---------------------------------------------------------------+
  5.05e+06 |-+     +       +       +       +       +       +       +     +-|
           |                                    Memory usage (KiB) ***A*** |
           |                                                               |
     5e+06 |-+                                                           +-|
           |                                                               |
  4.95e+06 |-+                                                           +-|
           |                                                               |
           |                                                               |
   4.9e+06 |-+                                      *AA                  +-|
           |  A*AA*A*A  A  A*AA*AA*A*AA*A  A  A  A*A   *AA*A*A  A  A*AA*AA |
           |  *      * **  *            *  *  ** *            ***  *       |
  4.85e+06 |-+*       ***  *            * * * ***             A *  *     +-|
           |  *       A *  *             ** * * A               *  *       |
           |  *         *  *             *  **                  *  *       |
   4.8e+06 |-+*         *  *             A   *                  *  *     +-|
           | *          * *                  A                  * *        |
  4.75e+06 |-*          * *                                     * *      +-|
           | *          * *                                     * *        |
           | *     +    * *+       +       +       +       +    * *+       |
   4.7e+06 +---------------------------------------------------------------+
           0       5       10      15      20      25      30      35      40

[0] https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com

Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c  |  6 +++++-
 kernel/module/stats.c | 14 +++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5642d77657a0..1ed373145278 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2815,7 +2815,11 @@ static int early_mod_check(struct load_info *info, int flags)
 	if (err)
 		return err;
 
-	return 0;
+	mutex_lock(&module_mutex);
+	err = module_patient_check_exists(info->mod->name, FAIL_DUP_MOD_BECOMING);
+	mutex_unlock(&module_mutex);
+
+	return err;
 }
 
 /*
diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index d4b5b2b9e6ad..d9b9bccf4256 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -87,7 +87,7 @@ extern struct dentry *mod_debugfs_root;
  * calls:
  *
  *   a) FAIL_DUP_MOD_BECOMING: at the end of early_mod_check() before
- *	layout_and_allocate(). This does not yet happen.
+ *	layout_and_allocate().
  *	- with module decompression: 2 virtual memory allocation calls
  *	- without module decompression: 1 virtual memory allocation calls
  *   b) FAIL_DUP_MOD_LOAD: after layout_and_allocate() on add_unformed_module()
@@ -130,15 +130,15 @@ static LIST_HEAD(dup_failed_modules);
  *   * invalid_becoming_bytes: total number of bytes wasted due to
  *     allocations used to read the kernel module userspace wants us to read
  *     before we promote it to be processed to be added to our @modules linked
- *     list. These failures could in theory happen in if we had a check in between
- *     between a successful kernel_read_file_from_fd() call and right before
- *     we allocate the our private memory for the module which would be kept if
- *     the module is successfully loaded. The most common reason for this failure
+ *     list. These failures could can happen in between a successful
+ *     kernel_read_file_from_fd() call and right before we allocate the our
+ *     private memory for the module which would be kept if the module is
+ *     successfully loaded. The most common reason for this failure
  *     is when userspace is racing to load a module which it does not yet see
  *     loaded. The first module to succeed in add_unformed_module() will add a
  *     module to our &modules list and subsequent loads of modules with the
- *     same name will error out at the end of early_mod_check(). A check
- *     for module_patient_check_exists() at the end of early_mod_check() could be
+ *     same name will error out at the end of early_mod_check(). The check
+ *     for module_patient_check_exists() at the end of early_mod_check() was
  *     added to prevent duplicate allocations on layout_and_allocate() for
  *     modules already being processed. These duplicate failed modules are
  *     non-fatal, however they typically are indicative of userspace not seeing
-- 
2.39.2

