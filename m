Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116EE6FB1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjEHNfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjEHNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:35:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC132C3C5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:34:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso6152328276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683552897; x=1686144897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1etNmHWMtLvzsARlvSHjLBWmKuJlsjx2XNuLPj18vU=;
        b=xvYrPgzRA66gjZV4ixxk31a1/H9TVB2pmWRKcTMFD7IALmuUo8MX5jtn9S4LeCt6Bc
         Nygo1zepvngiIp7FKawb1c71tXcF8veXgh9ifGwPi9vJv999PHFZFOez30TMS/GTIzSr
         lRYWv76lgJW4TOJk+FDMZknFJ7d6c+TFy7LemlImhCTO3ezPF1KX9E1KJ0KPDYakzsec
         Csc5oVpRArV0IbOxIGOaKnt2qNw6uuGh5YafcIbgwoLRuPft8moOFBMVtvJLuYdoqGpR
         EwQ+JSdXWtqSRSMy/wh12pO22hitdrsQlhrY2YLR8APPwJINHGz8gR3FY24v/2tPSMUS
         95Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552897; x=1686144897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1etNmHWMtLvzsARlvSHjLBWmKuJlsjx2XNuLPj18vU=;
        b=RAEhugztHuNeviR+lrid8B+Kxevjr/+wxdI40d4lytagNx0VxDyJQXJdfx0XtHE6zI
         9lAD0YgzXM9hSVI3XFpI0pcujVd7tsuoelkKjeESvFXV5bcRsGvnrc64IEAP9vkrFl1m
         YBx4UleqjeH7bHnCY+pBldUTjCyaoBcEjk+tym865bpeWuG2kcYudP6VJoikuSwNqTVs
         v6Xp+r6EMtg+8gCDbyT6Nt3R4cnHdK6hYnA7j/iuoLu78MkYW196AFRKk6mgSVnd5q3d
         lKeRyW++pFBdQrLUyXRUkrWy99rk4gHb+tqeyWoPB8KKIBUDx9NAc3ic3hDbxzqVH2ro
         vDRQ==
X-Gm-Message-State: AC+VfDxIgmlEMfRyIZ1pQlicV/dsxmEpRRqGBGMeKK5TMSdSeuaMfQ3n
        4FsJXOK2XK2oncdHGYvR34iKhxShhhNHnVOCjElCfw==
X-Google-Smtp-Source: ACHHUZ4OWKhi6umyKFXov2yXpEyUIYmvkdzmYG7kn9+lw8oSFw8k90EhW6GN0kLF7whs/sGPrbax1DiNCtGkfOE2DVw=
X-Received: by 2002:a25:3715:0:b0:b9d:89f5:1e9e with SMTP id
 e21-20020a253715000000b00b9d89f51e9emr11367491yba.32.1683552897280; Mon, 08
 May 2023 06:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230430125154.126863-1-saraday@hust.edu.cn>
In-Reply-To: <20230430125154.126863-1-saraday@hust.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 15:34:46 +0200
Message-ID: <CACRpkdYc0Pae0AnfqYh89FR6a8BxwfLgN1sTaR-Frx0gaZZB4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] bus: qcom-ebi2: use prefix devm for clock resource
 allocation functions
To:     Ziliang Liao <saraday@hust.edu.cn>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Apr 30, 2023 at 2:53=E2=80=AFPM Ziliang Liao <saraday@hust.edu.cn> =
wrote:

> Smatch reports:
>
> drivers/bus/qcom-ebi2.c:387 qcom_ebi2_probe() warn: 'ebi2clk' from
> clk_prepare_enable() not released on lines: 358.
>
> drivers/bus/qcom-ebi2.c:387 qcom_ebi2_probe() warn: 'ebi2xclk' from
> clk_prepare_enabled() not released on lines: 358.
>
> The clk_disable_unprepare() is only used to explicitly release resources
> when the qcom_ebi2_probe() fails, and when executed correctly, it may
> cause resource leakage due to unknown release time.
>
> Replace devm_clk_get() and clk_prepare_enable() with
> devm_clk_get_enabled() to automatically manage the allocated resources.
>
> Fixes: 335a12754808 ("bus: qcom: add EBI2 driver")
> Signed-off-by: Ziliang Liao <saraday@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Looks good:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think Bjorn can queue this in the Qualcomm ARM tree.

Yours,
Linus Walleij
