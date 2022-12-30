Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC54659617
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiL3IJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiL3IJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:09:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81326183BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:09:00 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pBARm-0001HW-3W; Fri, 30 Dec 2022 09:08:58 +0100
Message-ID: <bebd692d-7d21-6648-6b7a-c91063bb51c2@leemhuis.info>
Date:   Fri, 30 Dec 2022 09:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Sergey <zagagyka@basealt.ru>,
        Alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
Subject: =?UTF-8?Q?=5bregression=2c_5=2e10=2ey=5d_Bug=c2=a0216861_-_sound_di?=
 =?UTF-8?Q?sappearance_on_Acer_Swift_3_SF314-59-78UR_after_update_to_5=2e10?=
 =?UTF-8?Q?=2e157?=
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672387740;d7edfec5;
X-HE-SMSGID: 1pBARm-0001HW-3W
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216861 :

>  Sergey 2022-12-29 10:07:51 UTC
> 
> Created attachment 303497 [details]
> pulseaudio.log
> 
> Sudden sound disappearance was reported for some laptops, e.g.
> 
> Acer Swift 3 SF314-59-78UR 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
> 
> # lspci
> 0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)
>         Subsystem: Acer Incorporated [ALI] Device 148c
>         Flags: bus master, fast devsel, latency 32, IRQ 197, IOMMU group 12
>         Memory at 601f270000 (64-bit, non-prefetchable) [size=16K]
>         Memory at 601f000000 (64-bit, non-prefetchable) [size=1M]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [80] Vendor Specific Information: Len=14 <?>
>         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Kernel driver in use: sof-audio-pci
> 
> I am attaching the pulseaudio and dmesg logs
> 
> This bug started reproducing after updating the kernel from 5.10.156 to 5.10.157
> 
> Bisection revealed the commit being reverted:
> 
> c34db0d6b88b1da95e7ab3353e674f4f574cccee is the first bad commit
> commit c34db0d6b88b1da95e7ab3353e674f4f574cccee
> Author: Richard Fitzgerald <rf@opensource.cirrus.com>
> Date:   Fri Nov 4 13:22:13 2022 +0000
> 
>     ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()
>     
>     [ Upstream commit 39bd801d6908900e9ab0cdc2655150f95ddd4f1a ]
>     
>     The DAI tx_mask and rx_mask are set by snd_soc_dai_set_tdm_slot()
>     and used by later code that depends on the TDM settings. So
>     __soc_pcm_open() should not be obliterating those mask values.
>     
> [...]
> Original bug report: https://bugzilla.altlinux.org/44690

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: c34db0d6b88b1d
https://bugzilla.kernel.org/show_bug.cgi?id=216861
#regzbot title: sound: asoc: sudden sound disappearance
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
