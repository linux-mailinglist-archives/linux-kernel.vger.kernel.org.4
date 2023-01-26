Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3F467CBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbjAZNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbjAZNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FBA6952E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:37 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCEB9n016660;
        Thu, 26 Jan 2023 13:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UId5/JJoZBTeG9p9A1yOZ3nWp9P6VqwANs93MgDGf0s=;
 b=DrDxpvWzdXFvRAVauZWL2ShdoDlGGEM4vKvV959Q6Gdc6f7U3sLulnR9qdE+jWhPp9Jt
 J360MTu+SNADeThIgNuAg5I/df5HzKCIYnDboawVC/EAvIR72kzPVqMnTcmseZ5vubJs
 xCRYqQNElKq2Ykv87OVEO9m+gwgowGTJroLpyJ4SNSKNavq55BfEvG6QavOOiITKP/mL
 FDXm5nx6b3Qyk80XsH8taEQvdCHI23uHM/jKmv78XI0zVKVFYGkbgCHpT/SOD+esMRiV
 2LpJdwGCHZ0nufOTwM2wOJ8R93nj5hxIGd+a6C1qr4xEX5cCpGMmeab0AmH7LauG+LzA eg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbsbe1cb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QApjVW015356;
        Thu, 26 Jan 2023 13:14:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afeds5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDEVUj36700588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 759B220040;
        Thu, 26 Jan 2023 13:14:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4173A20043;
        Thu, 26 Jan 2023 13:14:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:14:31 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH 8/8] lib/zlib: DFLTCC always switch to software inflate for Z_PACKET_FLUSH option
Date:   Thu, 26 Jan 2023 14:14:28 +0100
Message-Id: <20230126131428.1222214-9-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fcNLZrWNVyT4SqoF1rX6CiDaPtGVV2u8
X-Proofpoint-GUID: fcNLZrWNVyT4SqoF1rX6CiDaPtGVV2u8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=874
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since hardware inflate does not support Z_PACKET_FLUSH option
(used exclusively by kernel PPP driver), always switch to
software like we already do for Z_BLOCK flush option.
Without this patch, PPP might get Z_DATA_ERROR return code from
zlib_inflate() and disable zlib compression for the packets.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc_inflate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
index 5786030c6dc2..437cd34c8490 100644
--- a/lib/zlib_dfltcc/dfltcc_inflate.c
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -95,8 +95,10 @@ dfltcc_inflate_action dfltcc_inflate(
     struct dfltcc_param_v0 *param = &dfltcc_state->param;
     dfltcc_cc cc;
 
-    if (flush == Z_BLOCK) {
-        /* DFLTCC does not support stopping on block boundaries */
+    if (flush == Z_BLOCK || flush == Z_PACKET_FLUSH) {
+        /* DFLTCC does not support stopping on block boundaries (Z_BLOCK flush option)
+         * as well as the use of Z_PACKET_FLUSH option (used exclusively by PPP driver)
+         */
         if (dfltcc_inflate_disable(strm)) {
             *ret = Z_STREAM_ERROR;
             return DFLTCC_INFLATE_BREAK;
-- 
2.34.1

