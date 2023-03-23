Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0E6C67BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCWMNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCWMN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:13:27 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07ED1EFD9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:25 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5447d217bc6so390930707b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n4JThIvTj6PwMP8Tc+wbes5jB+9//DVarS0wUhW+9E=;
        b=YQV0ifFChMu+GzWnG+rbhqAGf40XMt4vuCpKsVheY+wiWYpZyRBLpaO4SFujLcWdNy
         P0s775M0CzMr5ghPG+Vt86ixzyiSJ8O8+kjI6fSGf9seP5Va3A9wdcbR/iAm+gxRpkXL
         6bHCpCWPcgwHfmXFhdIdG/7sJ2mEPxGNEVCmM1cA9F/JzxME8tdd5o8M4tvbz/dyCGaH
         sUNQ4EWqwJQR94p54LwwjvYeOULaidfYLVC7HGqgqGz5gd8h11qVSWNrB20fhmE8P38/
         KGMsFhJOs1h6n07rAtXOSPh6BmCQz8IXcCkLRdNTapFIJz7dvRptreXGESmvVL4CaRII
         nFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n4JThIvTj6PwMP8Tc+wbes5jB+9//DVarS0wUhW+9E=;
        b=72/WL8DnQiZlTqFoleZl7LfMoeRIBJf58d1Y5wY0KEkpnUzIh8BXiv1klTVtK+0bLk
         b/3yOqjKjzv19NVatdVgrpfy182/kJApf2afEE+cpI7VdMqV7HYFBU04SM9pdVkVS2KZ
         XOLD5VfPrhzg10FDRXnnl1RHTQERFMrhuLIizrqZKgF+UJxRh7TRtnMU3vdLfXbzlxiQ
         F6g/CFTJHTS/D5raF4IgO0OkpuW5w9EM2tgUsAdqkXngVSTXZ2AGpdou7IxHbSS/kYiG
         419bcDZx8wmzLFTNR5NXhl1Z14zeL32EldpxLdIbIYn8bhmLU64PpwngrQFWvEGXJIuK
         axKQ==
X-Gm-Message-State: AAQBX9fVu95r1DSHT3Zy5fs2cID56p25Tax/lOpXH28ZCL7oWQwlmupX
        PuaWGV6HiKQQvYlW0/AbUpZuEQuPxOt/f3UO6kN7WA==
X-Google-Smtp-Source: AKy350aO1QSF9/2PBO4hdxQ8GSTVuWIPHxMlMcuBlCXl9q9h79YdWWP7wx9g9FVfJldi/WBStp4oDHkprcc5VDjjriM=
X-Received: by 2002:a81:ae1c:0:b0:52e:e095:d840 with SMTP id
 m28-20020a81ae1c000000b0052ee095d840mr1766782ywh.0.1679573605233; Thu, 23 Mar
 2023 05:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:49 +0100
Message-ID: <CAPDyKFq_ak_40PKm2SyuyZzHQkKJpUcLkGr_HZXTgcCfzZFjcA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: drop useless sdhci_get_compatibility() !OF stub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 21:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The sdhci_get_compatibility() uses OF functions which have stubs for !OF
> case, thus entire CONFIG_OF ifdef can be dropped.  This also fixes
> !CONFIG_OF W=3D1 warning:
>
>   drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for =
=E2=80=98sdhci_get_compatibility=E2=80=99 [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v1:
> 1. Drop the stub (Ulf)
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index 328b132bbe57..673e750a8490 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -54,7 +54,6 @@ static bool sdhci_wp_inverted(struct device *dev)
>  #endif /* CONFIG_PPC */
>  }
>
> -#ifdef CONFIG_OF
>  static void sdhci_get_compatibility(struct platform_device *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
> @@ -72,9 +71,6 @@ static void sdhci_get_compatibility(struct platform_dev=
ice *pdev)
>             of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>                 host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }
> -#else
> -void sdhci_get_compatibility(struct platform_device *pdev) {}
> -#endif /* CONFIG_OF */
>
>  void sdhci_get_property(struct platform_device *pdev)
>  {
> --
> 2.34.1
>
