Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE36FD8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjEJHxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjEJHxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:53:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84805DE;
        Wed, 10 May 2023 00:53:21 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A4u4wL024070;
        Wed, 10 May 2023 07:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=qtaD07TouvINu2QPk+H8FEJRWtVe9CQqLpxqtc/q7Zc=;
 b=UusSnrCnx9GzHXchMajoQM+OePiznofow7kyp2Pd7QaoAVnvAQHhpjYkaHGwiss9uKYC
 gZkZsB0Uyjx9QOabZvsuCdl9OSJhQpxVjgvwolDrruiA7P97/9VXJGsOMVF6YqgBll4U
 IKKBzIobhSVodw0xbhFnA7f0HG3Ry4sua+aQeY3IIcS6cl0Ns+uv+2pQORZkfSGFdnqG
 HcQA/j5v7vHaKOBIE1piI2WIxx281+LkKHxh+a3SgdSa+V2uEwUOr3u8DlT6c7bJhHlt
 8flWNDC0qv0hTrTOmxW4WuRQMtF3oWm8gnTvOnFQ3pfncFu5aLxOzNGzI6tjyXLQ9cIE gQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg1g10k9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 07:53:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34A7rAB2031805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 07:53:10 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 00:53:06 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Jiantao Zhang" <water.zhangjiantao@huawei.com>,
        Badhri Jagan Sridharan <badhri@google.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v3 0/2] Handle core soft reset failure in pullup
Date:   Wed, 10 May 2023 13:22:50 +0530
Message-ID: <20230510075252.31023-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yNtX8nqs0JdP-AsT3Ybx3D7g6DapygFP
X-Proofpoint-ORIG-GUID: yNtX8nqs0JdP-AsT3Ybx3D7g6DapygFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Link to v2: https://lore.kernel.org/all/20230328160756.30520-1-quic_kriskura@quicinc.com/

changes in v3:
Rebased on top of latest usb-next to resolve merge issues
Fixed comments from v2 related to code styling

changes in v2:
Fixed comments addressing incomplete error handling in udc core

Krishna Kurapati (2):
  usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
  usb: gadget: udc: Handle gadget_connect failure during bind operation

 drivers/usb/dwc3/gadget.c     |  5 ++++-
 drivers/usb/gadget/udc/core.c | 21 +++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.40.0

