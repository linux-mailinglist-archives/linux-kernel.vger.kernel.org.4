Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BC17447D8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGAIBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAIBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:01:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE5199;
        Sat,  1 Jul 2023 01:01:16 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3616PCoZ001008;
        Sat, 1 Jul 2023 08:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Bq5K7rcso76FRnQUINGc4ahi8qb9RXnchsW7X7lm+qw=;
 b=p4ugohzsN/JD9Vqb6ORg6pbmfB9hg9EUICGRNmtJO0qVjhujZa7IQM5jX6I+YnyI1xIP
 TTlCtpVGp0boe536oVQeTvyJgF78NpYQgz91WmU5Y81BmQk/y8Dk6zXo5XPDriTolq91
 9L72vWZz/0KdQw2Kj5xnLgbgMKSYfHubCe1SgosmcCmMcZXR3WwRsPC7ZzyGa0FBOkOp
 qULevOl3fVuXN+appvPA9oR0gEfs1M68717HELs2EIKROBUsrZwo5m63fouN0svwaONo
 ReWBJf7WKAM22RY5jkL4nqfAMHdf+fUI4JA5OSp5pxcHsviUqg3nXIshxKTInIevUSjr ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjbrd0h3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Jul 2023 08:01:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 361811La005784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Jul 2023 08:01:01 GMT
Received: from [10.253.13.42] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sat, 1 Jul 2023
 01:00:59 -0700
Message-ID: <bcedc53f-9393-2bd5-4f37-5a3f02c41887@quicinc.com>
Date:   Sat, 1 Jul 2023 16:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] net: phy: at803x: support qca8081 1G chip type
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-2-quic_luoj@quicinc.com>
 <48e41540-6857-4f61-bcc5-4d0a6dbb9ec1@lunn.ch>
 <b735b442-8818-c66e-5498-9faa2e4984f2@quicinc.com>
 <c2e8eeac-7e2b-48fa-bdf8-fa036e40a8a2@lunn.ch>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <c2e8eeac-7e2b-48fa-bdf8-fa036e40a8a2@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i3R6QwhnNkKOiJY24dpfly6mwKuUDhP2
X-Proofpoint-ORIG-GUID: i3R6QwhnNkKOiJY24dpfly6mwKuUDhP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-01_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=386 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307010075
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2023 9:16 PM, Andrew Lunn wrote:
> On Fri, Jun 30, 2023 at 02:39:06PM +0800, Jie Luo wrote:
>>
>>
>> On 6/29/2023 9:14 PM, Andrew Lunn wrote:
>>> On Thu, Jun 29, 2023 at 11:48:44AM +0800, Luo Jie wrote:
>>>> The qca8081 1G chip version does not support 2.5 capability, which
>>>> is distinguished from qca8081 2.5G chip according to the bit0 of
>>>> register mmd7.0x901d.
>>>>
>>>> The fast retrain and master slave seed configs are only needed when
>>>> the 2.5G capability is supported.
>>>
>>> Does genphy_c45_pma_read_abilities() work on these devices?
>>>
>>>        Andrew
>>
>> Hi Andrew,
>> yes, genphy_c45_pma_read_abilities works on both normal qca8081 2.5G chip
>> and qca8081 1G version chip, even the PHY ID is same, the only difference
>> between qca8081 1G and 2.5G chip is the 2.5G capability removed on 1G
>> version chip.
> 
> Great, then please use it to simply the driver.
> 
>         Andrew
Hi Andrew,
Per double check qca8081 PHY registers, the PHY ID only exists in the 
MII register, which is not in the MMD device register.

There are MMD device 1, 3, 7 in qca8081 PHY, the PMA abilities 
10/100/1000/2500 are compliant with genphy_c45_pma_read_abilities, but 
the MDIO_AN_STAT1_ABLE does not exist in MMD7.1 register.

so the genphy_c45_pma_read_abilities can't be fully supported by qca8081 
phy, sorry for this misunderstanding.
