Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6474BDC0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGHOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjGHOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:12:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D61991;
        Sat,  8 Jul 2023 07:12:25 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qI8fe-0004R5-4r; Sat, 08 Jul 2023 16:12:22 +0200
Message-ID: <cf6ef663-d947-ca54-a9c4-beeb105ff5bb@leemhuis.info>
Date:   Sat, 8 Jul 2023 16:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
Content-Language: en-US, de-DE
To:     Amit Pundir <amit.pundir@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org>
 <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688825545;b7616270;
X-HE-SMSGID: 1qI8fe-0004R5-4r
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 07.07.23 11:41, Amit Pundir wrote:
> Hi Johan,
> 
> On Wed, 31 May 2023 at 14:35, Johan Hovold <johan+linaro@kernel.org> wrote:
>>
>> Devices that lack persistent storage for the device address can indicate
>> this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controller
>> to be marked as unconfigured until user space has set a valid address.
>>
>> The related HCI_QUIRK_USE_BDADDR_PROPERTY was later added to similarly
>> indicate that the device lacks a valid address but that one may be
>> specified in the devicetree.
>>
>> As is clear from commit 7a0e5b15ca45 ("Bluetooth: Add quirk for reading
>> BD_ADDR from fwnode property") that added and documented this quirk and
>> commits like de79a9df1692 ("Bluetooth: btqcomsmd: use
>> HCI_QUIRK_USE_BDADDR_PROPERTY"), the device address of controllers with
>> this flag should be treated as invalid until user space has had a chance
>> to configure the controller in case the devicetree property is missing.
>>
>> As it does not make sense to allow controllers with invalid addresses,
>> restore the original semantics, which also makes sure that the
>> implementation is consistent (e.g. get_missing_options() indicates that
>> the address must be set) and matches the documentation (including
>> comments in the code, such as, "In case any of them is set, the
>> controller has to start up as unconfigured.").
>>
> 
> This patch broke Bluetooth on Dragonboard 845c (SDM845) devboard.
> Reverting this patch fixes the BT breakage and I see the following
> messages in dmesg:
> 
> Bluetooth: hci0: setting up wcn399x
> Bluetooth: hci0: QCA Product ID   :0x0000000a
> Bluetooth: hci0: QCA SOC Version  :0x40010214
> Bluetooth: hci0: QCA ROM Version  :0x00000201
> Bluetooth: hci0: QCA Patch Version:0x00000001
> Bluetooth: hci0: QCA controller version 0x02140201
> Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> Bluetooth: hci0: QCA Downloading qca/crnv21.bin
> Bluetooth: hci0: QCA setup on UART is completed

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 6945795bc81
#regzbot title Bluetooth: Dragonboard 845c (SDM845) devboard broken
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
