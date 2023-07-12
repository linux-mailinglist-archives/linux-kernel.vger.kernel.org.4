Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920A2750C79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGLPaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLPaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:30:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C81BD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:30:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666e916b880so3599026b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689175816; x=1691767816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=loka7yyam4HH4hk5o77esG6TL283l3EmLjPyoPIKm/E=;
        b=nc07v8jEidhBLwyehKkHTpbfeCgLDkXx4cFAUn8xa2dTdXPGDXqCtqTreOsjII8P2a
         YOb7hHtVXlagsGhk3uF6zgI12dg+0pmzQNrjufPZIdoR7iFCN4damvTqhjvmSfjiACNk
         noZr+GKgZAmuR6uHD77kVE0PC9AwczMjhzSuTi20G7t6UJpssqdlbW1YwQ4Spe87d9+p
         FIAsAqFhWW4vDBzxn87K1JxP13fvxFckagmpTP4sAj1RJL/Y/1xQW499nfQIiIhqcbLH
         In9quvnpwJkpAGATPd87VMbXe8hS7yrrrPbr4+mapIFN2SOxFNaa6TceU8eakVCYcWi0
         y5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175816; x=1691767816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loka7yyam4HH4hk5o77esG6TL283l3EmLjPyoPIKm/E=;
        b=l0U8gmqBsdnR/GgifDGqkQ1lsLX1Nf+myAciJSdl+KeaYgP7exdOsrd2eB0WIRjx2L
         g3DMXAvo54UU1TB6VL0XfmbN7T39vwT5mXIzRmANuE8eOcXKKu0gCXA2mNSw3/yIxWlG
         MPL0r9cu0CsKdb3Qx/D/1BbLehpoYQBXPR3FzC05RUOmqbEYj9AfQGpyrddDqClD1FGk
         VYOxhifN3UkDlx9xEUVx+Yab+O62gtIMy04XhL3srw39GH7l7twPX+3jq07S+Xs02cmj
         s5Xa/Eq4cTI0twAtEHScCm8ew99JoL3Zytfs2gZnNiIVfLrrDZ6LjoBYVM/hkURsNcdo
         NYeg==
X-Gm-Message-State: ABy/qLbndb9mInv+ZHfN+OOpNIMYbRnvC0YGuZg1hcx6Omnz9Q32zR7g
        /QHj9kiH+oF8EGu8wSfrHmZ/
X-Google-Smtp-Source: APBJJlH7b4UCDOU8YjQreDELwjYmIJ8MtN4tTdRE4VqJyUBoQtRp52SogLW/SJHoRn59x8mW+JwQfg==
X-Received: by 2002:a05:6a00:148b:b0:67a:8f2a:2cb2 with SMTP id v11-20020a056a00148b00b0067a8f2a2cb2mr18306254pfu.20.1689175816352;
        Wed, 12 Jul 2023 08:30:16 -0700 (PDT)
Received: from thinkpad ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id n18-20020a62e512000000b0064d57ecaa1dsm3772892pff.28.2023.07.12.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:30:15 -0700 (PDT)
Date:   Wed, 12 Jul 2023 21:00:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Provide deinit callback for i.MX
Message-ID: <20230712153003.GF102757@thinkpad>
References: <20230712-pci-imx-regulator-cleanup-v2-1-3b1f6e9d26bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712-pci-imx-regulator-cleanup-v2-1-3b1f6e9d26bc@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:02:57PM +0100, Mark Brown wrote:
> The i.MX integration for the DesignWare PCI controller has a _host_exit()
> operation which undoes everything that the _host_init() operation does but
> does not wire this up as the host_deinit callback for the core, or call it
> in any path other than suspend. This means that if we ever unwind the
> initial probe of the device, for example because it fails, the regulator
> core complains that the regulators for the device were left enabled:
> 
> imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie: probe of 33800000.pcie failed with error -110
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 46 at drivers/regulator/core.c:2396 _regulator_put+0x110/0x128
> 
> Wire up the callback so that the core can clean up after itself.
> 
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v2:
> - Rebase onto v6.5-rc1.
> - Link to v1: https://lore.kernel.org/r/20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 27aaa2a6bf39..a18c20085e94 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1040,6 +1040,7 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>  
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
>  	.host_init = imx6_pcie_host_init,
> +	.host_deinit = imx6_pcie_host_exit,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230703-pci-imx-regulator-cleanup-a17c8fd15ec5
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

-- 
மணிவண்ணன் சதாசிவம்
