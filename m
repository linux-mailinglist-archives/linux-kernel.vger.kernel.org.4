Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0541974355D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjF3Gyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjF3Gyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:54:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C92D52;
        Thu, 29 Jun 2023 23:54:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U5eTvb029105;
        Fri, 30 Jun 2023 06:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zRdrPmSxyjSjwqK+afzJqmmKXeL4XjLsfk/Rlu+siWM=;
 b=eGPin1XD6lyY5yL2VzCxTdE+eNAOxPOoNQw4CP4WOOGNX7wb1n+7UjDBp0az2V8kqdSt
 /wLDave/vX3AP2NnPmmdqBPQg974wXlLIk6HoxqMrtLaUY2szv12HbH2gPSOBFD9h+q8
 GVj/D+Bg+AVGoL7VpGLriN+tQhCiOBnYNXoVfhmQTrJzpiO88lRkty6iurnGEfxVu3uE
 XvOEG7iTECDiSVYCdrMsH/GY6PPkDuyWk9HQ5ducqtjowVOsY3h0e82oBKEU2VCj4dxW
 YMo5JvVwl0AFEO1wGziCPibPznziny0//P5enX0tSnL4QYBeAVtx8IgZxCbU46S44Iz0 vQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgy1tk38d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 06:54:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U6s7vN032684
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 06:54:07 GMT
Received: from [10.253.74.51] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Thu, 29 Jun
 2023 23:54:04 -0700
Message-ID: <0f3990de-7c72-99d8-5a93-3b7eaa066e49@quicinc.com>
Date:   Fri, 30 Jun 2023 14:54:02 +0800
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
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <e1cf3666-fecc-4272-b91b-5921ada45ade@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WXwQ74m6aA8A5PCKYRlAE9YeuO_SBOpg
X-Proofpoint-GUID: WXwQ74m6aA8A5PCKYRlAE9YeuO_SBOpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=597 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300059
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 9:23 PM, Andrew Lunn wrote:
>> +static int qca808x_fifo_reset(struct phy_device *phydev)
>> +{
>> +	/* Reset serdes fifo on link down, Release serdes fifo on link up,
>> +	 * the serdes address is phy address added by 1.
>> +	 */
>> +	return mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
>> +			MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
>> +			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
> 
> In polling mode, this is going to be called once per second. Do you
> really want to be setting that register all the time? Consider using
> the link_change_notify callback.
> 
> Also, can you tell us more about this SERDES device on the bus. I just
> want to make sure this is not a PCS and should have its own driver.
> 
>       Andrew
Hi Andrew,
Thanks for the review.
yes, we can use the link_change_notify, since the fifo reset is needed 
on the link changed, i will update the patch to use link_change_notify.

SERDES device is the block converts data between serial data and 
parallel interfaces in each direction, which is the SGMII interface in 
qca8081 PHY, it's address is always the PHY address added by 1 in 
qca8081 PHY.
