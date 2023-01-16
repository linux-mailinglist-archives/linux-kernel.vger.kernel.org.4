Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60B66B945
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjAPIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjAPIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:46:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721F1286C;
        Mon, 16 Jan 2023 00:46:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G6ukmT032407;
        Mon, 16 Jan 2023 08:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=9upRWgPsUI4MWJz8NNhINZoq9YCOZLLadpunlbq+F+I=;
 b=UnN5PMZIYloM18yNkt42oJvysp3WI+HRVAA+lSiq4mk+L8/tCBO6Ho8UMeCuIpiYUx8m
 iW/rmtED8PqAbB2/HLBCDpF3QBlCO9qzx0BlT581Hw+EB3RmFBaDok50qYP2uMSunDD8
 +I/sxax71S9iPJNvBJduo2SQfj1e/vQdwRxeBqx2C4UXmD02oiLPBIbwAv7fCdy2gsEY
 0buEhutE2o5j3zNHww0xeeGSoyQLtdQLIffma6hPlyWMYpLJc3lyjX+RERKKIwJnQ9QJ
 02+EFkpN2opWjW0Gpd7owyODK8gtGMmqf1a8UsvQ93TE36J//gcybSDoirbDSNlWTzY6 lw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3mm9tx1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:46:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30G8k74G028844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:46:07 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 16 Jan
 2023 00:46:00 -0800
Date:   Mon, 16 Jan 2023 14:15:57 +0530
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
Subject: Re: [PATCH v8 13/28] gunyah: rsc_mgr: Add RPC for sharing memory
Message-ID: <20230116084557.GB1737564@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-14-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20221219225850.2397345-14-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _ofK556yL_a9qSF87Ooq6UE7hMu7sYIb
X-Proofpoint-ORIG-GUID: _ofK556yL_a9qSF87Ooq6UE7hMu7sYIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_06,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=839 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160064
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:34]:

> +static int _gh_rm_mem_append(struct gh_rm_rpc *rm, u32 mem_handle, bool end_append,
> +			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
> +{
> +	size_t msg_size = 0;
> +	void *msg;
> +	struct gh_mem_append_req_header *req_header;
> +	struct gh_mem_share_req_mem_section *mem_section;
> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	msg_size += sizeof(struct gh_mem_append_req_header);
> +	msg_size += offsetof(struct gh_mem_share_req_mem_section, entries[n_mem_entries]);
> +
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	req_header = msg;
> +	mem_section = (void *)req_header + sizeof(struct gh_mem_append_req_header);
> +
> +	req_header->mem_handle = mem_handle;

cpu_to_le(mem_handle);


> +	if (end_append)
> +		req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
> +
> +	mem_section->n_entries = n_mem_entries;
> +	memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * n_mem_entries);
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, &resp, &resp_size);
> +	if (ret)

kfree(msg);

> +		return ret;
> +	kfree(resp);

kfree(msg);

> +
> +	return ret;
> +}
> +
> +static int gh_rm_mem_append(struct gh_rm_rpc *rm, u32 mem_handle, bool allow_append,

Is there any scenario where allow_append will be 'true'? As of this patch
atleast, its always 'false', so maybe just avoid this input argument?

> +static int gh_rm_mem_lend_common(struct gh_rm_rpc *rm, u32 message_id, struct gh_rm_mem_parcel *p)
> +{

[snip]

> +	acl_section->n_entries = p->n_acl_entries;

cpu_to_le32(p->n_acl_entries);

> +	memcpy(acl_section->entries, p->acl_entries, sizeof(*(p->acl_entries)) * p->n_acl_entries);
> +
> +	mem_section->n_entries = initial_n_mem_entries;

cpu_to_le32(initial_n_mem_entries);

> +	memcpy(mem_section->entries, p->mem_entries,
> +		sizeof(*(p->mem_entries)) * initial_n_mem_entries);
> +
> +	/* Set n_entries for memory attribute section to 0 */
> +	*mem_attr_section = 0;
> +
> +	ret = gh_rm_call(rm, message_id, msg, msg_size, &resp, &resp_size);
> +	if (ret)

kfree(msg)

> +		return ret;
> +
> +	if (resp_size != sizeof(__le32)) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	p->mem_handle = le32_to_cpu(*(__le32 *)resp);
> +
> +	if (initial_n_mem_entries != p->n_mem_entries) {
> +		ret = gh_rm_mem_append(rm, p->mem_handle, false,
> +					&p->mem_entries[initial_n_mem_entries],
> +					p->n_mem_entries - initial_n_mem_entries);
> +		if (ret)
> +			gh_rm_mem_reclaim(rm, p);

			p->mem_handle = GH_MEM_HANDLE_INVAL in this case?

> +	}
> +
> +out:

kfree(msg) ?

