Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81986A212D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBXSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBXSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:08:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798965302;
        Fri, 24 Feb 2023 10:08:46 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OI8VMV030263;
        Fri, 24 Feb 2023 18:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0YkAC5sdUDDNmzZjSAq+GcFuOfC2a1Wmd+AzIEAfGlk=;
 b=mtfdtO8xjp0EKrogibIHZXdFq3IWWg3cGIDlEeKVNGccHgKogSbdNPsV2JMqkJmcKBQ1
 S84I62QQt1n0GX8Hud235eLdJK+6kCYJKyNmaOgDX7LQ9pgGah/9skQ+2lK71cs7Yy4n
 IyyDNXqM6hu39RKFaHSTJXLtxxVSTsRK0ABCrOmE6YUyIcj4G3WIIeLz474gu/9qliis
 Pb4iEH5K6hUhvlLAK1cl6+T5MmXKudIKNJv7T0nrojK4nsQyepJZ6okIUNLci//ubyQd
 BLhtxO3C571knJ0uX20g++vedoQTHcWPEn8qCce1sc5KGYr9oso5TD3aFiH5c59UWMzk aQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny05mrcs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 18:08:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OI8UW5000665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 18:08:30 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 10:08:29 -0800
Message-ID: <7b6d4c14-ebde-1bc3-04de-59cae9d4b7be@quicinc.com>
Date:   Fri, 24 Feb 2023 10:08:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
To:     Fuad Tabba <tabba@google.com>
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Chao Peng" <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>,
        "smoreland@google.com" <smoreland@google.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
 <CA+EHjTxEeiBWXJMCnv0V+5n=jB8w=m0EFdgK=FKtSqKOkiaChg@mail.gmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CA+EHjTxEeiBWXJMCnv0V+5n=jB8w=m0EFdgK=FKtSqKOkiaChg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GB_MM5ia32HfIiO1IJ_OZveSflPxvTnN
X-Proofpoint-ORIG-GUID: GB_MM5ia32HfIiO1IJ_OZveSflPxvTnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_13,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240142
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 2:19 AM, Fuad Tabba wrote:
> Hi,
> 
> On Tue, Feb 14, 2023 at 9:26 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>
>>
>> When launching a virtual machine, Gunyah userspace allocates memory for
>> the guest and informs Gunyah about these memory regions through
>> SET_USER_MEMORY_REGION ioctl.
> 
> I'm working on pKVM [1], and regarding the problem of donating private
> memory to a guest, we and others working on confidential computing
> have faced a similar issue that this patch is trying to address. In
> pKVM, we've initially taken an approach similar to the one here by
> pinning the pages being donated to prevent swapping or migration [2].
> However, we've encountered issues with this approach since the memory
> is still mapped by the host, which could cause the system to crash on
> an errant access.
> 
> Instead, we've been working on adopting an fd-based restricted memory
> approach that was initially proposed for TDX [3] and is now being
> considered by others in the confidential computing space as well
> (e.g., Arm CCA [4]). The basic idea is that the host manages the guest
> memory via a file descriptor instead of a userspace address. It cannot
> map that memory (unless explicitly shared by the guest [5]),
> eliminating the possibility of the host trying to access private
> memory accidentally or being tricked by a malicious actor. This is
> based on memfd with some restrictions. It handles swapping and
> migration by disallowing them (for now [6]), and adds a new type of
> memory region to KVM to accommodate having an fd representing guest
> memory.
> 
> Although the fd-based restricted memory isn't upstream yet, we've
> ported the latest patches to arm64 and made changes and additions to
> make it work with pKVM, to test it and see if the solution is feasible
> for us (it is). I wanted to mention this work in case you find it
> useful, and in the hopes that we can all work on confidential
> computing using the same interfaces as much as possible.

Thanks for highlighting the memfd_restricted changes to us! We'll 
investigate how/if it can suit Gunyah usecases. It sounds like you 
might've made memfd_restricted changes as well? Are those posted on the 
mailing lists? Also, are example userspace (crosvm?) changes posted?

Thanks,
Elliot

> 
> Some comments inline below...
> 
> Cheers,
> /fuad
> 
> [1] https://lore.kernel.org/kvmarm/20220519134204.5379-1-will@kernel.org/
> [2] https://lore.kernel.org/kvmarm/20220519134204.5379-34-will@kernel.org/
> [3] https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com/
> [4] https://lore.kernel.org/lkml/20230127112932.38045-1-steven.price@arm.com/
> [5] This is a modification we've done for the arm64 port, after
> discussing it with the original authors.
> [6] Nothing inherent in the proposal to stop migration and swapping.
> There are some technical issues that need to be resolved.
> 
> <snip>
<snip, looking at comments in parallel>
