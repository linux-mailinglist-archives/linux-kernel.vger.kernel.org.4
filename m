Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAEB717AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjEaIvM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjEaIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:50:46 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A14121;
        Wed, 31 May 2023 01:50:41 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C31C3FF803;
        Wed, 31 May 2023 08:50:38 +0000 (UTC)
Message-ID: <8308180826ba9a5478bf568396034b8dc7fb6e72.camel@hadess.net>
Subject: Re: [BUG: 6.3 kernel] Logitech Trackball M575 misidentified
From:   Bastien Nocera <hadess@hadess.net>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Xose Vazquez Perez <xose.vazquez@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 31 May 2023 10:50:38 +0200
In-Reply-To: <8941c5f2-3861-da68-06ca-adc68a37e53b@leemhuis.info>
References: <eeb19342-3499-a1fb-388f-d4670472b16c@gmail.com>
         <8941c5f2-3861-da68-06ca-adc68a37e53b@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 14:33 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> [CCing a few people and the the regression list, as it should be in
> the
> loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> On 11.05.23 23:22, Xose Vazquez Perez wrote:
> > 
> > 6.3.2 kernel identifies "Logitech" "ERGO M575" as "Logitech"
> > "(\xc9_O\x04)",
> > 6.2.15 works fine.
> > 
> > 
> > 6.2.15 boot log:
> > input: Logitech ERGO M575 as
> > /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.3/3-
> > 1.3:1.2/0003:046D:C52B.0003/0003:046D:4096.0005/input/input15
> > logitech-hidpp-device 0003:046D:4096.0005: input,hidraw1: USB HID
> > v1.11
> > Mouse [Logitech ERGO M575] on usb-0000:00:1a.0-1.3/input2:1
> > 
> > 6.3.2 boot log:
> > input: Logitech \xc9_O\x04 as
> > /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.3/3-
> > 1.3:1.2/0003:046D:C52B.0003/0003:046D:4096.0005/input/input15
> > logitech-hidpp-device 0003:046D:4096.0005: input,hidraw2: USB HID
> > v1.11
> > Mouse [Logitech \xc9_O\x04] on usb-0000:00:1a.0-1.3/input2:1
> 
> I wonder if this if this is some related to this issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=217412
> ("Since kernel 6.3.1 logitech unify receiver not working properly")
> 
> That one so far seems to be ignored by the developers. Your report
> one
> also didn't get any reply yet.
> 
> Could you maybe perform a bisection to get down to this?
> 
> Side note: there is also
> https://bugzilla.kernel.org/show_bug.cgi?id=217330
> ("Broken Logitech unifying battery names in hid-next tree")

The device name problem is tracked in 217330, which I filed.

A bisection would definitely help me if you have time, otherwise I'll
get to it, but it's probably not going to be before a couple of weeks.

You can also test this patch on top of the latest kernel tree:
https://patchwork.kernel.org/project/linux-input/patch/20230531082428.21763-1-hadess@hadess.net/
although I don't expect it to make a difference.

Cheers

> 
> 
> Anyway, for the rest of this mail:
> 
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel
> regression
> tracking bot:
> 
> #regzbot ^introduced v6.2..v6.3
> #regzbot title input: Logitech Trackball M575 misidentified
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify
> when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed
> in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags
> pointing
> to the report (the parent of this mail). See page linked in footer
> for
> details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
> hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.

