Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBE747FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGEIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGEIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:35:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA9133;
        Wed,  5 Jul 2023 01:35:49 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3657mcCN011803;
        Wed, 5 Jul 2023 08:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b9Q5DgA18maSgdhrRWyHGDfLPIo6E2sL0af51kbX5pM=;
 b=RVeUCbF7K4WkNmaZ/X0cM+/J9swicp2TLtTDRNCD6Lg7AnEvsY+56C1pd5iisRUMYdcx
 mapLQ+FYflA2hgcWIKoeUu6xVbHdHnlryuVOAXHI8fZShLuj1Ta1Aoz79SbOXK+5iXon
 EkA4/FtrnxIVo0+MoU1mEZYLDCCYSNo9gLOOUcay7RSPWDE0lBpfi0CualsHVRxuW3th
 Wx7sm/ZRHe0hiATESDGJorCs9Qt+9bsWHwSsLJ6u8Nww8bwZ94B3+R6I7InmEgyRWhSN
 o4gO0eIEFO9RMJWL/A4803O1bv7gqMqvIAU/4sRpPNoy8wN+CONA9MOeJoSLXo4yBM3w Ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmnw6h8sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 08:35:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3658ZXjo012897
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 08:35:33 GMT
Received: from [10.253.8.233] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 5 Jul 2023
 01:35:31 -0700
Message-ID: <68ec9a1e-81d3-93b9-d68f-47df07db8965@quicinc.com>
Date:   Wed, 5 Jul 2023 16:35:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/2] net: phy: at803x: support qca8081 1G chip type
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230704090016.7757-1-quic_luoj@quicinc.com>
 <20230704090016.7757-2-quic_luoj@quicinc.com>
 <66a5f898-e3fd-460a-b604-bb11a000e4e9@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <66a5f898-e3fd-460a-b604-bb11a000e4e9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E2ZpSe5mr7u-ak0tnqLCNjHJyML0soyQ
X-Proofpoint-ORIG-GUID: E2ZpSe5mr7u-ak0tnqLCNjHJyML0soyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050078
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/2023 7:24 AM, Andrew Lunn wrote:
> On Tue, Jul 04, 2023 at 05:00:15PM +0800, Luo Jie wrote:
>> The qca8081 1G chip version does not support 2.5 capability, which
>> is distinguished from qca8081 2.5G chip according to the bit0 of
>> register mmd7.0x901d.
>>
>> The fast retrain and master slave seed configs are only needed when
>> the 2.5G capability is supported.
>>
>> Switch to use genphy_c45_pma_read_abilities for .get_features API.
> 
> It is better to have lots of small patches, each doing one thing. If
> something regresses, a git bisect gives a much finer idea where the
> problem is. It is also easier to review small patches with good commit
> messages.
> 
> So please break this patch up.

Ok, i will split this patch to small patches, thanks for the suggestion.

> 
>> -	/* Configure lower ramdom seed to make phy linked as slave mode */
>> -	ret = qca808x_phy_ms_random_seed_set(phydev);
>> -	if (ret)
>> -		return ret;
>> +		/* Configure lower ramdom seed to make phy linked as slave mode */
>> +		ret = qca808x_phy_ms_random_seed_set(phydev);
>> +		if (ret)
>> +			return ret;
> 
> Shouldn't this depend on how MDIO_MMD_AN, MDIO_AN_T1_ADV_L bit
> MDIO_AN_T1_ADV_M_MST is set? Maybe the user wants it to prefer master
> rather than slave?
> 
> I know you are just trying to move code around, but it does seem like
> a good time to also improve the code.
> 
> FYI: net-next is closed at the moment. Officially you should post as
> RFC, or wait until it opens again.
> 
>    Andrew

Hi Andrew,
The master/slave configuration/status is only existed in MII reg9, 10 on 
qca8081 PHY, which is not existed in MDIO_MMD_AN or MDIO_MMD_PMAPMD, i 
will improve this code according to the user's prefer master/slave 
configuration in the next patch series.

Thanks for the reminder of close window, i will upload the patches after 
the open of next window.

