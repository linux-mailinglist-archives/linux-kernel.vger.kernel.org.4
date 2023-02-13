Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB986954C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBMX0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjBMX0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:26:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B03D9D;
        Mon, 13 Feb 2023 15:26:19 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMXXEo006618;
        Mon, 13 Feb 2023 23:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=9zOsI7wDgUioyr1LYFvU/oJQKYz2SyKvRYNSma0iYpQ=;
 b=dt0UaPjUxGFQVPgKkEB/KKbQB/rInofyOQz5ph0A2DspCfXW0TahZyP0xV0O5SxYPuV6
 WfAxfvHqspt+XiO56cP+HlhaPMfg/bqvXBlksKO5amUDtffpW/NE/29i8CF3R2IyHc4d
 DXxxce4WRC4kp4eduDBL1ViKTx38Xv43TfTTAFLsDSHiYscEgvdtxemBL/dTHaMuIkwF
 CkhgXIlX6Plm9VXRfZABPxSn9GECSmBMsXxRfNniZ8pRNL0rnPUZDgtRyRBegOvuCOQp
 QSV9jIWEjCOyM4QpfVzeQ9D9e6duqfZlGPzFB6bAev1e9FqYY6m3FP1xyD+tgVf0WQgQ AQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmh4y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 23:26:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DNQEe7015102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 23:26:14 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 15:26:13 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 0/3] mailbox: Allow direct registration to a channel
Date:   Mon, 13 Feb 2023 15:25:34 -0800
Message-ID: <20230213232537.2040976-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qe4rdIla3ZIoRo8CM9jeNAGxf6fWRCgt
X-Proofpoint-GUID: qe4rdIla3ZIoRo8CM9jeNAGxf6fWRCgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=651 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130205
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two mailbox controllers have channel/client binding mechanisms that are
controller-specific and not using the devicetree binding mechanisms. Mailbox
channel/client is conceptually done in two steps: selecting the channel
and binding the selected to channel to a client. Channel selection is sometimes
controller specific (pcc and omap are examples). The channel/client binding
code is all the same.

This small series de-duplicates and refactors the channel/client binding
into a common framework function: "mbox_bind_client" which all of the
channel selection mechanisms can use.

I found this duplicate code while working on the support for Gunyah hypervisor
message queues [1]. I've only been able to compile-test omap-maiblox and pcc,
however it is a straightforward conversion here.

[1]: https://lore.kernel.org/all/20230120224627.4053418-9-quic_eberman@quicinc.com/

Elliot Berman (3):
  mailbox: Allow direct registration to a channel
  mailbox: omap: Use mbox_bind_client
  mailbox: pcc: Use mbox_bind_client

 drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
 drivers/mailbox/omap-mailbox.c | 22 ++------
 drivers/mailbox/pcc.c          | 82 ++++++++++++++++-------------
 include/linux/mailbox_client.h |  1 +
 4 files changed, 118 insertions(+), 83 deletions(-)


base-commit: 09e41676e35ab06e4bce8870ea3bf1f191c3cb90
-- 
2.39.1

