Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF0716FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjE3Vbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjE3Vbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:31:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4263C7;
        Tue, 30 May 2023 14:31:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ULM2dL022120;
        Tue, 30 May 2023 21:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=7NRpPg4lmFN/kBzznPAjKO91BJzU63zyR8+mdkzWhfI=;
 b=kKcUGgxiB7a7915/O6Ma91PH1MIH15uI2Y1VnSEhgJHbo4yAMuCm/09hxZ39YZ9psCXt
 LaloZBrmXXvangRfVQO4/VotFfPXcC1STIVMHfXvepsBbeOHOJRnUKUY8yxE+URKZLF6
 Sus6b1FuBbvKdeu0q0l+gvckzIB7J48aUmZ0lGs+vlMaXuqWzKKFexgf3u+bIvij2bSU
 jQwjttQ4takU76i0sqsAu8N6g71XJLsFYVClEc9oqo3r+eiKpHnft4zafUmZSzBFLOQ0
 uYlPjGOZZ7DhBHQhA6UZJR7zHsQvlEzIjodzwdv7sqb21G4il4gxfVVXHpuz9STZRIXw Kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwryer0j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 21:31:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ULVdMA007635
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 21:31:39 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 14:31:39 -0700
Date:   Tue, 30 May 2023 14:31:37 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soc: qcom: rmtfs: Support dynamic placement of region
Message-ID: <20230530213137.GA3645274@hu-bjorande-lv.qualcomm.com>
References: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
 <20230530193436.3833889-3-quic_bjorande@quicinc.com>
 <0e9903c0-4669-9298-e0ee-72fc775998c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e9903c0-4669-9298-e0ee-72fc775998c3@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rkcRdzAobJpBDzC1W823f2ayeOEdiF28
X-Proofpoint-ORIG-GUID: rkcRdzAobJpBDzC1W823f2ayeOEdiF28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:45:10PM +0200, Konrad Dybcio wrote:
> 
> 
> On 30.05.2023 21:34, Bjorn Andersson wrote:
> > In some configurations, the exact placement of the rmtfs shared memory
> > region isn't so strict. In the current implementation the author of the
> > DeviceTree source is forced to make up a memory region.
> IIUC the test here would be... "works" / "doesn't", just as if one
> misplaced the fixed region?
> 

The patch makes no effort to clarify this part.

> Does the downstream sharedmem-uio driver do any additional cryptic
> magic or does it simply rely on the vendor's cma/dma pool settings?
> Can we replicate its behavior to stop hardcoding rmtfs, period?
> 

Alignment on that is the intention with this patchset.

