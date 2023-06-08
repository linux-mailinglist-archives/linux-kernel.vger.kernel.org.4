Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF34728448
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjFHPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjFHPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:54:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D009030D8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:53:42 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38eb2984c82so443933b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686239617; x=1688831617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i3MkbyEQhd9XzAzL+T/IkEeTSb88Nr2kPqCfa3UMTGA=;
        b=irMhvMTvNMqSNRq8QdWr4K3wwDf4Ivwnp4zM+LRHgAvpHsEH/2aaT3wAyLhHctpLcQ
         Nbzfo5LTIoHTEj0DA/ozKoDsVo7EaddHDS25/FOsqgs2U90RqWigZn8p8CdXfaOvrXPc
         kAf7iP7L3eLEhCxdOFTvA09dXgAcKRmj/8Cb4DhUSlnfVt5hMc9Gua7f3FoiMaZl/IyV
         2zJpzMYc/0Yk2V/uo6+VZ6qK1rCf+CRDP0Ufy5yJz1X5yPmVyHykTaO+XD6eDM+vvwZt
         ShT5mjjMZyOATsZwmhrzjzFD3PAFUwT+7Ieq30Y5QQluSOzT39FsDoBjd5Dbe2xLVYev
         tVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239617; x=1688831617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3MkbyEQhd9XzAzL+T/IkEeTSb88Nr2kPqCfa3UMTGA=;
        b=BMGRhfaTuwNga/kpP78uy92qnvO6yZsnqHX572OOPyR+EOnZbldJu634CMZlquIwSC
         KOpn1FR9VR06HizUr/botMJ+JYLqoJXdrSuC0oxvxokF2ykGW+XoQakSeMQaMIPv9oEH
         GE58pi8U7RamYZPZLFyUc/VZPw4aGwAJPQpPbNf4V6XW0iFPnk2qak4oqgfh4nTD/dr1
         VTRkbetG33VP/oT+lsWWmCCDJqEtghIAMt5/kmPovT7aMIrOMjje9VFC3O88JQD/mDet
         GDwRvflGyxWg6KUi4R4lYFVe2tEyqYLgsCvM2xM0UMu6NEaDs6uj9x3Gyqr53tOEDSmY
         Bxeg==
X-Gm-Message-State: AC+VfDwtTrUPHBqRkq1Z10WdOF8daiaIvYXj5e2mhh+vWkt6wZmkmvbV
        +jr4QtkF+jHFHK7yIH20SqOA7+ph7XNz5mDN/faIMA==
X-Google-Smtp-Source: ACHHUZ67b0A6vEqzzfatB0AWylvHrVFokSygfhaIN9VTYUNCYumwZInyoKyuq2SHD85W7890zFDW3fB3H9QgwVyDaUA=
X-Received: by 2002:a54:4502:0:b0:398:84:de1c with SMTP id l2-20020a544502000000b003980084de1cmr4934080oil.2.1686239617005;
 Thu, 08 Jun 2023 08:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
In-Reply-To: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 17:53:01 +0200
Message-ID: <CAPDyKFqGdC9y9UAknREfT_TCsJH6pPG7UqL1EXET2_=j9PSCbQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 11:39, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> While SDHCI claims to support 64-bit DMA on MSM8916 it does not seem to
> be properly functional. It is not immediately obvious because SDHCI is
> usually used with IOMMU bypassed on this SoC, and all physical memory
> has 32-bit addresses. But when trying to enable the IOMMU it quickly
> fails with an error such as the following:
>
>   arm-smmu 1e00000.iommu: Unhandled context fault:
>     fsr=0x402, iova=0xfffff200, fsynr=0xe0000, cbfrsynra=0x140, cb=3
>   mmc1: ADMA error: 0x02000000
>   mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>   mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002e02
>   mmc1: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000000
>   mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
>   mmc1: sdhci: Present:   0x03f80206 | Host ctl: 0x00000019
>   mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>   mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>   mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000001
>   mmc1: sdhci: Int enab:  0x03ff900b | Sig enab: 0x03ff100b
>   mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>   mmc1: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x00008007
>   mmc1: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
>   mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x5b590000
>   mmc1: sdhci: Resp[2]:   0xe6487f80 | Resp[3]:  0x0a404094
>   mmc1: sdhci: Host ctl2: 0x00000008
>   mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000ffffff224
>   mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP -----------
>   mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:  0x60006400 | DLL cfg2: 0x00000000
>   mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:  0x00000000 | DDR cfg: 0x00000000
>   mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88018a8 Vndr func3: 0x00000000
>   mmc1: sdhci: ============================================
>   mmc1: sdhci: fffffffff200: DMA 0x0000ffffffffe100, LEN 0x0008, Attr=0x21
>   mmc1: sdhci: fffffffff20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x03
>
> Looking closely it's obvious that only the 32-bit part of the address
> (0xfffff200) arrives at the SMMU, the higher 16-bit (0xffff...) get
> lost somewhere. This might not be a limitation of the SDHCI itself but
> perhaps the bus/interconnect it is connected to, or even the connection
> to the SMMU.
>
> Work around this by setting SDHCI_QUIRK2_BROKEN_64_BIT_DMA to avoid
> using 64-bit addresses.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ac81d57a3df..1877d583fe8c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2479,6 +2479,9 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>                 msm_host->ddr_config = DDR_CONFIG_POR_VAL;
>
>         of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
> +
> +       if (of_device_is_compatible(node, "qcom,msm8916-sdhci"))
> +               host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
>  }
>
>  static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>
> ---
> base-commit: d4ebc9419afbac330e9ec0d2936108742aa4d97a
> change-id: 20230518-msm8916-64bit-f5bcf6af7679
>
> Best regards,
> --
> Stephan Gerhold <stephan@gerhold.net>
>
