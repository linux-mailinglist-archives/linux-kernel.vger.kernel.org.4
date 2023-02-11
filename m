Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7A6932DA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 18:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBKR24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 12:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 12:28:54 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F7BDD7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 09:28:49 -0800 (PST)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pQtg7-0005f0-Vi; Sat, 11 Feb 2023 18:28:48 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report for mainline [2023-02-11]
Date:   Sat, 11 Feb 2023 17:28:47 +0000
Message-Id: <167613641114.2124708.9785978428796571420@leemhuis.info>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676136529;271c7f5a;
X-HE-SMSGID: 1pQtg7-0005f0-Vi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Below you'll find regzbot's report about regression from this
cycle me or someone else told the bot about. One day earlier than usual,
as I'm on the road tomorrow.

Let me quickly mention a few random things with available fixes:

* the fix for a SPI issue I already mentioned two weeks ago is still
sitting in next; the reporter complained about that today, as the "whole
test infrastructure crashes [due to that bug] preventing the normal
testing we normally do on mainline kernel".
https://lore.kernel.org/lkml/Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com/
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=eede42c9459b58b71edc99303dad65216a655810
https://lore.kernel.org/lkml/Y%2BexzSwy1UJQCUKg@francesco-nb.int.toradex.com/

* David already sent BTRFS updates this week, but right after that
merged a fix for a issue that affected quite a few people on 6.1 to his
tree. Not sure if he'll send it in for rc8, which might be better than
applying it next week right before the release. And it liekly would make
a few 6.1.y users happy if the fix might land in 6.1.y a week earlier, too:
https://lore.kernel.org/linux-btrfs/20230206184044.GD28288@twin.jikos.cz/
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6afaed53cc9adde69d8a76ff5b4d740d5efbc54c

* A patch to fix a page corruption caused by racy check in __free_pages
emerged on Thursday. It's caused by a change merged for 5.10-rc1, but
Vlastimil nevertheless said "That's nasty enough to go into 6.2, IMHO".
Willy reviewed it, but Andrew didn't pick it up yet.
https://lore.kernel.org/lkml/BYAPR02MB448855960A9656EEA81141FC94D99@BYAPR02MB4488.namprd02.prod.outlook.com/

And one other thing:

* Last week I mentioned a long and ongoing discussion about problems
with the NFS client where there was some disagreement if the issue
qualifies as regression, as it's an old problem with tmpfs that is more
likely to happen now. That discussion afaics faded out a few days ago
without a fix or a revert (which if I remember the discussion correctly
would be possible) in sight (unless I missed it):
https://lore.kernel.org/linux-nfs/9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com/

There are still quite a few known issues from this cycle mentioned
below. Afaics none of them affect a lot of people; and with a bit of
luck one or two might still be fixed next week. I'm just a bit unhappy
that it takes so long to get "Black screen when amdgpu started during
6.2-rc1 boot with AMD IOMMU enabled" fixed, but well, there is quite a
bit discussion about it, so people tried.
https://bugzilla.kernel.org/show_bug.cgi?id=216865
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
https://lore.kernel.org/all/20230114073420.759989-1-baolu.lu@linux.intel.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 10 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.1.. aka v6.2-rc), culprit identified
======================================================


spi: spidev: recursive locking error
------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com/
https://lore.kernel.org/lkml/Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com/

By Francesco Dolcini; 26 days ago; 13 activities, latest 0 days ago.
Introduced in a720416d9463 (v6.2-rc4)

Fix incoming:
* spi: spidev: fix a recursive locking error
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=eede42c9459b58b71edc99303dad65216a655810


meida: venus: firmware: AOSS doesn't seel anymore on at least sc7180 and sc7280
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y9LSMap+jRxbtpC8@google.com/
https://lore.kernel.org/lkml/Y9LSMap%2BjRxbtpC8@google.com/

By Matthias Kaehlcke; 15 days ago; 11 activities, latest 0 days ago.
Introduced in a837e5161cff (v6.2-rc1)

Recent activities from: Javier Martinez Canillas (4), Vikash
  Garodia (2), mka@chromium.org (2), Linux regression tracking (Thorsten
  Leemhuis) (1)

Noteworthy links:
* [PATCH] Revert "venus: firmware: Correct non-pix start and end addresses"
  https://lore.kernel.org/lkml/20230207102254.1446461-1-javierm@redhat.com/
  4 days ago, by Javier Martinez Canillas; thread monitored.


drm: nouveau: hangs on poweroff/reboot
--------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com/
https://lore.kernel.org/lkml/b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com/

By Chris Clayton; 23 days ago; 21 activities, latest 0 days ago.
Introduced in 0e44c2170876 (v6.2-rc1)

