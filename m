Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D296027FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJRJKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJRJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:10:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA44454D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:10:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z20so13205013plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ukoFf7wEa/GfUfveeUzu2PUBZk7HPVe9cL2u/UltyEU=;
        b=csXExqhBkarPFPg6wEBtNxdgATZM8UopsHo3GUeTmwW04QbJH4NX5y5046JrhCf66H
         OS0czsOqU3JxwafgRAZIi/JmUa4SB4MFcsWb6JIv40cZWC5kkr9pC+tJUljFXEwRJ0fy
         cnX/HOTJHiOBudJTp5MtFv4L99UUXYYVX7yLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukoFf7wEa/GfUfveeUzu2PUBZk7HPVe9cL2u/UltyEU=;
        b=nbbZQIINAtKkVVatVqs2N5TFX21ji8nJeGZig6owPZvbN5LE2Y+sugG1Pxi5WX1qVt
         Nus4zhqYOBOu214lZqCMpaHFa5x4GBoMEAPBwVqhIl4E2kkjNgYk+ETLglDAbZ7SwoJv
         Pd+X4g3Au4gArVRNrP/NzCe8eXg/gwk1ZxYZWkkrOvzh9xw05xGWO6FNcLa2dYSVeXNo
         8F/0YHx+GXJATBe+9cwOqXbv53ILIcC/cxgBwxhBcaAuiwff0oeIyGKiIT0utV7L+ZC8
         2pcBJT5rjhK3GJPChnrmB8cFf+q9MSel/iVNt8wLU782NYrJQxsh7LEbFYvTBItGhTbc
         tt2w==
X-Gm-Message-State: ACrzQf1lbHU8CLfGCil+hG+9sOBpmMoRatm0Vuig3aXDUSPNnjIvKVA8
        urzB2jeQSvT35UV0kS1/1wis9Q==
X-Google-Smtp-Source: AMsMyM6AMqxalz2EiUvSsTLj683MBoAwpQpreDb/Xeav5jgLr57NynSC9KI51LhT7Kytdced3HqcMQ==
X-Received: by 2002:a17:90b:3588:b0:20b:590:46a2 with SMTP id mm8-20020a17090b358800b0020b059046a2mr2491865pjb.14.1666084214343;
        Tue, 18 Oct 2022 02:10:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0017300ec80b0sm8058997plk.308.2022.10.18.02.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:10:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] dma-buf: Proactively round up to kmalloc bucket size
Date:   Tue, 18 Oct 2022 02:10:11 -0700
Message-Id: <20221018090858.never.941-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject:message-id; bh=8hepCmu6KkNCIQiT6ONpaMe4VoHSy9sRDnadRc3o6dY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTm1zq8jKCG/tc7/8bPvsM44d+bw8pliNmUV1nYs9 oZ3UNCqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05tcwAKCRCJcvTf3G3AJh7AEA CTcI1pdlR5PlvYxNvP2WDxxU4tjQpCYFU8DL3QIbpSPAGCSHnu/fLH6mOTmflitrQ/DsyHD4LRh+Gc MNL44FREEbJ4PDUi+k2SbLlkCESNKduXwzMSU4AzBIbf3TD2GmvqnQc6663oVj/0gCMK1PtcnYqkkK 7dOrQHMvouIoxWrgiOoK8U8K+6pHwwJK66vChECKJN261DcRu+LrteWxTMCEuwWexFa8DVde3NAK9Z rBLz4Cq8ZdLitk/OXx0Dq5Sr+lvsTuhgodexasrD6PbK4g3XSSyHuqSiRLwSb+WgKJaOQ/FwHA/zxz N1ktC3FGVv0rs3PTxdAwcI0FNVEpUdZUkQI0UfFotI03jATt3Ar/11oa77oln6OVD4p86J25TmPSsL 5mbkclNofm6EXo/VniQoq6dc6Bt4acmroVMeYDxRuAwfwxW0tBusHyGG0uUaczhMLcI+8aB7B9Ww5w Z1tpDuQLaTSmDAfOskStapWlFTBdZczM8RsO88iM5k/TH/00g53wBnDEHyYBXaMZWIc+rSuGFChZzf H0+guk6+nfMF3k18/pY3Ysj5RPQE3FF4i1DOJ1aqc9zQLB9+BV8bbsTxy/GCHGenjhYmFipzHZeJat dOlM+mCyFQ3zOAYDS2ZW+1sW0Gfg5Xqh5qC7jyxMfqfwVjvzt1oaXABQEm0g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of discovering the kmalloc bucket size _after_ allocation, round
up proactively so the allocation is explicitly made for the full size,
allowing the compiler to correctly reason about the resulting size of
the buffer through the existing __alloc_size() hint.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: added reviewed-by, rebase to v6.1-rc1
v2: https://lore.kernel.org/lkml/20220923202822.2667581-9-keescook@chromium.org/
---
 drivers/dma-buf/dma-resv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index e3885c90a3ac..1c76aed8e262 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -98,12 +98,17 @@ static void dma_resv_list_set(struct dma_resv_list *list,
 static struct dma_resv_list *dma_resv_list_alloc(unsigned int max_fences)
 {
 	struct dma_resv_list *list;
+	size_t size;
 
-	list = kmalloc(struct_size(list, table, max_fences), GFP_KERNEL);
+	/* Round up to the next kmalloc bucket size. */
+	size = kmalloc_size_roundup(struct_size(list, table, max_fences));
+
+	list = kmalloc(size, GFP_KERNEL);
 	if (!list)
 		return NULL;
 
-	list->max_fences = (ksize(list) - offsetof(typeof(*list), table)) /
+	/* Given the resulting bucket size, recalculated max_fences. */
+	list->max_fences = (size - offsetof(typeof(*list), table)) /
 		sizeof(*list->table);
 
 	return list;
-- 
2.34.1

