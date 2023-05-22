Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A970B689
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjEVH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjEVH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:28:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82397121
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:28:37 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56204ac465fso55737827b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684740516; x=1687332516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVUES5gprWy9hWLjZRgO1AU9wP0G35/UkxWCBnTGLek=;
        b=jKwmnkFDmZ6Y6AIP96LeOggu3SlWQaTdSPBkIMCM/oQb9XmhryXnwL4Xx0af7JzOoI
         VbJfqpt+vpSjsYYUSZqN2iG0lZuc1cQ+aQrdvluUeS//0G6sMxcn+JvQk5vjPI23CcpY
         h/FPWU1OSETd5AsGHtJmfX2IVaa+7LZg+WRzZ/sZsbo1uS3gWsuIt1QTL+TxrVQNUAv7
         MaAi3vY/mns082UbDxvxx9/so10EiCJXOp9T8zN02fc1Nb+srbhcE4bCywpKKFqHLZ1c
         MVJIjDoNNAnknuVZikCQLjEgAspGSRakQMehOV2PGgcFqrStiuTffdxR5S0NssZxXOsk
         AJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684740516; x=1687332516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVUES5gprWy9hWLjZRgO1AU9wP0G35/UkxWCBnTGLek=;
        b=h9PgMIi6ETP9UhanZDu15jIoQgnTSC4P0xq008cswFxuVvhY5KGA676nOeZbAANOyz
         HSyD2w2cShDEjBS3RaAjHPrWXl40ZcJPasiB8eQlnw/mOy4NiYr2rVN2cjV3wjc/4TMi
         BsA+2/Pa5ysaaqioCANm6pggUw7X4IJTa8EbenDTPSXe+gfjf6EM8jSBOsncy3uelI1c
         4dJsfP4BHzbGh7JiDfDlD+0qNteZViFq7v5H42OvKUX47KbEzU+wTyk7gOE7EW5deT/l
         C5hUZlRKtzfQ8+s0Of4goIiKP8PT2wou57RaOfhhAtsCDqBZocqnpn40Uy5wrmKKiQvH
         cK4A==
X-Gm-Message-State: AC+VfDzncDp2Vg4BRHgtQMKp+kHkO1lMAhTcXdAmbVnHEY8FeG0TRS0u
        E8Di0det4FWzm0dPYZVib3nL0yCNxBN0Flr2ncMiMA==
X-Google-Smtp-Source: ACHHUZ4ic+uWFu3mzwmmQMWZDypcG+im4NFdthUl64HKaCkIQ1tTp/vWNJKpqvYCkfkmFIVqeKmjN3dwsgcs6+7URIA=
X-Received: by 2002:a81:834d:0:b0:561:b595:100e with SMTP id
 t74-20020a81834d000000b00561b595100emr9579311ywf.37.1684740516696; Mon, 22
 May 2023 00:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230515092515.180920-1-brgl@bgdev.pl>
In-Reply-To: <20230515092515.180920-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:28:25 +0200
Message-ID: <CACRpkdb1qnngV0orA=+BXgg-jYQjs5Ch_tUN1dzD8PcddhHQ4A@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: sa8775p: add the wakeirq map
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Mon, May 15, 2023 at 11:25=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The SA8775P TLMM driver is missing the GPIO-to-wakeup-pin mapping. This
> adds it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - fix the 30->200 mapping

Patch applied!

Yours,
Linus Walleij
