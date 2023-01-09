Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A628B661F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjAIHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjAIHNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:13:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606C655A;
        Sun,  8 Jan 2023 23:13:37 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30952lm0009418;
        Mon, 9 Jan 2023 07:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=+T3VIEWVegWplUGukrhykwFnwriNfkJ62nVMapRgGrM=;
 b=jXrP28WMz4c3qndcA3P40qMMezIc41FWg6h6xqFLqCWV0gmNiDnnJPSsygm5xGQUeCuh
 g3HN4+EdBR0YF80wvBghWtE4vbAll3XQ3Uwl/Bcl9kmyP1GJlXGON2MlkQDJ2HDQJJXh
 gIxUbE4sUlBUNnPxRvcle+Kbkknfh3TFXF3qtVS7VSm+xitmxf4VCJyh6K0wxNvJTjUa
 2pDyAAV3Y4MVBVt4zWC6nrNoD+Oh1WCTb76x0QGoC87NbRoB2kYEiyBLzGiUezn8UJ8A
 gJ3Cr0ZxJIZ240O8FOQi32kIqBoXiH/dkUJseHxbJc+enveQaczSyDwzxi0EBDy/p6aJ Vg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my21ftf7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 07:13:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3097DK0e011786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 07:13:20 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 8 Jan 2023
 23:13:13 -0800
Date:   Mon, 9 Jan 2023 12:43:09 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 11/28] gunyah: rsc_mgr: Add VM lifecycle RPC
Message-ID: <20230109071309.GA3480070@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-12-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20221219225850.2397345-12-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KmxXwIzcVN610P58UOSed39adOioGZLg
X-Proofpoint-GUID: KmxXwIzcVN610P58UOSed39adOioGZLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_02,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=676 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090051
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:32]:

> +/* Call: CONSOLE_OPEN, CONSOLE_CLOSE, CONSOLE_FLUSH */

I think this struct is used by other calls as well?
Also CONSOLE_** functions are not yet introduced in this patch

> +struct gh_vm_common_vmid_req {
> +	__le16 vmid;
> +	__le16 reserved0;
> +} __packed;

[snip]

> +int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid)
> +{
> +	void *resp;
> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	struct gh_vm_common_vmid_req *resp_payload;
> +	size_t resp_size;
> +	int ret;
> +
> +	if (vmid == GH_VMID_INVAL)
> +		vmid = 0;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
> +			&resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (!vmid) {
> +		if (resp_size != sizeof(*resp_payload)) {
> +			ret = -EINVAL;
> +		} else {
> +			resp_payload = resp;
> +			ret = resp_payload->vmid;

Do we need a le_to_cpu() wrapper on the response here?

> +int gh_rm_vm_stop(struct gh_rm_rpc *rm, u16 vmid)
> +{
> +	struct gh_vm_stop_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload),
> +			&resp, &resp_size);
> +	if (ret)
> +		return ret;
> +	kfree(resp);

Why not use gh_rm_common_vmid_call() here as well?

	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_STOP, vmid);

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_vm_stop);
> +

[snip]

> +ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
> +				struct gh_rm_hyp_resource **resources)
> +{
> +	struct gh_vm_get_hyp_resources_resp *resp;
> +	size_t resp_size;
> +	int ret;
> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
> +			 &req_payload, sizeof(req_payload),
> +			 (void **)&resp, &resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (resp_size < sizeof(*resp) ||
> +		(sizeof(*resp->entries) && (resp->n_entries > U32_MAX / sizeof(*resp->entries))) ||
> +		(resp_size != sizeof(*resp) + (resp->n_entries * sizeof(*resp->entries)))) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	*resources = kmemdup(resp->entries, (resp->n_entries * sizeof(*resp->entries)), GFP_KERNEL);

Consider NULL return value from kmemdup

> +	ret = resp->n_entries;
> +
> +out:
> +	kfree(resp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get_hyp_resources);
> +
> +/**
> + * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
> + * @vmid: Filled with the VMID of this VM
> + */
> +int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid)
> +{
> +	static u16 cached_vmid = GH_VMID_INVAL;
> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +	int payload = 0;
> +
> +	if (cached_vmid != GH_VMID_INVAL) {
> +		*vmid = cached_vmid;
> +		return 0;
> +	}
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_VMID, &payload, sizeof(payload), &resp, &resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (resp_size != sizeof(*vmid))

kfree(resp) in this case?

> +		return -EIO;
> +	*vmid = *(u16 *)resp;

Do we need a le_to_cpu() wrapper on the response?
Also update cached_vmid in success case.

> +	kfree(resp);
> +
> +	return ret;
> +}
