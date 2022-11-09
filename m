Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04506623402
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiKIT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKIT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:57:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C72F00A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:57:54 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9Jn7qf018415;
        Wed, 9 Nov 2022 19:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=myHppXYv+tVrjK8QfFQ1K+zoLS6d5fd/tIEWHucmWbc=;
 b=NgP3BElhz2a4MqmU3AftzIRIJIxvrIofv9r9Vycl3gzKfBHHt0T6RlDV5Tgswx8XAVvz
 aJ1qRchBwnpfGBrpPJPbnX6aDeqRVLL2Z5xhczHEHdAsflD3BsoF4YV7skCP9OCMFF1u
 LBdyXqcz2LwClHe1RDlNmvUU9Qnl6H3IDom9uQ+oTCRGqxR99/6YEU5cEZK1rrq5hf85
 hsiO6EyMnUL9wXSH7IMhnFdEng3k7RzZx3PQESoA+p81b3adqrvuIHwz7MZgnPRJM9zB
 jWp03uYYd0mbtWQD4fKj2fEKy6OY0B0Xp7fEti0O6O90BEw2G6WSZrg6DygaLDQjboHn eQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krg8agcw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 19:57:32 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A9JvV3H017108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 19:57:31 GMT
Received: from [10.216.43.221] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 9 Nov 2022
 11:57:28 -0800
Message-ID: <8d6f41f6-96ae-2f34-4bc7-58b63bf55159@quicinc.com>
Date:   Thu, 10 Nov 2022 01:27:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Query on handling some special Group0 interrupt in Linux
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
References: <d7b70de6-cd7f-3724-3449-5b838a478277@quicinc.com>
 <86tu38oupr.wl-maz@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <86tu38oupr.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c7dfpCVaHnYeXp5bv-zRyFA7RAjDxaz1
X-Proofpoint-ORIG-GUID: c7dfpCVaHnYeXp5bv-zRyFA7RAjDxaz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=753 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for your reply.

On 11/9/2022 11:50 PM, Marc Zyngier wrote:
> On Wed, 09 Nov 2022 16:20:35 +0000,
> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> Hi,
>>
>> I was working on a use case where both el2/el3 are implemented and we
>> have a watchdog interrupt (SPI), which is used for detecting software
>> hangs and cause device reset; If that interrupt's current cpu affinity
>> is on a core, where interrupts are disabled, we won't be able to serve
>> it or if this interrupt comes on a core which has interrupt enabled,
>> calling panic() or with smp_send_stop(), we would not be able
>> to know the call stack of the other cores which is running with
>> interrupt disabled.
>>
>> I was thinking of configuring both a watchdog irq(SPI) and IPI_STOP
>> (SGI) or any reserve IPI as an FIQ. And from the watchdog irq handler,
>> I was thinking of calling panic() which eventually sends IPI_STOP(SGI
>> FIQ) to all the cores. And with this we will able to dump all the core
>> call stack.
>>
>> I am able to achieve this but wanted to know if this is acceptable to
>> the community to support/allow such use cases like above and enable
>> group0 interrupt from GIC for some special use cases.
> 
> For a start, we only deal with Group-1 interrupts in Linux. Group-0
> interrupts are for the firmware, and we really don't want to see them
> (this is consistent with your HW having EL3). 

What is the downside of it we support this ? I see one of the 
implementation here.

https://elixir.bootlin.com/linux/v6.0.7/source/drivers/irqchip/irq-apple-aic.c#L510

>We also mask IRQ and FIQ at the same time, so this is a non-starter.
This can be taken care if we support this.

> 
> If you want to be able to deliver an interrupt while the interrupts
> are masked, what you are looking for is the NMI framework, for which
> you can register SPIs as (pseudo-)NMI.

Yes, kind of NMI.
I have already looked into this.
Since, in our system El2 is implemented and each physical interrupt get 
routed to hypervisor and later vIrq comes to El1 and each interrupt 
enable/disable call exercise pmr register trap can cause latency in
regular run(like multiple VM).

Since, some of the use-case could be special like i have mentioned
in my initial mail where such interrupt will be fatal and system will
get reset after that. I am not able to think of any other use case than
this but can this not be considered as one of the feature.

> 
> This is of course assuming that you're using GICv3. If you're using an
> older version of the architecture, we don't have a good solution for
> you, unfortunately.
> 

we are using GICv3.

> Thanks,
> 
> 	M.
> 

-Mukesh
