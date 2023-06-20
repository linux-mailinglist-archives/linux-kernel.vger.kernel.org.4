Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948B736B14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjFTLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjFTLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:33:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564F10E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:33:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so6068430e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687260814; x=1689852814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVsib4qKyB82Osq6CfMX+p3Eul3U7zE2OWUFnDtEhvo=;
        b=PkVmSxkxBTKfOJoGCeY3MpFQDih6koxeOCQ14L+BpZCZ6kD0s2PK4WBKEjZ50gVvx9
         tDm5MO2zh+vUPqQtUMqEard3YaukFyV9rTD8o9U6ek/JzB8fLufmF4HixGFiJnWZ/h6E
         Lyx82E7hKSR0qnVKz+l7gF6f1sU15vY2D/C2vwiYp9kGbb+ge6YlzQQup20662JX3man
         vRAiHnQSro7U2xy1x7mRUyrFcwTVjEcFg4DnUgrv8S4FODS46xb1h7BpQ+PIz0f6co0l
         SCr41shFRago+35eQ234HzgUloxVacc+VWJEPu3EPp6zsdzuG7V+xVNBfazLkXQQdCuZ
         3CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260814; x=1689852814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVsib4qKyB82Osq6CfMX+p3Eul3U7zE2OWUFnDtEhvo=;
        b=LnIeA7pcX3b5DWsPqiDc/SMhglrkSTIaCOTHS1XP60xhs375zWIdtv1IQ/AwkTwGiZ
         ZUYGK0yLWXP/trPnLY4Zs6mTlPlb71o0Oh8p11/Zuf1RFpqKZY1cmYRGG45hmN4O9tnf
         50GRzMuGcvOPSFF2oorFJJCleBPLOTzqoFLQ5n5HSGJrMt1tqK/wy6jHjQ/kzQN4Dhbt
         GK49DBtinGUd4vweDymTwLLTlEzk6xQalxsSwUVZC0DGu6WOejPMYRRZT4o0SvZg7wIm
         lB3ay7GTcbh6kbh3XO6ueUvEnmXDNBMXYsGhXPVTnM82CThm8Bs63taVZ5fxw7BenSnZ
         w0Pg==
X-Gm-Message-State: AC+VfDy/yhV53yeiFMjQCAmbv/y3+05xawwE++HT+ST2FM+xfdXoSLmy
        PCkn/7kux3jFvWu81wrYyKa2NJRjhCpv6EnYmzW4YQ==
X-Google-Smtp-Source: ACHHUZ6i52O32LZigRCWsfh0agBf2LmLpUofUpFF51XMDq+fuNByYXQJL7Pt5SwRjcIXw5UxCzPhjHNhb3uSV71WwNo=
X-Received: by 2002:ac2:5b0c:0:b0:4f8:666b:9de8 with SMTP id
 v12-20020ac25b0c000000b004f8666b9de8mr5150573lfn.13.1687260814348; Tue, 20
 Jun 2023 04:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230614095158.1133673-1-elver@google.com> <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
In-Reply-To: <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 20 Jun 2023 13:32:57 +0200
Message-ID: <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
Subject: Re: [PATCH] kasan: add support for kasan.fault=panic_on_write
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 at 12:57, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Wed, Jun 14, 2023 at 11:52=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> >
> > @@ -597,7 +614,11 @@ void kasan_report_async(void)
> >         pr_err("Asynchronous fault: no details available\n");
> >         pr_err("\n");
> >         dump_stack_lvl(KERN_ERR);
> > -       end_report(&flags, NULL);
> > +       /*
> > +        * Conservatively set is_write=3Dtrue, because no details are a=
vailable.
> > +        * In this mode, kasan.fault=3Dpanic_on_write is like kasan.fau=
lt=3Dpanic.
> > +        */
> > +       end_report(&flags, NULL, true);
>
> Hi Marco,
>
> When asymm mode is enabled, kasan_report_async should only be called
> for read accesses. I think we could check the mode and panic
> accordingly.

How do we check the mode, and how do we prove it's only called for
read accesses?

> Please also update the documentation to describe the flag behavior wrt
> async/asymm modes.

Will do.

> On a related note, it looks like we have a typo in KASAN
> documentation: it states that asymm mode detects reads synchronously,
> and writes - asynchronously. Should be the reverse.

This says the documentation is correct, and it's actually called for
writes: https://docs.kernel.org/arm64/memory-tagging-extension.html#tag-che=
ck-faults

Who is right?
