Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C1654300
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiLVO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiLVO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28FE29341
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671719313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fx9ad2rlPWF5dF27a81pZTlxjb2rUdl1cuvJMpxalUE=;
        b=hEptauBvHcfuCICwpwP3G/hntofh4Dri0d/oqbCklWkG94Nx6GLAwOO0nG+1QJd9hhGI3I
        RW0jEFFsE40oLH6cC5Dx/gHK2hOjW9e7YIVPWQEtZEOdC9mKJL4t6BSV6Nzmv7yAoqLGsg
        EH6BXDgBePITLm2xxkNIPT7boLQIbMA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-m0XyKdqRP5usv6PIzaqcIg-1; Thu, 22 Dec 2022 09:28:31 -0500
X-MC-Unique: m0XyKdqRP5usv6PIzaqcIg-1
Received: by mail-ot1-f71.google.com with SMTP id f39-20020a9d03aa000000b006705c6992daso1068959otf.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx9ad2rlPWF5dF27a81pZTlxjb2rUdl1cuvJMpxalUE=;
        b=hFk+ZXf2IjcSzdsVV3rEjTpQefuiLR1FXhfMOuBMVbfoV0U3rEW6y9cj7vXIL/TyTT
         kLun3vY9DB91+vcL3uG/+BkWN7RyhdYUFsSRwhqQ8109A46KreSOvDz+c749i0XF16wl
         Xcfeu7nBFRzCBQdiUiVJxVGQwEsHKyQ3qx559WKPp+cf7EaFS+viMRlkw14tFZPtd3Gw
         9e7aiYE1AsjDoVCuBMvg50LtbT8kGSNRO+odaDktNyEN5Kc0eBiVqZfooZTv4LJpk8OP
         Jxiv7Fej6sNAZubcdQcpxgoJXiBKvItILwbL4MCEfTzrqMdgeBxc2nFZl0WujwcLiaS5
         kK7Q==
X-Gm-Message-State: AFqh2kqYlYgwNf0aFQAY9cOP51spl33KAPmgl40+JvEx7aDDZavsmAnT
        h/PnMUAauCa9SSOPXnHhgC7XcRPlOo8pjL9FpRK79CXFU/KL3psgm0UUFaMi1Ty/SkKYAKzw8Z7
        amH3vGu+vl/QfyYMOelH58Xju
X-Received: by 2002:a05:6870:b285:b0:144:b21b:1c1a with SMTP id c5-20020a056870b28500b00144b21b1c1amr2039976oao.56.1671719311164;
        Thu, 22 Dec 2022 06:28:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvOoiyjHVabuKrRHA369Cpmf5CpdYf95RldfQOYnjjqoR7xSZBVXcxXbk3ive9GmTJxmTt7qA==
X-Received: by 2002:a05:6870:b285:b0:144:b21b:1c1a with SMTP id c5-20020a056870b28500b00144b21b1c1amr2039960oao.56.1671719310904;
        Thu, 22 Dec 2022 06:28:30 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id s24-20020a056870ea9800b0014c7958c55bsm321860oap.42.2022.12.22.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:28:30 -0800 (PST)
Date:   Thu, 22 Dec 2022 08:28:27 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com, steev@kali.org
Subject: Re: [PATCH v4 00/16] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221222142827.n44ha3uv3ktsqjqu@halaney-x13s>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 06:46:40PM +0530, Manivannan Sadhasivam wrote:
> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> This offset only works for some SoCs like SDM845 for which driver support
> was initially added.
>     
> But the later SoCs use different register stride that vary between the
> banks with holes in-between. So it is not possible to use a single register
> stride for accessing the CSRs of each bank. By doing so could result in a
> crash with the current drivers. So far this crash is not reported since
> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> driver extensively by triggering the EDAC IRQ (that's where each bank
> CSRs are accessed).
>     
> For fixing this issue, let's obtain the base address of each LLCC bank from
> devicetree and get rid of the fixed stride.
> 
> This series affects multiple platforms but I have only tested this on
> SM8250, SM8450, and SM6350. Testing on other platforms is welcomed.
> 
> Thanks,
> Mani

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride

With this series applied:
  1. The module loads automatically
  2. I get the edac driver setup in interrupt mode
  3. unloading/loading the module repeatedly works without issue

Thanks Mani!

> 
> Changes in v4:
> 
> * Added a patch that fixes the use-after-free bug in qcom_edac driver
> 
> Changes in v3:
> 
> * Brought back reg-names property for compatibility (Krzysztof)
> * Removed Fixes tag and stable list as backporting the drivers/binding/dts
>   patches alone would break (Krzysztof)
> * Fixed the uninitialized variable issue (Kbot)
> * Added a patch to make use of driver supplied polling interval (Luca)
> * Added a patch for module autoloading (Andrew)
> * Didn't collect Review tags from Sai as the dts patches were changed.
> 
> Changes in v2:
> 
> * Removed reg-names property and used index of reg property to parse LLCC
>   bank base address (Bjorn)
> * Collected Ack from Sai for binding
> * Added a new patch for polling mode (Luca)
> * Renamed subject of patches targeting SC7180 and SM6350
> 
> Manivannan Sadhasivam (16):
>   dt-bindings: arm: msm: Update the maintainers for LLCC
>   dt-bindings: arm: msm: Fix register regions used for LLCC banks
>   arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
>   EDAC/device: Make use of poll_msec value in edac_device_ctl_info
>     struct
>   EDAC/qcom: Add platform_device_id table for module autoloading
>   EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's
>     pvt_info
>   qcom: llcc/edac: Fix the base address used for accessing LLCC banks
>   qcom: llcc/edac: Support polling mode for ECC handling
> 
>  .../bindings/arm/msm/qcom,llcc.yaml           | 128 ++++++++++++++++--
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   5 +-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  10 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm6350.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 +-
>  drivers/edac/edac_device.c                    |   2 +-
>  drivers/edac/qcom_edac.c                      |  63 +++++----
>  drivers/soc/qcom/llcc-qcom.c                  |  85 ++++++------
>  include/linux/soc/qcom/llcc-qcom.h            |   6 +-
>  14 files changed, 243 insertions(+), 95 deletions(-)
> 
> -- 
> 2.25.1
> 