Recent activities from: Chris Clayton (2), Linux regression tracking
  (Thorsten Leemhuis) (2), Karol Herbst (1)


nfs: NULL pointer dereference since NFS_V4_2_READ_PLUS is enabled by default
----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/
https://lore.kernel.org/lkml/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/

By Krzysztof Kozlowski; 35 days ago; 19 activities, latest 0 days ago.
Introduced in 7fd461c47 (v6.2-rc1)

Recent activities from: Krzysztof Kozlowski (3), Anna Schumaker (2)

One patch associated with this regression:
* Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS (commit 7fd461c47)
  https://lore.kernel.org/lkml/CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com/
  0 days ago, by Anna Schumaker


xen/usb(?): External USB disks not recognized anymore under Xen
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/
https://lore.kernel.org/lkml/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/

By Christian Kujau; 12 days ago; 17 activities, latest 0 days ago.
Introduced in 90b926e68f50 (v6.2-rc4)

Recent activities from: Juergen Gross (3), Linux regression tracking
  (Thorsten Leemhuis) (1), Borislav Petkov (1), Linus Torvalds (1)

One patch associated with this regression:
* Re: External USB disks not recognized with v6.1.8 when using Xen
  https://lore.kernel.org/lkml/Y9%2BtDmLAlqg37TS%2B@zn.tnic/
  6 days ago, by Borislav Petkov

Noteworthy links:
* [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
  https://lore.kernel.org/lkml/20230209072220.6836-6-jgross@suse.com/
  2 days ago, by Juergen Gross; thread monitored.


usb: gadget: USB network interface is recognized, but 'ip link' sees it as 'NO-CARRIER'
---------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net/
https://lore.kernel.org/lkml/f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net/

By Paul Cercueil; 10 days ago; 10 activities, latest 0 days ago.
Introduced in 321b59870f85 (v6.2-rc1)

Recent activities from: Sascha Hauer (4), Alan Stern (2), Paul
  Cercueil (2), Greg Kroah-Hartman (1)


Black screen when amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216865/
https://bugzilla.kernel.org/show_bug.cgi?id=216865
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

By Matt Fagnani and Matt Fagnani; 43 days ago; 56 activities, latest 5 days ago.
Introduced in 201007ef707a (v6.2-rc1)

Recent activities from: Tian, Kevin (1)

One patch associated with this regression:
* Re: [PATCH v3 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://lore.kernel.org/lkml/b75a5a94-a962-f88e-149e-7d23982a7ad2@linux.intel.com/
  9 days ago, by Baolu Lu

Noteworthy links:
* [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled on upstream path"
  https://lore.kernel.org/linux-pci/20230111085745.401710-1-christian.koenig@amd.com/
  31 days ago, by Christian König; thread monitored.
* [PATCH 1/1] PCI: Add translated request only opt-in for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230112084629.737653-1-baolu.lu@linux.intel.com
  30 days ago, by Lu Baolu; thread monitored.
* [PATCH v2 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230113014409.752405-1-baolu.lu@linux.intel.com
  29 days ago, by Lu Baolu; thread monitored.
* [PATCH v3 1/1] PCI: Add translated request only flag for pci_enable_pasid()
  https://bugzilla.kernel.org/show_bug.cgi?id=20230114073420.759989-1-baolu.lu@linux.intel.com
  28 days ago, by Lu Baolu; thread monitored.


nfs: failures during the git regression suite on all NFS versions
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com/
https://lore.kernel.org/linux-nfs/9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com/

By Chuck Lever III; 10 days ago; 25 activities, latest 6 days ago.
Introduced in 85aa8ddc3818 (v6.2-rc1)


==================================================
current cycle (v6.1.. aka v6.2-rc), unkown culprit
==================================================


net: r8169: NETDEV WATCHDOG: enp6s0 (r8169): transmit queue 0 timed out
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/216884/
https://bugzilla.kernel.org/show_bug.cgi?id=216884
https://lore.kernel.org/regressions/f5b100c0-cdeb-59d1-5c82-e1df59ee3773@leemhuis.info/

By HougeLangley and HougeLangley; 38 days ago; 21 activities, latest 8 days ago.
Introduced in v6.1..v6.2-rc2

Fix incoming:
* PCI: loongson: Improve the MRRS quirk for LS7A
  https://lore.kernel.org/regressions/2a9140bb-8c4f-dda8-cf43-92db792a29db@leemhuis.info/


chrome crashes
--------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com/
https://lore.kernel.org/lkml/CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com/

By Chris McGimpsey-Jones; 14 days ago; 1 activities, latest 14 days ago.
Introduced in v6.1..v6.2-rc5


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167562163001.1743361.7332568307990617200@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