> > 
> > Extend the rmtfs memory driver to relieve the author of this
> > responsibility by introducing support for using dynamic allocation in
> > the driver.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 10 ++++
> >  drivers/soc/qcom/rmtfs_mem.c            | 66 +++++++++++++++++++------
> >  2 files changed, 61 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > index d1440b790fa6..e6191b8ba4c6 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > @@ -12,6 +12,8 @@
> >  #include "pm8998.dtsi"
> >  #include "pmi8998.dtsi"
> >  
> > +/delete-node/ &rmtfs_mem;
> > +
> >  / {
> >  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
> >  	compatible = "qcom,sdm845-mtp", "qcom,sdm845";
> > @@ -48,6 +50,14 @@ vreg_s4a_1p8: pm8998-smps4 {
> >  		vin-supply = <&vph_pwr>;
> >  	};
> >  
> > +	rmtfs {
> > +		compatible = "qcom,rmtfs-mem";
> > +
> > +		qcom,alloc-size = <(2*1024*1024)>;
> > +		qcom,client-id = <1>;
> > +		qcom,vmid = <15>;
> > +	};
> This should have been a separate patch.
> 

Of course, I should have paid more attention when I did the last git
add, to not include test code...

> > +
> >  	thermal-zones {
> >  		xo_thermal: xo-thermal {
> >  			polling-delay-passive = <0>;
> > diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> > index f83811f51175..5f56ded9f905 100644
> > --- a/drivers/soc/qcom/rmtfs_mem.c
> > +++ b/drivers/soc/qcom/rmtfs_mem.c
> > @@ -3,6 +3,8 @@
> >   * Copyright (c) 2017 Linaro Ltd.
> >   */
> >  
> > +#include "linux/gfp_types.h"
> > +#include "linux/sizes.h"
> <>?
> 
> >  #include <linux/kernel.h>
> >  #include <linux/cdev.h>
> >  #include <linux/err.h>
> > @@ -168,23 +170,63 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
> >  	kfree(rmtfs_mem);
> >  }
> >  
> > +static int qcom_rmtfs_acquire_mem(struct device *dev, struct qcom_rmtfs_mem *rmtfs_mem)
> > +{
> > +	struct device_node *node = dev->of_node;
> > +	struct reserved_mem *rmem;
> > +	dma_addr_t dma_addr;
> > +	void *mem;
> > +	u32 size;
> > +	int ret;
> > +
> > +	rmem = of_reserved_mem_lookup(node);
> > +	if (rmem) {
> > +		rmtfs_mem->addr = rmem->base;
> > +		rmtfs_mem->size = rmem->size;
> > +
> > +		rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
> > +						rmtfs_mem->size, MEMREMAP_WC);
> > +		if (IS_ERR(rmtfs_mem->base)) {
> > +			dev_err(dev, "failed to remap rmtfs_mem region\n");
> > +			return PTR_ERR(rmtfs_mem->base);
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	ret = of_property_read_u32(node, "qcom,alloc-size", &size);
> > +	if (ret < 0) {
> > +		dev_err(dev, "rmtfs of unknown size\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * Ensure that the protected region isn't adjacent to other protected
> > +	 * regions by allocating an empty page on either side.
> > +	 */
> > +	mem = dma_alloc_coherent(dev, size + 2 * SZ_4K, &dma_addr, GFP_KERNEL);
> Should this be made pagesize-independent? Can we even run non-4K kernels on msm?
> 

Yes, I fixed the issue in UFS and I believe Alex corrected the bug in
IPA. With that I've been able to boot the few platforms where I've tried
it with 16KB PAGE_SIZE.

That's however the Linux page size, the numbers here relates to things
on the secure side.

Regards,
Bjorn

> Konrad
> > +	if (mem) {
> > +		rmtfs_mem->base = mem + SZ_4K;
> > +		rmtfs_mem->addr = dma_addr + SZ_4K;
> > +		rmtfs_mem->size = size;
> > +
> > +		return 0;
> > +	}
> > +
> > +	dev_err(dev, "unable to allocate memory for rmtfs mem\n");
> > +	return -ENOMEM;
> > +}
> > +
> >  static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *node = pdev->dev.of_node;
> >  	struct qcom_scm_vmperm perms[NUM_MAX_VMIDS + 1];
> > -	struct reserved_mem *rmem;
> >  	struct qcom_rmtfs_mem *rmtfs_mem;
> >  	u32 client_id;
> >  	u32 vmid[NUM_MAX_VMIDS];
> >  	int num_vmids;
> >  	int ret, i;
> >  
> > -	rmem = of_reserved_mem_lookup(node);
> > -	if (!rmem) {
> > -		dev_err(&pdev->dev, "failed to acquire memory region\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	ret = of_property_read_u32(node, "qcom,client-id", &client_id);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "failed to parse \"qcom,client-id\"\n");
> > @@ -196,22 +238,16 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> >  	if (!rmtfs_mem)
> >  		return -ENOMEM;
> >  
> > -	rmtfs_mem->addr = rmem->base;
> >  	rmtfs_mem->client_id = client_id;
> > -	rmtfs_mem->size = rmem->size;
> >  
> >  	device_initialize(&rmtfs_mem->dev);
> >  	rmtfs_mem->dev.parent = &pdev->dev;
> >  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
> >  	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
> >  
> > -	rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
> > -					rmtfs_mem->size, MEMREMAP_WC);
> > -	if (IS_ERR(rmtfs_mem->base)) {
> > -		dev_err(&pdev->dev, "failed to remap rmtfs_mem region\n");
> > -		ret = PTR_ERR(rmtfs_mem->base);
> > +	ret = qcom_rmtfs_acquire_mem(&pdev->dev, rmtfs_mem);
> > +	if (ret < 0)
> >  		goto put_device;
> > -	}
> >  
> >  	cdev_init(&rmtfs_mem->cdev, &qcom_rmtfs_mem_fops);
> >  	rmtfs_mem->cdev.owner = THIS_MODULE;
