Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7F73BDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFWRaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjFWR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:29:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316B81997
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:29:54 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qCkbY-0005zi-IS; Fri, 23 Jun 2023 19:29:52 +0200
Message-ID: <60c2f8c9-15b2-a3e5-2247-5adf4581e037@leemhuis.info>
Date:   Fri, 23 Jun 2023 19:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: A quick small additional regressions report pre -rc8/final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687541394;7423a839;
X-HE-SMSGID: 1qCkbY-0005zi-IS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, here is a quick manual report about regressions introduced
this cycle that I'm aware of and are currently unresolved afaik:


 * kernel test robot noticed a -20.0% regression of
vm-scalability.throughput post -rc7; Mike posted reverts akpm applied
that landed in next recently:

https://lore.kernel.org/lkml/202306211346.1e9ff03e-oliver.sang@intel.com/
https://lore.kernel.org/lkml/20230621212403.174710-1-mike.kravetz@oracle.com/


 * Swapnil Sapkal from AMD found another performance regression; from
skimming the thread it seems a partial fix is in -next for some time
already; part of the problem is also caused by df323337e50 "apparmor:
Use a memory pool instead per-CPU caches" [v5.5-rc1]

https://lore.kernel.org/lkml/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com/
https://lore.kernel.org/lkml/20230515143536.114960-1-mathieu.desnoyers@efficios.com/
https://lore.kernel.org/lkml/6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com/

[this one is not tracked by regzbot, something went sideways, need to
look closer]


 * Mario came up with a fix for the ppc/tpm kexec hang recently reported:

https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
https://lore.kernel.org/all/20230623030427.908-1-mario.limonciello@amd.com/


 * still no solution in sight for the "Dragonboard 845c broken due to
asynchronous probe" regression

https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
https://lore.kernel.org/lkml/20230515145323.1693044-1-amit.pundir@linaro.org/
https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/


 * no progress wrt to the MPTCP tests regressions due to 9p changes

https://lore.kernel.org/regressions/855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net/


 * brand new: transmit queue timeouts with r8169 due to 2ab19de62d6
("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI
poll") [v6.4-rc1]

https://lore.kernel.org/netdev/c3465166-f04d-fcf5-d284-57357abb3f99@freenet.de/


 * just noticed: patches for a "WiFi / LTE won't work at all on trogdor
devices" regression might still be heading your way:

https://lore.kernel.org/lkml/20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid/


HTH, Ciao, Thorsten
