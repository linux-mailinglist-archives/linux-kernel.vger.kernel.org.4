Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD11729735
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbjFIKnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbjFIKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24AE62;
        Fri,  9 Jun 2023 03:39:58 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359ARCtA019786;
        Fri, 9 Jun 2023 10:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zVwMAznnkuKOBTCJu0ZtM00hpj9ccYzftK5RO2xV5Rc=;
 b=feT76DuekCodNEabn9IWaLNaMqGgVZP2D0gkPzpbzMvxj4BQWg9pOOd3abZcHMsmKNvI
 bQilE+tp1SeawraNHLicaQDV8MpPEfAWliJ7RuBlApWbDOiypeVsFsq7wrjLMTGAvtkJ
 W14iSumUPskN0HHjxFRZRds+mHbkFblV//vi33PJbIC5zikNiYYoOo6JSj0ljJRKGwWH
 3g9hI9h0XtlYBqBd89zs7R5v4BKc3JKEvOsezlal5mG2+cD6/W9399HT2SnaWjN1eKZ7
 S+qa6NOcVnO+klhqdGGn6qS0ZADiLnEQ/q9+XMP3Sfgz3OW3Xk5V9nrmo2H9QPXoQ6hn Mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r41r0r30k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:39:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359AdsIf012471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 10:39:54 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 03:39:51 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <quic_anane@quicinc.com>
Subject: [PATCH v1 0/2] Add changes for cached buffer and persistent header buffers
Date:   Fri, 9 Jun 2023 16:09:45 +0530
Message-ID: <1686307187-15199-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XocjlRZvVQEZkwySiSMIFOG83kvFfkdk
X-Proofpoint-ORIG-GUID: XocjlRZvVQEZkwySiSMIFOG83kvFfkdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=696
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series carries changes to reduce RPC call overhead by
skippikng DMA API allocation calls for all type of buffer allocation
requests.

Cached buffer support enables caching of allocated buffers
instead of freeing which can be reused for any new request.

Persistent header buffer changes allocated a number for header
buffers during CDSP process initialization which is then used
for remote calls by the process.

When any process make a remote call, the metadata buffer is first
tried to be used from allocated persistent header buffers. If due
to any reason, persistent header buffers are not available, the
allocation request falls back to cached buffers and allocations
using DMA API.

Ekansh Gupta (2):
  misc: fastrpc: Add cached buffer support
  misc: fastrpc: Add persistent header buffer support

 drivers/misc/fastrpc.c      | 348 ++++++++++++++++++++++++++++++++++++--------
 include/uapi/misc/fastrpc.h |   8 +
 2 files changed, 295 insertions(+), 61 deletions(-)

-- 
2.7.4

