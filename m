Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A616643A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbjAJOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbjAJOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:49:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3914FD7F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:49:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so16765313pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpLsPS64gGD8YUBI0Bu4AVydWOuQrgek2DJ1L/L5vUo=;
        b=Lh3fv9IdNK5JAnIf9GmAOUwqP5r6aUh6lH/JPj8z99x6jz/msFyv3ueeoONNbgR1R2
         L2y6RUjLss/Mg3SYY5n3dmG33LWM+tGAEBOef4GOP8TxdDcJnYT1F8iZYV6teejjbM5J
         NNFfTAX5dD19ZM2F4xzS7Pqv3+2ziil7lewCBqB41ATqP9jPQq4bwM75gaTDBlz88UiX
         EfBtXYjT3k2noLMW4ftVct8UhfocoLYFAsoVh5fB6zYZfp+1O+/gMTT2hsIxkEJaCrVk
         yx967glDzZK0HF1X12gZ2L6FUShEktaPMjmbRZds2nwTJFUA3R/v/QV461qZUSqYBsia
         8bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpLsPS64gGD8YUBI0Bu4AVydWOuQrgek2DJ1L/L5vUo=;
        b=b1QyIz5QniAMAsqi76BTXwpj7IGRJFplHAR5isTra8lPklSIL1q9LWJz24u4oOwsyA
         2pvuRAx2tjeVRp1EGk3SxdLjVpMqlmGVerfUXNEvazXeN6jPmsThwQ20MW7LsTLjcpiL
         PiJSQPNwbWWAHG72pSsLSsTMjiBSNYfwMjuKUqeQk5PYurdPs5Hz+/kEt4vybUWWlzvJ
         vwrAwG+gl6qHVeLdnNSbAltzWjNUqfV0Fn6zZqNoKgYi50ufXO2ZgGx5azc132TLCaf1
         iJTGmni/rmbQFZHyhe61BWH7ZDSpE7sdSqgUikakpZSEMuo2soOBQXYz0pCPPC25jfwg
         5ZvQ==
X-Gm-Message-State: AFqh2krA09nWkbG1CUaP4D7hF+QajfBF6aoG6mVbH6oCYkngflDrgGw/
        GDjIkeFLp6fxFRDkFuZYAXK+22Ee3x/gJcm3QMadL55okRBUpQ==
X-Google-Smtp-Source: AMrXdXttvIGiddNe1eSz5eqSdQNwiC9hIOfs6SkVdBw2PRyxVa/ty/aHYIdEQ1dfFTwGyop40X+qHJT9NyvsRhlje5k=
X-Received: by 2002:a17:902:f314:b0:192:f1fc:e8b8 with SMTP id
 c20-20020a170902f31400b00192f1fce8b8mr2303934ple.37.1673362187411; Tue, 10
 Jan 2023 06:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20230110125101.10533-1-hejunhao3@huawei.com>
In-Reply-To: <20230110125101.10533-1-hejunhao3@huawei.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 10 Jan 2023 14:49:36 +0000
Message-ID: <CAJ9a7VhCnzGuq2sGOZ89ALThg9j6VYCUAJMeKxMwbweZ1DoiuA@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Fix accesses to TRCSEQRSTEVR and TRCSEQSTR
To:     Junhao He <hejunhao3@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, shenyang39@huawei.com,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 at 12:51, Junhao He <hejunhao3@huawei.com> wrote:
>
> The TRCSEQRSTEVR and TRCSEQSTR register is not implemented if the
> TRCIDR5.NUMSEQSTATE == 0. Skip accessing the register in such cases.
>
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 80fefaba58ee..c7a65d1524fc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -424,8 +424,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>                 etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
>         for (i = 0; i < drvdata->nrseqstate - 1; i++)
>                 etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
> -       etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> -       etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> +       if (drvdata->nrseqstate) {
> +               etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> +               etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> +       }
>         etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>         for (i = 0; i < drvdata->nr_cntr; i++) {
>                 etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
> @@ -1631,8 +1633,10 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>         for (i = 0; i < drvdata->nrseqstate - 1; i++)
>                 state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
>
> -       state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
> -       state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
> +       if (drvdata->nrseqstate) {
> +               state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
> +               state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
> +       }
>         state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>
>         for (i = 0; i < drvdata->nr_cntr; i++) {
> @@ -1760,8 +1764,10 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>         for (i = 0; i < drvdata->nrseqstate - 1; i++)
>                 etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
>
> -       etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
> -       etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
> +       if (drvdata->nrseqstate) {
> +               etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
> +               etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
> +       }
>         etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>
>         for (i = 0; i < drvdata->nr_cntr; i++) {
> --
> 2.33.0
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
