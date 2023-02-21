Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97169E106
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjBUNGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjBUNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:06:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A361826CFF;
        Tue, 21 Feb 2023 05:06:41 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCbFbR015942;
        Tue, 21 Feb 2023 13:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=g1P63C+a580kYDfcdmzQvxGNzrNC04RSAQ2tEvn68zk=;
 b=Q7OK7LMoLOgTp1KJe7muKbm086Q1tbKWe4m549VWQv0gAbd6DixXjBHMQ7tiAj8UVYps
 zeRmvt4KDc2tOVJ3uytQCqOPOgGo927I0WYOnOBc0xNEq0rKpuQ4YQUG+OUx8s14yVwp
 Xe43JnGI5zwVijib2wC2sHaCKx/zw5viCWZel2JUT6aRsQMTmZ09sZgjtwggt/PHRIgX
 h/HphD0KpPfCzvNfqzeFZEGFmh9EN7vfmqzx0amEwgJFfYFbCOyqMaXOk0OzXdoZP2KA
 ZXqfNo5H3s7EUbrWjB2M2DnYWAHtMTEdHXBSFfmzHrBTMsk9OJwq5T1XsAdkSw0ZIl3q tA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvnbt97xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:06:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LD6SeT019399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:06:28 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 05:06:21 -0800
Date:   Tue, 21 Feb 2023 18:36:18 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
Message-ID: <20230221130618.GB787573@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212427.3316544-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230214212427.3316544-1-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8D9JSBLljUsyWQQyWmRSmhsM8u3vA7SX
X-Proofpoint-ORIG-GUID: 8D9JSBLljUsyWQQyWmRSmhsM8u3vA7SX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_07,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=774 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210111
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-02-14 13:24:26]:

> +static int gh_vm_start(struct gh_vm *ghvm)
> +{
> +	struct gh_vm_mem *mapping;
> +	u64 dtb_offset;
> +	u32 mem_handle;
> +	int ret;
> +
> +	down_write(&ghvm->status_lock);
> +	if (ghvm->vm_status != GH_RM_VM_STATUS_LOAD) {
> +		up_write(&ghvm->status_lock);
> +		return 0;
> +	}
> +
> +	ghvm->vm_status = GH_RM_VM_STATUS_RESET;
> +
> +	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
> +		switch (mapping->share_type) {
> +		case VM_MEM_LEND:
> +			ret = gh_rm_mem_lend(ghvm->rm, &mapping->parcel);
> +			break;
> +		case VM_MEM_SHARE:
> +			ret = gh_rm_mem_share(ghvm->rm, &mapping->parcel);
> +			break;
> +		}
> +		if (ret) {
> +			pr_warn("Failed to %s parcel %d: %d\n",
> +				mapping->share_type == VM_MEM_LEND ? "lend" : "share",
> +				mapping->parcel.label,
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	mapping = gh_vm_mem_find_mapping(ghvm, ghvm->dtb_config.gpa, ghvm->dtb_config.size);

It may be some optimization to derive DTB 'mapping' in the first loop you have
above (that lends/shares all mappings)


> +	if (!mapping) {
> +		pr_warn("Failed to find the memory_handle for DTB\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
