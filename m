Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C127B66E8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjAQVsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAQVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:45:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573ED3FF26
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:09:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j17so48722132lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f5NEd6eZ6l988KDif7fnrmwveNTDaM7DpJUpoJA7DU=;
        b=YGfKF+dZTPvOJehm7OvLo3emCrC3GwjMJ17aaE0Ac6GWvy12D9AosaDFsOYSeI/3qI
         eVuShmBFm8DXWfpFPZk/0ekTq4ANCTdfJhXPpIbaBe7WXji2NFnUI9gNboDyzvIhgfHv
         JU6aKh5GDzct+7j9xr2HXoCvnRCpxVXOZz314=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f5NEd6eZ6l988KDif7fnrmwveNTDaM7DpJUpoJA7DU=;
        b=CoSXmw8J5sFT/C6g3fk+kpBOWtyjD+QPpL+4PAuCkh80ZPDzBcLhrtgBISC53PrsF2
         uAnLD/Jp5aTZmNmCEs9GKX6qEmDisDKD7GpV9vjGG2yxBFfWSX0iwFBhyyKSQWW8o3e+
         jbeK9GCp48mtUvgjTMWbLiTrvlxEoQFc9LwwshAnn1c70cq2d6D2U/DJjIFWsLRD9OzU
         Hh2qI08dmeJF+2zs2fV+migS8l3BIj0iUGjIvtTi9Eq8m0H9qG9uhLqJ/12woh/gAlMa
         9xF6iEWJElZ4lm1fqDJ2AzbEUyuLpqY1gaHD6O9ce/veaPm1HfYuMvVx0zCylbjkJa/S
         4W2g==
X-Gm-Message-State: AFqh2kpPOwuPyHh3S3awRCnpkudSkcDLcKQVpk0NOLY1yeS6vXJ1KlXU
        BnUxarUvC8WU3Uh0kk0nuolKjJPshEGrwQ8c9hdk+g==
X-Google-Smtp-Source: AMrXdXsohAUXpxdWFb4vlqMteXqM/doqJncGnB7aUa7q4EaVDecaR4yZ61+WHk2Qdgo1aJFB1Ci4ua6U2Iq5fA4PjMA=
X-Received: by 2002:a05:6512:2114:b0:4bd:35fd:65b5 with SMTP id
 q20-20020a056512211400b004bd35fd65b5mr418821lfr.297.1673986170632; Tue, 17
 Jan 2023 12:09:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Jan 2023 12:09:29 -0800
MIME-Version: 1.0
In-Reply-To: <Y8Ky1UgT2yxFB2EB@kroah.com>
References: <20230113002149.3984494-1-swboyd@chromium.org> <Y8Ky1UgT2yxFB2EB@kroah.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 17 Jan 2023 12:09:29 -0800
Message-ID: <CAE-0n52wiAiHACFXeki6w7hfn3swuUp6jK6gpFvPxfrnmcV0TQ@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] kbuild: Allow kernel installation packaging to
 override pkg-config
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (2023-01-14 05:49:09)
> On Thu, Jan 12, 2023 at 04:21:49PM -0800, Stephen Boyd wrote:
> > From: Chun-Tse Shao <ctshao@google.com>
> >
> > commit d5ea4fece4508bf8e72b659cd22fa4840d8d61e5 upstream.
> >
> > Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> > what pkg-config and parameters are used.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > [swboyd@chromium.org: Drop certs/Makefile hunk that doesn't
> > apply because pkg-config isn't used there, add dtc/Makefile hunk to
> > fix dtb builds]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > I need this to properly compile 5.15.y stable kernels in the chromeos
> > build system.
>
> Is this a new issue?  A regression?  This feels odd to add a new build
> feature to an old kernel when nothing changed to require it other than
> an external tool suddenly requiring something new?
>

The chromeos build system checks for pkg-config being called directly
and fails the build if the proper wrapper isn't used. We set
HOSTPKG_CONFIG in the environment when building the kernel so that it
doesn't fail.

It's not exactly a new issue, but a self-inflicted one that makes
building the stable kernel annoying. I figured it was similar to fixing
problems with compiling stable kernels with newer toolchains, but if it
feels odd then I'll just have to remember to pick this patch whenever
bisecting stable trees. No worries.
