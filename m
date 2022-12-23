Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527BD654E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiLWJ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiLWJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:27:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301E3720E;
        Fri, 23 Dec 2022 01:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uj5J1LKb/4UIpagExHs49WqhLRVbYSUrTZ0b+D0WTrE=; b=nIi94Z7xg6PPdFGLsL4tc1cRkg
        fk8vpDY3Qb3un4xD1x2lRvrSE26lm0N2VFu2vOaxEEGO0wHPAN1Yxwhvxql+tye9eIB5BRKK8X8XV
        qanYlBggDmH2iPfyygKTQw+sRmJFClDwKQ2kuS5u26BxfEccIXUncjf++Bd5jYUx+wbGGQKfYdk4c
        7/mdYbO9Mwpwbfp/CjA+1UI4MNSaFjOBU4i6+PdCtDeRCOcmkq8GcN830iPnmFv/pc+vl/vmUZblo
        TDK7c8vj1Clg2JWlevxJIVFeIehSHNSv5VExgK9skZq/Qyl4aoiTv6ZetYah0ZlvZ0ESd3tYFwVPO
        Judum79A==;
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8eKe-005hTn-Jv; Fri, 23 Dec 2022 09:27:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: [PATCH 2/2] vmalloc: reject vmap with VM_FLUSH_RESET_PERMS
Date:   Fri, 23 Dec 2022 10:27:03 +0100
Message-Id: <20221223092703.61927-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223092703.61927-1-hch@lst.de>
References: <20221223092703.61927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_FLUSH_RESET_PERMS is just for use with vmalloc as it is tied to freeing
the underlying pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9e30f0b3920325..88a644cde9fb12 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2849,6 +2849,9 @@ void *vmap(struct page **pages, unsigned int count,
 
 	might_sleep();
 
+	if (WARN_ON_ONCE(flags & VM_FLUSH_RESET_PERMS))
+		return NULL;
+
 	/*
 	 * Your top guard is someone else's bottom guard. Not having a top
 	 * guard compromises someone else's mappings too.
-- 
2.35.1

