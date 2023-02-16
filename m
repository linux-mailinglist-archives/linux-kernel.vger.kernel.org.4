Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF2699B21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBPRUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBPRUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:20:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A14C3ED;
        Thu, 16 Feb 2023 09:20:21 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GCt8qW010208;
        Thu, 16 Feb 2023 17:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CvEmRzvubJL6Lk72z7V0twUXA882j4nFECNyTnUSNKA=;
 b=WmXomSAkO2ZvyPZHq93yDzzZbd1jnKyvIZ8kb6Wj8IF1AFQVWp37az/fklDNsmZwcqYN
 M4o7OzPB+0K8CgYQtUDcCD/6sJY8ncycdJs06xXLq5CnNo/uScApzO/VwwC6vM3TdWXj
 bmm4A1ysaQvZjYSgIPh+eaTND4GCBrlROmiTTHwUI/OyptmVpiImzzh9whKLfZTTsVat
 yNtcUvO+qaEBCbBiDUXZLB6PKULCiUxx3T7JzTk4rwGjHTVmnmwjeLgb0fGxhS5z+Gxe
 4QuYJhNp7a7WsJBXR03m0NHfEa/mN8bTOa/kAVK/yHYUG2rdO8g7JZn2aG5ck61ZcTAh 6g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns0hkkspd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:20:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GHK9Tu007598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:20:09 GMT
Received: from [10.110.95.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 09:20:08 -0800
Message-ID: <62a05595-ef52-aa51-039b-95d546fb6a81@quicinc.com>
Date:   Thu, 16 Feb 2023 09:20:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212427.3316544-1-quic_eberman@quicinc.com>
 <Y+3Ou02LwsfS0TLl@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y+3Ou02LwsfS0TLl@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i04LpIZhRqhzFvRQ8jaKjPqxZ-jLng_2
X-Proofpoint-GUID: i04LpIZhRqhzFvRQ8jaKjPqxZ-jLng_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_14,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160150
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2023 10:35 PM, Greg Kroah-Hartman wrote:
> On Tue, Feb 14, 2023 at 01:24:26PM -0800, Elliot Berman wrote:
>> +	case GH_VM_SET_DTB_CONFIG: {
>> +		struct gh_vm_dtb_config dtb_config;
>> +
>> +		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
>> +			return -EFAULT;
>> +
>> +		dtb_config.size = PAGE_ALIGN(dtb_config.size);
>> +		ghvm->dtb_config = dtb_config;
> 
> Do you really mean to copy this tiny structure twice (once from
> userspace and the second time off of the stack)?  If so, why?

Ah, yes this can be optimized to copy directly.
> 
> And where are the values of the structure checked for validity?  Can any
> 64bit value work for size and "gpa"?
> 

The values get checked when starting the VM

static int gh_vm_start(struct gh_vm *ghvm)
	...
	mapping = gh_vm_mem_find_mapping(ghvm, ghvm->dtb_config.gpa, 
ghvm->dtb_config.size);
	if (!mapping) {
		pr_warn("Failed to find the memory_handle for DTB\n");
		ret = -EINVAL;
		goto err;
	}

If user passes an address that they've not set up, then 
gh_vm_mem_find_mapping returns NULL and GH_VM_START ioctl fails.

I've not done the check from the GH_VM_SET_DTB_CONFIG ioctl itself 
because I didn't want to require userspace to share the memory first. 
We'd need to check again anyway since user could SET_USER_MEMORY, 
SET_DTB_CONFIG, SET_USER_MEMORY (remove), VM_START.

Thanks,
Elliot

