Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F3F6CD1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjC2FcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjC2FcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:32:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1143C33;
        Tue, 28 Mar 2023 22:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RbshZVKDekPDOboeHnEAcgErH9krvuwQN7TysZlnIZw=; b=GyXZwQdzvgM7yhc8r+C5Vhai/9
        IOpEs0a2tDWNEdfprqiEIcZ2E8v1vexNsaoG9ZN2e1ZBToe1wdV9OPP21g4oLpqbMgEuo3fyX/8r2
        z8ZG617RPED8eMv9RVJgKv6yxZsjZikUTsRsoepiIWpblLpufupifKeeB2RZS9hCVfFLS5Qi/zaPs
        wbXqYiFQNVQ9NpGD3zNYkWbEk7J5CwMo3VeJ2PMxGIbDq6flmPN4cv/e7EzAP13A/ztHYle/wUwUP
        pdzO68cb4rR6+2D/EtIoNOIRkfU1dIvlJhCsfV4cOL31V/agcdygbpFFjQy9YclM9/4eqvm8S4zQH
        /GKQHogQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phOPW-00GgRY-2D;
        Wed, 29 Mar 2023 05:31:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, mcgrof@kernel.org
Subject: [PATCH 3/7] module: avoid allocation if module is already present and ready
Date:   Tue, 28 Mar 2023 22:31:45 -0700
Message-Id: <20230329053149.3976378-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329053149.3976378-1-mcgrof@kernel.org>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_module() will allocate a struct module before even checking
if the module is already loaded. This can create unecessary memory
pressure since we can easily just check if the module is already
present early with the copy of the module information from userspace
after we've validated it a bit.

This can only be an issue if a system is getting hammered with userspace
loading modules. Note that there are two ways to load modules, one is
kernel moduile auto-loading (request_module() calls in-kernel) and the
other is modprobe calls from userspace. The auto-loading is in-kernel, that
pings back to userspace to just call modprobe. We already have a way to
restrict the amount of concurrent kernel auto-loads in a given time, however
that does not stop a system from issuing tons of system calls to load a
module and for the races to exist. Userspace itself *is* supposed to check
if a module is present before loading it. But we're observing situations
where tons of the same module are in effect being loaded. Although some of
these are acknolwedged as in-kernel bugs such as the ACPI frequency
modules, issues for which we already have fixes merged or are working
towards, but we can also help a bit more in the modules side to avoid
those dramatic situations. All that is just memory being allocated to then
be thrown away.

To avoid memory pressure for such stupid cases put a stop gap for them.
We now check for the module being present *before* allocation, and then
right after we are going to add it to the system.

On a 8vcpu 8 GiB RAM system using kdevops and testing against selftests
kmod.sh -t 0008 I see a saving in the *highest* side of memory
consumption of up to ~ 84 MiB with the Linux kernel selftests kmod
test 0008. With the new stress-ng module test I see a 145 MiB difference
in max memory consumption with 100 ops. The stress-ng module ops tests can be
pretty pathalogical -- it is not realistic, however it was used to
finally successfully reproduce issues which are only reported to happen on
system with over 400 CPUs [0] by just usign 100 ops on a 8vcpu 8 GiB RAM
system.

This can be observed and visualized below. The time it takes to run the
test is also not affected.

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
 kernel/module/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 77c2e7a60f2e..145e15f19576 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2785,7 +2785,11 @@ static int early_mod_check(struct load_info *info, int flags)
 	if (err)
 		return err;
 
-	return 0;
+	mutex_lock(&module_mutex);
+	err = module_patient_check_exists(info->mod->name);
+	mutex_unlock(&module_mutex);
+
+	return err;
 }
 
 /*
-- 
2.39.2

