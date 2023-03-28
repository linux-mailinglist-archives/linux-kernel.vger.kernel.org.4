Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1E6CC780
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjC1QIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC1QI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:08:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C35CA22;
        Tue, 28 Mar 2023 09:08:26 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SBGbDR006581;
        Tue, 28 Mar 2023 16:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4Cd7FiiJO37CbrdHVr5t20E/qKeGVKmXVyF6KG0EpX8=;
 b=NXm2unGfOI8lYKgaLuM3OqSq2oPs791IHCeYvyRj4xgXfaXa+ZN/0wr0Zoqhxoi8EST3
 RvXAsE4ED+Iio+eRfuzr4Tbw6ZAVB9zZ6dsEWlfsZAJ/4sGf1XPlWmvUnK0lnpKHgIQi
 sHeBS9FKTZxOq9JszNhcbTMzlC1sIs/1vBS3vUbXfouTdi5rNMohAZo5p2TYVw2/sAF2
 kPtMZMrfwXO66b1/8wir9uQbiBD/qR6vbwfUVTkJijIIpz8LzStVNBxROqstJW6Z/ikM
 NIEW8U3EKAB64TW/2peJe0+7PbKG3rKQFSCYW89KBWEqO6s1x8R6R1/jvIU0vQxTP1wJ 3w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pky700vtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 16:08:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SG8AqH030273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 16:08:10 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 09:08:05 -0700
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
Subject: [PATCH v2 0/2] Handle core soft reset failure in pullup
Date:   Tue, 28 Mar 2023 21:37:54 +0530
Message-ID: <20230328160756.30520-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KYZHOfRS-zCUyEVqMpXipDBdacuBbk6u
X-Proofpoint-GUID: KYZHOfRS-zCUyEVqMpXipDBdacuBbk6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=858 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280126
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When core soft reset timeout happens, pullup doesn't check for the
return value and proceeds setting up of event buffers and starts the
controller.

In this scneario, it is observed sometimes that the GEVTADDR LO/HI
registers read zero while we are setting the run stop bit and we end
up accessing address 0x00 leading to a crash. This series tries to
address this issue by handling the timeout and return back appropriate
error code to configfs for it to retry enumeration if it chooses to.

Link to v1: https://lore.kernel.org/all/20230322092740.28491-1-quic_kriskura@quicinc.com/

changes in v2:
Fixed comments addressing incomplete error handling in udc core

Krishna Kurapati (2):
  usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
  usb: gadget: udc: Handle gadget_connect failure during bind operation

 drivers/usb/dwc3/gadget.c     |  5 ++++-
 drivers/usb/gadget/udc/core.c | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.40.0

