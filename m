Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1E726520
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbjFGPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjFGPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:55:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE91FD7;
        Wed,  7 Jun 2023 08:55:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Er4Aa014381;
        Wed, 7 Jun 2023 15:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ePWbcl7sywkQf8jrOeRxLl0Iv09edeqAWEtCrEHQvm4=;
 b=am+dVGvHAFCW336lvjl+v7OSlSpSvJ6Iurojv33m7F1MiNLe9IX2K0uW8fhPSQuEnP4W
 j/aIDbl8UP/oAt+F1gKddCOvL1qo8hQqBk873NEu9rs+ssycUi4JKJliqlp1Ff4sPIEJ
 V5SreFZrjPIxTZ4/kcFA+ThIOZfBiQwFhoQknPhRkfBMa7Ktfq6DYDg3xPqNc1mQ2O2R
 VFKoB/zq8mM5hrH0u77GKtpkUqyVaAT/dw9z4Qwl5PSzl/LIRUBnmMh5OVtuhJonUtFT
 pUZ6tzHNY8Wj3tE7nRhFra1JMVDJjWdTlqvZVkl9cTyLpG3lJJ5jEJSXQvNglmqvR4ZC +w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7g29pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 15:54:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357FsnCv032002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 15:54:49 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 08:54:48 -0700
Message-ID: <3bd86221-ee2e-d157-009b-11f6ada98537@quicinc.com>
Date:   Wed, 7 Jun 2023 08:54:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 10/24] gunyah: vm_mgr: Add/remove user memory regions
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
        <linux-arm-kernel@lists.infradead.org>, <qperret@google.com>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-11-quic_eberman@quicinc.com>
 <20230519115948.GB2637@willie-the-truck>
 <e22c31bd-10ed-f242-3e72-debf40e01e3c@quicinc.com>
 <20230605141839.GD21212@willie-the-truck>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230605141839.GD21212@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y0pKxrQR9trwJj6KGThieFSTWS6Zk-oa
X-Proofpoint-ORIG-GUID: y0pKxrQR9trwJj6KGThieFSTWS6Zk-oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=704
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070135
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 7:18 AM, Will Deacon wrote:
> Hi Elliot,
> 
> [+Quentin since he's looked at the MMU notifiers]
> 
> Sorry for the slow response, I got buried in email during a week away.
> 
> On Fri, May 19, 2023 at 10:02:29AM -0700, Elliot Berman wrote:
>> On 5/19/2023 4:59 AM, Will Deacon wrote:
>>> On Tue, May 09, 2023 at 01:47:47PM -0700, Elliot Berman wrote:
>>>> +	ret = account_locked_vm(ghvm->mm, mapping->npages, true);
>>>> +	if (ret)
>>>> +		goto free_mapping;
>>>> +
>>>> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL_ACCOUNT);
>>>> +	if (!mapping->pages) {
>>>> +		ret = -ENOMEM;
>>>> +		mapping->npages = 0; /* update npages for reclaim */
>>>> +		goto unlock_pages;
>>>> +	}
>>>> +
>>>> +	gup_flags = FOLL_LONGTERM;
>>>> +	if (region->flags & GH_MEM_ALLOW_WRITE)
>>>> +		gup_flags |= FOLL_WRITE;
>>>> +
>>>> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
>>>> +					gup_flags, mapping->pages);
>>>> +	if (pinned < 0) {
>>>> +		ret = pinned;
>>>> +		goto free_pages;
>>>> +	} else if (pinned != mapping->npages) {
>>>> +		ret = -EFAULT;
>>>> +		mapping->npages = pinned; /* update npages for reclaim */
>>>> +		goto unpin_pages;
>>>> +	}
>>>
>>> Sorry if I missed it, but I still don't see where you reject file mappings
>>> here.
>>>
>>
>> Sure, I can reject file mappings. I didn't catch that was the ask previously
>> and thought it was only a comment about behavior of file mappings.
> 
> I thought the mention of filesystem corruption was clear enough! It's
> definitely something we shouldn't allow.
> 
>>> This is also the wrong interface for upstream. Please get involved with
>>> the fd-based guest memory discussions [1] and port your series to that.
>>>
>>
>> The user interface design for *shared* memory aligns with
>> KVM_SET_USER_MEMORY_REGION.
> 
> I don't think it does. For example, file mappings don't work (as above),
> you're placing additional rlimit requirements on the caller, read-only
> memslots are not functional, the memory cannot be swapped or migrated,
> dirty logging doesn't work etc. pKVM is in the same boat, but that's why
> we're not upstreaming this part in its current form.
>

I thought pKVM was only holding off on upstreaming changes related to 
guest-private memory?

>> I understood we want to use restricted memfd for giving guest-private memory
>> (Gunyah calls this "lending memory"). When I went through the changes, I
>> gathered KVM is using restricted memfd only for guest-private memory and not
>> for shared memory. Thus, I dropped support for lending memory to the guest
>> VM and only retained the shared memory support in this series. I'd like to
>> merge what we can today and introduce the guest-private memory support in
>> tandem with the restricted memfd; I don't see much reason to delay the
>> series.
> 
> Right, protected guests will use the new restricted memfd ("guest mem"
> now, I think?), but non-protected guests should implement the existing
> interface *without* the need for the GUP pin on guest memory pages. Yes,
> that means full support for MMU notifiers so that these pages can be
> managed properly by the host kernel. We're working on that for pKVM, but
> it requires a more flexible form of memory sharing over what we currently
> have so that e.g. the zero page can be shared between multiple entities.

Gunyah doesn't support swapping pages out while the guest is running and 
the design of Gunyah isn't made to give host kernel full control over 
the S2 page table for its guests. As best I can tell from reading the 
respective drivers, ACRN and Nitro Enclaves both GUP pin guest memory 
pages prior to giving them to the guest, so I don't think this 
requirement from Gunyah is particularly unusual.

