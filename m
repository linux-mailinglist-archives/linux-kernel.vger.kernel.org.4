Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD18681D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjA3VqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjA3Vp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:45:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0FE86B0;
        Mon, 30 Jan 2023 13:45:55 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ULUVkD022923;
        Mon, 30 Jan 2023 21:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NhrOGJv0wHfmhC/EZl8LNpCyTCrJjvuMMumnsh4PgOQ=;
 b=Bw/8SaIYvYfjbeIBNyr1rtCyJReNxEedIswnX1EPkEZo98fizFZMU7R7zwyIRd3Wjhj2
 vw9MO5arBJCPOtp5XVMoK/dOEA9dxnLYn9Tv4C0D/Yiy2UUcEiPuhIXK5CM+eLxYZtwQ
 I4T2n0Wxzq/lqh7PYZgXq/zibkmHgdQvTsx8HxFL2lA0TlZbKSRuLYsih+Znvxtgevi5
 IBey4nY8L+o1MdvL0HLIDAk9xU3RcE+XE4rn8/VIq9aQtA9kgsFOKQTCDcC3zac5+Q2m
 CyyWS6DnW+xw1JN9ghknnFVmS5JlRkTGfHmZFGP5RNWpz7ggCB2ZMp8SSFGv45N/JNIm jQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpcm57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:45:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ULjd2L001184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:45:39 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 13:45:38 -0800
Message-ID: <40a44366-69b8-7efa-e9b4-5b585a4dd929@quicinc.com>
Date:   Mon, 30 Jan 2023 13:45:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 12/27] gunyah: rsc_mgr: Add RPC for sharing memory
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
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
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-13-quic_eberman@quicinc.com>
 <20230130101445.GB332@quicinc.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230130101445.GB332@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fUSjbwmTBrAXM-qkK38e4YinJ314pGtj
X-Proofpoint-ORIG-GUID: fUSjbwmTBrAXM-qkK38e4YinJ314pGtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300201
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2023 2:14 AM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:11]:
> 
>> +static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_mem_parcel *p)
>> +{
>> +	size_t msg_size = 0, initial_n_mem_entries = p->n_mem_entries;
>> +	void *msg;
>> +	__le32 *resp;
>> +	struct gh_mem_share_req_header *req_header;
>> +	struct gh_mem_share_req_acl_section *acl_section;
>> +	struct gh_mem_share_req_mem_section *mem_section;
>> +	u32 *mem_attr_section;
>> +	size_t resp_size;
>> +	int ret;
>> +
>> +	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || !p->n_mem_entries ||
>> +	    p->n_acl_entries > U8_MAX || p->mem_handle != GH_MEM_HANDLE_INVAL)
>> +		return -EINVAL;
>> +
>> +	if (initial_n_mem_entries > GH_RM_MAX_MEM_ENTRIES)
>> +		initial_n_mem_entries = GH_RM_MAX_MEM_ENTRIES;
>> +
>> +	/* The format of the message goes:
>> +	 * request header
>> +	 * ACL entries (which VMs get what kind of access to this memory parcel)
>> +	 * Memory entries (list of memory regions to share)
>> +	 * Memory attributes (currently unused, we'll hard-code the size to 0)
>> +	 */
>> +	msg_size += sizeof(struct gh_mem_share_req_header);
>> +	msg_size += offsetof(struct gh_mem_share_req_acl_section, entries[p->n_acl_entries]);
>> +	msg_size += offsetof(struct gh_mem_share_req_mem_section, entries[initial_n_mem_entries]);
>> +	msg_size += sizeof(u32); /* for memory attributes, currently unused */
>> +
>> +	msg = kzalloc(msg_size, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	ret = gh_rm_platform_pre_mem_share(rm, p);
> 
> Hmm ..I think gh_rm_platform_pre_mem_share() is not yet defined as of this
> patch, so you probably want this in a later patch.
> 

Seems I fell victim to trusting automatic fixup tools. Fixed.

>> +	if (ret) {
>> +		kfree(msg);
>> +		return ret;
>> +	}
>> +
