Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54A6DB40D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjDGTSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDGTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:18:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477BBB9A;
        Fri,  7 Apr 2023 12:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7AF64D51;
        Fri,  7 Apr 2023 19:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316F4C433EF;
        Fri,  7 Apr 2023 19:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680895088;
        bh=v36g2BJAp9VAUH4Pa6BbAM86j6+La0PhFyT56lBz4qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiTiaY4nNrXh2Blyn4YPwEYHeW1ZRvk7gDlluFVq7g0F5of484SqgjKjTogpg7PYY
         U7nFq0OuSg4f3cJ0Slb0/ECgFq1IOCt5bj3lc6EI7yCutpMlbHLZu/5rb9fIhh/xZ7
         KZOlhNoAXKw1XOGLEyQH3W4olv3S9pdTRU6y72XxZ1aN/F6sbHsefCN1YokjDYYGfQ
         XewjP5Wog4DHU8Up85MynErWjvvYhzNr2z80wyNFovvWpxQpOwBUT0u2XQA0fkJdxY
         j6lBo/q9pJ5y0fcOXnyjYsEaYmAv1Yn0j+DFGJpnzRQcoDBjZqkIyfaEQ1O6F9jAXA
         xstivBMt6PjzQ==
Date:   Fri, 7 Apr 2023 12:20:57 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Add dedicated Qcom ICE driver
Message-ID: <20230407192057.pgccwiie3mriuklp@ripper>
References: <20230407105029.2274111-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407105029.2274111-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 01:50:23PM +0300, Abel Vesa wrote:
> As both SDCC and UFS drivers use the ICE with duplicated implementation,
> while none of the currently supported platforms make use concomitantly
> of the same ICE IP block instance, the new SM8550 allows both UFS and
> SDCC to do so. In order to support such scenario, there is a need for
> a unified implementation and a devicetree node to be shared between
> both types of storage devices. So lets drop the duplicate implementation
> of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.
> 
> For now, only SM8550 has been added to support the new approach. This
> also involves adding support for HW version 4.x.
> 

I picked the ICE driver and pushed it out to make it possible to pick up
the mmc and ufs patches independently.

  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git tags/20230407105029.2274111-4-abel.vesa@linaro.org

Regards,
Bjorn

> The v5 is here:
> https://lore.kernel.org/all/20230403200530.2103099-1-abel.vesa@linaro.org/
> 
> Changes since v5:
>  * See each individual patch for changelogs.
> 
> Changes since v4:
>  * dropped the SDHCI dt-bindings patch as it will be added along
>    with the first use of qcom,ice property from an SDHCI DT node
> 
> Abel Vesa (6):
>   dt-bindings: crypto: Add Qualcomm Inline Crypto Engine
>   dt-bindings: ufs: qcom: Add ICE phandle
>   soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
>   scsi: ufs: ufs-qcom: Switch to the new ICE API
>   mmc: sdhci-msm: Switch to the new ICE API
>   arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node
> 
>  .../crypto/qcom,inline-crypto-engine.yaml     |  42 ++
>  .../devicetree/bindings/ufs/qcom,ufs.yaml     |  26 ++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi          |   9 +
>  drivers/mmc/host/Kconfig                      |   2 +-
>  drivers/mmc/host/sdhci-msm.c                  | 223 +++--------
>  drivers/soc/qcom/Kconfig                      |   4 +
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/ice.c                        | 366 ++++++++++++++++++
>  drivers/ufs/host/Kconfig                      |   2 +-
>  drivers/ufs/host/Makefile                     |   4 +-
>  drivers/ufs/host/ufs-qcom-ice.c               | 244 ------------
>  drivers/ufs/host/ufs-qcom.c                   |  99 ++++-
>  drivers/ufs/host/ufs-qcom.h                   |  32 +-
>  include/soc/qcom/ice.h                        |  37 ++
>  14 files changed, 637 insertions(+), 454 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
>  create mode 100644 drivers/soc/qcom/ice.c
>  delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c
>  create mode 100644 include/soc/qcom/ice.h
> 
> -- 
> 2.34.1
> 
