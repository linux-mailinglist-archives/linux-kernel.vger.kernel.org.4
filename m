Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAE744A53
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGAPpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGAPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:45:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6242686;
        Sat,  1 Jul 2023 08:45:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 361FgEAi015314;
        Sat, 1 Jul 2023 15:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h/XryedWCGvhLgCpbQHnyuG4JAfrMRU14lrm6sbrl0c=;
 b=Eb4nAKUmAMYLNBw8VRE1mV8AO6xxmTDSrz1SgAtpAclvk9ugwt0sDGQhJJ4F9zzSvQ2G
 otVLYf3ZE/k1ijHhtFo7vh1h4gO8Ux5HkxeC0fVa/GM74NXY97a0/rBoDBv7Bm+TR4uS
 WsHma16V5BT9/HJofqIApO+bX42jpgR2ewgFVXdNQJ6xSoQrQ4vmoErmX43pMas8GITJ
 QqtDN4pQms1ABEMpf7+lKEz6MgYO17FTlRtbCdSmDq/XT24h/KrwSwY7Deb2uHCbT1qD
 tCEUj9JB3E5LnuWRczB1LG7nL8dxp+0EGhqanDpUmJSGn19RiXqTADmF42ZoIRAePt6b QA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rj9umh5kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Jul 2023 15:44:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 361FiqBN029610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Jul 2023 15:44:52 GMT
Received: from [10.253.13.42] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sat, 1 Jul 2023
 08:44:46 -0700
Message-ID: <49f8ca40-e079-ad00-256e-08a61ffced22@quicinc.com>
Date:   Sat, 1 Jul 2023 23:44:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] net: phy: at803x: add qca8081 fifo reset on the link
 down
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-4-quic_luoj@quicinc.com>
 <e1cf3666-fecc-4272-b91b-5921ada45ade@lunn.ch>
 <0f3990de-7c72-99d8-5a93-3b7eaa066e49@quicinc.com>
 <924ebd8b-2e1f-4060-8c66-4f4746e88696@lunn.ch>
 <7144731c-f4ae-99b6-d32a-1d0e39bc9ee7@quicinc.com>
 <d4043e1f-d683-48c2-af79-9fea14ab7cc1@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <d4043e1f-d683-48c2-af79-9fea14ab7cc1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hnzGu5DvQj1kn3Mc_mXq6crkiUPKWeeR
X-Proofpoint-ORIG-GUID: hnzGu5DvQj1kn3Mc_mXq6crkiUPKWeeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-01_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=474 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307010151
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2023 10:34 PM, Andrew Lunn wrote:
>> Hi Andrew,
>> This block includes MII and MMD1 registers, which mainly configure the PLL
>> clocks, reset and calibration of the interface sgmii, there is no related
>> Clause 73 control register in this block.
> 
> O.K. What does it have in the MII ID registers? Does Linux think it is
> a PHY and instantiating an generic PHY driver for it?
> 
> 	Andrew
Hi Andrew,
it is the PLL related registers, there is no PHY ID existed in MII 
register 2, 3 of this block, so it can't be instantiated as the generic 
PHY device.
