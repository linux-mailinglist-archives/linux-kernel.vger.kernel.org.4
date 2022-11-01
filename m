Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE26149D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiKALtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiKALtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:49:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B64639C;
        Tue,  1 Nov 2022 04:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE956B81CE8;
        Tue,  1 Nov 2022 11:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EABCC433D6;
        Tue,  1 Nov 2022 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667302990;
        bh=JcTrk/RF3JsSWeq8eah3J59uSDdXRqqd/gbzuT/lHpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3mID94cJ3Uf66O/Er1AuJ2n2fP8Juk9Mke++TzbpWqT+GlPVBWScoFqGkUhnOGTE
         RUxC/6WBn0mEPtil+qH7v9Rq8Q7ajYjGlkio6GdRzM+TSfad1OZ4tnZD8+j1c833Wx
         OQIXkmKCT8LEAnF7KdpiyL2pC+jNKjukCYvXCJBa2beuQSviG0gi9/6C6WWaL72nKO
         IkXc5zfDwBG7FVDrmG2OdAPzVXubjFbdSXiTNK28Svlwial8hUHqzojEXRgVRdHEaX
         r3spBnNvNyoYwAMAcwgRcmD9lwbHttvagFsV5pkgU9DhwdaqqDh7473lCmpeBGPuNd
         SHKGLDCaLHRYg==
Date:   Tue, 1 Nov 2022 17:12:58 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mhi: pci_generic: add support for sc8280xp-crd SDX55
 variant
Message-ID: <20221101114258.GB54667@thinkpad>
References: <20221031083429.18971-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031083429.18971-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:34:29AM +0100, Johan Hovold wrote:
> The SC8280XP Compute Reference Design (CRD) has an on-PCB SDX55 modem
> which uses MBIM.
> 
> The exact channel configuration is not known but the Foxconn SDX55
> configuration allows the modem to be used so reuse that one for now.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index caa4ce28cf9e..f9f4345d472d 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -542,6 +542,9 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
>  static const struct pci_device_id mhi_pci_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
> +	/* SC8280XP-CRD (sdx55) */

Platform device name is not needed.

> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),

Sub ID looks wierd. Did you test with mhi_qcom_sdx55_info? If it didn't
work, what was the issue?

Thanks,
Mani

> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
>  	/* EM919x (sdx55), use the same vid:pid as qcom-sdx55m */
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x18d7, 0x0200),
>  		.driver_data = (kernel_ulong_t) &mhi_sierra_em919x_info },
> -- 
> 2.37.3
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
