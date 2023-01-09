Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4CE662F87
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjAISvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjAISvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:51:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B877A1B0;
        Mon,  9 Jan 2023 10:51:40 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309DthXp024652;
        Mon, 9 Jan 2023 18:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ndqB61nAt6ZcnmufjO7EHToLNrxx+EvxMZ0X9ORWO2Y=;
 b=OFOwtZZbAx4Mr6lVSGNioF/FNkgNaHzKd0yXwRzjYAZDEJx+XTFhJE4169In7OoevRbJ
 pkHzld7AkiyvwwoZ8TaGvtzgfUHUrlblFc0Z6r656vEcIM+41glDyrOQdvs29UeIlsBt
 /m4eNATImhwin/4X5hmqIyIyoaQis9JUNf1ywtzEGQa13fxZNskqV2a3mkziAKf5IR0y
 DgBZgKFFSjKIfP7L3cXH7+3iPNNtBJyh5AChGmSKw4Mk6mu7005cMx5tPo6pxK5uCRNZ
 Aol8NwlXDptlt3WKY42yPUKIb10T+o7msNRBlJMnKf8+fwQuHXGNfNF0W3+zIDJXU+Dz Jg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0u13tms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 18:51:22 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309IpKxj001695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 18:51:20 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 10:51:19 -0800
Message-ID: <f30261bc-7d4c-b074-4531-2b244afe0e59@quicinc.com>
Date:   Mon, 9 Jan 2023 10:51:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 11/28] gunyah: rsc_mgr: Add VM lifecycle RPC
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
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
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-12-quic_eberman@quicinc.com>
 <20230109071309.GA3480070@quicinc.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230109071309.GA3480070@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uD31rIDTTBS-TOarOMzEqnYpHZD-IZI-
X-Proofpoint-ORIG-GUID: uD31rIDTTBS-TOarOMzEqnYpHZD-IZI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=869
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2023 11:13 PM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:32]:
> 
>> +/* Call: CONSOLE_OPEN, CONSOLE_CLOSE, CONSOLE_FLUSH */
> 
> I think this struct is used by other calls as well?
> Also CONSOLE_** functions are not yet introduced in this patch
> 
>> +struct gh_vm_common_vmid_req {
>> +	__le16 vmid;
>> +	__le16 reserved0;
>> +} __packed;
> 
> [snip]
> 
>> +int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid)
>> +{
>> +	void *resp;
>> +	struct gh_vm_common_vmid_req req_payload = {
>> +		.vmid = cpu_to_le16(vmid),
>> +	};
>> +	struct gh_vm_common_vmid_req *resp_payload;
>> +	size_t resp_size;
>> +	int ret;
>> +
>> +	if (vmid == GH_VMID_INVAL)
>> +		vmid = 0;
>> +
>> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
>> +			&resp_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!vmid) {
>> +		if (resp_size != sizeof(*resp_payload)) {
>> +			ret = -EINVAL;
>> +		} else {
>> +			resp_payload = resp;
>> +			ret = resp_payload->vmid;
> 
> Do we need a le_to_cpu() wrapper on the response here?
> 
>> +int gh_rm_vm_stop(struct gh_rm_rpc *rm, u16 vmid)
>> +{
>> +	struct gh_vm_stop_req req_payload = {
>> +		.vmid = cpu_to_le16(vmid),
>> +	};
>> +	void *resp;
>> +	size_t resp_size;
>> +	int ret;
>> +
>> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload),
>> +			&resp, &resp_size);
>> +	if (ret)
>> +		return ret;
>> +	kfree(resp);
> 
> Why not use gh_rm_common_vmid_call() here as well?
> 
> 	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_STOP, vmid);
> 
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_vm_stop);
>> +
> 
> [snip]
> 
>> +ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
>> +				struct gh_rm_hyp_resource **resources)
>> +{
>> +	struct gh_vm_get_hyp_resources_resp *resp;
>> +	size_t resp_size;
>> +	int ret;
>> +	struct gh_vm_common_vmid_req req_payload = {
>> +		.vmid = cpu_to_le16(vmid),
>> +	};
>> +
>> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
>> +			 &req_payload, sizeof(req_payload),
>> +			 (void **)&resp, &resp_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (resp_size < sizeof(*resp) ||
>> +		(sizeof(*resp->entries) && (resp->n_entries > U32_MAX / sizeof(*resp->entries))) ||
>> +		(resp_size != sizeof(*resp) + (resp->n_entries * sizeof(*resp->entries)))) {
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>> +
>> +	*resources = kmemdup(resp->entries, (resp->n_entries * sizeof(*resp->entries)), GFP_KERNEL);
> 
> Consider NULL return value from kmemdup
> 
>> +	ret = resp->n_entries;
>> +
>> +out:
>> +	kfree(resp);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_get_hyp_resources);
>> +
>> +/**
>> + * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
>> + * @vmid: Filled with the VMID of this VM
>> + */
>> +int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid)
>> +{
>> +	static u16 cached_vmid = GH_VMID_INVAL;
>> +	void *resp;
>> +	size_t resp_size;
>> +	int ret;
>> +	int payload = 0;
>> +
>> +	if (cached_vmid != GH_VMID_INVAL) {
>> +		*vmid = cached_vmid;
>> +		return 0;
>> +	}
>> +
>> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_VMID, &payload, sizeof(payload), &resp, &resp_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (resp_size != sizeof(*vmid))
> 
> kfree(resp) in this case?
> 
>> +		return -EIO;
>> +	*vmid = *(u16 *)resp;
> 
> Do we need a le_to_cpu() wrapper on the response?
> Also update cached_vmid in success case.
> 
>> +	kfree(resp);
>> +
>> +	return ret;
>> +}

Applied all these.

Thanks,
Elliot
