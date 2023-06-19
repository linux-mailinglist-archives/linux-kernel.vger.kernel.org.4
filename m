Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B9E734C97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjFSHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjFSHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:44:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B29FB1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:44:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bcd0226607bso6389981276.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687160643; x=1689752643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rfqVV4RqiyGX+NOos9GrR72Yg9f5DCocdZ0hjpuxCI=;
        b=gF6aMplCSu2sOB/mOJCxQ+kgwIDeX4++gFbVg8o3++FKFxZxhjseSDRKtp0V3+ETzH
         gIvOqxvPQQ4rNj78kJ5ToXXifY3Q/rVRIUk70dFCzv/huIacWmtwcez5OG42CtXeP6Ve
         TWSTaLit3tdftYavzZKYvbwq9NmNxnNlJVonqXOiT2RvQYOBP0iMjAHjA6NCIRNkKkl/
         k/8rkYQuQbX1V0p/PrFsFF4vRF8wQafAqIs4blOT+GsztKb8knC05AamS5ncai+2rubY
         hGHwTW5TRyrwytELCOyoS0Hv24Co3KH3zpZQnCk4c5CnMG8ynVt3BJkI311WctPidttL
         wz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687160643; x=1689752643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rfqVV4RqiyGX+NOos9GrR72Yg9f5DCocdZ0hjpuxCI=;
        b=YEUr3tj/jIhXsVAn0f+HDkyN8M/J+nVYxvSa2faTJMF2hRfkCsuwC0Gy1+LAXV9qTB
         Bq330I4fjxrL1FtY/XxDttBeL90Wr1KyBTLiPEh9k4SjTxsratECWBn4TOTrJRBWmPWX
         T+qEv4DGrYmupo/fmX4iAs1lh5u5UiIU0FuwAqtEL67Y9/hzXIVSyKQd6Rd6vRpufKyO
         zJmxS2UZa0lv6WqvKrVjG1vuKCvB3NPpl5MoiKJSXUdeVM/+uoPvJLvmTceFsWCZJEqF
         pPVODVumxGy3CJJmgzUEOKYRkY+BtOGBPT2gtLIB8/vhR7cgczshcbcqIrhqXdTIbP7V
         mzoA==
X-Gm-Message-State: AC+VfDz2lmNTxTFm+B880tWTLckYo9d7pc19qvjMkedqz+Da3e+5ShYa
        YvwFOclXNVLQWAKZ7VMKmMHCcGbXZ1FaUi7oBNB5zA==
X-Google-Smtp-Source: ACHHUZ5qjGTBy4mHzg1dwkSZg91R1AfLOxHyU9a5EkeZaRf8LL2IqGXOpAO0lxXoTlGKCj+FNAMPSmfmYAjCIH0+9As=
X-Received: by 2002:a25:6902:0:b0:bca:f08b:69ea with SMTP id
 e2-20020a256902000000b00bcaf08b69eamr5742162ybc.14.1687160643564; Mon, 19 Jun
 2023 00:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230616-fixes-gpiolib-irq-domain-v1-1-27fe870db961@kernel.org>
 <ZIxuExRypHsUejFI@smile.fi.intel.com> <4b55afe91d2a704c0229340c5ea4885e@walle.cc>
 <CAHp75VfJ4vB2yWY6rFQrRh3Sbz9bg-fgKXXH-_-YFHMHuM=ZLw@mail.gmail.com>
In-Reply-To: <CAHp75VfJ4vB2yWY6rFQrRh3Sbz9bg-fgKXXH-_-YFHMHuM=ZLw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Jun 2023 09:43:52 +0200
Message-ID: <CACRpkdYsp4eTQE5=eqPqXuV_x=Xqaf7nWL+RVvqwVDaAmeTqqw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix irq_domain resource tracking for gpiochip_irqchip_add_domain()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiawen Wu <jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 4:25=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 16, 2023 at 9:02=E2=80=AFPM Michael Walle <michael@walle.cc> =
wrote:
> > Am 2023-06-16 16:13, schrieb Andy Shevchenko:
> > > On Fri, Jun 16, 2023 at 09:30:06AM +0200, Michael Walle wrote:
>
> ...
>
> > >>      /* Remove all IRQ mappings and delete the domain */
> > >> -    if (gc->irq.domain) {
> > >> +    if (!gc->irq.domain_is_ext && gc->irq.domain) {
> > >
> > > Looking at this, perhaps positive about allocation?
> > >
> > >       domain_is_allocated?
> >
> > I mean all domains are allocated ;)
> >
> > domain_is_allocated_externally? I'm bad with short and concise
> > names..
>
> Naming is one of the hardest problems in software...
> Your variant is long, but conscious. I dunno. Bart, Linus, do you have
> any ideas?

No, this name is fine. It is meant for human readers and they
will immediately understand.

Yours,
Linus Walleij
