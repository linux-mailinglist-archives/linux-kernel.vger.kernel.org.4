Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A566E72D777
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbjFMCuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbjFMCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7BC1726;
        Mon, 12 Jun 2023 19:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2311C62F76;
        Tue, 13 Jun 2023 02:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5EAC4339B;
        Tue, 13 Jun 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686624627;
        bh=7W9U+eKYl0KSlX2mWiw+hamipckUREqq7kenoM24PBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USvaVPPMj4eUpgKrLBEkNAhkOXLxlspXcqZaOvAcwlgQ933qCwlDYnkFQ2pTDXktO
         1nABQ65OaVzLQrsi3iLwGX2BShh62BS/OcBa1JJSs3Cj287HbGiE/3HeZ80C7wu9nK
         3xbd5RaChtKf2XVBY2frx6BDcBx7XD20cBLUdFptJBaNcBQKzJ2cORiEjnOqjmtRpk
         M9EVHi78n9Y0AFjlEuTpK+LqfOmf3eN82hPk6ITGImCTTa3l+mnWYNH+0tziqykjEY
         sNXcfFHutsGkx1DNhfotKHyRytzUp14mV56u7oSuQBvagncHINrfCxKKLpHuZ2AF3y
         oo0S9YLHgGyTA==
Date:   Mon, 12 Jun 2023 19:50:25 -0700
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RESEND v7 2/3] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <20230613025025.GB883@sol.localdomain>
References: <20230612192847.1599416-1-abel.vesa@linaro.org>
 <20230612192847.1599416-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612192847.1599416-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:28:46PM +0300, Abel Vesa wrote:
> Now that there is a new dedicated ICE driver, drop the ufs-qcom-ice and
> use the new ICE api provided by the Qualcomm soc driver ice. The platforms
> that already have ICE support will use the API as library since there will
> not be a devicetree node, but instead they have reg range. In this case,
> the of_qcom_ice_get will return an ICE instance created for the consumer's
> device. But if there are platforms that do not have ice reg in the
> consumer devicetree node and instead provide a dedicated ICE devicetree
> node, the of_qcom_ice_get will look up the device based on qcom,ice
> property and will get the ICE instance registered by the probe function
> of the ice driver.
> 
> The ICE clock is now handle by the new driver. This is done by enabling
> it on the creation of the ICE instance and then enabling/disabling it on
> UFS runtime resume/suspend.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/ufs/host/Kconfig        |   2 +-
>  drivers/ufs/host/Makefile       |   4 +-
>  drivers/ufs/host/ufs-qcom-ice.c | 244 --------------------------------
>  drivers/ufs/host/ufs-qcom.c     |  99 ++++++++++++-
>  drivers/ufs/host/ufs-qcom.h     |  32 +----
>  5 files changed, 104 insertions(+), 277 deletions(-)
>  delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c

My concern about this patch removing the ICE clock from UFS clock gating
(https://lore.kernel.org/linux-scsi/ZDBSvVIIq6cMTf1Y@gmail.com) was not
addressed.  But I guess this is good enough.  Maybe someone can do a fixup patch
on top of this if they really care about the UFS clock gating.  You can add:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
