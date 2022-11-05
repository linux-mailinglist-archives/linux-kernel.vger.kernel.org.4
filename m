Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6105961A77C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 05:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiKEETu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 00:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEETr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:19:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F4F25C5F;
        Fri,  4 Nov 2022 21:19:46 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A549KRm009176;
        Sat, 5 Nov 2022 04:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rVE969ogytLqBE1VG7Ut5W0MADRp4Pwg8YyYhTSqUIU=;
 b=UWfd7D3XfTDRQowpKnPwjyAnX7ExKR4UkxTJRaIk4Z60W1gYwvNX4qY2fASRc1cowmJu
 BwRHzslwrYfUQKb4rKBdkWXCTfSpMM2PMIH56mot5k/UkSe4iiNmsTZdUFg9eH9+SBM0
 5/g3qY7ozdGlQP8AbZLzHVzjbbZ6r7SQoKe7N5RFeloBjF/2yhn2VtUcBi4kIcCql/ly
 2U/FH2770cpQdoBkC8GPv/X8Pg71t7H0mledAm+U4yBke+16Pd4amyMf9gMTqu/viVej
 clhtyHRb+3/5Za4ztEgNMrZLY+TYdr7+iwTQVLgs3ZKXBJhaLyOumQXGUBCW3VFqZqzU dQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kneswr504-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Nov 2022 04:19:27 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A54JQLB027279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Nov 2022 04:19:26 GMT
Received: from [10.110.19.49] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 4 Nov 2022
 21:19:25 -0700
Message-ID: <95a9f253-984a-14e0-7e01-f168452576c4@quicinc.com>
Date:   Fri, 4 Nov 2022 21:19:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <980db147-794e-ecd9-9626-64ff81109bab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oMN8xX8RjMfaonXf2jb0_V1n3cX4SrZn
X-Proofpoint-ORIG-GUID: oMN8xX8RjMfaonXf2jb0_V1n3cX4SrZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-05_01,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211050031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/2022 3:38 PM, Elliot Berman wrote:
> 
> 
> On 11/4/2022 1:10 AM, Arnd Bergmann wrote:
>> On Fri, Nov 4, 2022, at 01:11, Elliot Berman wrote:
>>> On 11/2/2022 5:24 PM, Greg Kroah-Hartman wrote:
>>>> On Wed, Nov 02, 2022 at 11:45:12AM -0700, Elliot Berman wrote:
>>>>
>>>> Even if you don't support it 1:1, at least for the ones that are the
>>>> same thing, pick the same numbers as that's a nicer thing to do, right?
>>>>
>>>
>>> Does same thing == interpretation of arguments is the same? For
>>> instance, GH_CREATE_VM and KVM_CREATE_VM interpret the arguments
>>> differently. Same for KVM_SET_USERSPACE_MEMORY. The high level
>>> functionality should be similar for most all hypervisors since they will
>>> all support creating a VM and probably sharing memory with that VM. The
>>> arguments for that will necessarily look similar, but they will probably
>>> be subtly different because the hypervisors support different features.
>>
>> I think in the ideal case, you should make the arguments and the
>> command codes the same for any command where that is possible. If
>> you come across a command that is shared with KVM but just needs
>> another flag, that would involve coordinating with the KVM maintainers
>> about sharing the definition so the same flag does not get reused
>> in an incompatible way.
>>
> 
> I think the converse also needs to be true; KVM would need to check that
> new flags don't get used in some incompatible way with Gunyah, even if
> one of us is just -EINVAL'ing. I don't think Gunyah and KVM should be
> reliant on the other reviewing shared ioctls.
> 
> The problem is a bit worse because "machine type" is architecture-
> dependent whereas the planned Gunyah flags are architecture-independent.
> KVM within itself re-uses flags between architectures so Gunyah would
> need to reserve some flags from all architectures that KVM supports.

I agree w/ Elliot. We would like to keep Gunyah independent and not rely 
on the existing KVM ioctls space. We should allow new hypervisor drivers 
interfaces addition in Linux kernel without them relying on KVM.

> 
>> For commands that cannot fit into the existing definition, there
>> should be a different command code, using your own namespace and
>> not the 0xAE block that KVM has. It still makes sense to follow
>> the argument structure roughly here, unless there is a technical
>> reason for making it different.
>>
>>> I don't think userspace that supports both KVM and Gunyah will benefit
>>> much from re-using the same numbers since those re-used ioctl calls
>>> still need to sit within the context of a Gunyah VM.
>>
>> One immediate benefit is for tools that work on running processes,
>> such as strace, gdb or qemu-user. If they encounter a known command,
>> they can correctly display the arguments etc.
>>
> 
> We can update these tools and anyway there will be different ioctls to
> get started. There are important ioctls that wouldn't be correctly
> displayed off the bat anyway; work would need to be done to support the
> Gunyah ioctls either way. Whereas tooling update is temporary, the
> coupling of KVM and Gunyah ioctls would be permanent.

Agree, tools can be updated and that is the easy part as we grow the s/w 
stack around Gunyah in userspace, like we already do w/ CrosVM (Virtual 
Machine Manager) and QEMU will be next followed by rust-vmm. All of them 
can be done without Gunyah ioctls relying anything on the KVM ioctls. 
Elliot has also explained very well that we don't to go to KVM 
maintainers for any of our additions and we also don't want them to come 
to us, since there is no interoperability testing. It is best that both 
Hypervisors and their Linux interfaces evolve independently.

---Trilok Soni
