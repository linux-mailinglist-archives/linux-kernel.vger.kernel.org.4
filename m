Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68972681D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjA3Vps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjA3Vpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:45:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC53AAD;
        Mon, 30 Jan 2023 13:45:41 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ULY1Lx000753;
        Mon, 30 Jan 2023 21:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AbDsMrUWoDurcwZPXPA09xCJ155aDBHF682mEnr6eJw=;
 b=lmgdSq7gRgVs9Ns0ZjjnRzJbLT+ML946CPlrLF6kVLTcqFphfvQfVjhx40qotjzVYDkP
 z/SKgqtsomJWlrrAt1PmvL9p0xSK9UsbHzj/DAExxbC7JFmwAnoAnpsAkCxjS4so+xp6
 JMQzcTNCdXKL9afXwZNnA02ijWxOLqlzaHTNUJu+tuDzK8eErIETYYUf1daQU+AZ7KVh
 5qHFKlpGJ5nuZIDn5kX9wsar85wOOr+qVWhvcuQldLn3JhPswPZW1B3n31aqxtbWSo50
 El5g/uNwF8tRJ1XCcY6hH9qw2mv8GwsILWvin0xssKQBweJZNOQ7X+SKmAnEQEe5KvKA QA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpcm4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:45:29 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ULjSV4014529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:45:28 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 13:45:27 -0800
Message-ID: <6e14cca8-7d44-3b89-2702-202ef988c2bf@quicinc.com>
Date:   Mon, 30 Jan 2023 13:45:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 14/27] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
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
 <20230120224627.4053418-15-quic_eberman@quicinc.com>
 <20230130085359.GC4169015@quicinc.com>
 <3fd29474-eed2-3651-15d6-f1725500d7b9@quicinc.com>
In-Reply-To: <3fd29474-eed2-3651-15d6-f1725500d7b9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7s8l9EZK3Oh6PLee36eK5EgKoRPxU6q2
X-Proofpoint-ORIG-GUID: 7s8l9EZK3Oh6PLee36eK5EgKoRPxU6q2
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



On 1/30/2023 1:44 PM, Elliot Berman wrote:
> 
> 
> On 1/30/2023 12:53 AM, Srivatsa Vaddagiri wrote:
>> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:13]:
>>
>>> +static int gh_vm_start(struct gunyah_vm *ghvm)
>>> +{
>>> +    struct gunyah_vm_memory_mapping *mapping;
>>> +    u64 dtb_offset;
>>> +    u32 mem_handle;
>>> +    int ret;
>>> +
>>> +    down_write(&ghvm->status_lock);
>>> +    if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
>>> +        up_write(&ghvm->status_lock);
>>> +        return 0;
>>
>> return -EINVAL in this case.
>>
>> Additionally check if its already GH_RM_VM_STATUS_READY and return 0 
>> in that
>> case.
>>
>> [snip]
>>
> 
> Caller can use gh_vm_ensure_started for this behavior. I'll move this to 
> be used in the GH_VM_RUN ioctl as well.
                 *GH_VM_START
>  >>
>>> +    mem_handle = mapping->parcel.mem_handle;
>>> +    dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
>>> +
>>> +    ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, 
>>> mem_handle,
>>> +                0, 0, dtb_offset, ghvm->dtb_config.size);
>>
>> Default value of auth is 0 (GH_RM_VM_AUTH_NONE). Is that what you 
>> wanted here?
>> Perhaps initialize default value of auth to be 
>> GH_RM_VM_AUTH_QCOM_PIL_ELF?
>>
> 
> Yes, default VM is GH_RM_VM_AUTH_NONE.
