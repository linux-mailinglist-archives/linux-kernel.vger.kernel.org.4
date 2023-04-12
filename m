Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979546E0025
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDLUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDLUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:48:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987EB61B4;
        Wed, 12 Apr 2023 13:48:30 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJO0DL031517;
        Wed, 12 Apr 2023 20:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K4XHZz2aY2nW6NB6OBt9fcQ6aWSAEbS0apa/t/BVKUs=;
 b=LevbVUH1rieLvZEWkWcoRDCp6krorWyA4FNvBT59LI2AZnvOWMWziKuhsYguXG5PkDHA
 lIwkpgaqPqORzUtWvsf/GtHBiRMQiqHAuhnXiCKolAz5hWQbZb2yUuFJd2rp8vlOi/iv
 +bDCfDYTJD7UVmAa8pOBmwqRjoqg1DAZ05CfbVYaAtnKD+vrmvvsxf6aPilWQRwZYlEE
 tJ9Qepfmaoc/iSK3lXIn1bX4vPGjxgIga1LhD8fzjHxPVd/nnScXLWO7tt5iAGox/5Pd
 do4JndTeM1p+ck6TGEBJnlw0LGw0kLBmbU7FqkFloBn9B767W4pBz7zRSO2BBBMreZdA XA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwsx69en4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 20:48:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CKm9nW009140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 20:48:09 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 13:48:08 -0700
Message-ID: <67209a0d-1dc5-ce96-e916-85bfd8f6a7f8@quicinc.com>
Date:   Wed, 12 Apr 2023 13:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 12/26] gunyah: vm_mgr: Add/remove user memory regions
To:     Will Deacon <will@kernel.org>
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
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-13-quic_eberman@quicinc.com>
 <20230324183659.GB28266@willie-the-truck>
 <5d1c6160-6bc4-5246-2a0b-de5ddcbbc2c4@quicinc.com>
 <20230411211940.GC23890@willie-the-truck>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230411211940.GC23890@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aEoLzdQIFUpvDG41hNSkfTxWy3q6rP-_
X-Proofpoint-ORIG-GUID: aEoLzdQIFUpvDG41hNSkfTxWy3q6rP-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_11,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=864 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120176
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2023 2:19 PM, Will Deacon wrote:
> On Tue, Apr 11, 2023 at 01:34:34PM -0700, Elliot Berman wrote:
>> On 3/24/2023 11:37 AM, Will Deacon wrote:
>>> On Fri, Mar 03, 2023 at 05:06:18PM -0800, Elliot Berman wrote:
>>>> +
>>>> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
>>>> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
>>>> +	if (pinned < 0) {
>>>> +		ret = pinned;
>>>> +		mapping->npages = 0; /* update npages for reclaim */
>>>> +		goto reclaim;
>>>> +	} else if (pinned != mapping->npages) {
>>>> +		ret = -EFAULT;
>>>> +		mapping->npages = pinned; /* update npages for reclaim */
>>>> +		goto reclaim;
>>>> +	}
>>>
>>> I think Fuad mentioned this on an older version of these patches, but it
>>> looks like you're failing to account for the pinned memory here which is
>>> a security issue depending on who is able to issue the ioctl() calling
>>> into here.
>>>
>>> Specifically, I'm thinking that your kXalloc() calls should be using
>>> GFP_KERNEL_ACCOUNT in this function and also that you should be calling
>>> account_locked_vm() for the pages being pinned.
>>>
>>
>> Added the accounting for the v12.
>>
>>> Finally, what happens if userspace passes in a file mapping?
>>
>> Userspace will get EBADADDR (-14) back when trying to launch the VM
>> (pin_user_pages_fast returns this as you might have been expecting). We
>> haven't yet had any need to support file-backed mappings.
> 
> Hmm, no, that's actually surprising to me. I'd have thought GUP would
> happily pin page-cache pages for file mappings, so I'm intrigued as to
> which FOLL_ flag is causing you to get an error code back. Can you
> enlighten me on where the failure originates, please?

Ah this ended up being an error on my part. Userspace was opening the 
file as RO and Gunyah driver will unconditionally add FOLL_WRITE as part 
of the gup flags. I got the flags aligned and seemed to be able to boot 
the VM ok and it works as expected.

Thanks,
Elliot
