Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4869A628306
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiKNOnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiKNOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:42:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10412C117;
        Mon, 14 Nov 2022 06:42:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E03A61211;
        Mon, 14 Nov 2022 14:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABE7C433D6;
        Mon, 14 Nov 2022 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668436946;
        bh=zsPHg2CbneKaAfSvj9WkPgYa0y7b09xQojV5FYHP5sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5Qy7Rlxxzy9JFuT/hsrGD7f4hcJbO+ae6+Z61L2DEEAQC8FLT8AzwxSGnRYkjM1L
         JXl7B816rveuzs3L556r6NgStq28YHhw9aR3ouMRpSOfV7M+4blTngit83vE/8cV8J
         lF4oqxRF2Zpj3r1LLNx0YVeJZdQ1J1mFbOYFMPhwfA07JK8qs7jNlfMQSUduK/CVii
         R0XwReJzXGRWDzqx9BGNEPMzg8F8LCpNxP83h/yoVp4tFpJyJp2xY2QKy3KOZYnWTO
         nu0Nb4qLpiFVTOtyQmLtwu55ms6fwZb5cc3ZIn4Gx58AYlv0PLaOHN/sAWctoQRWZ2
         lUA80vWx3Wrow==
Date:   Mon, 14 Nov 2022 14:42:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers: arm-smmu-impl: Add QDU1000 and QRU1000
 iommu implementation
Message-ID: <20221114144220.GA31043@willie-the-truck>
References: <20221026190534.4004945-1-quic_molvera@quicinc.com>
 <20221026190534.4004945-3-quic_molvera@quicinc.com>
 <0ae09be0-cb1b-dc27-943b-db64ca97b8c7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae09be0-cb1b-dc27-943b-db64ca97b8c7@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:28:15PM +0100, Krzysztof Kozlowski wrote:
> On 26/10/2022 21:05, Melody Olvera wrote:
> > Add compatible for Qualcomm QDU1000 and QRU1000 SoCs to add iommu
> > support for them.
> > 
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index b2708de25ea3..0580a381a04b 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -426,6 +426,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
> >  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
> >  	{ .compatible = "qcom,msm8998-smmu-v2" },
> >  	{ .compatible = "qcom,qcm2290-smmu-500" },
> > +	{ .compatible = "qcom,qdu1000-smmu-500" },
> 
> The patch was applied but it contradicts work here:
> https://lore.kernel.org/all/20221102184420.534094-12-dmitry.baryshkov@linaro.org/
> which explicitly asks not to add such compatibles...

Sure, but we've been adding new compatibles for years so I don't mind
picking up the last few now before we stop accepting new ones.

I already asked Dmitry to respin his series as there are some open comments
from others anyway.

Will
