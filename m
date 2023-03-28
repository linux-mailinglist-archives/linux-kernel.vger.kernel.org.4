Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96006CC78C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjC1QJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjC1QJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:09:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A49DFF3C;
        Tue, 28 Mar 2023 09:08:53 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SDUSdG029866;
        Tue, 28 Mar 2023 16:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QKhL0KzrR4b6znOdJrnhGJP/JXQIAdpm6o5hO8iT3zo=;
 b=f5exfEoamxF6isProRqyoHRbL59Rd/PXrWEdT87yK9DIhAqhAPwiv77VGg2pnJL0DZ4Y
 wPzr1KTObta1Lcvm7cbsomnALQ0dUrDaJvgjpvrIxvmEY+ffQGAS5CYl9wPYkR6LMC8l
 9PScKFswyjWIByMMA15FMF4upFseRVTXso+7ch0lAjfyafonLSGx/MThZB4SNpQSCoxJ
 9Edri0bRSPfbbukc/CHVIfFXcDfWdOdNXjzBXHVA2JMo723MB8kwPUKH8pgYHc5HB8IP
 wxW7Gye7VVl1iTPSduGs8/MX7vC0dvLdMO4tlK/d8d03dZUXiruhoPgrhlJ08vFLaBfl sQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk5774nu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 16:08:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SG8EJb012255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 16:08:14 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 09:08:10 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
Date:   Tue, 28 Mar 2023 21:37:55 +0530
Message-ID: <20230328160756.30520-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328160756.30520-1-quic_kriskura@quicinc.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AoVszABDzWQTIz1CwF3bS0QWeQDBeEov
X-Proofpoint-ORIG-GUID: AoVszABDzWQTIz1CwF3bS0QWeQDBeEov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280126
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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

