Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91CF708C02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjERXG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjERXG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:06:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF718D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25348d724f2so398934a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1684451185; x=1687043185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIB5nolYlR7mZtM7NMk4WurxovvarDu47ffDj2xUgaI=;
        b=EhJgky4OdgM86fs0x3LyOes6hLpgtE3xSHUR576ODesiJFfCIEwI4K2JyLeKLnAQFL
         lU19bEuOcjKucmsqagyFJYBzOX2oGGJiFeLcg5tWi/l/55ueB70VpBbKSSmMfMj5k4B0
         EKn6FibDF3cccfDbmYR7iAOropbkOQW3lRpIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684451185; x=1687043185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIB5nolYlR7mZtM7NMk4WurxovvarDu47ffDj2xUgaI=;
        b=PhnG2CdfATxfPOguEc0x8M8BIzTKeXNWd8/I2oiVyPFhvPQnKiX1n2ywcZleuEvRpB
         vXpsWAEhWEVZDLo7OYGSzdOnUQygAgQtk4J8PgvcQiDhEn4pEReUDD//h5+zusUe+icq
         MftL6osd1YxAhjJ2816XGjbpBxBDulCt7Gk0/BPqYOeW/oh2trjoHaN9n3Ka1h23509f
         iocwV46kMoKOdnlqndB5FLSRWODWTJ2TU97cVQ/lB+BSOLNoFKcUEbMiccjsq7Dg0A/a
         soL0mTxnS8JPmfzB3x4jbUhEtlMDSAQMkqRoJm+Q+7rzn/y05RSuMajdtAXtEu6Q509G
         RmNw==
X-Gm-Message-State: AC+VfDzCcU8aF5WVeH4NEr57ZUtnodLcrzHlbxqv1RbFLhNiD57Eo/DH
        OoZoyurE1Z7n+72jG2MCgE38lj7muoH+ezT7zco3LPABSGqzBrwAruhK9Q==
X-Google-Smtp-Source: ACHHUZ6eZiwkSP+pRyy2pr27pZZ2cIOQMw9ECXUDDBLKPcNW3Xy9O3stjropam1ceMtas+Q3cA4DC9Or3zWHd67OAvg=
X-Received: by 2002:a17:90b:3ecd:b0:24e:102c:10cc with SMTP id
 rm13-20020a17090b3ecd00b0024e102c10ccmr241203pjb.4.1684451184699; Thu, 18 May
 2023 16:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230513112931.176066-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513112931.176066-1-krzysztof.kozlowski@linaro.org>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Thu, 18 May 2023 16:06:13 -0700
Message-ID: <CAGt4E5tjKwPf5m-xiDF3DskGWWvZDb2jLYPaXL0kkbfer7Fe7A@mail.gmail.com>
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix testing array offset after use
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2023 at 04:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Code should first check for valid value of array offset, then use it as
> the index.  Fixes smatch warning:
>
>   drivers/memory/brcmstb_dpfe.c:443 __send_command() error: testing array offset 'cmd' after use.
>
> Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/memory/brcmstb_dpfe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 76c82e9c8fce..9339f80b21c5 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -434,15 +434,17 @@ static void __finalize_command(struct brcmstb_dpfe_priv *priv)
>  static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
>                           u32 result[])
>  {
> -       const u32 *msg = priv->dpfe_api->command[cmd];
>         void __iomem *regs = priv->regs;
>         unsigned int i, chksum, chksum_idx;
> +       const u32 *msg;
>         int ret = 0;
>         u32 resp;
>
>         if (cmd >= DPFE_CMD_MAX)
>                 return -1;
>
> +       msg = priv->dpfe_api->command[cmd];
> +
>         mutex_lock(&priv->lock);
>
>         /* Wait for DCPU to become ready */
> --
> 2.34.1
>

Acked-by: Markus Mayer <mmayer@broadcom.com>
