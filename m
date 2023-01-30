Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE0680A91
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjA3KPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjA3KPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:15:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2F5252;
        Mon, 30 Jan 2023 02:15:15 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U6LBr4028583;
        Mon, 30 Jan 2023 10:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=FQ25Ocj9mmDa26Q4Qbvq4/AjPwDuTjYyZW7kxiBvCw4=;
 b=BZi8IdZDbX5hx6pjZrgv/HIi1W23MKVBMB0rmvPOzvHxatgRF61leNff6FStpwl9emy0
 va3LN1khxdjFM4WEEzq82Nc2zSuoU1XD9RlgUuQ7jrJSst3oTHR5WUJIpJUEsIldq4+D
 ZFd9ONjt69t9qYre5l9DmPMUJqoZoIBu+Z5hYP47hD/dr7PVnDImaD506x4AvEyH6Wu8
 QgummUH5FKBwl7slhEmTxcN8+5E21YnSpbOIW3XmpM+gp4eDcTdhjvKEQClt88987UqQ
 /zNhxclZ27zUV89K5/Ten0g0cZdzM2RWQccXqduoLeEHdZfWNxp5Qd73QmUjTqPc6FhP Mg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvvu36p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 10:15:00 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UAEx3E005764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 10:14:59 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 02:14:51 -0800
Date:   Mon, 30 Jan 2023 15:44:45 +0530
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
Subject: Re: [PATCH v9 12/27] gunyah: rsc_mgr: Add RPC for sharing memory
Message-ID: <20230130101445.GB332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-13-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-13-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QKEya6Z32GHI_o5Kft3PK1XLQziwReYd
X-Proofpoint-ORIG-GUID: QKEya6Z32GHI_o5Kft3PK1XLQziwReYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=802 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:11]:

> +static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_mem_parcel *p)
> +{
> +	size_t msg_size = 0, initial_n_mem_entries = p->n_mem_entries;
> +	void *msg;
> +	__le32 *resp;
> +	struct gh_mem_share_req_header *req_header;
> +	struct gh_mem_share_req_acl_section *acl_section;
> +	struct gh_mem_share_req_mem_section *mem_section;
> +	u32 *mem_attr_section;
> +	size_t resp_size;
> +	int ret;
> +
> +	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || !p->n_mem_entries ||
> +	    p->n_acl_entries > U8_MAX || p->mem_handle != GH_MEM_HANDLE_INVAL)
> +		return -EINVAL;
> +
> +	if (initial_n_mem_entries > GH_RM_MAX_MEM_ENTRIES)
> +		initial_n_mem_entries = GH_RM_MAX_MEM_ENTRIES;
> +
> +	/* The format of the message goes:
> +	 * request header
> +	 * ACL entries (which VMs get what kind of access to this memory parcel)
> +	 * Memory entries (list of memory regions to share)
> +	 * Memory attributes (currently unused, we'll hard-code the size to 0)
> +	 */
> +	msg_size += sizeof(struct gh_mem_share_req_header);
> +	msg_size += offsetof(struct gh_mem_share_req_acl_section, entries[p->n_acl_entries]);
> +	msg_size += offsetof(struct gh_mem_share_req_mem_section, entries[initial_n_mem_entries]);
> +	msg_size += sizeof(u32); /* for memory attributes, currently unused */
> +
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	ret = gh_rm_platform_pre_mem_share(rm, p);

Hmm ..I think gh_rm_platform_pre_mem_share() is not yet defined as of this
patch, so you probably want this in a later patch.

> +	if (ret) {
> +		kfree(msg);
> +		return ret;
> +	}
> +
