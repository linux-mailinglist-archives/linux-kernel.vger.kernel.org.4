Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8F655081
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiLWMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiLWMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:41:05 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A21F4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:40:41 -0800 (PST)
Received: from [2a02:8108:963f:de38:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1p8hLs-0001Cb-JF; Fri, 23 Dec 2022 13:40:40 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2022-12-23]
Date:   Fri, 23 Dec 2022 12:40:39 +0000
Message-Id: <167179914593.1360994.17503278527422432544@leemhuis.info>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671799242;739de44b;
X-HE-SMSGID: 1p8hLs-0001Cb-JF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! Below you'll find regzbot's report about regression from this
cycle the bot was told about or I became aware of. This is a kind of
"extra report" now that the end of the merge window is close and the
festival season is about to go into full swing. A few notes from my side:

* The fix for "drm: amdgpu: use-after-free and random computer hangs" is
in the drm pull Dave send in the past 24h:
https://lore.kernel.org/amd-gfx/20221219104718.21677-1-christian.koenig@amd.com/

* Christoph two days ago merged the fix for "dma-mapping: audio devices
disappeared", not sure if it's heading your way already:
https://lore.kernel.org/alsa-devel/20221220082009.569785-1-hch@lst.de/

* The revert to fix the "usb: ulpi: various qemu test failures" issue is
in the works:
https://lore.kernel.org/lkml/20221222205302.45761-1-ftoth@exalondelft.nl/

* I wondered if the issue "arm64: missing build-id in vmlinux breaks at
least Fedora's kernel packaging" (on arm64) was worth a quick revert,
but Masahiro and Ard don't think so:
https://lore.kernel.org/lkml/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com/

* "wifi: mt76: wifi stopped working" needs more debugging and a simple
revert afaics is not possible
https://lore.kernel.org/lkml/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre%2BXJS_s5FgVteYA@mail.gmail.com/

* "mm, slub: CONFIG_SLUB_TINY causes various build errors": this new
option disables KASAN which allows other stuff to be enabled, that
apparently were already broken; looks like the discussion stalled and
needs a restart in the new year.
https://lore.kernel.org/lkml/Y5hTTGf%2FRA2kpqOF@debian/

BTW, a fix for a 6.1 regression causing random rpm install failures (
https://lore.kernel.org/lkml/20221216163227.24648-1-vbabka@suse.cz/
) is in the pile of changes Andrew's send your way in the past 24h. To
me it feels kinda wrong that it took about one week to get this change
into mainline, but maybe that's just me.

Another revert to fix a input regression on one particular laptop sits
in next (3c44e2b6cde6 ("Revert "Input: synaptics - switch touchpad on HP
Laptop 15-da3001TU to RMI mode"")),

The fix for the regression "net: regression tests of
python-ephemeral-port-reserve fail" reported by Jiri is still discussed.

HTH, Ciao, Thorsten


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 6 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v6.1.. aka v6.1-post), culprit identified
========================================================


[ *NEW* ] drm: amdgpu: use-after-free and random computer hangs
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CABXGCsNryN9Koz48DiSTPwTBSOKo0U0B3PnW3+gEf2B8n8u0GA@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNryN9Koz48DiSTPwTBSOKo0U0B3PnW3%2BgEf2B8n8u0GA@mail.gmail.com/

By Mikhail Gavrilov; 4 days ago; 6 activities, latest 0 days ago.
Introduced in aab9cf7b6954

Fix incoming:
* drm/amdgpu: grab extra fence reference for drm_sched_job_add_dependency
  https://lore.kernel.org/lkml/28c5c38b-de13-b2b5-0ffa-8a08d96391df@leemhuis.info/


[ *NEW* ] usb: ulpi: various qemu test failures
-----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/20221220194334.GA942039@roeck-us.net/
https://lore.kernel.org/lkml/20221220194334.GA942039@roeck-us.net/

By Guenter Roeck; 2 days ago; 11 activities, latest 0 days ago.
Introduced in 8a7b31d545d3

Fix incoming:
* Revert "usb: ulpi: defer ulpi_register on ulpi_read_id timeout"
  https://lore.kernel.org/lkml/a858f1fc-1927-c4d1-3efe-f2aff23a2cbb@leemhuis.info/


[ *NEW* ] arm64: missing build-id in vmlinux breaks at leas Fedora's kernel packaging
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com/
https://lore.kernel.org/lkml/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com/

By Dennis Gilmore; 4 days ago; 4 activities, latest 1 days ago.
Introduced in 994b7ac1697b

Recent activities from: Ard Biesheuvel (1), Thorsten Leemhuis (1),
  Masahiro Yamada (1), Dennis Gilmore (1)

One patch associated with this regression:
* Re: BUG: arm64: missing build-id from vmlinux
  https://lore.kernel.org/lkml/CAMj1kXE%2BLBOBavOre1O8LTGPCmB8m58fbfo92Sx4WukyNAur-A@mail.gmail.com/
  1 days ago, by Ard Biesheuvel


[ *NEW* ] wifi: mt76: wifi stopped working
------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre%2BXJS_s5FgVteYA@mail.gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=216829

By Mikhail Gavrilov and Mike Lothian; 2 days ago; 9 activities, latest 1 days ago.
Introduced in cd372b8c99c5

Recent activities from: Mikhail Gavrilov (4), Felix Fietkau (3), Lorenzo
  Bianconi (2)

4 patch postings are associated with this regression, the latest is this:
* Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
  https://lore.kernel.org/lkml/3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name/
  1 days ago, by Felix Fietkau


[ *NEW* ] dma-mapping: audio devices disappeared
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com/

By Mikhail Gavrilov; 7 days ago; 14 activities, latest 2 days ago.
Introduced in ffcb75458460

Fix incoming:
* dma-mapping: reject GFP_COMP for noncohernt allocaions
  https://lore.kernel.org/lkml/5dff36ee-bfe5-4596-b01d-0eaca1b552bd@leemhuis.info/


[ *NEW* ] mm, slub: CONFIG_SLUB_TINY causes various build errors
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/Y5hTTGf/RA2kpqOF@debian/
https://lore.kernel.org/lkml/Y5hTTGf%2FRA2kpqOF@debian/

By Sudip Mukherjee (Codethink); 10 days ago; 7 activities, latest 9 days ago.
Introduced in e240e53ae0ab

Recent activities from: Guenter Roeck (3), Vlastimil Babka (2), Sudip
  Mukherjee (1), Sudip Mukherjee (Codethink) (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/167077682369.767290.4323979751797298970@leemhuis.info

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
