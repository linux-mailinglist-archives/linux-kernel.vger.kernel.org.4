Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8876064E9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiLPK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiLPK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:59:49 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED81A554F8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:59:45 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i127so428339oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/X5f1b3Jd5E8SVV/ERglFPxZyk8fr+L/PokTEbRk3Y=;
        b=zKSRWyyH6dbufGau63jnR/+AbZ1uw0rc6CbAIWPGoncNBLYiur5SDIGqtBkYsDWvx/
         kJLpQHLtJCXyySVVExoj7nuey6U7BRo3gBi/Atr4BcTzfbl8AWOYmGIoh8IjDgnTTjF2
         IIQ6qdi2HqSnB3oOFMqdsQ1q1LUR3yluo/zEkXXhRdm8I5kyprIdXVlFpYqD0U50HkIb
         ORaPFYpMYu4AqdnDcRy1PHM6omb65tyZTeYv9PdAmXByJXpcG3K4AT2Ztury9QwBqIZA
         GUapTjDiFx8rt6U6sLRTBz69KYCTQEj2XpJGRSioOHl1D7EnociSSR1FxtE8wDh+N6kY
         o3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/X5f1b3Jd5E8SVV/ERglFPxZyk8fr+L/PokTEbRk3Y=;
        b=tdmodSyLQpJASkav7L2KUIoQijW0DNFEVjpFNiIK8c+LFQXiBr+e21++AP7Lyci4Vt
         fEo9/SKckCkTIUEi97+9PSYftdawCCe3H1vUHRhVF2FSIbWX/g/Q2bcxC6zP4Tx48HNY
         hyOrthv2kG9jwwvMoO54qwdb6Liu6e4gNVh8PEEECoOsi9LX2jtPPBwH3bxSOeG6qd/Z
         ikQEdN2uEjfNkSOi2i2y6bQvkiDpnMSM+1Po3zqHwLcWQbE46qELqojO8k4FQ4PCrsCD
         JmJ8xU+ACMPLISidj0/PRF8KDQ6MVPNakJve/udkcxNAK2nJy8S/Ph3qWezj5ni/PhdP
         hR8g==
X-Gm-Message-State: ANoB5plqr8wQtSwvW8MHI1qm+g49sU+U+aVVHhjFEJVEVIK4Af0gFH/Y
        QKz9GvHgCRnKNhBRf9/DE07Wk2WHhEol3mOnUwmy/Yr62GT3gw==
X-Google-Smtp-Source: AA0mqf7lqofw6GNI3Y6Di93mOEjknDpnuUaSQ7N5EQdUyvuNwrTkHlh788t0GM2DeGmmxZm+wcAF6BNG+4L4vwEYLDE=
X-Received: by 2002:a05:6808:1b2b:b0:35e:5a1b:825c with SMTP id
 bx43-20020a0568081b2b00b0035e5a1b825cmr615149oib.155.1671188385246; Fri, 16
 Dec 2022 02:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20221215162905.3960806-1-arnd@kernel.org>
In-Reply-To: <20221215162905.3960806-1-arnd@kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 16 Dec 2022 11:59:34 +0100
Message-ID: <CAG3jFyun2NhHT_mQjrRvt44Adk_O7UqE49YQNm4_G8wZ5JOskA@mail.gmail.com>
Subject: Re: [PATCH] media: camss: csiphy-3ph: avoid undefined behavior
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Todor Tomov <todor.too@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Marek <jonathan@marek.ca>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 at 17:29, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Marking a case of the switch statement as unreachable means the
> compiler treats it as undefined behavior, which is then caught by
> an objtool warning:
>
> drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.o: warning: objtool: csiphy_lanes_enable() falls through to next function csiphy_lanes_disable()
>
> Instead of simply continuing execution at a random place of the
> driver, print a warning and return from to the caller, which
> makes it possible to understand what happens and avoids the
> warning.
>
> Fixes: 53655d2a0ff2 ("media: camss: csiphy-3ph: add support for SM8250 CSI DPHY")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index 451a4c9b3d30..04baa80494c6 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -429,7 +429,8 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
>                 array_size = ARRAY_SIZE(lane_regs_sm8250[0]);
>                 break;
>         default:
> -               unreachable();
> +               WARN(1, "unknown cspi version\n");
> +               return;
>         }
>
>         for (l = 0; l < 5; l++) {
> --
> 2.35.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
