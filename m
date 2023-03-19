Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD16C05C8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCSVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCSVtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:49:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFC12BCE;
        Sun, 19 Mar 2023 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=a2k40cfDvwQf7JPgjDLK8Q4I5Dlky1AGZanNutR4j48=; b=SwGIxlRBNjoIa2X8GFxoM6VC9z
        k3/PeqV3amwDnKgIsM5Q2hWs8vZ9ZXAMSb8/hOZtiX9esSJz6xJumrJF97D4g9T50izMRI2iogk7A
        ftSFrd0cOlNehEJItvp18YMvKaM7azk7nQcWXt3s0CoTZbGYSTk5DcZeO00pbGil6cRYu1ZMZju/2
        d2gxSLaKkJXh8zGP7PhifCOULU5mupYg/4T44Iu1guOw9QUukMk/YzA3/KqesH44QILx2wOtSq/RI
        1sr8kdfqbNvLNTiKXaDc0KcSQGjF5P9dAeEkWstglna/dksEJ9n9WWFXb70eILfSqEPaT7dJoGyfm
        BDfih+CA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0u8-007WjU-0V;
        Sun, 19 Mar 2023 21:49:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [RFT 3/5] module: avoid allocation if module is already present and ready
Date:   Sun, 19 Mar 2023 14:49:24 -0700
Message-Id: <20230319214926.1794108-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319214926.1794108-1-mcgrof@kernel.org>
References: <20230319214926.1794108-1-mcgrof@kernel.org>
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

load_module() will allocate a struct module before even checking
if the module is already loaded. This can create unecessary memory
pressure since we can easily just check if the module is already
present early with the copy of the module information from userspace
after we've validated it a bit.

This can only be an issue if a system is getting hammered with userspace
loading modules. Note that there are two ways to load modules, one is
auto-loading in-kernel and that pings back to userspace to just call
modprobe, and we already have a way to restrict the count and load
from there on the kernel usermode helper. However that does not stop
a system from issuing tons of system calls to load a module. So userspace
itself *is* supposed to check if a module is present before loading it.
But we're observing situations where tons of the same module are in effect
being loaded. Although some of these are acknolwedged as in-kernel bugs
such as the ACPI frequency modules we can also help a bit more in the
modules side to avoid those dramatic situations. All that is just memory
being allocated to then be thrown away.

To avoid memory pressure for such stupid cases put a stop gap for them.
We now check for the module being present *before* allocation, and then
right after we are going to add it to the system.

On a 8vcpu 8 GiB RAM system using kdevops and testing against selftests
kmod.sh -t 0008 I see a saving in the *highest* side of memory
consumption of up to ~ 84 MiB. This can be obvserved and visualized
below. The time it takes to run the test is also not affected.

The gnuplot is set to a range from 400000 KiB (390 Mib) - 580000 (566 Mib)
given the tests peak around that range.

cat kmod-simple.plot
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

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 3644438ff96e..0ad26455def2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2787,7 +2787,11 @@ static int early_mod_check(struct load_info *info, int flags)
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
2.39.1

