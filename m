Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52A2645BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLGN6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiLGN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:58:25 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C87D5BD78
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:58:23 -0800 (PST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D991141672
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670421502;
        bh=9GCL3W6v/AmfhZbVCu5utEsH4vGz3v+tufp1/dYemRM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dKUvmoqIGuOxHNNKEtH6Ri+Tj3dSZVfYeYVSgDiUN6H61FwQWPWJqUqi/e4Fn2xuu
         cFFpbwz27G0cH6IvLJ9wk6uLw6/Ow4k3UNfLuHX976tCwLL8XzugxeKaFI6WAjjwCD
         r6YjAgtYcE4OPdfkKhayYEYRrmzAcRTeViS01iqxhbNpV5X5rVxhSLpHF6Pin6tx5m
         CCDm32bdgv/mRZnnZbR6BQ7pMATmx3j8ckrdtGTzDv8s5ePMbVvjv39CcD6tCAFH2J
         /DPUK9zV3PpQsFoI78UI62t60cGEMqIy4bbVoNDTNKjGyKKiDSdg7yHEYqSm31N70d
         JlkdjN8VAbp8g==
Received: by mail-io1-f69.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so13544417iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GCL3W6v/AmfhZbVCu5utEsH4vGz3v+tufp1/dYemRM=;
        b=xWjGCNYfyc9kXE9pFVziDPeQeLscTIek99dH1xcx62Uj1MIXRhXd/wsbhPRcVptrrq
         XMPU5lMla4KfG4qLx69fyhKakqjjFDE4L1QRw4sPicR6XXRepfpapodwogt5SugjMdzh
         vvRS3hDLUb6JivpjrMSIRRVG5MYHuV73fB45NK9jhM3TpOS+fMI1lVygIegnuFGLsRZ6
         74H2H5bdLG0IeT1CFzXbjgrw/AeCJTbD9GHtWlBSEBFs+fGyQnmENAj6eaH1Qip4/tIl
         jMpzbo8uYlhCZ4PYZBo63XfvG9h5mS+NvlDR94cwp2EPGPPeSwPdWHIDulUMtHrCPALC
         S5+A==
X-Gm-Message-State: ANoB5plk1bIPOl/bWVyM9SbkaccdgIAcThrWm9Rp89Vc0mQI6zFGigxM
        VowWipqk7q7ViskHrPOYEKI2FCrakRALof+HgeoomPD0KREd1MXgcMJoSojGlBqY3GTGXP5v2Y4
        riLHt2zIGND/BfjhEmLiTEspCQ13JAmVSKykj74t3OKDRtbK9kZuj7LnlVA==
X-Received: by 2002:a05:6638:15cb:b0:38a:a2c:5c1e with SMTP id i11-20020a05663815cb00b0038a0a2c5c1emr14812173jat.35.1670421501102;
        Wed, 07 Dec 2022 05:58:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6oS4WtB4AY/x9xEAWaZszCLUNeiIhVzCL4QBdnRGkNjsZUkTVArtcl3+u1LcaAO1HHytY7Lk4DCTgXk2m0eYo=
X-Received: by 2002:a05:6638:15cb:b0:38a:a2c:5c1e with SMTP id
 i11-20020a05663815cb00b0038a0a2c5c1emr14812154jat.35.1670421500857; Wed, 07
 Dec 2022 05:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20221201090242.2381-1-yanhong.wang@starfivetech.com> <20221201090242.2381-3-yanhong.wang@starfivetech.com>
In-Reply-To: <20221201090242.2381-3-yanhong.wang@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 7 Dec 2022 14:58:04 +0100
Message-ID: <CAJM55Z8ZDKWEkdWuRZfcMQDrySMh4vdB1UvkAC+q1GRKMbGuEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] net: stmmac: platform: Add snps,dwmac-5.20 IP
 compatible string
To:     Yanhong Wang <yanhong.wang@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 at 10:05, Yanhong Wang <yanhong.wang@starfivetech.com> wrote:
>
> Add "snps,dwmac-5.20" compatible string for 5.20 version that can avoid
> to define some platform data in the glue layer.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>

Hi Yanhong.

Thanks for submitting this.
But just as a reminder. Please don't change the author of the commits
you cherry-picked from my tree.

/Emil

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 50f6b4a14be4..cc3b701af802 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -519,7 +519,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>         if (of_device_is_compatible(np, "snps,dwmac-4.00") ||
>             of_device_is_compatible(np, "snps,dwmac-4.10a") ||
>             of_device_is_compatible(np, "snps,dwmac-4.20a") ||
> -           of_device_is_compatible(np, "snps,dwmac-5.10a")) {
> +           of_device_is_compatible(np, "snps,dwmac-5.10a") ||
> +           of_device_is_compatible(np, "snps,dwmac-5.20")) {
>                 plat->has_gmac4 = 1;
>                 plat->has_gmac = 0;
>                 plat->pmt = 1;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
