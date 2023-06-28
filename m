Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D547412E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjF1Npy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjF1NpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:45:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828102690;
        Wed, 28 Jun 2023 06:45:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51dd1e5a621so645400a12.0;
        Wed, 28 Jun 2023 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687959922; x=1690551922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgTCzvxOkTw07Gl+wh/Ts/Fs3pfQYOVhwNsd1TgQxTk=;
        b=AyZboz77juBumkeSGUBufF5M7xReqM5K1e6umcbHsb30l0feX0KIGY7XOyzeDGz0MX
         93VotL9LUWsBInyoQED7dC6XYWhBxBXN2baosppawNIW3yyUae/LDENB+x4XPb0NngEi
         5KLJWzWJDrpQGDx3oWBwW9uZO36/3lWid4iG04gmYReBtx/o3s6RW6tCVsDuhVzABF0O
         ejL0mvnrNcDvs/5sc6yDBCqb9Q/8il/Ysi5/Xn3nd7PvQGn8YGHFAceZ6Fa3H1XaggDz
         mqwUvQF0Rs4MltSMeS1sh0pm1sQulLjQgac1I0fELDgjeUDeAfQbuDk4+qmKozj0byaz
         fP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959922; x=1690551922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgTCzvxOkTw07Gl+wh/Ts/Fs3pfQYOVhwNsd1TgQxTk=;
        b=QXY3+e+8xAp/TwQXwAeeUFtp/mGqaZ+pqismeryIo/m4vypNY/BhqX1fkeTiAr4TXE
         /Thawbpy1r+Tur4HYqnsBtEvePMlkyxs82p9X7ZpAt1PsBPwn3r/PkBREs9a9fYX7/CF
         ElQIgSUjL72xlypLp85GY3MVhZSMYCGOpQ8IV+6jJy689bMnfzt5kdbREHrclO1vXtiO
         uVDcwWBjc7oCEBwOA6XrF1APHeZyy2oaqvDCjynf/KsDJTb3QliSWwnKzrYqgo4BiW+O
         rMC1THrD+KiNvSOKMvkfiCw34M80EjEUoBVfVaVodq1u3+FUMU7JiQuncAlvHaeGoIiK
         iufQ==
X-Gm-Message-State: AC+VfDy/aoa1u0iBWcEk4Zfw/M6mDNmsZl4cfIfHPLrIYcN2ZAOYV5I9
        R0ncK0dabpJlocET4b9hFygzfJ4FMbovMU/P33U=
X-Google-Smtp-Source: ACHHUZ5MTuKYGAjxJZua1thUQH3QTSIJIOYTEK6u5aBrVw88MhlZAVxC50UCD3vZ7gpDI+DLGUCHn7piUud70oEwPx0=
X-Received: by 2002:aa7:c98d:0:b0:51d:d280:6c51 with SMTP id
 c13-20020aa7c98d000000b0051dd2806c51mr1028444edt.1.1687959921903; Wed, 28 Jun
 2023 06:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-19-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-19-git-send-email-quic_mojha@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jun 2023 16:44:45 +0300
Message-ID: <CAHp75VcUgC+TATXp2c+VCNbfYTPYANrAcYftYqLsj+wg+e=12A@mail.gmail.com>
Subject: Re: [PATCH v4 18/21] pinctrl: qcom: Use qcom_scm_io_update_field()
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:37=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> Use qcom_scm_io_update_field() exported function introduced
> in last commit.

the last

But what is that? Be more specific.

...

> +       mask =3D (GENMASK(2, 0) << g->intr_target_bit);

Outer parentheses are not needed.

--=20
With Best Regards,
Andy Shevchenko
