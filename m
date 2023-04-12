Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166376DF20D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:34:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985C2D48;
        Wed, 12 Apr 2023 03:34:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pmXnc-0001gq-N8; Wed, 12 Apr 2023 12:34:00 +0200
Message-ID: <c63dab2b-906d-5383-39f9-b02e7d7d2659@leemhuis.info>
Date:   Wed, 12 Apr 2023 12:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217310 - mt7921e swiotlb buffer is full
Cc:     Petr Tesarik <petr.tesarik.ext@huawei.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681295646;7d9805e5;
X-HE-SMSGID: 1pmXnc-0001gq-N8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developers don't keep an eye on it, I decided to forward it by mail.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

Petr, I CCed you because you apparently dealt with another case with a
similar error message.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217310 :

>  Mike Lothian 2023-04-08 12:03:01 UTC
> 
> Created attachment 304097 [details]
> dmesg
> 
> Since the start of the 6.3 kernel cycle I've been having issues with my
> wifi when it's been going at high speeds, which usually requires me
> having to disable and re enable wifi to get it going again
> 
> When this happens I see this in the logs:
> 
> mt7921e 0000:05:00.0: swiotlb buffer is full (sz: 4096 bytes), total
> 32768 (slots), used 32160 (slots)
> 
> I'm running the latest firmware from
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> 
> And I don't see this on 6.2
> 
> I've attached my dmesg and the device is listed as:
> 
> 05:00.0 Network controller [0280]: MEDIATEK Corp. MT7921 802.11ax PCI
> Express Wireless Network Adapter [14c3:7961]

And later:

> I managed to work around it by setting swiotlb=131072

See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.2..v6.3-rc6
https://bugzilla.kernel.org/show_bug.cgi?id=217310
#regzbot title: dma-mapping: / net: wireless: mt7921e swiotlb buffer is full
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"
