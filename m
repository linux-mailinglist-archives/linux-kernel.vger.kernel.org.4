Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A4D5BAF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiIPOvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiIPOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:51:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE1AA3FA;
        Fri, 16 Sep 2022 07:51:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j188so4085136oih.0;
        Fri, 16 Sep 2022 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EBqCKShT/F8kMJH+Z3gM3kcmqT/mLcpixNsbluDSabY=;
        b=ZQ+ACWTj+tDVmU1b+agSsJZd6a5IS2rB0q/WHmmuTuxBnjJbUZXIYTQ7FPOOmt1b92
         KN09NPjvBGMqZ98ITIpjOXP0xiwLQ4H40dwk0smybp59dgwugcA245ehNdO5ItzO43VL
         f5s5WiceQd3TjQ8WtP4KSN2FmcZIFdWUDCJlhIVodeUCVd57p+wts5Jv9kZzFeE54jM7
         M23tHA7TJX3da4ZOkxAD7MoOQlqwCh3Q2YJNSq1a93OouGD7zDPOE0zlPGlM3FxlKwze
         NgqhbKKv1TcVJYp8SVHA3UR4BmvydRRnZQwX28Y9lCu4AuF3AtIOgc6RFXwcasGyII35
         KAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EBqCKShT/F8kMJH+Z3gM3kcmqT/mLcpixNsbluDSabY=;
        b=7wHkbX+CWesjSmhbJWUdhLltTkW4YO6D5K/LEEvPM7a2dR+tZVRYNWCz9o4Ei1ZGqv
         uRuc/z3mQsg++XjThWRcXOYrI9rkvfCwCd2v1k+xOalIMIg8dUtm6a40NtkOx9OycpFR
         oO8kAq3jEF9ydAJJamVS3DdiE+Cl4LV9kGk6AxGeB9rAdBfeT8AK2SIF6zrOI9qiSE1r
         As1VaWZ0TPIc9CI6UEnI/THHVDLbv7tS8L8p/gW7H+6yXYUmdN1Gy8aftWnPsTby7VuN
         VdYq2Uyp0kX8Ic3V1rM5k89bW9IWUSeFRNr5kILTlbbpcNu6QybMvPAMPuOgHoSJqFGl
         Z/dw==
X-Gm-Message-State: ACrzQf2ZD0TrSI7ddKqhIJDGBRongEMNqHP1R/8/bz4pvZHNSrFuEcIg
        MM1rIeMd8Au2O+3Vp3qxvAB3qMbzguZlHaypCelv+Y+0YkhBEGFWm4g=
X-Google-Smtp-Source: AMsMyM4u6Yt0nQEAgIxRqF8ByBOCtBXgFVf54bX03uKK29Rpm3rIkZMafjoU1bDV8cBINjL2cnNcV9kBs4DLmrzl24w=
X-Received: by 2002:a05:6808:168f:b0:34b:ac91:6f5f with SMTP id
 bb15-20020a056808168f00b0034bac916f5fmr2653045oib.254.1663339869682; Fri, 16
 Sep 2022 07:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220915150155.9908-1-91tuocao@gmail.com> <87fsgsee2n.fsf@meer.lwn.net>
In-Reply-To: <87fsgsee2n.fsf@meer.lwn.net>
From:   tuo cao <91tuocao@gmail.com>
Date:   Fri, 16 Sep 2022 22:50:58 +0800
Message-ID: <CAEVeK2CMs8J3urkZnRpbW=965sT51N3Qey=0y-JwkvHZy_FFRA@mail.gmail.com>
Subject: Re: [PATCH v3] docs: x86: replace do_IRQ int the entry_64.rst with common_interrupt()
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> =E4=BA=8E2022=E5=B9=B49=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=BA=94 01:35=E5=86=99=E9=81=93=EF=BC=9A
>
> Tuo Cao <91tuocao@gmail.com> writes:
>
> > do_IRQ has been replaced by common_interrupt in commit
> > fa5e5c409213 ("x86/entry: Use idtentry for interrupts").
> >
> > Signed-off-by: Tuo Cao <91tuocao@gmail.com>
> > ---
> >  Documentation/x86/entry_64.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_6=
4.rst
> > index e433e08f7018..0afdce3c06f4 100644
> > --- a/Documentation/x86/entry_64.rst
> > +++ b/Documentation/x86/entry_64.rst
> > @@ -33,8 +33,8 @@ Some of these entries are:
> >   - interrupt: An array of entries.  Every IDT vector that doesn't
> >     explicitly point somewhere else gets set to the corresponding
> >     value in interrupts.  These point to a whole array of
> > -   magically-generated functions that make their way to do_IRQ with
> > -   the interrupt number as a parameter.
> > +   magically-generated functions that make their way to common_interru=
pt()
> > +   with the interrupt number as a parameter.
> >
> >   - APIC interrupts: Various special-purpose interrupts for things
> >     like TLB shootdown.
>
> So why have you sent a "v3" the same day?  It doesn't look like anything
> has changed...?
"v3" has wrote common_interrupt() with the brackets.

>
> Thanks,
>
> jon
