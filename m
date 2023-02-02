Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784E06879B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjBBKEE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 05:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBBKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:04:02 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBFD87D28;
        Thu,  2 Feb 2023 02:04:00 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id k4so4492493eje.1;
        Thu, 02 Feb 2023 02:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clsa25B6uh3TqL++IWKNzvuUDRRdgLH56IcdQZXErh4=;
        b=BiXpYwX3lkSkL6v2NzklBXcr/m7l0dmZYBrLl5Vp3WjSZZGBlpCdFWo6QwHVl7xwwL
         PRLql1+dTlX+1/WuoOmwX4nJazKhfPLs5G2MUTOgXaMEhFRtXPqrka0gMhQnfDjH0QQS
         Ng57YlkhSpPdsvd0leNQUzpWqYipdGs5Z/wsoRM/0uE2ivMdQmi4oe9/+2LjOli9+PBj
         x4ZHhckBB3hUeIItwKB1GnAndq536IcjYcQOzQorpLnSOSK7oBatQk3tg/AF/dY3JsBV
         hnsTPnSfKr4WZj044EZ/4b0EiLSkKn59wYK1l7C32TZLi39SnSQr1+DykmXB3QVZ9uix
         nsrQ==
X-Gm-Message-State: AO0yUKXSGB2WRkXYGioLsXMyacHnCqyBvZ9ZxhFzNB/NDOUPMptllQ3M
        RVkEt3i102az0BT3WczkbFbZt9gZwe8nkSr8B9U=
X-Google-Smtp-Source: AK7set+0HgUbMr92UD9yKEnXsOFQo8ehw1RBiBQ94RZdWnHiOytj3NY3QK8W/WKN3xI1ndFBb/LLm/Q4fUq0IhG1EHE=
X-Received: by 2002:a17:907:1397:b0:88a:30dc:5730 with SMTP id
 vs23-20020a170907139700b0088a30dc5730mr1731560ejb.25.1675332238971; Thu, 02
 Feb 2023 02:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20230131233755.58942-1-pedro.falcato@gmail.com>
 <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com> <20230202084953.3035c6e3@gmail.com>
In-Reply-To: <20230202084953.3035c6e3@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 11:03:47 +0100
Message-ID: <CAJZ5v0iwO=xJ8A=vv4Khm6Z+Lb9hpZsZmyCjMeSHutMWRcp78g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Make custom_method use per-open state
To:     Sebastian Grzywna <swiftgeek@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Hang Zhang <zh.nvgt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 8:50 AM Sebastian Grzywna <swiftgeek@gmail.com> wrote:
>
> Dnia 2023-02-01, o godz. 19:34:48
> "Rafael J. Wysocki" <rafael@kernel.org> napisał(a):
>
> > On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato
> > <pedro.falcato@gmail.com> wrote:
> > >
> > > Make custom_method keep its own per-file-open state instead of
> > > global state in order to avoid race conditions[1] and other
> > > possible conflicts with other concurrent users.
> > >
> > > Link:
> > > https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/
> > > # [1] Reported-by: Hang Zhang <zh.nvgt@gmail.com> Cc: Swift Geek
> > > <swiftgeek@gmail.com> Signed-off-by: Pedro Falcato
> > > <pedro.falcato@gmail.com> ---
> > >  This patch addresses Hang's problems plus the ones raised by
> > > Rafael in his review (see link above).
> > > https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was
> > > submitted but since there were still people that wanted this
> > > feature, I took my time to write up a patch that should fix the
> > > issues. Hopefully the linux-acpi maintainers have not decided to
> > > remove custom_method just yet.
> >
> > Well, thanks for the patch, but yes, they have.  Sorry.
>
> Hi Rafael,
> Can you please explain why you don't want to keep it, given there's a
> patch?

Because this interface was a bad idea to start with and its
implementation is questionable at the design level.

Granted, at the time it was introduced, there was no alternative, but
there is the AML debugger in the kernel now and as far as debugging is
concerned, it is actually more powerful than custom_metod AFAICS.  See
Documentation/firmware-guide/acpi/aml-debugger.rst.

If the AML debugger has problems, I would very much prefer fixing them
to the perpetual maintenance of custom_method.

> I find it really useful in my day-to-day as a firmware engineer.
> I don't see much happening in git history of
> drivers/acpi/custom_method.c , and I don't see anything that was
> specifically changed in it in past 10 years to keep it being
> functional. Without your more detailed explanation I have hard time
> understanding your decision to remove it, since I'm not a kernel
> developer myself.

It's been always conceptually questionable, problematic from the
security standpoint and implemented poorly.  Also its documentation is
outdated.

The patches fixing its most apparent functional issues don't actually
address much of the above.

The AML debugger should really be used for debug rather than
custom_method and honestly, what's the purpose of it beyond debug?
