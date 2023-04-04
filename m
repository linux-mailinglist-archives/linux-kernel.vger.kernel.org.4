Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825B46D5969
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjDDHXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjDDHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:23:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866F1FF5;
        Tue,  4 Apr 2023 00:23:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3343QV9B005827;
        Tue, 4 Apr 2023 07:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=g5Ez/ME1s3fCg2PLZheuBcsYTG0hLfX78U6r4oUQSJQ=;
 b=bZ6+seTV1ISjYgOhuaOwgof24t4wRPOITdKiHFCjoNqaNksQFjBT/j8cBbnleL6x0VTu
 mP2eEipgOTnEqU/WABjNTfkS2BqHPOIKY4Q2ogI6OMqqnmEi03T8IMbfXfjEoJ+EJJA9
 tGglhm2WY4DS9gpO6BOllkqrBW8FLuu5FX3fcLnqZc3BAZ2tAFwTjPwratyKgjnhTVP0
 smSv704YiON5JKSwYulEZ3Mm8iGi4wNBqG9X/wye/d+EIiYiPWxq6i62JINtb4rBJfWO
 DMaZnIRsJ9x8PDF6G0vfSO2MxPq9KK8SgmNEX9N9HgIsRLEVBvHjUFZRpKuNfnlb1xzZ FQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqy6229nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 07:23:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3347N7t7031543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 07:23:07 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 00:23:04 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 0/3] wifi: ath11k: Fix incorrect signal avg in station dump on WCN6750
Date:   Tue, 4 Apr 2023 12:52:31 +0530
Message-ID: <20230404072234.18503-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XMyFJYNJRJWyiB5-YXX-YfwkSSm3IoS8
X-Proofpoint-ORIG-GUID: XMyFJYNJRJWyiB5-YXX-YfwkSSm3IoS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=365 phishscore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040066
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on WCN6750, the average signal printed in the station dump
has invalid values. This is happening because of multiple reasons
in the driver.

This patches fixes this problem.

Station dump without fixes:

iw dev wlan0 station dump
Station 2c:30:33:d2:93:3f (on wlan0)
	inactive time:  16428 ms
	rx bytes:       91417
	rx packets:     642
	tx bytes:       4715
	tx packets:     31
	tx retries:     59
	tx failed:      0
	beacon loss:    0
	beacon rx:      294
	rx drop misc:   22
	signal:         -16 [-21, -20] dBm
	signal avg:     -95 dBm
	beacon signal avg:      -15 dBm
	tx bitrate:     650.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 2
	tx duration:    0 us
	rx bitrate:     6.0 MBit/s
	rx duration:    0 us
	authorized:     yes
	authenticated:  yes
	associated:     yes
	preamble:       long
	WMM/WME:        yes
	MFP:            no
	TDLS peer:      no
	DTIM period:    2
	beacon interval:100
	short slot time:yes
	connected time: 64 seconds

Station dump with fixes:
iw wlan0 station dump
Station 2c:30:33:d2:93:3f (on wlan0)
	inactive time:  4328 ms
	rx bytes:       10245
	rx packets:     3211
	tx bytes:       10245
	tx packets:     102
	tx retries:     72
	tx failed:      0
	beacon loss:    0
	beacon rx:      1506
	rx drop misc:   29
	signal:         -36 [-37, -45] dBm
	signal avg:     -37 dBm
	beacon signal avg:      -34 dBm
	tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
	tx duration:    0 us
	rx duration:    512633 us
	authorized:     yes
	authenticated:  yes
	associated:     yes
	preamble:       long
	WMM/WME:        yes
	MFP:            no
	TDLS peer:      no
	DTIM period:    2
	beacon interval:100
	short slot time:yes

Youghandhar Chintala (3):
  wifi: ath11k: Use proper API to get peer id for WCN6750
  wifi: ath11k: Align RX MPDU info with the hardware for WCN6750
  wifi: ath11k: Populate the signal average field properly

 drivers/net/wireless/ath/ath11k/hal_rx.h |  4 ++--
 drivers/net/wireless/ath/ath11k/hw.c     |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c    | 11 +++++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.38.0

