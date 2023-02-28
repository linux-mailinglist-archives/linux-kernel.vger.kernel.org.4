Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC86A59FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjB1N1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1N1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33402A16E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677590797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nflL+RFyijy+MOrYN/ocNgDme0JSg3TrgUceQka/qA=;
        b=LPh5xxvZKmlNRfvSIGucic10IkHuG9OB0udJ8Oy7KdkNOrFj5PGZAXs1KTHvrFbC8ST/pa
        UbCSiCHVX3NNEoFAyip0ZW6N8h4xev7qEPAB4ERv5WEYKlojCvBW+nG1jwzqzj97Ux69kM
        +UdKslb4atmcH9XR+9xq+4mljrVjWLU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-_UfATNUlMEaQq0-XN3wh9A-1; Tue, 28 Feb 2023 08:26:36 -0500
X-MC-Unique: _UfATNUlMEaQq0-XN3wh9A-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-53865bdc1b1so210268787b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nflL+RFyijy+MOrYN/ocNgDme0JSg3TrgUceQka/qA=;
        b=DRRT/UfcBWOSxbp2lHvOmXiYm1ZECF+NmO14qEJGoglIxffZwZVBXrq9qjeowegiiE
         73HT9wpDXAYaKIS9ymc+hi/fnTaSQxh3kK9ixQXARNkf2nNbn0nPnkTR8Of5K7t3yJ4P
         sRKCR5E8ukExV9UjhZpv556EPpOmUe+GjuiCAwDalMsgSu2jLsjc2HuhUJnNJOQBk6i7
         TEcIIDUT33H9xq1C+8aKiV6H4MQJehsDxD5BvvYICFsztZXHnKVk205HN2Wq/wtfXAG0
         FIG1ykeApkSDw/NCw25ZyzZL8t/GmzaCYC2lgJOYnvKT6Gxe1/51t/1PtPTL8hiqedv5
         ftUQ==
X-Gm-Message-State: AO0yUKXA/zXwN0KVCTmVpdO0u7CYIBW2pizSkErUTPI2OEvDJ0cO+fHu
        QIZB144JtK35YiP8Iz5Tk6ZI/r7LWGdUPa2ALs9si5tmWzxx5P6kUbr/i6k5/Vg/aN3nBtj+XBz
        KD3OSKhoyTpJG6fUp48yfSHilQ+K/20IhJOGN56Ew
X-Received: by 2002:a81:b705:0:b0:533:9252:32fa with SMTP id v5-20020a81b705000000b00533925232famr1578241ywh.4.1677590796197;
        Tue, 28 Feb 2023 05:26:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/3bX4Gi9ZZkPRvxv4eE2vCAWG/LKy0mNnDqFLbSl9TB9oMlrHOu7ukkN8cStIHo0bp2imE/jCHAgG4yhN9/PM=
X-Received: by 2002:a81:b705:0:b0:533:9252:32fa with SMTP id
 v5-20020a81b705000000b00533925232famr1578233ywh.4.1677590795935; Tue, 28 Feb
 2023 05:26:35 -0800 (PST)
MIME-Version: 1.0
References: <32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info> <abb495f7-f973-4614-846b-d3922dc0fe25@leemhuis.info>
In-Reply-To: <abb495f7-f973-4614-846b-d3922dc0fe25@leemhuis.info>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 28 Feb 2023 14:26:24 +0100
Message-ID: <CAO-hwJJ2OMFgpmrXK_Z43z0ddujaS1fNjaAJSWwao4qQN+pJ6w@mail.gmail.com>
Subject: Re: [regression] Bug 216946 - Toshiba satellite click mini l9w-b:
 touchscreen: no touch events with kernel 6.1.4
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Hans De Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?R8OpIEtvZXJrYW1w?= <ge.koerkamp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 12:32=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 19.01.23 16:06, Linux kernel regression tracking (Thorsten Leemhuis)
> wrote:
> > Hi, this is your Linux kernel regression tracker.
> >
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developer don't keep an eye on it, I decided to forward it by
> > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D216946=
 :
>
> The reporter recently confirmed in the ticket that the issue still
> happens with 6.2.
>
> There wasn't any reply from any of the input developers here or in
> bugzilla afaics. :-/ Hmmm. Could someone from that camp maybe please
> take a minute and at least briefly look into this as answer something
> like "that might be due to a problem in subsystem 'foo'", "maybe ask bar
> for an option", or "we have no idea what might cause this, this needs to
> be bisected"? That would help a lot.

The working dmesg shows a line with:
hid-generic 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00 Device
[SIS0817:00 0457:10FB] on i2c-SIS0817:00
and then
hid-multitouch 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00
Device [SIS0817:00 0457:10FB] on i2c-SIS0817:00

But these 2 lines do not appear on the 6.1.4 logs.

So the device is not properly enumerated by ACPI or I2C. Hans might
have an idea on how to debug/solve that issue.

Also there were no changes between v5.15 and v5.16 in i2c-hid.ko, so
it's unlikely to be an issue there (unless '5.16' means '5.16.x').

Cheers,
Benjamin

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
> >>  G=C3=A9 Koerkamp 2023-01-17 20:21:51 UTC
> >>
> >> Created attachment 303619 [details]
> >> Kernel configuration for v6.1.4/ journalctl (dmesg)/ ACPIdump/lsmod
> >>
> >> Overview:
> >> The touchscreen does not react on touch events.
> >> Touchscreen display and touchpad are working.
> >>
> >> Step to reproduce:
> >> Open any UI page
> >> Try to use touch on relevant UI controls (buttons etc.)
> >>
> >> Result:
> >> No reaction on screen touches
> >>
> >> Expected result:
> >> Reaction on touched control, same as when using the touch pad or conne=
cted mouse (which do work).
> >>
> >> Build information:
> >> The error happens with kernel version 6.1.4
> >> After rebuilding with different kernel versions, it appears that it fi=
rst fails with kernel 5.16
> >>
> >> Additional builds:
> >> The click mini l9w-b still works with kernel 5.10.y LTS and 5.15.y LTS=
.
> >>
> >> Important remark:
> >> Touchscreen still works fine with kernel 6.1.4 using
> >> - an HP x2 detachable 10-p0xx or
> >> - a Lenovo yoga 520-14ikb
> >>
> >> So it could be a hardware dependent issue
> >
> > See the ticket for more details.
> >
> >
> > [TLDR for the rest of this mail: I'm adding this report to the list of
> > tracked Linux kernel regressions; the text you find below is based on a
> > few templates paragraphs you might have encountered already in similar
> > form.]
> >
> > BTW, let me use this mail to also add the report to the list of tracked
> > regressions to ensure it's doesn't fall through the cracks:
> >
> > #regzbot introduced: v5.15..v5.16
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216946
> > #regzbot title: hid: touchscreen broken with Toshiba satellite click
> > mini l9w-b
> > #regzbot ignore-activity
> >
> > This isn't a regression? This issue or a fix for it are already
> > discussed somewhere else? It was fixed already? You want to clarify whe=
n
> > the regression started to happen? Or point out I got the title or
> > something else totally wrong? Then just reply and tell me -- ideally
> > while also telling regzbot about it, as explained by the page listed in
> > the footer of this mail.
> >
> > Developers: When fixing the issue, remember to add 'Link:' tags pointin=
g
> > to the report (e.g. the buzgzilla ticket and maybe this mail as well, i=
f
> > this thread sees some discussion). See page linked in footer for detail=
s.
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
>

