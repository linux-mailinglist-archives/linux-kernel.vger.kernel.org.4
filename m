Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C356B1299
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCHUD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCHUDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:03:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8539BA0;
        Wed,  8 Mar 2023 12:03:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2E1EB81DDC;
        Wed,  8 Mar 2023 20:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F021CC433D2;
        Wed,  8 Mar 2023 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678305799;
        bh=ZOJZzFkzo22oFPUVhPTC+vDa6ZOA9KNgV7uiJ7HpC+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+aSkGY3nJuQjQopgH7Ed766WYaltgfSsv4yJjk2nCxNYi5Z/7UkaNIQD2Nsu0giX
         bSCTOoPRZM5pVEUQwXUnVh3ZUhXcgWdOQvcYCOPqAR89sFphwrAZatYetZIQ246RPG
         5ePbA3JZ4NNeMxbWsAiNRbwarkT7GgUK9hzhNR2FhcV01YOVLYUxA460pDLF5zuOqL
         jPkTU9DiVCGRzI4zpnUwjEFyFVMKOk/J6kpj6LLD3KacB1Hamhx9g/kc9oFVw4maCe
         PKdEIsHO1lU7exECj8VD52Nhi2EhtlIgo0AcNP5njF+DkTBlPDmFtnWJfvbkeBufIr
         nKdiZ7HbKhLEw==
Date:   Wed, 8 Mar 2023 12:03:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] Add dedicated Qcom ICE driver
Message-ID: <ZAjqBemusfSKEWgF@sol.localdomain>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308155838.1094920-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Wed, Mar 08, 2023 at 05:58:31PM +0200, Abel Vesa wrote:
> As both SDCC and UFS drivers use the ICE with duplicated implementation,
> while none of the currently supported platforms make use concomitantly
> of the same ICE IP block instance, the new SM8550 allows both UFS and
> SDCC to do so. In order to support such scenario, there is a need for
> a unified implementation and a devicetree node to be shared between
> both types of storage devices. So lets drop the duplicate implementation
> of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.
> Also, switch all UFS and SDCC devicetree nodes to use the new ICE
> approach.
> 
> See each individual patch for changelogs.
> 
> The v1 is here:
> https://lore.kernel.org/all/20230214120253.1098426-1-abel.vesa@linaro.org/
> 
> Abel Vesa (7):
>   dt-bindings: soc: qcom: Add schema for Inline Crypto Engine
>   dt-bindings: ufs: qcom: Add ICE phandle and drop core clock
>   dt-bindings: mmc: sdhci-msm: Add ICE phandle and drop core clock
>   soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
>   scsi: ufs: ufs-qcom: Switch to the new ICE API
>   mmc: sdhci-msm: Switch to the new ICE API
>   arm64: dts: qcom: Add the Inline Crypto Engine nodes

Does this address all the comments on v1?  I had also asked some questions on
v1.  It would be helpful if you would respond.

- Eric
