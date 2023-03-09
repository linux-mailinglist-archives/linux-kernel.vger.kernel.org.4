Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452576B2D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCITDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCITDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:03:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144BE190D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:03:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so11170439edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1678388627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scRxhb1EthKdFtRVzvo5kCJab8FR8hn8dhh2GJSj6ZI=;
        b=FOyqYZS4U/ie5QXCcO8sJ7GRaiuOE+eiUs6oiJ+2eLzufdGbT8i0FMV4OdxRE2+PFq
         u3YLGVrUee1h3ZfKtuaPgg4e3kmaySlJVv4kZM8grZdX7eBt4m024aW4k0PcZpXegWZx
         qJYamX+xbskjkAnobRxsWkQFaJ028E4+S7M1+Gm7aY4SSuXAoMVWdrn3civPGbQ+X28W
         VRykSO0x6gis0W2QsGM3AzQ7/PDsjGlIVelPRzUy/lGV22t1F4Jwt0PMXaSs76sFAswA
         KzLmXYpx/saF/1ewiIcnGVRP86xHxHjsibdFxdbwFM/PgcEeJvURHKaN5zZ5TQoYbwRu
         +/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scRxhb1EthKdFtRVzvo5kCJab8FR8hn8dhh2GJSj6ZI=;
        b=ddUiLuKGwPD4pZGKV33IPZm1uygmPAYyZMLMQb5UjQSRsByFjaE6uc+EH23/dTvX2O
         QKux/eBDRuj5igQenZral/wmHD9uGJdA0DO1zH4PE3kFkCXyDicIOigButq8m36HJTzi
         6UsOTgDitY4+CY+SGoeaAsNZnQdgzctxYtKehggguvXh4X6CIV6Ml2+KjrnING7Fh5bN
         uTsUz5d2cPJ8r7LwzAfPzODMzeq0CJzCLZPHwgUdn8iAsgjrUEu9xyP0WfSDlJ1PB2Vc
         vxR15/4lYPlUQd15DhgIBjL0oaItbi2lU2j30BWaGoY7r0635WA8Cbqc/q1wm98kAzgo
         T2Dg==
X-Gm-Message-State: AO0yUKWh5nCt7wmovwQlYh7vOmeiWeNmFwWa5lYFw6EmAFR7vY/c24Vc
        OpoJVT6yTL6ea90Tv2uKM4mngS+oablnDhCCCfDJxg==
X-Google-Smtp-Source: AK7set9qUYcda+RW0AG93BoWkHwnInIXkLtnPU/7Nz0fDOSu9r+++/Wi2gMEbPWYVSh6a8nzG1n67ziPWHYAujrZdP8=
X-Received: by 2002:a17:906:6b83:b0:878:790b:b7fd with SMTP id
 l3-20020a1709066b8300b00878790bb7fdmr11093781ejr.14.1678388627495; Thu, 09
 Mar 2023 11:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20230309111209.31606-1-johan+linaro@kernel.org>
In-Reply-To: <20230309111209.31606-1-johan+linaro@kernel.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Thu, 9 Mar 2023 13:03:36 -0600
Message-ID: <CAKXuJqj3tf5wARwq8+MfTjfZxfrcTFdoV3Oa9btg5bK2XNO8JA@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom: scm: fix bogus irq error at probe
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 5:16=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A recent commit added support for an optional interrupt which is only
> available on some platforms.
>
> Stop spamming the logs with bogus error messages on platforms that do
> not use this new optional resource:
>
>         qcom_scm firmware:scm: error -ENXIO: IRQ index 0 not found
>
> Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic"=
)
> Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/firmware/qcom_scm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 468d4d5ab550..b1e11f85b805 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1479,7 +1479,7 @@ static int qcom_scm_probe(struct platform_device *p=
dev)
>
>         init_completion(&__scm->waitq_comp);
>
> -       irq =3D platform_get_irq(pdev, 0);
> +       irq =3D platform_get_irq_optional(pdev, 0);
>         if (irq < 0) {
>                 if (irq !=3D -ENXIO)
>                         return irq;
> --
> 2.39.2
>

Thank you!
Tested on the Thinkpad X13s
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
