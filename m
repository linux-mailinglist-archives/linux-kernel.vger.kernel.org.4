Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20D568B8FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBFJux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjBFJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:50:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC201EFC6;
        Mon,  6 Feb 2023 01:50:40 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3166EZe1020951;
        Mon, 6 Feb 2023 09:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=GaXGShalBdR+4E7bscfprSnkG+lkWmy3o6V2yYDA6PY=;
 b=Zrk6nqBDqN5oq2nTszs4+V0FJSulZ+KVuX6pz+WHaCAu2hS+WiCgRKtRe1FfJ/afN2ef
 7iNmjva7YYUPy7Yp75h+uk4wLm8j3olStVZ4ydKepJtaMaOE6FDfEUsLSf+ZDnvykQKg
 L2LeNIfritgZNnPXFGegvRIh7BK55I04r89JbfSv7fgn0G6GgExSpjj0hJsAfH0wCjFl
 Kp0hUjkeNRTd8HUbAQh0AhGW6NGM7C0uo0KcDplvHB8+NZeQBsz2nHYrsXdbW0f+SGWW
 IKkuQBzQ1wNu3uYnTssPjp4f+OLVPvuvOthV8BmOQkZC5wG/4EbOegzW/P6yH1bDNNHd KQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhff2kc39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 09:50:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3169oL47010875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 09:50:21 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 01:50:14 -0800
Date:   Mon, 6 Feb 2023 15:20:10 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 22/27] virt: gunyah: Add resource tickets
Message-ID: <20230206095010.GF332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-23-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-23-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C0UKRVdLXcQCDHmW3cy3GisLir22OZNU
X-Proofpoint-GUID: C0UKRVdLXcQCDHmW3cy3GisLir22OZNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_05,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:21]:

> +int ghvm_add_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket)
> +{
> +	struct gunyah_vm_resource_ticket *iter;
> +	struct gunyah_resource *ghrsc;
> +	int ret = 0;
> +
> +	mutex_lock(&ghvm->resources_lock);
> +	list_for_each_entry(iter, &ghvm->resource_tickets, list) {
> +		if (iter->resource_type == ticket->resource_type && iter->label == ticket->label) {
> +			ret = -EEXIST;
> +			goto out;
> +		}
> +	}
> +
> +	if (!try_module_get(ticket->owner)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	list_add(&ticket->list, &ghvm->resource_tickets);
> +	INIT_LIST_HEAD(&ticket->resources);
> +
> +	list_for_each_entry(ghrsc, &ghvm->resources, list) {
> +		if (ghrsc->type == ticket->resource_type && ghrsc->rm_label == ticket->label) {
> +			if (!ticket->populate(ticket, ghrsc))
> +				list_move(&ghrsc->list, &ticket->resources);

Do we need the search to continue in case of a hit? 'gh_vm_add_resource' seems to
break loop on first occurrence. 

Also do we have examples of more than one 'gunyah_resource' being associated
with same 'gunyah_vm_resource_ticket'?  Both vcpu and irqfd tickets seem to deal
with just one resource?

>  static int gh_vm_start(struct gunyah_vm *ghvm)
>  {
>  	struct gunyah_vm_memory_mapping *mapping;
>  	u64 dtb_offset;
>  	u32 mem_handle;
> -	int ret;
> +	struct gunyah_resource *ghrsc;
> +	struct gh_rm_hyp_resources *resources;
> +	int ret, i;
>  
>  	down_write(&ghvm->status_lock);
>  	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
> @@ -241,6 +314,22 @@ static int gh_vm_start(struct gunyah_vm *ghvm)
>  		goto err;
>  	}
>  
> +	ret = gh_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
> +	if (ret) {
> +		pr_warn("Failed to get hypervisor resources for VM: %d\n", ret);
> +		goto err;
> +	}
> +
> +	for (i = 0; i < le32_to_cpu(resources->n_entries); i++) {

minor nit: not sure if we can rely on compiler to optimize this, but it would
be better if we run le32_to_cpu once and use the result in loop. 

> +		ghrsc = gh_rm_alloc_resource(ghvm->rm, &resources->entries[i]);
> +		if (!ghrsc) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		gh_vm_add_resource(ghvm, ghrsc);

Shouldn't we have gh_vm_add_resource()->  ticket->populate() return a result and
in case of failure we should bail out from this loop?

> +	}
> +
>  	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
>  	if (ret) {
>  		pr_warn("Failed to start VM: %d\n", ret);
