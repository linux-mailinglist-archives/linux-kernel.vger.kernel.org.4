Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4468CDD6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBGD7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBGD7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:59:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C744D9;
        Mon,  6 Feb 2023 19:59:46 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3171jXGm032028;
        Tue, 7 Feb 2023 03:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dKn000mqdgebyRGCvfqjvl5A8oSOiVLU+kcFkvL/tUY=;
 b=Cd3uXutbcWGTk80js5BaciQ9aVnWR4/4d9Trx/GredhvIw3cAx+83MVuLUVLqVLVCRUr
 XE2h3pLA+iuxNhkVXQP7ZFHc6iClHHjn65J/Pj7IsdiT+Nkkc/9D+d6jQXSYW4BawF7T
 Ym9e33Q8EZg8noVyGkBCd4PUVZed/w3vEM4YWGKuUzsmGPbqxJm08kEJmDMLUq1fUS+M
 OheQ7zGbkOMKTn0c7FQ+S3iMH2JP5PlPulh7jMYylcZ34BR2iOc+rZ2AhsB2qzusobNP
 T2oSkQMcsf+2ecO6ytZpmN6eBAQ6zMmPoLmekX3+Wm6Vl7fTYpYkRhvdNm99GWKJupw4 jQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkd8m07kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 03:59:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3173xV8X018175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 03:59:31 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 19:59:30 -0800
Message-ID: <5b4b0c3b-0d1f-5f6c-d541-744c9a7173f8@quicinc.com>
Date:   Mon, 6 Feb 2023 19:59:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 23/27] virt: gunyah: Add IO handlers
Content-Language: en-US
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
 <20230120224627.4053418-24-quic_eberman@quicinc.com>
 <20230206104637.GG332@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230206104637.GG332@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T8Z4B15NOY4HQUe04TE_v83na-vCu4_y
X-Proofpoint-ORIG-GUID: T8Z4B15NOY4HQUe04TE_v83na-vCu4_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=912
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070035
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 2:46 AM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:22]:
> 
>> +static inline bool gh_vm_io_handler_matches(struct gunyah_vm_io_handler *io_hdlr, u64 addr,
>> +						u64 len, u64 data)
>> +{
>> +	u64 mask = BIT_ULL(io_hdlr->len * BITS_PER_BYTE) - 1;
>> +
>> +	if (io_hdlr->addr != addr)
> 
> Isn't this test redundant (given that caller would have performed same test)?
> 

Done.

>> +		return false;
>> +
>> +	if (!io_hdlr->datamatch)
>> +		return true;
>> +
>> +	if (io_hdlr->len != len)
>> +		return false;
>> +
>> +	return (data & mask) == (io_hdlr->data & mask);
>> +}
>> +
>> +static struct gunyah_vm_io_handler *gh_vm_mgr_find_io_hdlr(struct gunyah_vm *ghvm, u64 addr,
>> +								u64 len, u64 data)
>> +{
>> +	struct gunyah_vm_io_handler *io_hdlr = NULL;
>> +	struct rb_node *root = NULL;
>> +
>> +	root = ghvm->mmio_handler_root.rb_node;
>> +	while (root) {
>> +		io_hdlr = rb_entry(root, struct gunyah_vm_io_handler, node);
>> +		if (addr < io_hdlr->addr)
>> +			root = root->rb_left;
>> +		else if (addr > io_hdlr->addr)
>> +			root = root->rb_right;
>> +		else if (gh_vm_io_handler_matches(io_hdlr, addr, len, data))
> 
> In case of handler not matching, don't we need to modify root?
> Otherwise we can be stuck in infinite loop here AFAICS.
> 

Done.

>> +			return io_hdlr;
>> +	}
>> +	return NULL;
>> +}
> 
> // snip
> 
>> +int gh_vm_mgr_add_io_handler(struct gunyah_vm *ghvm, struct gunyah_vm_io_handler *io_hdlr)
>> +{
>> +	struct rb_node **root, *parent = NULL;
>> +
>> +	if (io_hdlr->datamatch &&
>> +		(!io_hdlr->len || io_hdlr->len > (sizeof(io_hdlr->data) * BITS_PER_BYTE)))
>> +		return -EINVAL;
>> +
>> +	root = &ghvm->mmio_handler_root.rb_node;
>> +	while (*root) {
>> +		struct gunyah_vm_io_handler *curr = rb_entry(*root, struct gunyah_vm_io_handler,
>> +								node);
>> +
>> +		parent = *root;
>> +		if (io_hdlr->addr < curr->addr)
>> +			root = &((*root)->rb_left);
>> +		else if (io_hdlr->addr > curr->addr)
>> +			root = &((*root)->rb_right);
>> +		else
> 
> We should allow two io_handlers on the same addr, but with different data
> matches I think.
> 

Done.

>> +			return -EEXIST;
>> +	}
>> +
>> +	rb_link_node(&io_hdlr->node, parent, root);
>> +	rb_insert_color(&io_hdlr->node, &ghvm->mmio_handler_root);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_mgr_add_io_handler);
