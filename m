Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A934688FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjBCGp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjBCGpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:45:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C47423F;
        Thu,  2 Feb 2023 22:42:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg26so3135824wmb.0;
        Thu, 02 Feb 2023 22:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f70mbEbt7FLy2LoaRRNo6wzX+0YKTgsAgAP9p3nm+4Y=;
        b=LRK/vVh4BEuHT88Q1rFI9sJGGo4rCFhlxIWnXq1bkqhplqCzF/Wy0Rs7jJjC+gH+GG
         81WHrpogz8kH6C+IEpL5ALqJV5q3trgtk/554ZIJtVawKBFXJ8+W5TdN7gIus4dF3fG6
         H5SrdVazSOhj/vyNNGe7J8VocAYvoY9oh7N3aagKBkIiaF+mu5x7DPB/yHohaccQuPyB
         o1tK9aL1mO8m1JEuMh6gFEjUI/DrVeGA0W98p+GH/Baddmh7/JDgn/b2BSuvnqa46x+z
         Nw31DSrd40DEtUovWB2NjSBVWZuj75lAD8Rll8YHhTnZz1cWpi/16AsBGRRff1+HLfyR
         yAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f70mbEbt7FLy2LoaRRNo6wzX+0YKTgsAgAP9p3nm+4Y=;
        b=y+Zy9PvbPewWdoG2oZPo3Q4o8CHZlkvSh3heWOON7V68BygxTSitXmFYkFQJPAIpJF
         AGHt4DjrRTbcaRwEWf63h8SEn+ks/USdEzYY/nZakGtAQYgjjsdSH2VCYPfVazkSTHhI
         yXSJtTRzG/r8vH30l1zy/mHd/YTefx0v1XOd3VA4f1CZfzTh2Zy/Bw9KB1ahryM3ohoP
         EMgqWfMq532oD0GtDLim7A7MncOsOqe1CjCoZUfbwQwUK3F0j9MpWm7R9J9hGK7W1Rud
         Gx6h8+4i0wb0Hyv9Ni1ur/RRQG6cyHS7S6xYO47pzd72NZ11P3avpzvtycJqDoCIQbZJ
         IFZw==
X-Gm-Message-State: AO0yUKU4o74Zt8U7eEi9jPJbtV2e9MrfZfGU54+XFSamw3T6NgB9aj8c
        XHlexEqKChjiqdywB6z11Xw=
X-Google-Smtp-Source: AK7set93oVujA5ONd897ksh5msMaZzhZf5cyZ0NlZWcH7kE9JymNXTwtchbjoCnwxSGAASku+toX3Q==
X-Received: by 2002:a05:600c:16c4:b0:3dc:eaef:c1bb with SMTP id l4-20020a05600c16c400b003dceaefc1bbmr8683342wmn.35.1675406574412;
        Thu, 02 Feb 2023 22:42:54 -0800 (PST)
Received: from localhost.localdomain (staticline-31-182-169-137.toya.net.pl. [31.182.169.137])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003de2fc8214esm1760270wmi.20.2023.02.02.22.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 22:42:54 -0800 (PST)
Date:   Fri, 3 Feb 2023 07:42:27 +0100
From:   Sebastian Grzywna <swiftgeek@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Hang Zhang <zh.nvgt@gmail.com>
Subject: Re: [PATCH] ACPI: Make custom_method use per-open state
Message-ID: <20230203074227.47c3e363@gmail.com>
In-Reply-To: <CAJZ5v0iwO=xJ8A=vv4Khm6Z+Lb9hpZsZmyCjMeSHutMWRcp78g@mail.gmail.com>
References: <20230131233755.58942-1-pedro.falcato@gmail.com>
        <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
        <20230202084953.3035c6e3@gmail.com>
        <CAJZ5v0iwO=xJ8A=vv4Khm6Z+Lb9hpZsZmyCjMeSHutMWRcp78g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 2 Feb 2023 11:03:47 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Thu, Feb 2, 2023 at 8:50 AM Sebastian Grzywna
> <swiftgeek@gmail.com> wrote:
> >
> > Dnia 2023-02-01, o godz. 19:34:48
> > "Rafael J. Wysocki" <rafael@kernel.org> napisa=C5=82(a):
> > =20
> > > On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato
> > > <pedro.falcato@gmail.com> wrote: =20
> > > >
> > > > Make custom_method keep its own per-file-open state instead of
> > > > global state in order to avoid race conditions[1] and other
> > > > possible conflicts with other concurrent users.
> > > >
> > > > Link:
> > > > https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@g=
mail.com/
> > > > # [1] Reported-by: Hang Zhang <zh.nvgt@gmail.com> Cc: Swift Geek
> > > > <swiftgeek@gmail.com> Signed-off-by: Pedro Falcato
> > > > <pedro.falcato@gmail.com> ---
> > > >  This patch addresses Hang's problems plus the ones raised by
> > > > Rafael in his review (see link above).
> > > > https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was
> > > > submitted but since there were still people that wanted this
> > > > feature, I took my time to write up a patch that should fix the
> > > > issues. Hopefully the linux-acpi maintainers have not decided to
> > > > remove custom_method just yet. =20
> > >
> > > Well, thanks for the patch, but yes, they have.  Sorry. =20
> >
> > Hi Rafael,
> > Can you please explain why you don't want to keep it, given there's
> > a patch? =20
>=20
> Because this interface was a bad idea to start with and its
> implementation is questionable at the design level.
>=20
> Granted, at the time it was introduced, there was no alternative, but
> there is the AML debugger in the kernel now and as far as debugging is
> concerned, it is actually more powerful than custom_metod AFAICS.  See
> Documentation/firmware-guide/acpi/aml-debugger.rst.
>=20
> If the AML debugger has problems, I would very much prefer fixing them
> to the perpetual maintenance of custom_method.
>=20
> > I find it really useful in my day-to-day as a firmware engineer.
> > I don't see much happening in git history of
> > drivers/acpi/custom_method.c , and I don't see anything that was
> > specifically changed in it in past 10 years to keep it being
> > functional. Without your more detailed explanation I have hard time
> > understanding your decision to remove it, since I'm not a kernel
> > developer myself. =20
>=20
> It's been always conceptually questionable, problematic from the
> security standpoint and implemented poorly.  Also its documentation is
> outdated.
>=20
> The patches fixing its most apparent functional issues don't actually
> address much of the above.
>=20
> The AML debugger should really be used for debug rather than
> custom_method and honestly, what's the purpose of it beyond debug?

I tried to investigate how to get my workflow going with
tools/power/acpi/acpidbg , and after looking at
drivers/acpi/acpica/dbinput.c I am a bit confused as to how should I
enable CMD_LOAD properly, and if it's not in Kconfig then how
supported/tested is this feature.

acpica-reference_19.pdf is also confusing me a bit with mention of
"Unloading the DSDT is not allowed", making me worry that live
reloading of DSDT would not be possible (which would be superset of
overriding just a single method).

I want to be able to swap a particular method, and have it run as close
to normally as possible, sometimes for prolonged period of time, but
most of the time I will fail at writing a patch and will need to swap
it again with another attempted fix.
