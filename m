Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68228661422
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 09:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjAHIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 03:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjAHIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 03:20:25 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A0313DEC;
        Sun,  8 Jan 2023 00:20:24 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pEQuk-00071S-Dt; Sun, 08 Jan 2023 09:20:22 +0100
Message-ID: <d073942d-f6b6-81c4-5058-04d99185929a@leemhuis.info>
Date:   Sun, 8 Jan 2023 09:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?Q?Re=3a_=5bregression=5d_Bug=c2=a0216894_-_brcmfmac_stopped?=
 =?UTF-8?Q?_working_due_to_missing_firmware=3b_brcmf=5fpcie=5finit=5fringbuf?=
 =?UTF-8?Q?fers=3a_invalid_max=5fflowrings=28264=29?=
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Wright Feng <wright.feng@infineon.com>
Cc:     Ian Lin <ian.lin@infineon.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        Christian Marillat <marillat@debian.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Double Lo <double.lo@infineon.com>,
        Kurt Lee <kurt.lee@infineon.com>
References: <ef8861dc-33df-0e35-4205-c8c666a3f4ba@leemhuis.info>
In-Reply-To: <ef8861dc-33df-0e35-4205-c8c666a3f4ba@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673166024;38e4f42d;
X-HE-SMSGID: 1pEQuk-00071S-Dt
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending this once more as a reply to myself, as I forgot to CC the
maintainers for the driver. And now I'm also using the current email
address for Wright Feng (my earlier mail used the one used for the
culprit, but that bounced).

Sorry for the noise, seem I need more tea.

On 08.01.23 08:59, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216894 :

Subject for that bug report is "Regression in commit
2aca4f3734bd717e04943ddf340d49ab62299a00"

>>  Christian Marillat 2023-01-06 10:58:26 UTC
>>
>> Hi,
>>
>> With this commit the kernel doesn't load the firmware and I lost my wifi device, But without this commit the firmware load fine without a kernel panic.
>>
>> kernel 6.0.15/6.1.3
>> brcmfmac 0000:02:00.0: brcmf_pcie_init_ringbuffers: invalid max_flowrings(264)
>>
>> kernel 6.0.17
>> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4366c-pcie for chip BCM4366/4
>> brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
>> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4366/4 wl0: Nov  5 2018 03:19:56 version 10.28.2 (r769115) FWID 01-d2cbb8fd
>>
>> PCI info :
>>
>> 02:00.0 Network controller: Broadcom Inc. and subsidiaries Device 43c3 (rev 04)
>> 	Subsystem: ASUSTeK Computer Inc. Device 86fb
>> 	Flags: bus master, fast devsel, latency 0, IRQ 45
>> 	Memory at f7000000 (64-bit, non-prefetchable) [size=32K]
>> 	Memory at f6800000 (64-bit, non-prefetchable) [size=8M]
>> 	Memory at f2400000 (64-bit, prefetchable) [size=4M]
>> 	Capabilities: <access denied>
>> 	Kernel driver in use: brcmfmac
>> 	Kernel modules: brcmfmac
>>
>> Christian
>>
>> [reply] [−] Comment 1 Christian Marillat 2023-01-06 11:00:21 UTC
>>
>> kernel version should be  6.0.17/6.1.3 and 6.0.15
>>
>> Christian
>>
> 
> See the ticket for more details.
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: 2aca4f3734bd717e04943
> https://bugzilla.kernel.org/show_bug.cgi?id=216894
> #regzbot title: net: wifi: brcmfmac stopped working as firmware is not
> loaded anymore
> #regzbot ignore-activity
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
