Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19E67A721
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjAXXrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjAXXrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:47:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92899E39E;
        Tue, 24 Jan 2023 15:47:14 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ONKgMW001519;
        Tue, 24 Jan 2023 23:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=X2Q0tE37VDp4hy/FQTBoYaG77TQ/eZFORCyeWxKtWp8=;
 b=dDD9ZU3VpQgOBrUeo6KH0qtmZmBOzlbxfsumgL3n0y77xlSB48JJOBXlYrAt7x+u4DYG
 LpiUCYrAulcPrk9Qxy3vJmiLBiiBl15C3AcfyyjAxejri9j5mRaMyy2jzCpyw/VGtfMU
 hk+i86/tAy4GE/qJUss0Qz22qnzlg2DmDzDbSAp6GiR05lXQCYbYrTWwswcrJGxRDzoq
 m0FtGG/+lerbH3LCXaJ1jE+xOKw79a0WP3BmqxUfw05Ar/b7eEE7iuCQIVqcewbZMi1y
 HwUNQdXWxlWv5o1v0bVwihIH1HWhZzX7vaZCQUSdx8C8alZuq3QZqw6BpcRf8iy8NYoA Cg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3napvhg6wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 23:47:06 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ONl5C0007759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 23:47:05 GMT
Received: from hu-collinsd-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 15:47:04 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 0/3] thermal: qcom-spmi-temp-alarm: add support for new TEMP_ALARM subtypes
Date:   Tue, 24 Jan 2023 15:46:03 -0800
Message-ID: <cover.1674602698.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T35YPkFgzIg2TtnfBnJxUkLE8-Nreg4f
X-Proofpoint-ORIG-GUID: T35YPkFgzIg2TtnfBnJxUkLE8-Nreg4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in the qcom-spmi-temp-alarm driver for the new PMIC
TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE.  The GEN2 rev 2
subtype provides greater flexibility in temperature threshold
specification by using an independent register value to configure
each of the three thresholds.  The LITE subtype utilizes a simplified
set of control registers to configure two thresholds: warning and
shutdown.

Also add support to avoid a potential issue on certain versions of
the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
is disabled.

Changes since v2 [1]:
* Added missing header <linux/bitfield.h> in the third patch

Changes since v1 [2]:
* Updated the thermal API usage in the patches to work with the recent commit
  ca1b9a9eb3fd ("thermal/drivers/qcom: Switch to new of API")

[1]: https://lore.kernel.org/lkml/cover.1670375556.git.quic_collinsd@quicinc.com/
[2]: https://lore.kernel.org/lkml/cover.1663282895.git.quic_collinsd@quicinc.com/

David Collins (3):
  thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
  thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
    peripherals
  thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 407 +++++++++++++++++++-
 1 file changed, 392 insertions(+), 15 deletions(-)

-- 
2.25.1

