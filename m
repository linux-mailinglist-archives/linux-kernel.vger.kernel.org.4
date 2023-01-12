Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC8666739C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjALNwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjALNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:52:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E51169;
        Thu, 12 Jan 2023 05:52:36 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CARCei009736;
        Thu, 12 Jan 2023 13:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=SYIvEG8pmrpBPywF9py6RlwQ1BL6zQFVc3QP7tQ9KFs=;
 b=gcWD7EhnOYuyJ193CVHYjL/D1r50XImE2FIt8wL2rRro59p+VIcjDAWJp2Zt7fzNGJAp
 alMHdj23+HK2L/zLyRsCBA2BINJKUPyoFI269C19PBaKhV6Y7ZkJvgQmMmqhuys8BWfP
 ygQDtl2m+MuD2dFWMmIOv2B2l6MBietV2JNigV21w+fi7Pm1GC6BS6CqXRcujnshZwEB
 eDbbXciaFhPSvFw3nCxRfTrzkUSBAr5rhdWMjv4ich8rp3/V/nJ/rVyIFW78+8KnkMSc
 jx5rU83035oi6h0+ZXKoKy7v7lvo0aBVXLZpBEQRbw5LDWXgCgTbzIVRjoyP+qJC4AQW pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2d750y9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:52:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CDqUOv031106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:52:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 05:52:29 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: qcom: gdsc: Disable HW control until supported
Date:   Thu, 12 Jan 2023 05:52:24 -0800
Message-ID: <20230112135224.3837820-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AQpynj6-zGzN2bRDomeYvYhomB2fsL1j
X-Proofpoint-GUID: AQpynj6-zGzN2bRDomeYvYhomB2fsL1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software normally uses the SW_COLLAPSE bit to collapse a GDSC, but in
some scenarios it's beneficial to let the hardware perform this without
software intervention.

This is done by configuring the GDSC in "hardware control" state, in
which case the SW_COLLAPSE bit is ignored and some hardware signal is
relies upon instead.

The GDSCs are modelled as power-domains in Linux and as such it's
reasonable to assume that the device drivers intend for the hardware
block to be accessible when their power domain is active.

But in the current implementation, any GDSC that is marked to support
hardware control, gets hardware control unconditionally while the
client driver requests it to be active. It's therefor conceivable that
the hardware collapses a GDSC while Linux is accessing resources
depending on it.

There are ongoing discussions about how to properly expose this control
to the client drivers, but until conclusion in that discussion is
reached, the safer option would be to keep the GDSC in software control
mode.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/clk/qcom/gdsc.c | 48 ++++++-----------------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 9e4d6ce891aa..6d3b36a52a48 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -291,22 +291,6 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	 */
 	udelay(1);
 
-	/* Turn on HW trigger mode if supported */
-	if (sc->flags & HW_CTRL) {
-		ret = gdsc_hwctrl(sc, true);
-		if (ret)
-			return ret;
-		/*
-		 * Wait for the GDSC to go through a power down and
-		 * up cycle.  In case a firmware ends up polling status
-		 * bits for the gdsc, it might read an 'on' status before
-		 * the GDSC can finish the power cycle.
-		 * We wait 1us before returning to ensure the firmware
-		 * can't immediately poll the status bits.
-		 */
-		udelay(1);
-	}
-
 	if (sc->flags & RETAIN_FF_ENABLE)
 		gdsc_retain_ff_on(sc);
 
@@ -321,24 +305,6 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_assert_reset(sc);
 
-	/* Turn off HW trigger mode if supported */
-	if (sc->flags & HW_CTRL) {
-		ret = gdsc_hwctrl(sc, false);
-		if (ret < 0)
-			return ret;
-		/*
-		 * Wait for the GDSC to go through a power down and
-		 * up cycle.  In case we end up polling status
-		 * bits for the gdsc before the power cycle is completed
-		 * it might read an 'on' status wrongly.
-		 */
-		udelay(1);
-
-		ret = gdsc_poll_status(sc, GDSC_ON);
-		if (ret)
-			return ret;
-	}
-
 	if (sc->pwrsts & PWRSTS_OFF)
 		gdsc_clear_mem_on(sc);
 
@@ -419,13 +385,6 @@ static int gdsc_init(struct gdsc *sc)
 				goto err_disable_supply;
 		}
 
-		/* Turn on HW trigger mode if supported */
-		if (sc->flags & HW_CTRL) {
-			ret = gdsc_hwctrl(sc, true);
-			if (ret < 0)
-				goto err_disable_supply;
-		}
-
 		/*
 		 * Make sure the retain bit is set if the GDSC is already on,
 		 * otherwise we end up turning off the GDSC and destroying all
@@ -439,6 +398,13 @@ static int gdsc_init(struct gdsc *sc)
 		on = true;
 	}
 
+	/* Disable HW trigger mode until propertly supported */
+	if (sc->flags & HW_CTRL) {
+		ret = gdsc_hwctrl(sc, false);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (on || (sc->pwrsts & PWRSTS_RET))
 		gdsc_force_mem_on(sc);
 	else
-- 
2.37.3

