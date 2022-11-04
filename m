Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D777B618D21
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKDALq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:11:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4EF1EEC2;
        Thu,  3 Nov 2022 17:11:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3NPaL5002973;
        Fri, 4 Nov 2022 00:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9um3ZqpDt41HPVHjQIIDyCNQp1mkqmYAWnmHFIiqcqg=;
 b=TJY2YdUCBPRkFGI+qord3bqcXfQbmjmXlIDTC5RFGzMC36RN2++mEb1QwsZsWTM3IZAz
 NPiIIp4F03m4ubxE6yS7CrJCNh29g3t+ia3VcQT+etjMvfoKiKjFWu523hcbGmqv3iFn
 MNWPjCdspDJwEbB74akki60rgpMiWF7UzcxfRakt5yCHe2F8Qp9B5D72uOT0TlczRN5+
 XPUYxkNIKhmrRiiynnwhlbV1Z3el43LvDFMRM4vwVnukvX6b/zJ2efaG9S6qxm+6H615
 A+cD+A7xRwg1pv1it/eJyBmh3sejemhXgI/2H+Oc7PaXabmlraNYgpkAK4KMrOAS5E14 xA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmq0f03gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 00:11:23 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A40BMSJ007251
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 00:11:22 GMT
Received: from [10.110.42.219] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 3 Nov 2022
 17:11:21 -0700
Message-ID: <96238455-73b6-bead-0fdb-55ca68e5bf0b@quicinc.com>
Date:   Thu, 3 Nov 2022 17:11:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
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
        "Arnd Bergmann" <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <Y2H8oh7AvYDiMqKs@kroah.com>
 <722b05a1-4bf5-0837-baea-b1d0a9cc1e43@quicinc.com>
 <Y2MKWOihjAPxfl6v@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y2MKWOihjAPxfl6v@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ionMH-UFMBFFVCX6rmfZ0BCak8qJtsx
X-Proofpoint-ORIG-GUID: 7ionMH-UFMBFFVCX6rmfZ0BCak8qJtsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=782
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 5:24 PM, Greg Kroah-Hartman wrote:
> On Wed, Nov 02, 2022 at 11:45:12AM -0700, Elliot Berman wrote:
>> +Michael
>>
>> On 11/1/2022 10:14 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Oct 26, 2022 at 11:58:38AM -0700, Elliot Berman wrote:
>>>> +#define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x40) /* Returns a Gunyah VM fd */
>>>
>>> Why 0x40?  Why not just use the same KVM ioctl numbers and names as you
>>> are doing the same thing as them, right?
>>
>> We've designed so that there are a few ioctls that will feel similar to KVM
>> ioctls since we know this design has been successful, but we don't intend to
>> support KVM ioctls 1:1. Gunyah has different semantics for many of the
>> name-identical ioctls. It seems odd to mix some re-used KVM ioctls with
>> novel Gunyah ioctls?
> 
> Even if you don't support it 1:1, at least for the ones that are the
> same thing, pick the same numbers as that's a nicer thing to do, right?
> 

Does same thing == interpretation of arguments is the same? For
instance, GH_CREATE_VM and KVM_CREATE_VM interpret the arguments
differently. Same for KVM_SET_USERSPACE_MEMORY. The high level 
functionality should be similar for most all hypervisors since they will 
all support creating a VM and probably sharing memory with that VM. The 
arguments for that will necessarily look similar, but they will probably 
be subtly different because the hypervisors support different features.

I don't think userspace that supports both KVM and Gunyah will benefit 
much from re-using the same numbers since those re-used ioctl calls 
still need to sit within the context of a Gunyah VM.

Thanks,
Elliot
