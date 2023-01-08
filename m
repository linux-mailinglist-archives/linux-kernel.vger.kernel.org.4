Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7805661827
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjAHSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjAHSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:30:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC4B486;
        Sun,  8 Jan 2023 10:30:16 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pEaQx-0001Os-9I; Sun, 08 Jan 2023 19:30:15 +0100
Message-ID: <05449f93-1d2f-e678-dc9b-5cc8956149b4@leemhuis.info>
Date:   Sun, 8 Jan 2023 19:30:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: brcmfmac regression - cfg80211_set_channel: set chanspec 0x????
 fail, reason -52 spew
Content-Language: en-US, de-DE
To:     Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Ian Lin <ian.lin@infineon.com>, KalleValo <kvalo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <509b8748971fd988c5dd623adc6db97617a50fb5.camel@gmx.de>
 <6ff1691d505630f3cc7bc1d5c128a7252f66bf71.camel@gmx.de>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <6ff1691d505630f3cc7bc1d5c128a7252f66bf71.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673202617;7c80e34b;
X-HE-SMSGID: 1pEaQx-0001Os-9I
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.01.23 17:29, Mike Galbraith wrote:
> Geez.  Sorry for multiple copies, let's see if any of the CCs work.
> 
> On Sun, 2023-01-08 at 17:18 +0100, Mike Galbraith wrote:
>> Greetings,
>>
>> 6c04deae1438 "brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection"
>>
>> This commit seems to inspire my little raspberrypi 4b to moan
>> endlessly, though it seems to work.  Brute force revert silenced it.

Not my area of expertise, but I'd guess this patch might fix your problem:

https://lore.kernel.org/all/20230103124117.271988-2-arend.vanspriel@broadcom.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> [    7.917448] brcmfmac: F1 signature read @0x18000000=0x15264345
>> [    7.974270] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
>> [    8.326846] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
>> [   10.799571] brcmfmac: brcmf_cfg80211_set_power_mgmt: power save enabled
>> [   15.078022] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, reason -52
>> [   15.078347] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, reason -52
>> [   15.185674] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, reason -52
>> [   15.289609] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, reason -52
>> [   15.393796] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, reason -52
>> [   17.066478] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, reason -52
>> [   17.066923] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, reason -52
>> [   17.070632] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, reason -52
>> [   17.071080] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, reason -52
>> [   17.071653] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, reason -52
>> [   17.072197] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a5 fail, reason -52
>>
> 
