Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9F704DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjEPMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjEPMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:33:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44B109;
        Tue, 16 May 2023 05:33:26 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pytro-0005Hc-6i; Tue, 16 May 2023 14:33:24 +0200
Message-ID: <8941c5f2-3861-da68-06ca-adc68a37e53b@leemhuis.info>
Date:   Tue, 16 May 2023 14:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [BUG: 6.3 kernel] Logitech Trackball M575 misidentified
Content-Language: en-US, de-DE
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        linux-input@vger.kernel.org
References: <eeb19342-3499-a1fb-388f-d4670472b16c@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <eeb19342-3499-a1fb-388f-d4670472b16c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684240406;c7f7ccdc;
X-HE-SMSGID: 1pytro-0005Hc-6i
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing a few people and the the regression list, as it should be in the
loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 11.05.23 23:22, Xose Vazquez Perez wrote:
> 
> 6.3.2 kernel identifies "Logitech" "ERGO M575" as "Logitech"
> "(\xc9_O\x04)",
> 6.2.15 works fine.
> 
> 
> 6.2.15 boot log:
> input: Logitech ERGO M575 as
> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.3/3-1.3:1.2/0003:046D:C52B.0003/0003:046D:4096.0005/input/input15
> logitech-hidpp-device 0003:046D:4096.0005: input,hidraw1: USB HID v1.11
> Mouse [Logitech ERGO M575] on usb-0000:00:1a.0-1.3/input2:1
> 
> 6.3.2 boot log:
> input: Logitech \xc9_O\x04 as
> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.3/3-1.3:1.2/0003:046D:C52B.0003/0003:046D:4096.0005/input/input15
> logitech-hidpp-device 0003:046D:4096.0005: input,hidraw2: USB HID v1.11
> Mouse [Logitech \xc9_O\x04] on usb-0000:00:1a.0-1.3/input2:1

I wonder if this if this is some related to this issue:
https://bugzilla.kernel.org/show_bug.cgi?id=217412
("Since kernel 6.3.1 logitech unify receiver not working properly")

That one so far seems to be ignored by the developers. Your report one
also didn't get any reply yet.

Could you maybe perform a bisection to get down to this?

Side note: there is also
https://bugzilla.kernel.org/show_bug.cgi?id=217330
("Broken Logitech unifying battery names in hid-next tree")


Anyway, for the rest of this mail:

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v6.2..v6.3
#regzbot title input: Logitech Trackball M575 misidentified
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
