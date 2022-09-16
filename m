Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06215BB347
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiIPULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIPULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:11:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D09A6C24;
        Fri, 16 Sep 2022 13:11:45 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GG33s0008348;
        Fri, 16 Sep 2022 20:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=iJ6d2sn2MmcqIBgiHIMTwQGrs/VT3krEInF8FhIvbrc=;
 b=OGhnTcBeQ9BiUtBQSSX+Zy+dQu5U/NAxs0XvGYr4se4vyY2Dm+5F27J3IVVaaB66lqGg
 OvHU4dGwOB4BJAPQwZ0HZSf1yMc4z1W9NAeMjhcvzI8FW9VdjXNmexrCceQhROx7sn/B
 Tl36+qKcMzzT77456n48I0riaxMTyOuYIWQIElgxculeEq6D2/lTsa0nkY6Nzwgy36OY
 l2IXX41yv02kLDLJRI30wdT4iqVcfW/Sc4zdVymYE9fpZsUKF/L5Bd310LrgOoeQdhUX
 h/yhKAHThuaL+KslYyrZaB1KxxzE0C43s84s4CSuTq87cBXg3ybcod1fKN6Vfmkj/22n lA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm8xmvyk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 20:11:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28GK0YtX017184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 20:00:34 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 16 Sep 2022 13:00:34 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] drm/msm/dp: Support for external displays
Date:   Fri, 16 Sep 2022 13:00:21 -0700
Message-ID: <20220916200028.25009-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3pS7xyhis5Id7ou13zdl1mLnmmaavbJZ
X-Proofpoint-ORIG-GUID: 3pS7xyhis5Id7ou13zdl1mLnmmaavbJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_12,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for DisplayPort on SDM845 and SC8280XP, followed by
introduction of drm_bridge based HPD handling.

The version of these patches are restarted, as the previous
drm_connector_oob_hotplug_event()-based approach was abandoned and this
only barely resembles that effort.

In this effort the HPD handling is based on the reliance of the
hpd_notify() being invoked by a downstream (next_bridge) drm_bridge
implementation, such as the standard display-connector, or a something
like an USB Type-C controller implementation.

Bjorn Andersson (7):
  dt-bindings: msm/dp: Add SDM845 and SC8280XP compatibles
  drm/msm/dp: Stop using DP id as index in desc
  drm/msm/dp: Add DP and EDP compatibles for SC8280XP
  drm/msm/dp: Add SDM845 DisplayPort instance
  drm/msm/dp: Implement hpd_notify()
  drm/msm/dp: Don't enable HPD interrupts for edp
  drm/msm/dp: HPD handling relates to next_bridge

 .../bindings/display/msm/dp-controller.yaml   |   3 +
 drivers/gpu/drm/msm/dp/dp_display.c           | 135 +++++++++++-------
 drivers/gpu/drm/msm/dp/dp_drm.c               |   1 +
 drivers/gpu/drm/msm/dp/dp_drm.h               |   2 +
 drivers/gpu/drm/msm/msm_drv.h                 |   1 +
 5 files changed, 88 insertions(+), 54 deletions(-)

-- 
2.17.1

