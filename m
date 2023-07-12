Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64467750836
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjGLM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjGLM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A561BEA;
        Wed, 12 Jul 2023 05:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4C6617AF;
        Wed, 12 Jul 2023 12:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA20C433C7;
        Wed, 12 Jul 2023 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689164812;
        bh=W3smyjCEDQCZ7N9U5xTsAijdASzIF9l4tZ+KT93zqNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbHJHjNSm0fHEbmnjn/xqszft8Exw4uVANi9F/2nCEsVcTkKb+GvzopoYiu5/w3cc
         j5G5hy+ON1v9ZjRezYwd14KXa7vkLKvtlYhq9Ju3UFmjx7uMAmBRTeGaGcazJwvA0Y
         Q1/bZE0VpRL04w5CTcNeI/QVEAQvTtZeZubA3VYpSw4NT2izVpLKqhwLpmYRMCLStx
         DGugihHBitupae5T+moP6G4KEyW6oaH+EHr63xWtl09l0BR+1TrPEr3cD483dq4UgP
         R21ef/YAU++ezyWjlpZiUdB+7k5majlClVWxh7xXHDO66lb8zDi29cQO3AQUcDMMkV
         8ts/ohS+YYEjQ==
Date:   Wed, 12 Jul 2023 17:56:41 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     loic.poulain@linaro.org, fabio.porcedda@gmail.com,
        bhelgaas@google.com, song.fc@gmail.com, duke_xinanwen@163.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add support for Dell DW5932e
Message-ID: <20230712122641.GD102757@thinkpad>
References: <20230712083741.7615-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712083741.7615-1-slark_xiao@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:37:41PM +0800, Slark Xiao wrote:
> The DW5932e has 2 variants: eSIM(DW5932e-eSIM) and non-eSIM(DW5932e).
> Both of them are designed based on Qualcomm SDX62 and it will
> align with the Foxconn sdx65 settings.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 9ca0dc3a3bfe..07172789b197 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -625,6 +625,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* T99W510 (sdx24), variant 3 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f2),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
> +	/* DW5932e-eSIM (sdx62), With eSIM */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f5),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> +	/* DW5932e (sdx62), Non-eSIM*/
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
