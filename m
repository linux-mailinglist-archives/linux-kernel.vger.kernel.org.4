Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D875673D136
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFYNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFYNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:51:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE581B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:51:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qDQ9O-0007dG-FW; Sun, 25 Jun 2023 15:51:34 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-06-25]
Date:   Sun, 25 Jun 2023 13:51:33 +0000
Message-Id: <168770105071.1044236.16811678381872089646@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687701096;8c194fc5;
X-HE-SMSGID: 1qDQ9O-0007dG-FW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, find below regzbot's report about the remaining regressions
that were introduced this cycle. Not much has changed since my "quick &
small additional regressions report pre -rc8/final", so I'm quoting it
here:

>  * kernel test robot noticed a -20.0% regression of
> vm-scalability.throughput post -rc7;

BTW, that was caused by 9425c591e06 ("page cache: fix
page_cache_next/prev_miss off by one") [v6.4-rc7]

> Mike posted reverts akpm applied
> that landed in next recently:
> 
> https://lore.kernel.org/lkml/202306211346.1e9ff03e-oliver.sang@intel.com/
> https://lore.kernel.org/lkml/20230621212403.174710-1-mike.kravetz@oracle.com/

Akpm moved to those reverts from the mm-unstable to the mm-stable branch
(not totally sure, but I think those are branch with changes for the
next merge window):

https://lore.kernel.org/all/20230624000036.57829C433CB@smtp.kernel.org/
https://lore.kernel.org/all/20230624000035.3C79BC433C0@smtp.kernel.org/


>  * Swapnil Sapkal from AMD found another performance regression; from
> skimming the thread it seems a partial fix is in -next for some time
> already; part of the problem is also caused by df323337e50 "apparmor:
> Use a memory pool instead per-CPU caches" [v5.5-rc1]
> 
> https://lore.kernel.org/lkml/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com/
> https://lore.kernel.org/lkml/20230515143536.114960-1-mathieu.desnoyers@efficios.com/
> https://lore.kernel.org/lkml/6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com/
> 
> [this one is not tracked by regzbot, something went sideways, need to
> look closer]
> 
> 
>  * Mario came up with a fix for the ppc/tpm kexec hang recently reported:
> 
> https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
> https://lore.kernel.org/all/20230623030427.908-1-mario.limonciello@amd.com/
> 
> 
>  * still no solution in sight for the "Dragonboard 845c broken due to
> asynchronous probe" regression
> 
> https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
> https://lore.kernel.org/lkml/20230515145323.1693044-1-amit.pundir@linaro.org/
> https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/
> 
> 
>  * no progress wrt to the MPTCP tests regressions due to 9p changes
> 
> https://lore.kernel.org/regressions/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/
> 
> 
>  * brand new: transmit queue timeouts with r8169 due to 2ab19de62d6
> ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI
> poll") [v6.4-rc1]
> 
> https://lore.kernel.org/netdev/c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de/
> 
> 
>  * just noticed: patches for a "WiFi / LTE won't work at all on trogdor
> devices" regression might still be heading your way:
> 
> https://lore.kernel.org/lkml/20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 6 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.3.. aka v6.4-rc), culprit identified
======================================================


[ *NEW* ] transmit queue timeout on r8169
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de/
https://lore.kernel.org/netdev/c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de/

By Tobias Klausmann; 3 days ago; 4 activities, latest 1 days ago.
Introduced in 2ab19de62d67 (v6.4-rc1)

Recent activities from: Tobias Klausmann (2), Thorsten Leemhuis (1),
  Bagas Sanjaya (1)


regulator: qcom-rpmh: Dragonboard 845c broken due to asynchronous probe
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/

By Amit Pundir; 42 days ago; 52 activities, latest 1 days ago.
Introduced in ad44ac082fd (v6.4-rc1)

Recent activities from: Amit Pundir (2), Thorsten Leemhuis (1), Bjorn
  Andersson (1)

One patch associated with this regression:
* Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
  https://lore.kernel.org/lkml/552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org/
  42 days ago, by Caleb Connolly

Noteworthy links:
* [PATCH] Revert "regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS""
  https://lore.kernel.org/lkml/20230515145323.1693044-1-amit.pundir@linaro.org/
  40 days ago, by Amit Pundir; thread monitored.
* [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
  https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/
  22 days ago, by Amit Pundir; thread monitored.


9p: MPTCP tests regressions due to new 9p features in v6.4
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/
https://lore.kernel.org/regressions/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/

By Matthieu Baerts; 18 days ago; 6 activities, latest 1 days ago.
Introduced in d9bc0d11e33b (v6.4-rc1)

Recent activities from: Thorsten Leemhuis (1)


tpm/ppc: crash during a kexec
-----------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/

By Sachin Sant; 10 days ago; 10 activities, latest 1 days ago.
Introduced in bd8621ca1510 (v6.4-rc1)

Recent activities from: Limonciello, Mario (2), Thorsten Leemhuis (1),
  Greg KH (1), Mario Limonciello (1), Sachin Sant (1), Michael
  Ellerman (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [6.4-rc6] Crash during a kexec operation (tpm_amd_is_rng_defective)
  https://lore.kernel.org/lkml/3f5a37f1-70e0-3dcf-3bd3-acc8a04e53ee@amd.com/
  2 days ago, by Limonciello, Mario

Noteworthy links:
* [PATCH] tpm: Ensure that tpm chip has ops to check if it's defective
  https://lore.kernel.org/lkml/20230623030427.908-1-mario.limonciello@amd.com/
  2 days ago, by Mario Limonciello; thread monitored.


[ *NEW* ] mm/page cache: performance regression (2 reverts pending)
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/202306211346.1e9ff03e-oliver.sang@intel.com/
https://lore.kernel.org/lkml/202306211346.1e9ff03e-oliver.sang@intel.com/

By kernel test robot; 4 days ago; 14 activities, latest 1 days ago.
Introduced in 9425c591e06a (v6.4-rc7)

Fix incoming:
* Revert "page cache: fix page_cache_next/prev_miss off by one"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=555d5a30e7b3020e6c4137ce7da8cd028c67caea


=======================================================
on back burner, but with activity since the last report
=======================================================


mm: performance regression on shell-heavy workloads
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20230608111408.s2minsenlcjow7q3@quack3/
https://lore.kernel.org/lkml/20230608111408.s2minsenlcjow7q3@quack3/

By Jan Kara; 17 days ago; 7 activities, latest 6 days ago.
Introduced in f1a7941243c (v6.2-rc1)

Recent activities from: Michal Hocko (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168709975910.455445.13798099813754443067@leemhuis.info

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
