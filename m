Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D767467CBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjAZNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbjAZNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0369507
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:36 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCkVh3000343;
        Thu, 26 Jan 2023 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=ZKOqHnDXJa7jRfwmB881p/x5nb/JTibiWGwBU+BYF4k=;
 b=FxlywZqu7WtBFFV0CJc4JlgYNlLcxtmlKcIVObhpfRYIqIR+SdduOgXH5NBFTsa6n95k
 +cYzlRVs8fRiCLPBlXGDPrEUMahNiLgEIYz35SFNRnWcz8ZEMmAMAziakd7TIOPukse3
 qX0VBZw4m6KBCwdsrbw3YBbfEU9I9zgb3kEmXEpNbcsksKCHL/DLcT4eWQpnMJzgbDDT
 JWQVUKd9voc8CYokLWGzR9m9cGwFE3VpXhaQLgNYTakltOhKKCA1r3BH2vl/2ltCgy+A
 4ABjSu1R9KiEhVM/Bsrdz0eZX0zLjaMNV3FFdqI0XJW/nRrJDiiKx3ESvGDYB1t5xGjI ZA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbrka2ca0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:35 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q2KLfI027371;
        Thu, 26 Jan 2023 13:14:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n87p6ckhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDETNT48693644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EDF820040;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612EA2004B;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH 1/8] lib/zlib: Adjust offset calculation for dfltcc_state
Date:   Thu, 26 Jan 2023 14:14:21 +0100
Message-Id: <20230126131428.1222214-2-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0T-ZVNQ6r_emaLyPji3ibcq_SSxr3Ms_
X-Proofpoint-GUID: 0T-ZVNQ6r_emaLyPji3ibcq_SSxr3Ms_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=700 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is based on:
  https://github.com/zlib-ng/zlib-ng/commit/d8b67f5

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index 2a2fac1d050a..1f63094366e9 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -100,8 +100,9 @@ struct dfltcc_state {
     char msg[64];                      /* Buffer for strm->msg */
 };
 
+#define ALIGN_UP(p, size) (__typeof__(p))(((uintptr_t)(p) + ((size) - 1)) & ~((size) - 1))
 /* Resides right after inflate_state or deflate_state */
-#define GET_DFLTCC_STATE(state) ((struct dfltcc_state *)((state) + 1))
+#define GET_DFLTCC_STATE(state) ((struct dfltcc_state *)((char *)(state) + ALIGN_UP(sizeof(*state), 8)))
 
 /* External functions */
 int dfltcc_can_deflate(z_streamp strm);
-- 
2.34.1

