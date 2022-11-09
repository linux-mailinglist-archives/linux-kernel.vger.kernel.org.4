Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3E62300E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiKIQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKIQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:21:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63E167F9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:21:09 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9GDS2l026158;
        Wed, 9 Nov 2022 16:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : to : cc : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=9+zn9aT3goQMYvYtzGmv91f9BqSf6p56HLa/mNlOKEU=;
 b=YLCPtbrONtA/SD/QAOtrmqXcdaPnKbr+QdnZvyMbzyV2MUOvLJS9CoRUB7HphGERBrV6
 55/0zjCeRUIIx3vGMQZXSe7k2jqveVEWpJ4NhFqteZEbnyNrW1uxZgMDDmlyCI/W1SfP
 tSd3dkLt3EjE4F++uopGdLr5OXeHHxfejrSRjTbyR2d4gvt86R7nRFXmmlEUpDUToBPM
 xGaip4cmNki8eA0EaQupK4CLaA+I8zYOteSIftilIZpEQQgPhx4n7q73ehW5QB6YnsV6
 DnWsiyJ3LjksOMNm44iFVd7bWjswXoUpYTJ8ED8HCmH5IGvD437GjNYCtotWcgNyvhe+ JA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr6b41p3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 16:20:44 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A9GKhq1001542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 16:20:43 GMT
Received: from [10.216.26.166] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 9 Nov 2022
 08:20:40 -0800
Message-ID: <d7b70de6-cd7f-3724-3449-5b838a478277@quicinc.com>
Date:   Wed, 9 Nov 2022 21:50:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     lkml <linux-kernel@vger.kernel.org>
Subject: Query on handling some special Group0 interrupt in Linux
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JIsw-B78DLroBkCTyipoW4J8UZJqGcFb
X-Proofpoint-ORIG-GUID: JIsw-B78DLroBkCTyipoW4J8UZJqGcFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 mlxlogscore=664 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was working on a use case where both el2/el3 are implemented and we 
have a watchdog interrupt (SPI), which is used for detecting software 
hangs and cause device reset; If that interrupt's current cpu affinity 
is on a core, where interrupts are disabled, we won't be able to serve 
it or if this interrupt comes on a core which has interrupt enabled, 
calling panic() or with smp_send_stop(), we would not be able
to know the call stack of the other cores which is running with 
interrupt disabled.

I was thinking of configuring both a watchdog irq(SPI) and IPI_STOP 
(SGI) or any reserve IPI as an FIQ. And from the watchdog irq handler,
I was thinking of calling panic() which eventually sends IPI_STOP(SGI 
FIQ) to all the cores. And with this we will able to dump all the core 
call stack.

I am able to achieve this but wanted to know if this is acceptable to 
the community to support/allow such use cases like above and enable 
group0 interrupt from GIC for some special use cases.

-Mukesh
