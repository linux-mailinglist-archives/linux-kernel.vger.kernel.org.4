Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8E664DD53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiLOPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLOPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:09:58 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C0303F1;
        Thu, 15 Dec 2022 07:09:56 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id p18so2770681qkg.2;
        Thu, 15 Dec 2022 07:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRK7b4YTFDqD0ddpHKV1yukQyR96FeHvIOON11LsLBg=;
        b=3OEhIwMkX1t8DWtD8yncIFq73+f8jlmBye01D7jXXHe6vCzQr99WfP2QrEyLaWzAEg
         biyC/uoMpWgTOTPOeo95QKVYAXSPhpBYIa2ojuGGey/IHczQl1yFD6g5nNR1IdYYFnNs
         /l+JEHp2fYjYFYHBcB6sm6ADbw2qyA+YUuD525A9xxQTV9mpNziaSFEphEi66jDsTRqF
         bcIvDwrpqL+aSQZQpr2TjgI42I9y3y1KcZ5nDM+/qrvOk0DB6klfy01PF2HHdzpe5fuT
         +5BjZM8Gc55hd40R3kiUsPOB4zLh76iSezbsznc+G0TEK0cHZWI2/qXKgyqU88prSX/P
         cWtw==
X-Gm-Message-State: ANoB5pkLXfwOe6O40qq1ETwdT11+otcNOOWbFndBXwQaWCn+UL8FHi+2
        d5C5awkT1mgwOrkAPMYA+m9ob2udWtzjrMEp8dc=
X-Google-Smtp-Source: AA0mqf7wusuKMs1Q8WwRWT/Pt548QltdxupyQSw7BdWJWLp7RFWt/7IPy4nNx0f8dhf5aJlnBUqxaT4CuGH14pvSFhE=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr82807384qkb.443.1671116995879; Thu, 15
 Dec 2022 07:09:55 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <1df12728a2e788788fd387588bac62023e123d16.camel@hadess.net>
 <2145955.irdbgypaU6@kreacher> <CAJZ5v0ic+pm+NWD8g4O2MwQEvi+xuB-W9Wpd6c1RhprhoxuK1g@mail.gmail.com>
 <8281ddcc16cc950f9cde4b196cf208adcc798319.camel@hadess.net>
 <CAJZ5v0gjAGZFS6ap+NAbsi96hq7y9MRGE0h_A-n6xfB1CMs=2g@mail.gmail.com>
 <cd8b2a2160f5d36d1b73bc0567cd0f6e7e5751c4.camel@hadess.net>
 <CAJZ5v0gRm1NG=QuDFDFdcZgTu7Q0Z3cW3fwGg09sD+3BBV8E1A@mail.gmail.com>
 <91367d07a72ecb2065faebe974c54ebd966e0d59.camel@hadess.net>
 <CAJZ5v0ghW2DdC0quVQ-+Oad7bR95Pyp4Uhd9=XUYk9SQrXKj5w@mail.gmail.com>
 <b356b5684cc631513c0498f18d7c185b77416f85.camel@hadess.net> <6b5e878265958fb0201178fc3c1d75ef06c826ec.camel@hadess.net>
In-Reply-To: <6b5e878265958fb0201178fc3c1d75ef06c826ec.camel@hadess.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Dec 2022 16:09:44 +0100
Message-ID: <CAJZ5v0j3c33q_X-RoUxT4NnE=zoONvHCmMECz507E0XXRpOczA@mail.gmail.com>
Subject: Re: [Regression] Logitech BT mouse unusable after commit 532223c8ac57
 (still in 6.1-rc8)
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 5:14 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2022-12-08 at 16:20 +0100, Bastien Nocera wrote:
> > On Wed, 2022-12-07 at 18:44 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Dec 7, 2022 at 6:19 PM Bastien Nocera <hadess@hadess.net>
> > > wrote:
> > > >
> > > > On Wed, 2022-12-07 at 12:07 +0100, Rafael J. Wysocki wrote:
> > > > > # hidpp-list-features /dev/hidraw1
> > > > > Bluetooth Mouse M336/M337/M535 (046d:b016) is a HID++ 4.5
> > > > > device
> > > > > Feature 0x01: [0x0001] Feature set
> > > > > Feature 0x02: [0x0003] Device FW version
> > > > > Feature 0x03: [0x0005] Device name
> > > > > Feature 0x04: [0x0020] Reset
> > > > > Feature 0x05: [0x1e00] Enable hidden features (hidden)
> > > > > Feature 0x06: [0x1800] Generic Test (hidden, internal)
> > > > > Feature 0x07: [0x1000] Battery status
> > > > > Feature 0x08: [0x1b04] Reprog controls v4
> > > > > Feature 0x09: [0x2100] Vertical scrolling
> > > > > Feature 0x0a: [0x2200] Mouse pointer
> > > > > Feature 0x0b: [0x2205] Pointer speed
> > > > > Feature 0x0c: [0x18b1] ? (hidden, internal)
> > > > > Feature 0x0d: [0x2121] Hi-res wheel
> > > > > Feature 0x0e: [0x1f03] ? (hidden, internal)
> > > >
> > > > Would you be able to enable debugging for the hid subsystem to
> > > > get
> > > > some
> > > > debug data when getting the version from the device fails?
> > >
> > > I guess I could, but I think that the device is just quirky.
> > >
> > > At least the BT layer appears to think that it is connected.
> > >
> > > Anyway, what exactly do you need?
> > >
> > > > I can't see any problems in there that wouldn't also have
> > > > impacted
> > > > all
> > > > the other Logitech Bluetooth devices listed in the support
> > > > devices
> > > > list.
> > > >
> > > > If the problem is a timeout, maybe we should lower the timeouts
> > > > we
> > > > currently have (5*HZ = 5 seconds, right?), so we can retry 5
> > > > times
> > > > one
> > > > second instead.
> > >
> > > No, it doesn't take 5 sec to get a response from it.  It rather
> > > looks
> > > like __hidpp_send_report() returns an error.
> >
> > Adding "debug" on the kernel command-line should be enough to get
> > debug
> > out of hidpp_send_message_sync():
> > https://stackoverflow.com/a/63682160
> >
> > Either that or turn all the dbg_hid() into hid_err() if you're going
> > to
> > be compiling the kernel.
> >
> > We're mainly interested in the error code from the device, as that's
> > what I'm guessing is caused the error to propagate.
>
> Can you also check whether you had:
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?id=8b7e58409b1813c58eea542d9f3b8db35b4ac1f7
> in your git tree?
>
> Would be great to know whether that commit helps at all.

No, it's not present in the kernels I've tested so far.
