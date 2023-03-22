Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4256C4654
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCVJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCVJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:28:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3027AE;
        Wed, 22 Mar 2023 02:28:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M4s18B031607;
        Wed, 22 Mar 2023 09:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QKhL0KzrR4b6znOdJrnhGJP/JXQIAdpm6o5hO8iT3zo=;
 b=Yi0glNUJdOlLgZ0Py6XKFfq67OE7y5SnETNCxTT9dhuThHBqRXanlD1TINxYp8H5dFay
 wRBTsIYqcULYAk7FvwIa8FtvgaDp5JqM1N7oghK++C0FNbXMMDyDr+Xd3ag/slMi2/Lm
 FnTFNlIehRezIHzqh/FMMaWVoGq4v2KXiXadB1dfyjGWZIKPZT6Bd9/TUthD/4G/B/Gv
 T6HMR5q+Sne+8CHEg2bV9hw3gjYhkaQFYtjjQONFFzGG2k1nv5CZ9VhQvOeghRq2XWFx
 gZvl1cs94UtSEjs8bthLENUqnx3EMl/IjNWjauMtELN4IM7PgWNwjVpt97zRric6189/ /Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfbjyb0u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:28:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32M9RxPF024191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:27:59 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 02:27:55 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sre@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC 1/2] usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
Date:   Wed, 22 Mar 2023 14:57:39 +0530
Message-ID: <20230322092740.28491-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322092740.28491-1-quic_kriskura@quicinc.com>
References: <20230322092740.28491-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H2Cg2jbkzlM23B_6mpa_M32k2yQun96o
X-Proofpoint-ORIG-GUID: H2Cg2jbkzlM23B_6mpa_M32k2yQun96o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_06,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220069
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the core soft reset timeout happens, avoid setting up event
buffers and starting gadget as the writes to these registers
may not reflect when in reset and setting the run stop bit
can lead the controller to access wrong event buffer address
resulting in a crash.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3c63fa97a680..f0472801d9a5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2620,13 +2620,16 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		 * device-initiated disconnect requires a core soft reset
 		 * (DCTL.CSftRst) before enabling the run/stop bit.
 		 */
-		dwc3_core_soft_reset(dwc);
+		ret = dwc3_core_soft_reset(dwc);
+		if (ret)
+			goto done;
 
 		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
 		ret = dwc3_gadget_run_stop(dwc, true, false);
 	}
 
+done:
 	pm_runtime_put(dwc->dev);
 
 	return ret;
-- 
2.40.0

