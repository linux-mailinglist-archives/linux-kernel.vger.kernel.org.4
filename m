Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C705574839F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGEL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGEL6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:58:42 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C8E7B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:58:41 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-47e655e9a9aso823533e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688558321; x=1691150321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vuos0B/vOpdnWXlb8ybPgBxuuSZb4XpdiaCCE+1Ktg=;
        b=5JhAMUNiodKNURkdqi3LsJrTQBkPbyQkQ3q7yJFOdckDElWHYnOPjHpyiAJnExnKoj
         H49EcsHLSrtaUxHE0Ye3oUJk8H+XGSZ6oLSJEA4XWrWDAqQZmrUs0uuIRaXJeRSwzl8V
         XPiD/5KOFHfr07XVrFkYL7lbuD0CvEkxEa7zkG6J0xop9NCxKrJNFECfQQO/l+42ijcg
         NsmaZhYoOJBN4q5R5/DZTruRGYtUB21np1JHwsdsoRW9JKFJi9MBtvvdjbx8PhdfUTws
         K8SSWmBqaj1rQImWS3ffrwquW6z9WnGXK4cYgDIklpDD4PbsKGLc7gyYhx9jr80TviOT
         vhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688558321; x=1691150321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vuos0B/vOpdnWXlb8ybPgBxuuSZb4XpdiaCCE+1Ktg=;
        b=T/7CingrcK2xCL1UkbOY04c4FTUUAV4eKhkKZnhEY0ny2nWf06qCr1rDIc5nUJJcyo
         4zMKxw7FYQClwwv4j7Uw5kV0PKOhrhkK2PkJWCHYq5hcb44BEHuXlRomKg1R1UMOdcIh
         xlST8ipfTHDi13xslHY0ffTLKUJyvD0IK0aOIM0OIsuPGtl0X3aZBgsLV3J22XRVWLAG
         0KtbItEYLjEGcyNCEcDcSGTSrOnTh1MZyQStz5B6yr7met0xmmXrThn0lZKeGFO19k3K
         YDJ9IdqAFhDFePzwmmyMYhwvgwjLD3YbpvTRcnvFNGjfuH6Ao7sUmJcs2fxvkIBStvHj
         eVLA==
X-Gm-Message-State: ABy/qLbmbU8KyF1DR4ta8LONmVv9u2g4dq5u82nY+bb6N1AoODDHxHX+
        z5Y5CXt/CkzZBLmmwgbpVtCLYC0d3avGtzAbT+abhuYttvi1CwIq
X-Google-Smtp-Source: APBJJlGpUasLS7Rs6wE3CtOzhu1kmi+xa7y0dbvVKS4qLJ9VFoATYB6SpitO3aFn0W0DDRChr+zyQPQ9kOr3wElUMmY=
X-Received: by 2002:a67:e24f:0:b0:443:874b:7d64 with SMTP id
 w15-20020a67e24f000000b00443874b7d64mr5676572vse.26.1688558320952; Wed, 05
 Jul 2023 04:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230705074219.8321-1-brgl@bgdev.pl> <ZKVMr9yrL2JavqhF@sol>
 <CAMRc=MfVsayqftsBJcxyotP2Lz-EPzcXWofFBdYuBDSsVjho_g@mail.gmail.com> <ZKVOjft+q4FXykwd@sol>
In-Reply-To: <ZKVOjft+q4FXykwd@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 5 Jul 2023 13:58:30 +0200
Message-ID: <CAMRc=MeMvTQULCmP4N_0MoHxKVLOTBsxW8zL8=kcC15wAdMpVA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add missing include
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 1:05=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> On Wed, Jul 05, 2023 at 12:59:19PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Jul 5, 2023 at 12:57=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Wed, Jul 05, 2023 at 09:42:19AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > gpiolib.h uses notifiers but doesn't include <linux/notifier.h>.
> > > >
> > >
> > > Fair enough.
> > >
> > > Reviewed-by: Kent Gibson <warthog618@gmail.com>
> > >
> > > Same is true for gpiolib-cdev, btw.
> > > You want to touch that one up as well?
> > >
> >
> > No, it already includes gpiolib.h.
> >
>
> Yeah, but that is indirect, and gpiolib-cdev.c uses struct notifier_block
> directly.  Doesn't that warrant an explicit include?
>
> Cheers,
> Kent.

Then gpiolib.c would need one too. IMO it's fine to just have it in
gpiolib.h. It's a gpio-local header included by all core .c files.

Bart
