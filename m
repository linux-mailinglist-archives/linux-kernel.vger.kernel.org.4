Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C165B8648
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiINKYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiINKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:24:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36417AC2E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:24:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z21so21522287edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=cEOY86r4oJ9dG+dY6gFKjMyCCLe5WdgdPOCSwvF8n+4=;
        b=kijWTtrs6ynnic9VTdde5xeuO+1B4o2a0m7MCwMHZwPuVuTBv0UaxW9hAicCcSfqQo
         eKJzNVrd+p8Uxh5HXVgDTjRJ9Td/kGbI2Fj+2eQPRvz1WAYAgmOcZI79MFN3LinhPURs
         yQDCn/t3OGjLCgWIvGqlaDmI6JWaR2QtyIRS6X4oZyK8Ty8aU8dC+qcC697zbeCITDGM
         ZxsPjY9FULL5AmVkKvxMb+ZCktAtZR1fwp2U7c9xtdtcboMJQ2b9Dh2sdWQKPNPhtG8u
         I+BT0CkTp6Aw4IO7cGgbDrHjOy3voPVjYE0h6TMVP1jPmdKzw7TJ/Fiao4m0f5Ts1ap5
         qe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cEOY86r4oJ9dG+dY6gFKjMyCCLe5WdgdPOCSwvF8n+4=;
        b=A+RLTltYYCV+9v9A/ubTTBpvdvcXQbcwU5uAYoBxll/2lJQUI62vYW2/z33+WNhMPY
         2NB1G0E5EACnyXGh09cRDkZ+xZ/ybQwxsiiSRq9vVyKHAH/BgPb93RkBXjv8kKwr7Ag/
         xRxoTixCqBqQMuCZ9qHIvFa7E4pPYMHfZcIL0/nT6axuwWQ3mNabgxpxIf8vvFrTrN6V
         aBAmwbQDnD5JESJ7NUw8yV+K06o4YFA4hwKxNP5i4dyz4JsFZIbcOroZ3INB5lohHB/o
         NyritqKPzni3HcSgAjY+dIjScXpJ+JfEyra5VUGEMiNIsOFtvqyhJPXHtaIa9o6ZWd3z
         01Xg==
X-Gm-Message-State: ACgBeo0irQX6Lr1J2FNDoSDH3WE+OpZcmXkvOf2v6l/Zy0iOg6WFZ96l
        7AMl4w0k3OI+/5ynyRWYAAgnyCdaYvjSJ5C0iqPnuVHTwoA=
X-Google-Smtp-Source: AA6agR7rCMfwCFbu7eOJQgVzPOx5xJvdUFsVLXdhChnO5WCdop5AwG82PCXBZc6QQpS6OBmvtNOELTTHheJUOo2dac0=
X-Received: by 2002:a05:6402:f07:b0:450:bf95:59e9 with SMTP id
 i7-20020a0564020f0700b00450bf9559e9mr25103503eda.46.1663151046746; Wed, 14
 Sep 2022 03:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <3cdc2e776dea77b07c75694ba1410bd21e8ed749.1662902045.git.christophe.jaillet@wanadoo.fr>
 <fac99d27-2e28-3c08-4cf3-c97afec99b77@wanadoo.fr>
In-Reply-To: <fac99d27-2e28-3c08-4cf3-c97afec99b77@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 12:23:55 +0200
Message-ID: <CACRpkdbA4m87swhTSGibMz9WUdpffdMkQwodZh2wknLOw9jmOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] checkpatch: Check check for places where
 dev_err_probe() would likely be better than dev_err()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 3:21 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 11/09/2022 =C3=A0 15:15, Christophe JAILLET a =C3=A9crit :
> > Some functions are known to potentially return -EPROBE_DEFER. In such a
> > case, it is likely that dev_err_probe() is a better choice than err_err=
().
> >
> > dev_err_probe():
> >    - is usually less verbose
> >    - generates smaller .o files
> >    - handles -EPROBE_DEFER so that logs are not spammed
> >    - automatically log the error code in a human readable way
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > This patch is only a PoC to see if there is some interest in such a new
> > check.
> > The hard coded '5 lines of context' has been chosen because a typical
> > pattern is:
> >
> >       clk =3D devm_clk_get(dev, "clk_lcd");
> >       if (IS_ERR(clk) {
> >               dev_err(dev, "Error meesage\n");
> >               return PTR_ERR(clk);
> >       }
>
> (adding Linus Walleij)
>
>
> I forgot to say that this patch is a try to address the comment from
> Linus Walleij at [1].
>
> It would not help "fixing a gazillion dev_err_probe()", but it could
> help not having more to fix later :)

Needless to say I am a big fan of this patch!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
