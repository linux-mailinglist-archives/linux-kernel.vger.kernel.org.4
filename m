Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2652170A06E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjESUO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjESUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:14:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8410E9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:14:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so37048375e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684527248; x=1687119248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnzQY1sqcvkjTs0N5+FyW+tD9eHn3O+t59IFw425bEc=;
        b=lBMivHKfRgtwtCk+QICLAiIJZApK/Ya8eAcwg2PaSoWf/aHVGAuuAVxqiR8GzW4L3P
         QnOaTovcfEvbcdxxdX6Cy++w8DSCIVL2TTCMG2Y8IEo2ON0UjTTifJy/TgoHmB66wmjQ
         EPDzFOGysJEybVyEC4CKrHDZcXsDjbTVna5hli/+MjItKxiu9PmBgRGdqEpRQ3qeWgVN
         ucWiYZKuviqLbfq1YqHdoAwCQy031OYleemP0tyFxWzrezJNvORm3g38mqtn+geEDs5A
         udl1L6GjoTGK7lCDDUDydf2cmkDpGuAWi97/7sA+nMfN304GTW2xmNZrrFwZ2VPuvXdd
         etTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527248; x=1687119248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnzQY1sqcvkjTs0N5+FyW+tD9eHn3O+t59IFw425bEc=;
        b=LHOZECmVRrIfH7+ribfW/Y1DEsBgpil32XRrz+qgctOVwOQ44pHm9hJA7Pq1jmqSdR
         /xp/sJCWCAuu7cS3DQlCwhLY4Z+EyXGZkpQqZFAMqX373TvOXg8KPfLxhpeO2ZNFmHNb
         Q2l1JmPWenammMOjGj3kD6deEwxANmO46TjSCz2NT3kjWYDNEedY2F9I70p5M1aZa+Ky
         IPGC+X5q9sFawib4/s5cAUAMoUqWzRZOG/jbWph8AgYVjzJbL6MLqWNiHJ+gOru2Cif6
         /86jB3z1z+CbnVVZ7Y/dNOmraD2Yd+J4+sbj4WBW2nJ0vMKfgMgDGbpTI2HOMvA7nqr5
         88bw==
X-Gm-Message-State: AC+VfDxgd5jRRRVKMRlp7CZW+513XcdtfF79QDSBjG0/fl74OHavL2G3
        OmhwU6UlQgT6MrAoxZNwPV4+lF/h7dqgUQhENL8DlQ==
X-Google-Smtp-Source: ACHHUZ42sasNBJ5U+qQUANkYHe8wr6QZwvgJdArljj1mz3V27qwnBdyMWtJUiDirfiineHeOKCNND53yzPz00TsHIAA=
X-Received: by 2002:a1c:f705:0:b0:3f4:c28b:ec88 with SMTP id
 v5-20020a1cf705000000b003f4c28bec88mr1837762wmh.41.1684527248304; Fri, 19 May
 2023 13:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230518-bamclk-dt-v2-1-a1a857b966ca@gerhold.net>
In-Reply-To: <20230518-bamclk-dt-v2-1-a1a857b966ca@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 20 May 2023 01:43:56 +0530
Message-ID: <CAH=2Ntx3WxEM_ita+caGXvqCJjCy=TkX8gjyT9nSV3j-89Y_cQ@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: qcom: bam_dma: allow omitting num-{channels,ees}
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 at 16:30, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> The bam_dma driver needs to know the number of channels and execution
> environments (EEs) at probe time. If we are in full control of the BAM
> controller this information can be obtained from the BAM identification
> registers (BAM_REVISION/BAM_NUM_PIPES).
>
> When the BAM is "controlled remotely" it is more complicated. The BAM
> might not be on at probe time, so reading the registers could fail.
> This is why the information must be added to the device tree in this
> case, using "num-channels" and "qcom,num-ees".
>
> However, there are also some BAM instances that are initialized by
> something else but we still have a clock that allows to turn it on when
> needed. This can be set up in the DT with "qcom,controlled-remotely"
> and "clocks" and is already supported by the bam_dma driver. Examples
> for this are the typical BLSP BAM instances on older SoCs, QPIC BAM
> (for NAND) and the crypto BAM on some SoCs.
>
> In this case, there is no need to read "num-channels" and
> "qcom,num-ees" from the DT. The BAN can be turned on using the clock
> so we can just read it from the BAM registers like in the normal case.
>
> Check for the BAM clock earlier and skip reading "num-channels" and
> "qcom,num-ees" if it is present to allow simplifying the DT description
> a bit.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v2:
> - Rewrite commit message for more clarity (discussion with Bhupesh)
> - Link to v1: https://lore.kernel.org/r/20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net
> ---
>  drivers/dma/qcom/bam_dma.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 1e47d27e1f81..4c3eb972039d 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1272,7 +1272,15 @@ static int bam_dma_probe(struct platform_device *pdev)
>         bdev->powered_remotely = of_property_read_bool(pdev->dev.of_node,
>                                                 "qcom,powered-remotely");
>
> -       if (bdev->controlled_remotely || bdev->powered_remotely) {
> +       if (bdev->controlled_remotely || bdev->powered_remotely)
> +               bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
> +       else
> +               bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
> +
> +       if (IS_ERR(bdev->bamclk))
> +               return PTR_ERR(bdev->bamclk);
> +
> +       if (!bdev->bamclk) {
>                 ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
>                                            &bdev->num_channels);
>                 if (ret)
> @@ -1284,14 +1292,6 @@ static int bam_dma_probe(struct platform_device *pdev)
>                         dev_err(bdev->dev, "num-ees unspecified in dt\n");
>         }
>
> -       if (bdev->controlled_remotely || bdev->powered_remotely)
> -               bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
> -       else
> -               bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
> -
> -       if (IS_ERR(bdev->bamclk))
> -               return PTR_ERR(bdev->bamclk);
> -
>         ret = clk_prepare_enable(bdev->bamclk);
>         if (ret) {
>                 dev_err(bdev->dev, "failed to prepare/enable clock\n");

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
