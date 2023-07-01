Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7615B744A52
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGAPnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:43:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3D2686;
        Sat,  1 Jul 2023 08:43:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 361Fh07t007599;
        Sat, 1 Jul 2023 15:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HsTlqbRDu878dBuVfAk94J55u/pYjdRaAf6D7p8jU6Q=;
 b=grwX/0YBSlftntGXyg7x1BV/tT1QdNfjVBClVdUKgS9BEob0fSE0gXzacrHQ5mW7fHsK
 6nFKJB3QFtRO3aYyrqTvJjcIt0fDEQh9mmNi3OGfR/s2Cp867V2bZhNFGN7N9SJdxjhk
 IXnT+OnljBSzVdV3Mh32LDeFQB53xW9gHpNOOX69wFVuUIxSI+m9B9L2WFGDs0o/8FL8
 AMFw7qVhiYyKvjtjQgFKptNgC/q9slb1OlEzWWxl76UYl3oOYBNUWuTEFYXpzew8lyV3
 tQYPFLS2FtQ+5pfoDGWT38SRFg4blpKSuJ261v3069FyYj0mnog3PUUBbaodLQ+fiWcT Aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjday0wgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Jul 2023 15:43:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 361Fgx99010931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Jul 2023 15:42:59 GMT
Received: from [10.253.13.42] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sat, 1 Jul 2023
 08:42:57 -0700
Message-ID: <48ad596c-07ee-9721-7ae5-c524d8f4d3e7@quicinc.com>
Date:   Sat, 1 Jul 2023 23:42:55 +0800
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
 <bcedc53f-9393-2bd5-4f37-5a3f02c41887@quicinc.com>
 <3e0477e6-f96e-4842-a0c2-b2cb744ee83a@lunn.ch>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <3e0477e6-f96e-4842-a0c2-b2cb744ee83a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dis-XQJFY7mbb182TlV2frv8KhZe_duP
X-Proofpoint-GUID: Dis-XQJFY7mbb182TlV2frv8KhZe_duP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-01_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=560 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307010150
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2023 10:30 PM, Andrew Lunn wrote:
>> There are MMD device 1, 3, 7 in qca8081 PHY, the PMA abilities
>> 10/100/1000/2500 are compliant with genphy_c45_pma_read_abilities, but the
>> MDIO_AN_STAT1_ABLE does not exist in MMD7.1 register.
>>
>> so the genphy_c45_pma_read_abilities can't be fully supported by qca8081
>> phy, sorry for this misunderstanding.
> 
> If all you are missing is MDIO_AN_STAT1_ABLE, then i assume you are
> missing Autoneg? So have your tried using
> genphy_c45_pma_read_abilities() and then just doing:
> 
>                          linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>                                           phydev->supported);
> 
> with a comment explaining why.
> 
> 	Andrew					
Thanks Andrew for this suggestion, i will verify this code and update 
the patch series.
