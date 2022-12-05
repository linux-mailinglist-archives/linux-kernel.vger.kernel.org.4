Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA1C642B84
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiLEPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiLEPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:19:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0871A229
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:19:30 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B50UkFr019563
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:19:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=P/KRpfmdlQUKxAAPrLlGtIIYCnA6qEIJS0aGmE3w/OM=;
 b=jtG+mgTh7Z80eRamWInP2j8Uv8btmTRrxRZYCGOm49bRo9tMfiR3ycsoe+/u5rgu88g1
 6kQimJqXC5ofllDbbygKkFozEB4Q7dQGFA+kDt13DPL7oEo7qneol1qQwWdO5bFa6zDS
 adSeduIBU4TheBfJhIuKOujGMpOAJsP6Uz9gX1fYHTn0yUTywwBCzXvXVfnDxJvqTAiB
 /Eix5ptf30dLZBp5uO/U18JJB0Nipzn/VCIwePnENXY5CiVs92DfRKgAcF3V2fD3CXdN
 cnLIyCxpwRm6BYUk9V2c0WKQda8vOCZwnXdz0aDdjCpVsuudjMBn2wFjkhbpinTTVvYg KQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m83cskxvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:19:30 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:19:29 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 7A815C6156F4; Mon,  5 Dec 2022 07:00:10 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 05/11] dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
Date:   Mon, 5 Dec 2022 06:59:31 -0800
Message-ID: <20221205145937.54367-6-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205145937.54367-1-kbusch@meta.com>
References: <20221205145937.54367-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: o7lCOkJUmQNJNock67g4mqJzwFPvpAl5
X-Proofpoint-ORIG-GUID: o7lCOkJUmQNJNock67g4mqJzwFPvpAl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Battersby <tonyb@cybernetics.com>

Avoid double-memset of the same allocated memory in dma_pool_alloc()
when both DMAPOOL_DEBUG is enabled and init_on_alloc=3D1.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index ee993bb59fc27..eaed3ffb42aa8 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -356,7 +356,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem=
_flags,
 			break;
 		}
 	}
-	if (!(mem_flags & __GFP_ZERO))
+	if (!want_init_on_alloc(mem_flags))
 		memset(retval, POOL_POISON_ALLOCATED, pool->size);
 #endif
 	spin_unlock_irqrestore(&pool->lock, flags);
--=20
2.30.2

