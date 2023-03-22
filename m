Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3B06C4652
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCVJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCVJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:28:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E4C4ED8;
        Wed, 22 Mar 2023 02:28:11 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M9I8Wl020803;
        Wed, 22 Mar 2023 09:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6avEhP/cuHiS2fHBO2bSzDTAnuIaYByahfm2+cfiACw=;
 b=Hn9w2fCo5cUaZFcDpDth4aiZB9mUl0Nk+X53mLDsnZni+GOUWn0WOit8tpe9U/OlOqGT
 mpaQjU/k4sVaEkk6MR8bRVqB3D+QKUQeQEe9OTi6kN6NCxc1+Vg+u/QPgTFVtZNnpB+8
 iILcgVTpvx8znp1U6QWortIXobQfvdVJOZLAqSREmlWy1qWFe2JViiG3/gjSGKhLI/Df
 yY+1ShaYq5bZJKqMc+dgxkuGROo90CUPQmzy4i1Fw5hwgk9V16BU7MJOlF+sJ0MMgmKx
 RTdzX4ppo7tKYrzI4WYuJODfQ6Osg/sWizPvevVwVotdB5jkgv2YZr3uCwAqB0JkAUgg ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfbx030e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:27:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32M9RsKs001567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:27:54 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 02:27:50 -0700
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
Subject: [RFC 0/2] Handle core soft reset during Pullup
Date:   Wed, 22 Mar 2023 14:57:38 +0530
Message-ID: <20230322092740.28491-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IpvOQi1nJc6AzADBqu2bzmCEfDJW9uXx
X-Proofpoint-ORIG-GUID: IpvOQi1nJc6AzADBqu2bzmCEfDJW9uXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_06,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 phishscore=0 lowpriorityscore=0 mlxlogscore=823 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220069
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When core soft reset timeout happens, pullup doesn't check for the
return value and proceeds to setup event buffers and starts the
controller.

In this scneario, it is observed sometimes that the GEVTADDR LO/HI
registers read zero while we are setting the run stop bit and we end
up accessing address 0x00 leading to a crash. This series tries to
address this issue by handling the timeout and return back appropriate
error code to configfs for it to retry enumeration if it chooses to.

Krishna Kurapati (2):
  usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
  usb: gadget: udc: Handle gadget_connect failure during bind operation

 drivers/usb/dwc3/gadget.c     |  5 ++++-
 drivers/usb/gadget/udc/core.c | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.40.0

