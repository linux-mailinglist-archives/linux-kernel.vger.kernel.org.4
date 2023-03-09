Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78E36B2828
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCIPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjCIPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:04:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35EBDDF2B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:02:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id y19so1218285pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rzsJZdpZ7LPDoQfu9o9lW5gjnwOdZ6t+X4Prhh6Xwh8=;
        b=czM7cHYNWrkijeBV8VGOp7J3iol/R2pmJj5w+DjZF+eADrJovmHWPb2EhP1KZG8e/G
         ZJmEC/RkA3Q1UGvqmrmOZDwWpq9N/+uim1BfEpp3eOb6G30OkPC/EgS7nrZWaSNLHEiZ
         4rLBJdU/RpNn5kaddwjfzdFZRkF5z3QheH2rwo39cX4zccSfHZFRNoHwLFnuu/JXxYqg
         89oTgAeGvxcadtlxYCMw8UrbWpqCvXyEK7FeN2OOezV/8mPw9siUXUyevPdEKS/MicLk
         lWj/SClhiDYTgbQGGF3wcnXcrdTSAIwEhpdvjmF62Zgv4USje1OpSK5JEoA8mw9zFAIT
         B6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzsJZdpZ7LPDoQfu9o9lW5gjnwOdZ6t+X4Prhh6Xwh8=;
        b=HJKu3px4Dxdk3oUZCF/i5mTXRybreYYFMGCTPmkCKb2sew8tkBf/wGnTccJ4YWdaB1
         QKtrHG4LLWxnwnWkFuEMnimm0HD04XIlPQNA2k707TlG/ifDJ1QqCeJQQk1h3jmxzwWl
         kxKUt5Zu8bYbQfyX1N/YmyTPLUzveppfa+eIjaJ3GYRkCc94FZhL2TBYW+/HIzjxQKAE
         72x82G1OzAeWiaDi/uk67ChUTBn3ayNRHPxxcwALgYa/G13Ut1NKvSBGsahNdyt/HRLC
         HqSQrSEsh2d9BEqVzv4EIruDdnjCe66LuE/vZ+8TCU9SfSi3dre1KVK8I36wYQSmfByd
         r6zw==
X-Gm-Message-State: AO0yUKUHVPGuffDmJhcCNLEkEc3yn//J6FTFmvT2qK4itwxkTLEakhIt
        kahMq9njlfnoXGfLFj0EZaham+vsd0To+F7hCQWylw==
X-Google-Smtp-Source: AK7set/pg4ofM8YOtb7sDX31eSeRHJ4g+nh8yNyQMFWWgiMSTk2nHzbzts0k3Xa71amPJpu/lX7Qb7fMUm1R0Du6DvM=
X-Received: by 2002:a63:f91d:0:b0:502:fd12:83ce with SMTP id
 h29-20020a63f91d000000b00502fd1283cemr7999126pgi.5.1678374160137; Thu, 09 Mar
 2023 07:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20230223141402.23979-1-swati.agarwal@amd.com>
In-Reply-To: <20230223141402.23979-1-swati.agarwal@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:03 +0100
Message-ID: <CAPDyKFpSOs-xuQOssxPYrQPp=_qsAMem+LGYyqwSAkKqKXb7MQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate" clock
To:     Swati Agarwal <swati.agarwal@amd.com>
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 at 15:14, Swati Agarwal <swati.agarwal@amd.com> wrote:
>
> Add support to read the optional "gate" clock property and request the
> clock which will be used to ungate the DLL clock.
>
> For Xilinx platforms which has DLL module, dll clock must be
> ungated/enabled when SD controller operates at higher frequencies like 50
> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
> clock from the driver.
>
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 4eebbf801b41..1fd7528c14fc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1870,6 +1870,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         int ret;
>         struct device_node *node;
>         struct clk *clk_xin;
> +       struct clk *clk_dll;
>         struct sdhci_host *host;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct device *dev = &pdev->dev;
> @@ -1943,6 +1944,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_dis_ahb;
>         }
>
> +       clk_dll = devm_clk_get_optional_enabled(dev, "gate");
> +       if (IS_ERR(clk_dll)) {
> +               ret = dev_err_probe(dev, PTR_ERR(clk_dll), "failed to get dll clk\n");
> +               goto clk_disable_all;
> +       }
> +
>         if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
>                 sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
>
> --
> 2.17.1
>
