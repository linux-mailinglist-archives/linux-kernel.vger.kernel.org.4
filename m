Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031B624EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiKKADi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKADg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:03:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D0C49B52;
        Thu, 10 Nov 2022 16:03:34 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AANU1EL005940;
        Fri, 11 Nov 2022 00:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8PHwJILADgwdipE7zP40ijyqZwmjfhC7ELa8FFACbUY=;
 b=oJFv2GwLODupXfH93b/oGPNuDP8hYUem34OBFCcLWOVTfxymMzA+zpND2K01FvGZyGpH
 BT0A92MrTD5h8zeh/lk4bhiIzMJPltrdB8yhvyw5+laay01nl+disbCIHsTB4zMBBcd4
 EJi9DHCbtEeTcsApWSwPjdq/AyN0drnD62nOBj4qwKsgO+hmiAkkl7J32wvG95Ohhipx
 DD2YualjKP/6T4PZixQO6SHVFvM57tdYT035zM8OAWJgfpPUURkd40ChMmI/ik7uME24
 Z0K6TBBRv0TAyjXYuuW2hpSt24Qp0lECEuhgqkqvu8mAgaXTe1lNpyT1MyCicnkyCmEy Pw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksahhg2ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 00:03:13 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB03BAk031092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 00:03:11 GMT
Received: from [10.110.39.85] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 10 Nov
 2022 16:03:10 -0800
Message-ID: <543d95f8-be31-7553-4700-5dc04872e8ea@quicinc.com>
Date:   Thu, 10 Nov 2022 16:03:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <Y2H8oh7AvYDiMqKs@kroah.com>
 <722b05a1-4bf5-0837-baea-b1d0a9cc1e43@quicinc.com>
 <Y2MKWOihjAPxfl6v@kroah.com>
 <96238455-73b6-bead-0fdb-55ca68e5bf0b@quicinc.com>
 <9dd597d9-a3f3-48f2-8416-b5b097a230d5@app.fastmail.com>
 <980db147-794e-ecd9-9626-64ff81109bab@quicinc.com>
 <95a9f253-984a-14e0-7e01-f168452576c4@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <95a9f253-984a-14e0-7e01-f168452576c4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z_I6qo3MRu1stJfpFb1gxi7dMmaGmUYD
X-Proofpoint-ORIG-GUID: Z_I6qo3MRu1stJfpFb1gxi7dMmaGmUYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Greg,

On 11/4/2022 9:19 PM, Trilok Soni wrote:
> On 11/4/2022 3:38 PM, Elliot Berman wrote:
>>
>>
>> On 11/4/2022 1:10 AM, Arnd Bergmann wrote:
>>> On Fri, Nov 4, 2022, at 01:11, Elliot Berman wrote:
>>>> On 11/2/2022 5:24 PM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Nov 02, 2022 at 11:45:12AM -0700, Elliot Berman wrote:
>>>>>
>>>>> Even if you don't support it 1:1, at least for the ones that are the
>>>>> same thing, pick the same numbers as that's a nicer thing to do, 
>>>>> right?
>>>>>
>>>>
>>>> Does same thing == interpretation of arguments is the same? For
>>>> instance, GH_CREATE_VM and KVM_CREATE_VM interpret the arguments
>>>> differently. Same for KVM_SET_USERSPACE_MEMORY. The high level
>>>> functionality should be similar for most all hypervisors since they 
>>>> will
>>>> all support creating a VM and probably sharing memory with that VM. The
>>>> arguments for that will necessarily look similar, but they will 
>>>> probably
>>>> be subtly different because the hypervisors support different features.
>>>
>>> I think in the ideal case, you should make the arguments and the
>>> command codes the same for any command where that is possible. If
>>> you come across a command that is shared with KVM but just needs
>>> another flag, that would involve coordinating with the KVM maintainers
>>> about sharing the definition so the same flag does not get reused
>>> in an incompatible way.
>>>
>>
>> I think the converse also needs to be true; KVM would need to check that
>> new flags don't get used in some incompatible way with Gunyah, even if
>> one of us is just -EINVAL'ing. I don't think Gunyah and KVM should be
>> reliant on the other reviewing shared ioctls.
>>
>> The problem is a bit worse because "machine type" is architecture-
>> dependent whereas the planned Gunyah flags are architecture-independent.
>> KVM within itself re-uses flags between architectures so Gunyah would
>> need to reserve some flags from all architectures that KVM supports.
> 
> I agree w/ Elliot. We would like to keep Gunyah independent and not rely 
> on the existing KVM ioctls space. We should allow new hypervisor drivers 
> interfaces addition in Linux kernel without them relying on KVM.
> 
>>
>>> For commands that cannot fit into the existing definition, there
>>> should be a different command code, using your own namespace and
>>> not the 0xAE block that KVM has. It still makes sense to follow
>>> the argument structure roughly here, unless there is a technical
>>> reason for making it different.
>>>
>>>> I don't think userspace that supports both KVM and Gunyah will benefit
>>>> much from re-using the same numbers since those re-used ioctl calls
>>>> still need to sit within the context of a Gunyah VM.
>>>
>>> One immediate benefit is for tools that work on running processes,
>>> such as strace, gdb or qemu-user. If they encounter a known command,
>>> they can correctly display the arguments etc.
>>>
>>
>> We can update these tools and anyway there will be different ioctls to
>> get started. There are important ioctls that wouldn't be correctly
>> displayed off the bat anyway; work would need to be done to support the
>> Gunyah ioctls either way. Whereas tooling update is temporary, the
>> coupling of KVM and Gunyah ioctls would be permanent.
> 
> Agree, tools can be updated and that is the easy part as we grow the s/w 
> stack around Gunyah in userspace, like we already do w/ CrosVM (Virtual 
> Machine Manager) and QEMU will be next followed by rust-vmm. All of them 
> can be done without Gunyah ioctls relying anything on the KVM ioctls. 
> Elliot has also explained very well that we don't to go to KVM 
> maintainers for any of our additions and we also don't want them to come 
> to us, since there is no interoperability testing. It is best that both 
> Hypervisors and their Linux interfaces evolve independently.

Are above explanations reasonable to not re-use KVM ioctl numbers?

Thanks,
Elliot
