Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DC680B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjA3Kgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjA3Kgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:36:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE272718
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675074961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/wXvsciQ0KooaHBSOQrZRetD56/VUpWj90cA08FSe/s=;
        b=J/gRqGt9c7O4icQ/dqQvA3/QrHof0Ppq2E6pcu9y3lZMIPOs1lTUfKloUCk60dDp0D12dw
        dzV1RfCueqcz/DzifV0U9uqc7s9HDw91JKD8fd6FZZQgQvdsDQo/+rK5pB8ch7DtApXfF0
        8jhnIuIRZtkvgYnuT3CJ8vH0bEIaTas=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-ZpsAPXHMNseB5qnr9jkafQ-1; Mon, 30 Jan 2023 05:35:59 -0500
X-MC-Unique: ZpsAPXHMNseB5qnr9jkafQ-1
Received: by mail-yb1-f198.google.com with SMTP id u186-20020a2560c3000000b007c8e2cf3668so12553459ybb.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wXvsciQ0KooaHBSOQrZRetD56/VUpWj90cA08FSe/s=;
        b=qCXls5KTaky1Y1kMOuG/dojxOP9AjUUNN0kXPxjea34OqycJ/xcVGJpiU1HxNcvPNd
         PuU4n2c4vXwZZfd7MoK9Y8EWJb9SWRT5PdMdRub15PA0UJ+5RmoeUXT2m6QyUr+i/sGw
         m0k4KN2J7A7T4ylePrVP/6ixM4gM5A+AXWPnkAv/fLhEex/BlOA6ABMoJimnU9VQSRBy
         0o1ZbjSCzY9flmkvKxwPyUCQl6qCkhPij+OO5dQTHapmNAudtsecFX9WwN+JynifA5EX
         my56d5+v7tCovv/JVli0IzvLr7H8hcJhVQ2WQDGRL0JhrEhAEGdf7v/qeoWtw6dAfGG6
         NgeQ==
X-Gm-Message-State: AFqh2kpt7L+h+5Z8Eu4SevEUJbuK+awiHMfvmL+K6bx7DI4ar3KdRmB1
        WHeTEX/Nw4DJZBg1YYS86nI4MNLC1VOIOpLk8Yn4o+R0yoy+BDt8gEhC0Urovvzc+PxLCUqnwm/
        o3Kg+RgDYKIdnqagkrO3OcPUUasxDCrRNrqjsQ1uP
X-Received: by 2002:a25:c881:0:b0:7e8:ee11:9717 with SMTP id y123-20020a25c881000000b007e8ee119717mr5586430ybf.495.1675074958754;
        Mon, 30 Jan 2023 02:35:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs3NALW6sRFXMXHjsUm5AoXYtnmMaer0VfPdK6xb8TQcw5A5v00DIlVSANsdRqDaB39Vmu+u8RPCUZpf3gyL2I=
X-Received: by 2002:a25:c881:0:b0:7e8:ee11:9717 with SMTP id
 y123-20020a25c881000000b007e8ee119717mr5586426ybf.495.1675074958451; Mon, 30
 Jan 2023 02:35:58 -0800 (PST)
MIME-Version: 1.0
References: <1bb93259-1c9f-5335-a0bf-fc8641b26650@leemhuis.info> <be545e72-8312-f213-0250-86a128b7b629@leemhuis.info>
In-Reply-To: <be545e72-8312-f213-0250-86a128b7b629@leemhuis.info>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 30 Jan 2023 11:35:47 +0100
Message-ID: <CAO-hwJJtK3B2x8CAAYsB41X8D=1EpEYK+nSuVA+fXuz1LHkmSg@mail.gmail.com>
Subject: Re: [Regression] Bug 216885 - HID++ Logitech G903 generates full
 scroll wheel events with every hi-res tick when attached via USB
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
        David Roth <davidroth9@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klausmann <klausman@i-no.de>,
        Linus <luna+bugzilla@cosmos-ink.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:56 AM Linux kernel regression tracking
(Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>
> [ccing a few people that CCed to the bug]
>
> Hi, this is your Linux kernel regression tracker.
>
> On 05.01.23 09:12, Thorsten Leemhuis wrote:
> > [...] Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216885 :
> >
> >>  David Roth 2023-01-04 20:37:22 UTC
> >>
> >> Created attachment 303526 [details]
> >> Libinput record with G903 attached directly to USB
> >>
> >> Since
> >> https://lore.kernel.org/linux-input/20220914132146.6435-1-hadess@hadess.net/T/#u
> >> my Logitech G903 has gained hi res support. While normally a good
> >> thing, it seems that in this case it leads to generating one normal
> >> REL_WHEEL with each REL_WHEEL_HI_RES event instead of just a couple
> >> of REL_WHEEL_HI_RES, followed by the standard REL_WHEEL once a
> >> notch/tick is reached. This leads to overly sensitive scrolling and
> >> makes the wheel basically useless.
>
> Bastien, Benjamin, Jiri, that problem was reported 25 days ago now and
> there is still no fix in sight afaics (please correct me if I'm wrong)
> -- and based on the reports I've seen it seem quite a few people are
> hitting it. Hence please allow me to ask:
>
> Wouldn't it be best to revert that change for now (both in mainline and
> stable of course) and then reapply it once a fix for this problem is
> available? Or

Last I heard was that Bastien was actively trying to understand the
problem. I do have a G903 here but it is lacking the feature the
reporters have, and so I can not reproduce (there is likely a new
firmware/model around).

After a quick search on
https://support.logi.com/hc/en-us/search#q=G903&s=all it seems that
there are 2 G903: M-R0081 and M-R0068. I only own the 68 one which
explains why I can not reproduce it. :(

Cheers,
Benjamin


>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> >> Interestingly this only happens when the mouse is connected directly via
> >> cable (PID:0xC091) and not via the Lightspeed wireless dongle
> >> (PID:0x4087) where it will lead to correctly applying the times 8
> >> multiplier and the relevant set of HI_RES and REL_WHEEL event once a
> >> notch is reached.
> >>
> >> I originally thought about patching the module/adding a param to simple
> >> disable high res support in general, assuming this might be something
> >> people might want to configure, but seeing that this can be "fixed" that
> >> way I decided to hold off on the thought.
> >>
> >> However it seems like we'd need to trade one set of quirks for another,
> >> so not sure what the correct approach might be.
> >>
> >> I'll attach some libinput debug logs when the issue happens.
> >
> > See the ticket for more details.
> >
> > BTW, let me use this mail to also add the report to the list of tracked
> > regressions to ensure it's doesn't fall through the cracks:
> >
> > #regzbot introduced: 908d325e1665
> > https://bugzilla.kernel.org/show_bug.cgi?id=216885
> > #regzbot title: hid: overly sensitive scrolling with Logitech G903 that
> > makes the wheel basically useless
> > #regzbot ignore-activity
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
>

