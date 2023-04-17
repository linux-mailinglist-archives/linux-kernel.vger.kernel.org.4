Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17DE6E54BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDQWmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:42:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0296846A0;
        Mon, 17 Apr 2023 15:42:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HMfcHK026562;
        Mon, 17 Apr 2023 22:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ThdI2vVhVvUS1hsMYpkEhFDrFYSRDvOSV+xF6HW6x2s=;
 b=GqijgJafos026x3Hrrw5c92brwF7kWGFLX5YfQ8V6nOtk0KXUItJcG0fTFPUl9adNVAu
 CDswiV4isgLCElhDBUAP5y8n4SZ3/bQ2odE0Ggx6pnQiJMHe+B7HxXzcPyWsjspbaP2y
 HIWrUnyqK+1/rKOL56kqrGb/Ig1ZOs//Kqf0613yxnk32X1Ymm70lzKDWNaF1YVyuHSu
 NW/mO9x0s6GeEYz75U5r1Vm85oQKQik+mavyX6NVFdzAO3COSYfNdgEKhCdDk8ZO/T1J
 vNQ8HHg3taE47MbGMBNTBgLbf/56iJ9GTPz2KPrvzesEqYJoaKxjDe5DyC+QAwIQAYaO ng== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q171gh8fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:42:00 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HMfxaq027141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:41:59 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 15:41:58 -0700
Message-ID: <274ad221-f397-b634-5742-fe6c9cb18843@quicinc.com>
Date:   Mon, 17 Apr 2023 15:41:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 22/26] virt: gunyah: Add proxy-scheduled vCPUs
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-23-quic_eberman@quicinc.com>
 <98ad146d-492d-aa0c-4f6a-ba37e6bf74eb@linaro.org>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <98ad146d-492d-aa0c-4f6a-ba37e6bf74eb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VJu4-N-iNPmDz-8lNhuzwsk2eCSSOK6-
X-Proofpoint-ORIG-GUID: VJu4-N-iNPmDz-8lNhuzwsk2eCSSOK6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170200
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:27 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:

[snip]

>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index caeb3b3a3e9a..e52265fa5715 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -62,8 +62,32 @@ struct gh_vm_dtb_config {
>>   #define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>> +/**
>> + * GH_FN_VCPU - create a vCPU instance to control a vCPU
>> + *
>> + * gh_fn_desc is filled with &struct gh_fn_vcpu_arg
>> + *
>> + * The vcpu type will register with the VM Manager to expect to control
>> + * vCPU number `vcpu_id`. It returns a file descriptor allowing 
>> interaction with
>> + * the vCPU. See the Gunyah vCPU API description sections for 
>> interacting with
>> + * the Gunyah vCPU file descriptors.
>> + *
>> + * Return: file descriptor to manipulate the vcpu. See GH_VCPU_* ioctls
>> + */
>> +#define GH_FN_VCPU         1
> 
> I think you should define GH_VN_VCPU, GN_FN_IRQFD, and GN_FN_IOEVENTFD
> in an enumerated type.  Each has a type associated with it, and you can
> add the explanation for the function in the kernel-doc comments above
> thosse type definitions.
> 

I'd like to enumify the GH_FN_* macros, but one challenge I'm facing is 
that it breaks the module alias implementation in patch 19.

MODULE_ALIAS("ghfunc:"__stringify(_type))

When the GH_FN_* are regular preprocessor macros backed by an integer, 
the preprocessor will make the module alias ghfunc:0 (or ghfunc:1, etc). 
This works well because I can do

request_module("ghfunc:%d", type);

If the function hasn't been registered and then gunyah_vcpu.ko gets 
loaded automatically.

With enum, compiler knows the value of GH_FN_VCPU and preprocessor will 
make the module alias like ghfunc:GH_FN_VCPU.

[snip]

>> +
>> +/*
>> + * Gunyah presently sends max 4 bytes of exit_reason.
>> + * If that changes, this macro can be safely increased without breaking
>> + * userspace so long as struct gh_vcpu_run < PAGE_SIZE.
> 
> Is PAGE_SIZE allowed to be anything other than 4096 bytes?  Do you
> expect this driver to work properly if the page size were configured
> to be 16384 bytes?  In other words, is this a Gunyah constant, or
> is it *really* the page size configured for Linux?
> 

Our implementations are only doing 4096 bytes. I expect the driver to 
work properly when using 16k pages. This really is a Linux page. It's a 
reflection of the alloc_page in gh_vcpu_bind().

The exit reason is copied from hypervisor into field accessible by 
userspace directly. Gunyah makes the exit reason size dynamic -- there's 
no architectural limitation preventing the exit reason from being a 
string or some lengthy data.

As I was writing this response, I realized that I should be able to make 
this a zero-length array and ensure that reason[] doesn't overflow 
PAGE_SIZE...

The comment was trying to explain that Linux itself imposes a limitation 
on the maximum exit reason size. If we need to support longer exit 
reason, we're OK to do so long as the total size doesn't overrun 
PAGE_SIZE. There aren't any plans to need longer exit reasons than the 8 
bytes mentioned today.

Thanks,
Elliot
