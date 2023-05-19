Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6F709C99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjESQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjESQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:39:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B21D1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:39:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDR7Qo024834;
        Fri, 19 May 2023 16:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=kgDDoBNwxvR277BxCyv7koD/uI+FCD5MDKi5umWHI6A=;
 b=V1TRaFijUqb9pIF08MD+X/VzNEF2oT9EwZ5DQn5rCzgO+V0ilO7nyjLut6Do6qw+/4+H
 fYBtaqKVSxs7I3otNk2DAp3y2pbH9Ur8qBznQON58s3i15pHE7HPIwVnIMNNRHEQG4Ui
 1gsDYQJYK7jk7YNPAIgOUKiYnmPcIKR1e2IcM/InkP1SKbX5lOWNCGo/JTVKUhM58i9m
 8Lfq+Fd8UmK91kQ3jOSStCMJKvXRfq3bX0xOGLzpJ1v6LshmnduopCchRQtysOuL7Yq7
 VLfmk9/gI0sbQL8iiykKyWaeOiQMMxxYfob+NmJQC2wLX10SjBEJghFT1KfksXa2dnWX 9A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnwk4j0dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 16:39:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JGdL0m001824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 16:39:21 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 09:39:20 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <mhi@lists.linux.dev>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v2 0/2] Add MHI quirk for QAIC
Date:   Fri, 19 May 2023 10:39:00 -0600
Message-ID: <20230519163902.4170-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gy5WM1UCc3CbqIwU-6Q00Cn-2tX_UmbJ
X-Proofpoint-ORIG-GUID: Gy5WM1UCc3CbqIwU-6Q00Cn-2tX_UmbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=732 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the QAIC driver in -next, I'd like to suggest some MHI changes that
specific to AIC100 devices, but perhaps provide a framework for other
device oddities.

AIC100 devices technically violate the MHI spec in two ways. Sadly, these
issues comes from the device hardware, so host SW needs to work around
them.

Thie first issue, presented in this series, has to do with the
SOC_HW_VERSION register. This register is suposed to be initialized by the
hardware prior to the MHI being accessable by the host to contain a
version string for the SoC of the device. This could be used by the host
MHI controller software to identify and handle version to version changes.
The AIC100 hardware does not initialize this register, and thus it
contains garbage.

This would not be much of a problem normally - the QAIC driver would just
never use it. However the MHI stack uses this register as part of the init
sequence and if the controller reports that the register is inaccessable
then the init sequence fails.  On some AIC100 cards, the garbage value
ends up being 0xFFFFFFFF which is PCIe spec defined to be a special value
indicating the access failed.  The MHI controller cannot tell if that
value is a PCIe link issue, or just garbage.

QAIC needs a way to tell MHI not to use this register. Other buses have a
quirk mechanism - a way to describe oddities in a particular
implementation that have some kind of workaround. Since this seems to be
the first need for such a thing in MHI, introduce a quirk framework.

The second issue AIC100 has involves the PK Hash registers. A solution for
this is expected to be proposed in the near future and is anticipated to
make use of the quirk framework proposed here. With PK Hash, there are two
oddities to handle. AIC100 does not initialize these registers until the
SBL is running, which is later than the spec indicates, and in practice
is after MHI reads/caches them. Also, AIC100 does not have enough
registers defined to fully report the 5 PK Hash slots, so a custom
reporting format is defined by the device.

v2:
-Fix build error
-Fix typo in commit text

Jeffrey Hugo (2):
  bus: mhi: host: Add quirk framework and initial quirk
  accel/qaic: Add MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE

 drivers/accel/qaic/mhi_controller.c |  1 +
 drivers/bus/mhi/host/init.c         | 13 +++++++++----
 include/linux/mhi.h                 | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.40.1

