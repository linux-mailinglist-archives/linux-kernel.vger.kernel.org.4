Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC686A4554
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjB0O5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjB0O5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:57:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B17959CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:57:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p20so5763597plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMWRWsx+NX+ZsoBdeAksgis3WCgc+mV0ObFhcVdcQt8=;
        b=kf+IMnpHKi2YohvVX3jI9exE0YcLnVPKVbiWhYA0UsaOt3gj0DslKbWmTeAJF+deBn
         meF+9izukLixfjd9BAswfCNqywEex2kf9QA/qhU+V9kPWfK1QM/Z5nIKkPlfSJdGt/Zs
         62ZV4eVachhOHvjCfu+QEoUGqRT7hhbk3Q8s0lPpd2/p+XoGLvfU3jwu2Ke5wb/n5SG4
         imntlpnh8xUOpTeKpRfzwHPcVUuumEOHH/Zs42uN3TrVRiA5xTA5Xccd1OUgpGEFzNQz
         d+fbSrwCyN7xcjU/bJE8aNXI83hY4vEOKzwwQc84FjnNMU0YJz+fTC+7CLznLtASAs3M
         aDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMWRWsx+NX+ZsoBdeAksgis3WCgc+mV0ObFhcVdcQt8=;
        b=IjVo8DI7TIqiI0Sck6Gid4gAYAFXUffaF0bhCqg1rs3SE4ebShVWpTAAgIzTotohij
         RS+6QIk0rwFEn7LGvD9YZMOmav0EbcmNEmTAKN/QgcPMG2m9x6wSxa9l4dXQSMoxMqti
         U4AC5bJLxircyELKVLHD5t1pQboKVPyRBNsyov5tiOGPDGKW0wPG+Ep3t0tVY+DkHSln
         mrjuGEnlnjF9l9FLCSNKbwWtHpt89wOIDwdoNvzXwoJzrxtD0Gr9NVUP/tU/1ePAwNH4
         BFrR71z36XjA2dQs0gEj8pWo+rCYWcepOmvitewINAsnR1u2w9w6iElbzCvKrXU5wTM1
         P3Zg==
X-Gm-Message-State: AO0yUKV9lSOcXa0zLvz+XnptLSCn/zBazcjnCKEEnCNhA+U5Guy+iFGj
        /MQ9B+j9vXSbaoBQh6p2cVNIkOYSoqkoFC1rEQs/ng==
X-Google-Smtp-Source: AK7set/cIdRiYJnqStSeE4iB/dHP9Z6P3eJh8irZ4IU0wViUJxA8Hd4ovr+/3O68jVXLLarklUF2irVjnaHo0Uj/7rE=
X-Received: by 2002:a17:903:48e:b0:19a:e617:34ff with SMTP id
 jj14-20020a170903048e00b0019ae61734ffmr6114366plb.11.1677509837733; Mon, 27
 Feb 2023 06:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20230223141402.23979-1-swati.agarwal@amd.com>
In-Reply-To: <20230223141402.23979-1-swati.agarwal@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 15:56:41 +0100
Message-ID: <CAPDyKFoGmHpdt5UckyDTWQSK7OmZ789g9Owz7sPP4VJ6ezJbsQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate" clock
To:     Swati Agarwal <swati.agarwal@amd.com>
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@amd.com
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

On Thu, 23 Feb 2023 at 15:14, Swati Agarwal <swati.agarwal@amd.com> wrote:
>
> Add support to read the optional "gate" clock property and request the
> clock which will be used to ungate the DLL clock.
>
> For Xilinx platforms which has DLL module, dll clock must be
> ungated/enabled when SD controller operates at higher frequencies like 50
> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
> clock from the driver.

I guess we need to update the DT bindings too?

Kind regards
Uffe

>
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
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
