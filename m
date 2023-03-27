Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D276CB0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjC0Vgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjC0Vgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:36:32 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F02D4F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:36:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z83so12597388ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679952972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LphU3lCD6hhAgZNE1YP32TpKtjPy8gxgxUz41txnkwI=;
        b=PdjAr1ulU4+fiPDc8MJJ4bMk1J28GiMPnjlADakawwTEccjS2nDWPV5HhXcdkeMUan
         ygBBYbORhxLdCvHyH9vNIHVsFCuq36Arq8SVr2uzkkXlXt+4BzO1R6QUGNUx9k6mI/bn
         s4JUJ2TYy48U0J1zEIg3FAwmZKBhwSSAzivOklk1+YYNiBq8taqYsis/OQU/ZtvYnSTd
         aE0DdXmdnQClgRx+JPT8AVIZMYKr9ABAV2PzHow8wTbLCUG2yb1kqDtrqat6nECw7N79
         O+iAnCi/Poj2e/MGNGi+JpuPO/8uIZHp1PfmUyw7Mg8aEHs1N+RUdBS6vCWdTOClu0e0
         iFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LphU3lCD6hhAgZNE1YP32TpKtjPy8gxgxUz41txnkwI=;
        b=j3+1xAa7uVuQ6I7W7GxO+cRHNnj+ZS/3ocHlhicNCUx8MYM5lEk4/MamJUUR1/Voz9
         KQR6TAGmchsr4T9U9gfDQfGpAFLOdrgLk7+A7wmpxiaN6FYrnAoLViwjkCFnPyYgMMzW
         sccvUwbZplZOgq5/7CiMPZTt+dwyiRYDi9eteCZ9BBq/WvIXy22g+EZSSav+XK4Y9Zws
         FRGe6ZYPrfbpYWsbitD2WxTfb0q0JFxILbdwu6GdcNfy3cFp2PuJm9Quu/OJGFhDElce
         4H0qkTeaa5iodl1pHll+QIq/rLHxmNsxl6xP78lPEwCaZgxq+lv/taovTrDet/IJgpcG
         1FMg==
X-Gm-Message-State: AAQBX9eFG2FdLXES25Slo2pdc3f6Dkk9UYCGhRpBe8N9mWYS0YtiyM6G
        iNAP7lB3+07RiLvz/JNcrYiwXYoxMCRnG+Wh9Yb/YA==
X-Google-Smtp-Source: AKy350ZLawtXkeaTyp3Az5LBxbSlT3SuLjsuCbLFPiDphCP8jW8r4l+z8SaGLja6yEtOT8nU3N0XGMPJetk8NLLyII8=
X-Received: by 2002:a25:8712:0:b0:b74:3236:2fac with SMTP id
 a18-20020a258712000000b00b7432362facmr8044965ybl.4.1679952972432; Mon, 27 Mar
 2023 14:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230327062754.3326-1-clin@suse.com> <20230327062754.3326-4-clin@suse.com>
In-Reply-To: <20230327062754.3326-4-clin@suse.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Mar 2023 23:36:01 +0200
Message-ID: <CACRpkdYBm7KjSX2h2Oj1uWX8D2XvevbdczGWZc-9Zsb2SHvt-A@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] pinctrl: s32cc: embed generic struct pingroup
To:     Chester Lin <clin@suse.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 8:28=E2=80=AFAM Chester Lin <clin@suse.com> wrote:

> Use generic data structure to describe pin control groups in S32 SoC fami=
ly
> and drop duplicated struct members.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied!

Yours,
Linus Walleij
