Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C50738898
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjFUPQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjFUPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E2199C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687360237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FRgTCG4Y3quFGRPEFw6nH4nOnDuylcRDDOyFLT5gkg=;
        b=cqCzbe/61K8hJP83fKVQHzZNoROnmDupYWq1bwRV5St1Zhv4TC2BFFTzstF9pvVbnF23Oe
        vD8sFnPUAc26ztTrUurPzP5bK110El80v/f84Eeg+9MNYXqylsgOwqPLU9dPklLM2x8yoN
        kLnrUik7qcGJz6CDbnQfv+6VmYqSJGc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-tmgLoQozMNOiolAo2Y0DIA-1; Wed, 21 Jun 2023 11:10:31 -0400
X-MC-Unique: tmgLoQozMNOiolAo2Y0DIA-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-bfe92598ffaso1484226276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687360226; x=1689952226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FRgTCG4Y3quFGRPEFw6nH4nOnDuylcRDDOyFLT5gkg=;
        b=V/6u2K2GcLIeEdBlz2ZS4Ghlqb1oMtvBUD/QBiC8VaMJWT8ClBpt5s82jo0lAr8HGa
         3sxIs+Sg4grHuOTlmyx8iA2DCafmvxEG+8vpqWpl/LAsgfcGn1mzZTa18CSx/+oESW0Q
         WXMPIe/pE6Rlk5AyZUpZyhjNEV6eIVzgi0VEzZ53cIslkGW3QMB36dkRsSiLGkhuNdea
         IFJSk9Kx4S10u2DNfQG0m3hZlpnrOVHw9QJm6ZYkUaUwAwJ27O4HWcT0dxav788QWnx1
         HTziKhgavYCZ3gqvTx9ElL9kLV9eEUrs1FYIegUPbuTXYmj9UB72sSgbwCWN8e1tqnwA
         JDfQ==
X-Gm-Message-State: AC+VfDyAijcnVVi0yixiyXhOD0ryvQXSrPQFkIgGh9b2yoCHZwfUxsDN
        IvpdnO+gCa7maLMX6Fk+MMGzLKQvVXoZsxV4gCOb9tJbPaXCq4Sg1UFU9p62+jbV8kbbx/dra/u
        SBg/21dOUasjo0RCItM+s04wWtLc5e9XBr0si4wFc
X-Received: by 2002:a25:ad56:0:b0:beb:39a9:2be6 with SMTP id l22-20020a25ad56000000b00beb39a92be6mr11024988ybe.51.1687360226140;
        Wed, 21 Jun 2023 08:10:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ERQQsUqi5FzWoigxI2kl3qagbhHSk5UQ6FecX1jCfga89rhypFQmWtKSMcLTXHfnYobhUxhB0ZS1nDa7S9ek=
X-Received: by 2002:a25:ad56:0:b0:beb:39a9:2be6 with SMTP id
 l22-20020a25ad56000000b00beb39a92be6mr11024969ybe.51.1687360225908; Wed, 21
 Jun 2023 08:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531082428.21763-1-hadess@hadess.net> <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm> <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm> <42b6e582-f642-7521-135a-449140984211@leemhuis.info>
 <53903462-2552-b707-3831-cad3ef873b0d@leemhuis.info> <aa0e3371-dad1-3296-18fb-1957b92aa4d1@pobox.com>
 <ed27ca39-3609-695c-9f04-65c0bad343c2@leemhuis.info>
In-Reply-To: <ed27ca39-3609-695c-9f04-65c0bad343c2@leemhuis.info>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 21 Jun 2023 17:10:14 +0200
Message-ID: <CAO-hwJLyA==_Wkyi-gTn-FOAAne2JKDfNMY2EaELoFDo5Qbe-A@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Mark Lord <mlord@pobox.com>, Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 4:09=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 15.06.23 13:24, Mark Lord wrote:
> > On 2023-06-15 03:24 AM, Linux regression tracking (Thorsten Leemhuis) w=
rote:
> > ...
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D217412
> >>
> >> --- Comment #47 from Mark Blakeney ---
> >> @Juha, kernel 6.3.7 adds the 2 patches intended to fix this bug and th=
e
> >> startup delay is now gone. However, I have had 2 cases over the last 5
> >> days in which I have been running 6.3.7 where my mouse fails to be
> >> detected at all after startup. I have to pull the Logitech receiver
> >> out/in to get the mouse working. Never seen this issue before so I
> >> suspect the patches are not right.
> >> ```
> >
> > I too have had that happen with recent kernels,
>
> Ahh, good to know!
>
> > but have not yet put
> > a finger to a specific version or cause.
> >
> > Just toggling the power button on the wireless mouse is enough for
> > it to "re-appear".
> >
> > The 5.4.xx kernels never had this issue.  I went straight from those
> > to the 6.3.xx ones, where it does happen sometimes, both with and witho=
ut
> > the recent "delay" fixes.
>
> From Mark Blakeney it sounded a lot like this is something that started
> with 6.3, but would be good to confirm. Which brings me to the reason
> why I write this mail:
>
> Is anyone still working on this? There was radio silence already for a
> week now. Okay, it's not really urgent, but I guess this should not fall
> through the cracks.

Sorry for the radio silence. I worked on hidpp yesterday and submitted
a new patch for a problem that was overlooked in the previous fixes:
https://lore.kernel.org/linux-input/20230621-logitech-fixes-v1-1-32e70933c0=
b0@redhat.com/

The loop was not properly initializing all its local states, meaning
that when we encountered a "please retry" from the device, we could
never do the actual retry and returned a different error than in the
6.2 series.

Would anyone give it a shot?

Cheers,
Benjamin

>
> Bastian, are you back?
>
> If not: Does anyone know if there is hope that Bastien will be able to
> look into this in the not too far future?
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>

