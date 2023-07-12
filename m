Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70057750A99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjGLOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjGLOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:16:00 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5092410C2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:15:59 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so7793026276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689171358; x=1691763358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rtJ0JCAMmm0LZRc8yotvw33nVmFMyiP4jxZwS9BYrKs=;
        b=DfNLhDuSPRDQZfvG6PecJ8KNkztobYnqEwi9YZxN03DYxQBVzn8foN8f7/Zz+ZXKnh
         bxN3TwP6UfcAuL+TxOf228rjcViXl6baRGEh8IJoZKA0LUK3g/2UjobqzoAkkoSl1E1l
         UGQYqoKPYhdR6Tgtuhh31zhQpNplWCEXGdCINfKxFjI6RstiGWNJdaQ5dorX9zJ6vUl0
         7reqlbfKwpqZkQQSLZek71QenzS0m2C7Z3u/ukszgWAF+Lbt0pGWjGIpyC/XC7D43wTv
         GRyFRuWKAsid0Xq034zOpAdQ7koox1GREvBTTfj7YZqSLkhm6M5MAsDke1UwMSN0Gg8b
         aqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171358; x=1691763358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtJ0JCAMmm0LZRc8yotvw33nVmFMyiP4jxZwS9BYrKs=;
        b=kVRfnSa3TJBAe1ACdVbSzFeqWFccw/b3OTDSbzbvzzZqh/nmXEGObJ1smXb6y6jEfI
         f1R9pppl3X+VwwFhu8kJmfNd/G5umXUJv2DogRq4q4bqDm6KL/80CZ/YcgNKYjTDFM2Q
         3yAPt+U6d0CNkZnbyL7hyFiYpvfmrzTuN4P8k5GY9r0EfXr3ksdTbBCM0OOylOtpSvLx
         ZOTjUIWdf+cwEgdvDW8iJNSYqhxgLdgjIPSbdS2/fRaQakrklXHxf3MTys2yuPSDkLrF
         mN6PmTCNehiBFfH5Ix+0yL68aI5rXKQ5a+FloPa8sEFZPC9H8l07aEUSltOnlilUneKq
         mQ3Q==
X-Gm-Message-State: ABy/qLYoWmWJ3J+DlApNN58zp8TdAAsg8IeRMN3Rv3PxC6ZBDsjm/aaQ
        VrvwUhoAQEEVseg7RnZDUbj8WgX9ypPu62pGIvD0qg==
X-Google-Smtp-Source: APBJJlFJUb/gSYa9ONJ3QWGtgk9HEr6LtpVBvFeauDyBKu8n59z+Y2lf0u5pfwq39/QZ/JUqk+SKlkzjSPPSRL/7aUM=
X-Received: by 2002:a5b:54f:0:b0:ba8:6530:d561 with SMTP id
 r15-20020a5b054f000000b00ba86530d561mr15360987ybp.30.1689171358470; Wed, 12
 Jul 2023 07:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230712014812.3337992-1-quic_skakitap@quicinc.com>
In-Reply-To: <20230712014812.3337992-1-quic_skakitap@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 12 Jul 2023 17:15:47 +0300
Message-ID: <CAA8EJpqvUH4vhqGsnfKSzbV0xLV70GYuJwdejxQNN37XG68Oww@mail.gmail.com>
Subject: Re: [RESEND] clk: qcom: rcg: Update rcg configuration before enabling it
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 04:49, Satya Priya Kakitapalli
<quic_skakitap@quicinc.com> wrote:
>
> From: Taniya Das <quic_tdas@quicinc.com>
>
> If rcg is in disabled state when clk_rcg2_shared_set_rate is called, the
> new configuration is written to the configuration register but it won't be
> effective in h/w yet because update bit won't be set if rcg is in disabled
> state. Since the new configuration is not yet updated in h/w, dirty bit of
> configuration register will be set in such case. Clear the dirty bit and
> update the rcg to proper new configuration by setting the update bit before
> enabling the rcg.
>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>

I think there should be your S-o-B too, as you are resending this patch.

Next, should there be any Fixes tags? Probably this is a fix for 703db1f5da1e ?

> ---
> Resending this patch as there is no review for 2 months.
>
>  drivers/clk/qcom/clk-rcg2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e22baf3a7112..b25635feb617 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -982,7 +982,13 @@ static int clk_rcg2_set_force_enable(struct clk_hw *hw)
>  {
>         struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>         const char *name = clk_hw_get_name(hw);
> -       int ret, count;
> +       int ret, count, val;
> +
> +       if (!__clk_is_enabled(hw->clk)) {

There is clk_hw_is_enabled(). Can you consider using it instead?

Also, I'd like to point out the traditional source of controversy,
confusion and troubles. The clk_rcg2_shared_ops does not have the
is_enabled callback. Will this code work as expected in this case?

> +               regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG, &val);
> +               if (val & CMD_DIRTY_CFG)
> +                       update_config(rcg);
> +       }
>
>         ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
>                                  CMD_ROOT_EN, CMD_ROOT_EN);
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
