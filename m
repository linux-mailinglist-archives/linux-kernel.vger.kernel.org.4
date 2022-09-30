Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A55F0B00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiI3Lsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiI3LsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:48:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA55051B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:44:51 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeERl-00044M-4V; Fri, 30 Sep 2022 13:44:49 +0200
Message-ID: <d78137ce-f6d0-e8d9-9248-2ec84b502b72@leemhuis.info>
Date:   Fri, 30 Sep 2022 13:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Manual Linux regressions report for mainline [2022-09-30]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664538291;28c4f20e;
X-HE-SMSGID: 1oeERl-00044M-4V
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus! A quick manual regression report because we're close to the
end of this devel cycle:


Graphical issues on Lenovo Yoga 7 14ARB7 laptop since v6.0-rc1
--------------------------------------------------------------
https://lore.kernel.org/lkml/c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se/

Unlikely to hit many people afaics. A fix is posted and somewhat
reviewed, but not yet merged by the maintainers afaics:
https://lore.kernel.org/amd-gfx/20220928172726.128863-1-sunpeng.li@amd.com/


arm64 / rock960 : kernel panic (NULL pointer dereference)
---------------------------------------------------------
https://lore.kernel.org/lkml/4f398e4c-973b-7843-2f75-27324d109277@linaro.org/

A fix for that one is in next and might be heading your way:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=f340ed8664a55a467850ec1689996e63d9ee971a


qemu/KVM boot failures after commit 'iomap: add support for dma aligned
direct-io'
---------------------------------------------------------------------
https://lore.kernel.org/all/fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com/

Reported yesterday, caused by bf8d08532bc1. A kernel change exposed a
bug in Qemu:
https://lore.kernel.org/all/32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com/

I wonder if that commit should be reverted for now.


efi_pstore and ramoops backends are unable to properly decompress dmesg
sometimes
-----------------------------------------------------------------------
https://lore.kernel.org/all/20220929215515.276486-1-gpiccoli@igalia.com/

Reported in the past 24 hours, includes a revert. Kees wasn't able to
reproduce the problem. Guess developers will look into this today.


system hangs on Flatcar Container Linux
---------------------------------------
https://lore.kernel.org/all/c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com/

Reported two days ago against stable (and thus not strictly a mainline
regression), where it's caused by a backport of 51ae846cff5 (merged this
cycle). The latter had also triggered a syzbot problem earlier (see
thread). Investigation ongoing.


---
That's all I'm aware of, HTH, Thorsten
