Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86067D7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjAZVyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjAZVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:54:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F058646
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:28 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30QGWDx3013273
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=UyoQbuDcWCkMLbCWVjg85By3HibyoyANdI6PglTOTlg=;
 b=Kefr2vNT1NBrRgx/cIhqb29JdH3QfkFrzcMsv6RXzVT/Bt97zPsJi1ET99miCOlLfTaL
 VEDmvWx7lvbKlLrL3paXcIyf03+HCP3piWuL6Yp6G75d7u1xnOHXkDS2yurJSNQWBArZ
 dRQnHWxRwcNFBzfjxEzInlGlAimyfWyC54ieeApmniWm/EZsxawzWis1h/pAZMf5UrHB
 AHwBf7kdSicFV0rADI8j31EPcC+t/OjNLd6Rckkf4hXLuiPRVBHRuXADLX0faJzRFkXd
 vFAZ2qrs8T3pcZphxfizNaKjgvuuJq0R8smmoj+TbVJX3QeKyWqqcGcZthgBb7zMSyhA 6A== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nbw49tukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:27 -0800
Received: from twshared24547.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:54:25 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1F1EFFE80A97; Thu, 26 Jan 2023 13:51:26 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 05/12] dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
Date:   Thu, 26 Jan 2023 13:51:18 -0800
Message-ID: <20230126215125.4069751-6-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tT1mamBw0gtgojSoLz671x8Ck7au5KU6
X-Proofpoint-GUID: tT1mamBw0gtgojSoLz671x8Ck7au5KU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

