Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE26DA275
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjDFUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjDFUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF756592;
        Thu,  6 Apr 2023 13:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD7CC64C01;
        Thu,  6 Apr 2023 20:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C57C433EF;
        Thu,  6 Apr 2023 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680812197;
        bh=Ro81oFs2ERAZEjBoyQDuaMoEroanaW6iQPKQU7mVPEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRkFDdcqoGk64bp4sT+M9/sjnM3oJqqqFa2dofyP1WAn1JhXccOhbdpxbyTmu8TMS
         JWnOy2uQeOiJODNWHP7bJUSzb4d5M7BCWqCs3JwxfAeXj7OxEyBgXU0nbYifzB7Se4
         5XGHJ5HCAU04iATsAYymN3/hh0YExMF56CzNN0aTMLVlA2xTSHz6p0xjjHSsGduug8
         zVCShD2Cv7sBYRv2vbj9r+g1Caq3c/JbwfdMEKnmRwq0QPPM1+4Ecc/xuVIp0YCPGj
         /8z0S7YvyK3861/A3gyEaFP6Nr5J7g+cY6gyRo9dZXllu9MSv+FassMFU7aSFthh3E
         fMXJZCq8wDVPQ==
Date:   Thu, 6 Apr 2023 13:16:34 -0700
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
Subject: Re: [PATCH v5 4/6] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <20230406201634.GA20288@sol.localdomain>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
 <20230403200530.2103099-5-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403200530.2103099-5-abel.vesa@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Mon, Apr 03, 2023 at 11:05:28PM +0300, Abel Vesa wrote:
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
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

This is still silent about how the ICE clock behavior is being changed.

I'm still trying to understand all this myself, so please bear with me, but my
understanding is that the UFS clocks can be disabled even while the host
controller is runtime-resumed.  This is called "clock gating" in the code.

Before, the ICE clock was just listed as one of the UFS clocks.  So, it was just
managed like the other UFS clocks.

Now, it appears that the ICE clock is always enabled while the host controller
is runtime-resumed.  So, this patch removes support for gating of the ICE clock.

Is that intended?

- Eric
