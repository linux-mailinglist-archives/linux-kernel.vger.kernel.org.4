Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA1B67D810
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjAZV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjAZV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:58:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2149673773
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:58:32 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30QLuHvG013277
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:58:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=sTD50cTBzUMl+kZHjpCHKooMyDr+UIBBgnaoHVk+PWQ=;
 b=Hbx4OUL16Tu9e9qaQ44WJAfgoEPgn4JxNkq1VOs97Vy9ItigT2b8Q4kLJKrJbIpuQUZP
 +6BiNBTANridfBxVWSRcnd1uKjAIbLGzazO+eMxPGgsemIMwmQzLwD8+7LEgOYHude5P
 OuI+CbVVzPzVVFX3EwgkHACOV0tHMtvI9v4WEsRwFoUNopz9zaTpAv8y7yb4571iArwU
 vWQ8OpqrtrCWj9eV4VWu9NiyRi0Be2k36q4NhhIKYxyJkpZLwtSMF+xWmZg8s2tYFs/q
 BAUPjfJuceJOT72O6RGCY5/gBP/oNNDLo3iVnmZT9fOn9A627qyVFC+HFB1zD3MM+EED 0Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nbw49tvq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:58:30 -0800
Received: from twshared24547.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:58:29 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 581ACFE80AA2; Thu, 26 Jan 2023 13:51:26 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 10/12] dmapool: don't memset on free twice
Date:   Thu, 26 Jan 2023 13:51:23 -0800
Message-ID: <20230126215125.4069751-11-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RvHkgnaAZZvshAEP4t2ZlkGK-maC6mIT
X-Proofpoint-GUID: RvHkgnaAZZvshAEP4t2ZlkGK-maC6mIT
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

From: Keith Busch <kbusch@kernel.org>

If debug is enabled, dmapool will poison the range, so no need to clear
it to 0 immediately before writing over it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/dmapool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 4dea2a0dbd336..21e6d362c7264 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -160,6 +160,8 @@ static void pool_check_block(struct dma_pool *pool, v=
oid *retval,
 static bool pool_page_err(struct dma_pool *pool, struct dma_page *page,
 			  void *vaddr, dma_addr_t dma)
 {
+	if (want_init_on_free())
+		memset(vaddr, 0, pool->size);
 	return false;
 }
=20
@@ -441,8 +443,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr=
, dma_addr_t dma)
 		return;
 	}
=20
-	if (want_init_on_free())
-		memset(vaddr, 0, pool->size);
 	if (pool_page_err(pool, page, vaddr, dma)) {
 		spin_unlock_irqrestore(&pool->lock, flags);
 		return;
--=20
2.30.2

