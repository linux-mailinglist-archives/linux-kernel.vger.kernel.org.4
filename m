Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942AC6FF2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbjEKNbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbjEKNbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:31:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9E10DA;
        Thu, 11 May 2023 06:30:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDMVEo025180;
        Thu, 11 May 2023 13:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=4H6cg9/svGMCwZGXxTBtcYg0ozMTszd85OG5cGMvj7Q=;
 b=PlrJhQ3LqJhtTm+obYnYcWOaAmDaKKxjOZVmNnGu/Gx6mgie+8+Z33InbQsJB/aE19LM
 u0FfUtl8KcaVHgO/YQkTNj7hOxcycG+qwlACnnlgB1c8fLnQc+KJyvAE3hmfujNR9Csk
 GBsYkxywzNHmkMosl5Cy7034OZ54yr1yikGHv16X7vxkfkCmR1q1BTuA0bqeY4OooPrS
 C00WXDEt1YO+AYY7JsPrjFcN/svdlmuZnXuaOVI0fuUPz7pUAZHnI4yIqVWdfyaBg71y
 1+oD3zDN4JxzlGs9Qc8bhB7Fk49fhWRRjIDY45zRtUCJojvEHXTlQa0Hyi7rTB+Xllce dw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgv1t8v2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 13:30:25 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34BDULZx001532;
        Thu, 11 May 2023 13:30:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qdy5bq8kn-1;
        Thu, 11 May 2023 13:30:21 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BDULeF001526;
        Thu, 11 May 2023 13:30:21 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34BDUKuZ001525;
        Thu, 11 May 2023 13:30:21 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id AC8B512010C1; Thu, 11 May 2023 19:00:19 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH 0/5] mtd: rawnand: qcom: Implement exec_op()
Date:   Thu, 11 May 2023 19:00:12 +0530
Message-Id: <20230511133017.6307-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nQB32vKZAAlEPhsVUHYMWHeqLZ43SzsH
X-Proofpoint-GUID: nQB32vKZAAlEPhsVUHYMWHeqLZ43SzsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=611 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110116
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series of patches will add exec_ops support in qpic nand
driver. Earlier posted patches V1,V2 will be discontinued ,after
addrissing Mani and Miquel comment. These all patches are split
of single patche posted earlier for exec_ops.


Md Sadre Alam (5):
  mtd: rawnand: qcom: Implement exec_op()
  mtd: rawnand: qcom: Add support for reset, readid, status exec_op
  mtd: rawnand: qcom: Add support for param_page read exec_ops
  mtd: rawnand: qcom: Add support for read, write, erase exec_ops
  mtd: rawnand: qcom: Remove legacy interface implementation.

 drivers/mtd/nand/raw/qcom_nandc.c | 857 ++++++++++++++++++------------
 1 file changed, 510 insertions(+), 347 deletions(-)

-- 
2.17.1

