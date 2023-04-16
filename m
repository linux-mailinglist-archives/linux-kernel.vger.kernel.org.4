Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFB6E3AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDPR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:59:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B58121
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:59:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1po6eY-0008JP-N0; Sun, 16 Apr 2023 19:59:06 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-04-16]
Date:   Sun, 16 Apr 2023 17:59:06 +0000
Message-Id: <168166781352.1843526.278570500979918184@leemhuis.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681667948;f6c84dbf;
X-HE-SMSGID: 1po6eY-0008JP-N0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. I'm down to four regressions that I and regzbot are aware of
and worth mentioning. All of them are worked on by developers. See below
for details.

What currently worries me more are two regressions from the 6.2 cycle
still not fixed.

Wake-on-lan (WOL) apparently is broken for a huge number of users since
6.2 was released[1]. This is known for 8 weeks now and about 4 weeks ago
it was bisected to commit 5c62d5aab87 ("ACPICA: Events: Support fixed
PCIe wake event") we immediately could have reverted. The developer that
looked into this was even willing to do the revert late March, but then
got discouraged by a maintainer [2]. But well, a fix was apparently[3]
finally posted for review last week (to the acpica-devel list); with a
bit of luck your might get it next week. Still a bit sad that 6.2 is
broken for so long now, as Greg wants to see it fixed in mainline first.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217069
[2] https://bugzilla.kernel.org/show_bug.cgi?id=217069#c50
[3]
https://lore.kernel.org/all/754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn/

I have see similar situations a few times already. I sometimes wonder if
I should post reverts for review in cases like this (say a few days or a
week after bisection, is no fix is in sight) to enforce the issue and at
least trigger a discussion about the revert -- and depending on its
outcome ask you a few days later to consider picking it up. But I'm not
sure if that's really a wise move.


Another issue from the 6.2 days still not fixed are a huge number of
DISCARD request on NVME devices with Btrfs caused by 63a7cb13071
("btrfs: auto enable discard=async when possible") [1, 2]. This is known
for 7 weeks and likely results in a performance regression for some
users and might also reduce the life time of some devices. One user even
reported his laptop now uses ~10W more due to the constant drive
activity [3]. After some back and forth the Btrfs developers agreed on
working towards a fix recently [4]; but I doubt we'll see it this week.
I have no idea if a revert would be possible here. But I thought you
might want to be aware of this.

[1] https://lore.kernel.org/linux-btrfs/Y%2F%2Bn1wS%2F4XAH7X1p@nz/
[2]
https://lore.kernel.org/linux-btrfs/CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com/
[3]
https://lore.kernel.org/linux-btrfs/6a54fa77-9a0c-8844-2eb0-b65591e97a16@gmail.com/
[4] https://lore.kernel.org/linux-btrfs/20230404193909.GC344341@zen/

HTH, Ciao, Thorsten

P.S.: Sorry for bringing up a regression last week that was just a
kernel warning; for some reason I was under the wrong impression that
video apps were crashing; I guess my mind confused this with another
regression.

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 4 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.2.. aka v6.3-rc), culprit identified
======================================================


net: mlx5: InfiniBand devices were no longer present
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAHC9VhQ7A4+msL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com/
https://lore.kernel.org/netdev/CAHC9VhQ7A4%2BmsL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com/

By Paul Moore; 18 days ago; 18 activities, latest 1 days ago.
Introduced in fe998a3c77b9 (v6.3-rc1)

Recent activities from: Jakub Kicinski (6), Saeed Mahameed (5), Paul
  Moore (3), Leon Romanovsky (1)

Noteworthy links:
* [PATCH net] Revert "net/mlx5: Enable management PF initialization"
  https://lore.kernel.org/netdev/20230413222547.56901-1-kuba@kernel.org/
  2 days ago, by Jakub Kicinski; thread monitored.


sched: PostgreSQL performance regression introduced by mm_cid
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230327080502.GA570847@ziqianlu-desk2/
https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/

By Aaron Lu; 20 days ago; 75 activities, latest 2 days ago.
Introduced in af7f588d8f73 (v6.3-rc1)

Recent activities from: Mathieu Desnoyers (15), Aaron Lu (13), Peter
  Zijlstra (11), michael.christie@oracle.com (1)

5 patch postings are associated with this regression, the latest is this:
* Re: [RFC PATCH v4] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230413131353.GA214119@ziqianlu-desk2/
  3 days ago, by Aaron Lu

Noteworthy links:
* [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
  https://lore.kernel.org/lkml/20230330230911.228720-1-mathieu.desnoyers@efficios.com/
  16 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230403181342.210896-1-mathieu.desnoyers@efficios.com/
  12 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Fix performance regression introduced by mm_cid (v2)
  https://lore.kernel.org/lkml/20230405121535.3891327-1-mathieu.desnoyers@efficios.com/
  11 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v3] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230405162635.225245-1-mathieu.desnoyers@efficios.com/
  11 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v4] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230410150150.2179062-1-mathieu.desnoyers@efficios.com/
  6 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH] sched: Rate limit migrations
  https://lore.kernel.org/lkml/20230411214116.361016-1-mathieu.desnoyers@efficios.com/
  4 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v5] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230413140248.230479-1-mathieu.desnoyers@efficios.com/
  3 days ago, by Mathieu Desnoyers; thread monitored.
* [RFC PATCH v6] sched: Fix performance regression introduced by mm_cid
  https://lore.kernel.org/lkml/20230413223356.17195-1-mathieu.desnoyers@efficios.com/
  2 days ago, by Mathieu Desnoyers; thread monitored.


firmware/sysfb: wrong mode and display garbled on 16-year old i686 laptop
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/4Psm6B6Lqkz1QXM@panix3.panix.com/
https://lore.kernel.org/dri-devel/4Psm6B6Lqkz1QXM@panix3.panix.com/

By pa@panix.com; 10 days ago; 24 activities, latest 2 days ago.
Introduced in f35cd3fa7729 (v6.3-rc1)

Recent activities from: Javier Martinez Canillas (12), Pierre
  Asselin (9), pa@panix.com (1)

4 patch postings are associated with this regression, the latest is this:
* Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is calculated
  https://lore.kernel.org/lkml/87o7nsuumt.fsf@minerva.mail-host-address-is-not-set/
  3 days ago, by Javier Martinez Canillas

Noteworthy links:
* [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is calculated
  https://lore.kernel.org/lkml/20230412150225.3757223-1-javierm@redhat.com/
  4 days ago, by Javier Martinez Canillas; thread monitored.


pci: / net: igb: hangs during boot on PowerEdge R620
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/m2fs9lgndw.fsf@gmail.com/
https://lore.kernel.org/lkml/m2fs9lgndw.fsf@gmail.com/

By Donald Hunter; 16 days ago; 9 activities, latest 4 days ago.
Introduced in 6fffbc7ae137 (v6.3-rc1)

Recent activities from: Donald Hunter (2), Andy Shevchenko (1), Rob
  Herring (1), Bjorn Helgaas (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168106197596.1411382.4633915108737130144@leemhuis.info

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
