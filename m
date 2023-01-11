Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8C665132
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjAKBqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAKBqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:46:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21EEF5C;
        Tue, 10 Jan 2023 17:46:11 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1CNDe020383;
        Wed, 11 Jan 2023 01:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pvmm7Rctkc89Z25cuocd6Le1fJsQDZZv5dJqf9CDfPU=;
 b=gblG6qcaQmQhsCObzPMofNcqPxTpKKut0PDl/giRKZVpRPAw7J/Ynq67CMZbbGGU1xm2
 aZdaJ83o/EqqHxdhhtHtjSzKHMBP2uSnsybkHyhc/xsp4Xwxcbj4Smobt3RaGT3Fzvtc
 cUUxU9qSJzUhT8wCI5RSbj3OKF7Mjrh9PbsPpLNTU/kkLKGTVccFtjh8np4IODBUsWwp
 0YjR5bJNzNJRy+qnD/5Zyw9AriCR6Uo5QoCiX+2ddp6rftR061BtbKZiOJxCp9OrOvI5
 aT2j7S0AtNV00EP246bVxaPgJw0lZPYnItHJlp5ROUOReYOhkrdj7EMWbytnqnWc8OJe aQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k5k01rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 01:45:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30B1jw3t012279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 01:45:58 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 17:45:56 -0800
Message-ID: <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
Date:   Wed, 11 Jan 2023 09:45:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
References: <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
 <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
 <000201d920eb$c3715c50$4a5414f0$@samsung.com>
 <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
 <20230109182813.sle5h34wdgglnlph@synopsys.com>
 <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
 <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
 <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2sJN10Tyalrs1LVqe076jvcQhpYHQmar
X-Proofpoint-GUID: 2sJN10Tyalrs1LVqe076jvcQhpYHQmar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 malwarescore=0 spamscore=1
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=203
 clxscore=1015 bulkscore=0 mlxscore=1 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/11/2023 8:00 AM, Thinh Nguyen wrote:
>
>> one more question, is it legacy PCIe device still exist in real world ? and
>> any VID/PID info ?
> Currently, all dwc3 PCIe devices are affected. Some setups are more


if non PCIe device have no such issue, can we do some improvement for it ?

like new flag or static key/jump label to improve interrupt handler ?


> noticeable than others. The dwc3 driver is implemented to probe platform
> devices. So, dwc3 PCIe devices are wrapped as platform devices for the
> dwc3 driver. Since we're going through the platform device code path,
> the pci layer falls back to using legacy interrupt instead of MSI (last
> I check awhile ago).
>
> A little more detail on this problem:
> PCIe legacy interrupt will emulate interrupt line by sending an
> interrupt assert and deassert messages. After the interrupt assert
> message is sent, interrupts are continuously generated until the
> deassert message is sent. If there's a register write to unmask/mask
> interrupt or clearing events falls in between these messages, then there
> may be a race.
>
> Let's say we don't have event pending check, this can happen:
>
> Normal scenario
> ---------------
>      event_count += n # controller generates new events
>    interrupt asserts
>      write(mask irq)
>      event_count -= n # dwc3 clears events
>    interrupt deasserts
>      write(unmask irq)
>
>
> Race scenario
> -------------
>      event_count += n # new events
>    interrupt asserts
>      write(mask irq)
>      event_count -= n # clear events
>      event_count += n # more events come and hard irq handler gets called
> 		     # again as interrupt is generated, but cached
> 		     # events haven't been handled. This breaks
> 		     # serialization and causes lost events.
>      write(mask irq)
>
>      event_count -= n # clear events
>    interrupt deasserts
>      write(unmask irq) # events handled


if mask irq is not working, the race will happen like this, thanks for 
explanation.


>
> For MSI, this won't be a problem because it's edge-triggered and the way
> it sends interrupt is different.
>
> BR,
> Thinh
