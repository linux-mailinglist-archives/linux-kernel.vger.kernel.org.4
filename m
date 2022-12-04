Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055DD641D5E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 15:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLDOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 09:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiLDOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 09:16:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A2315FF1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 06:16:47 -0800 (PST)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1p1pnR-0002GH-H6; Sun, 04 Dec 2022 15:16:45 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Linux regressions report  for mainline [2022-12-04]
Date:   Sun,  4 Dec 2022 14:16:42 +0000
Message-Id: <167016324121.413036.10816787460130337195@leemhuis.info>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670163407;3d91bd69;
X-HE-SMSGID: 1p1pnR-0002GH-H6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below you'll find regzbot's report about regression from this
cycle the bot and I became aware of. But first let me highlight a few:

###
tmp/suspend problems reported by vbabka
https://lore.kernel.org/all/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/

Jason thankfully already[1] wrote a mail about this to you (
https://lore.kernel.org/all/Y4sj%2FknxLqqF2Tqr@zx2c4.com/
) and from what I can see he's right: you might want to pick up the
following patch directly for rc8, as the maintainers are MIA:
https://lore.kernel.org/all/20221128195651.322822-1-Jason@zx2c4.com/


###
performance/mm: building Linux with clang takes a lot longer by Nathan
https://lore.kernel.org/lkml/Y1DNQaoPWxE%2BrGce@dev-arch.thelio-3990X/

It recently was agreed on to revert the culprit for this regression, but
akpm didn't include the revert in yesterdays pull afaics. You'll find it
in next as 6de770be9266 ("revert "mm: align larger anonymous mappings on
THP boundaries"") in case you want to pick it up for rc8 to prevent
getting this as a last minute change next week.


###
arm64: crash on Qualcomm SM8250
https://lore.kernel.org/lkml/CAMi1Hd1VBCFhf7%2BEXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com/

Long story short: c44094eee32f ("arm64: dma: Drop cache invalidation
from arch_dma_prep_coherent()") exposed existing problems in at least
one in-tree driver (drivers/remoteproc/qcom_q6v5_mss.c; Qualcomm
Q6V5_MSS remoteproc) which now crashes during boot. A fix apparently is
finally in the works now, but will take some time to get ready.
Reverting c44094eee32f for now was proposed, but Will is against it:
https://lore.kernel.org/lkml/20221202100357.GB29396@willie-the-truck/


###
There are two others things you might want to know about:

* A regression causing boot failures on iMX7 (due to a backport this is
also affecting 6.0.y already) could be fixed with a quick revert. But
looks like there is no need for it, after some back and forth the
developers that care are close to come to an agreement how to fix the
problem properly soonish:
https://lore.kernel.org/linux-arm-kernel/Y4dgBTGNWpM6SQXI@francesco-nb.int.toradex.com/
https://lore.kernel.org/linux-arm-kernel/e80377c9-1542-d47d-6d35-2efdc15bcbf8@denx.de/

* I noticed a discussion mentioning that apparently "dax and reflink are
totally broken on 6.1" -- but it the same in 6.0, too:
https://lore.kernel.org/lkml/638700ba5db1_c95729435@dwillia2-mobl3.amr.corp.intel.com.notmuch/

HTH, Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 6 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.0.. aka v6.1-rc), culprit identified
======================================================


[ *NEW* ] ARM: dts: imx7: Boot failure on iMX7
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y4dgBTGNWpM6SQXI@francesco-nb.int.toradex.com/
https://lore.kernel.org/linux-arm-kernel/Y4dgBTGNWpM6SQXI@francesco-nb.int.toradex.com/

By Francesco Dolcini; 4 days ago; 32 activities, latest 0 days ago.
Introduced in 753395ea1e45 (v6.1-rc6)

Recent activities from: Marek Vasut (10), Francesco Dolcini (10), Miquel
  Raynal (9), Thorsten Leemhuis (2), Greg KH (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [PATCH v1] mtd: parsers: ofpart: Fix parsing when size-cells is 0
  https://lore.kernel.org/linux-arm-kernel/Y4ngOaKq224LIpQc@francesco-nb.int.toradex.com/
  2 days ago, by Francesco Dolcini

Noteworthy links:
* [PATCH v1] mtd: parsers: ofpart: Fix parsing when size-cells is 0
  https://lore.kernel.org/stable/20221202071900.1143950-1-francesco@dolcini.it/
  2 days ago, by Francesco Dolcini; thread monitored.


[ *NEW* ] performance: mm: building Linux with clang takes a lot longer (~27 %)
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X/
https://lore.kernel.org/lkml/Y1DNQaoPWxE%2BrGce@dev-arch.thelio-3990X/

By Nathan Chancellor; 45 days ago; 14 activities, latest 1 days ago.
Introduced in f35b5d7d676e (v6.1-rc1)

Fix incoming:
* revert "mm: align larger anonymous mappings on THP boundaries"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6de770be926680e2523296a449b4e6dad599634a


arm64: crash on the Qualcomm SM8250
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd1VBCFhf7%2BEXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com/

By Amit Pundir; 25 days ago; 30 activities, latest 1 days ago.
Introduced in c44094eee32f (v6.1-rc1)

Recent activities from: Thorsten Leemhuis (5), Manivannan
  Sadhasivam (3), Greg KH (2), Will Deacon (1), Amit Pundir (1), Catalin
  Marinas (1)

Noteworthy links:
* [PATCH] Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()"
  https://lore.kernel.org/lkml/20221114110329.68413-1-manivannan.sadhasivam@linaro.org/
  20 days ago, by Manivannan Sadhasivam; thread monitored.


drm: msm: DSI controller being switched off before the panel unprepare hook is called
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/1892d0af-8aa4-dc03-887a-e44bb623b836@linaro.org/
https://lore.kernel.org/dri-devel/1892d0af-8aa4-dc03-887a-e44bb623b836@linaro.org/

By Caleb Connolly; 22 days ago; 2 activities, latest 21 days ago.
Introduced in 007ac0262b0d (v6.1-rc1)


==================================================
current cycle (v6.0.. aka v6.1-rc), unkown culprit
==================================================


[ *NEW* ] suspend to ram fails in 6.1 due to tpm errors
-------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/
https://lore.kernel.org/lkml/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/

By Vlastimil Babka; 6 days ago; 10 activities, latest 1 days ago.
Introduced in v6.0..v6.1-rc4

Recent activities from: Jason A. Donenfeld (5), Vlastimil Babka (3), Jan
  Dąbroś (1), Thorsten Leemhuis (1)

Noteworthy links:
* [PATCH v3] char: tpm: Protect tpm_pm_suspend with locks
  https://lore.kernel.org/lkml/20221128195651.322822-1-Jason@zx2c4.com/
  5 days ago, by Jason A. Donenfeld; thread monitored.


[ *NEW* ] ata/arm32: TI BeagleBoard X15 doesn't boot
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com/
https://lore.kernel.org/lkml/CA%2BG9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com/

By Naresh Kamboju; 4 days ago; 3 activities, latest 3 days ago.
Introduced in v6.0..v6.1-rc7

Recent activities from: Anders Roxell (1), Niklas Cassel (1), Naresh
  Kamboju (1)

One patch associated with this regression:
* Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
  https://lore.kernel.org/lkml/CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c%2BtB0oUQPouE1idnuQ@mail.gmail.com/
  3 days ago, by Anders Roxell


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/166956961686.104691.2021186998003391429@leemhuis.info

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
