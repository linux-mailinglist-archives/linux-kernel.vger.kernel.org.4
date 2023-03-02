Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556FD6A7F35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCBJ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCBJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:56:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9B15543;
        Thu,  2 Mar 2023 01:56:29 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229YFLd014826;
        Thu, 2 Mar 2023 09:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=YSL8PIvsEULRIHWIOnANmoDoFzlGhSKEBLvUCGt5U3k=;
 b=ZApQzhtn1NCx5KzX5sPMya4Qte8ii1+0V33LZ138GyIEsxVvE7ocPNTZW3y+wXMOARtt
 LVhsQzYJm/bJzgXC6UQyCVPmqyfQP6HI6EATyyZ1Mjf1FWguxhx8bvUIEn2SqqIFIhjP
 q9linKy9gIBhK/tL3RmUfUreGmoL3xW2EzmiXJCcZiG/3ksUsk6gGWSUnPn5rfsW6G/t
 gbqd3MFejtxwfh/nADWMBAIetqJ8JXucdiu/U9c17R8b2F4VZAj7JhLWvNtMXGk0kVOT
 MC7+toWD8UVdWfH5D2++BBlJ2peRtHiwiXbZ7E7knZNhHf7j9n+/W8k92kU7QPlhuzT4 pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2ar125vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 09:56:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3229uNSW028432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 09:56:23 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 01:56:21 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mpubbise@qti.qualcomm.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH v2 0/2] Update the channel list if the change in channel flags 
Date:   Thu, 2 Mar 2023 15:25:49 +0530
Message-ID: <20230302095551.5510-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gjtb1_ME9_JF8CT7LQFKgwp_CNKnluQI
X-Proofpoint-ORIG-GUID: gjtb1_ME9_JF8CT7LQFKgwp_CNKnluQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_04,2023-03-02_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=813 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are connection failures in hidden SSID case when the device is with
default reg domain WW.
For WW reg domain most of the 5 GHz channels are passive. When device
listens to the beacon on that channel, the driver is updating its channel
flag but firmware is not aware of it and firmware is not sending probes
on that channels.
Due to this, we are seeing connection failures when the device is tries to
connect with hidden SSID AP.
Whenever the driver detects a channel flag change, send the updated channel
list command to the firmware.

Changes from v1:
 - Added the documentation for notifier call back.
 - Passed channel context as argument for notifier.

Youghandhar Chintala (2):
  wifi: cfg80211: Add beacon hint notifier support
  wifi: ath10k: update the channel list if change in channel flags.

 drivers/net/wireless/ath/ath10k/mac.c | 11 +++++++++++
 include/net/cfg80211.h                |  7 +++++++
 net/wireless/reg.c                    |  5 ++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.38.0

