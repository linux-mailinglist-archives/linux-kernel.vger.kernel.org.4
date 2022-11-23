Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBC6369BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiKWTRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbiKWTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:17:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF83C78FC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:17:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so4320156pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruO+YinHt02cD7LDLng29WAK5pZvQbCFBqvYCl3hrTY=;
        b=ixSC8hDnbztU0OC/soKUCSkVcuZpNhHZrTMy73xNCHzzfaOyQag8wcAC0zxDGxBQEL
         cFv7auDe3Fi4p541vWWnL5tcLNc4ebxoGg0/B1hK8LUhXQmzZgDYmUKupPy06uvdhq+u
         pZ/qgHC8iO7qPQHIiBSf2jxM95OSvjRzimzrdE/EZR2Fz8kS07wolWVCu7u8UnPTSxL/
         8f96Cj1m0EalvWOY5NWkL9XLuCj8AWz+EPKHmBSSQ4uS1ymXh/gwxuCrYA0BxUh72CNF
         w9kAwhEjdjC6kPN96wiobHFCgI++KuKuykXndt6lKhDz6zmY/05z3P/IVvnwBJCzZpMr
         yocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruO+YinHt02cD7LDLng29WAK5pZvQbCFBqvYCl3hrTY=;
        b=K8Z3i6nwYPdnAU6SUJR1F0ZhjuQeGlnC/wwg9dzkU+QS8jYhf42SLt2/LglkpVgIii
         sVbGuEOtCTAGTdYbsAUjM0QBcuyanzWJGd4Vu6L/oakY2CoB/WkSYNFfj5mHF/d2ac3L
         kRc09nWYAT2UEexWkC55gdaHP1fa0j+r1YoMPLpf44i2wcaT2G4KUyXtnPGj0qpMuuvH
         ZGpX4NgUCaeUsk+39laH/xKDcQTIZtfbDsRRkSHbkJ9okO2PQazFF0ov7TSVbxdswZmk
         kCTr0dfFPvSYbrThfj++rRm1CN2Uq0WlJ2GNqN1sj/nH/zy8fJKre9ftzTNt8Cdm4U9o
         QPww==
X-Gm-Message-State: ANoB5pmL5i2OKCEK9KS4jIWDu1PXE+tY25OOv/LtbCnNNJjUAqsU5eUg
        Z2MnfjWijKMhoazDBnBrkgc=
X-Google-Smtp-Source: AA0mqf4fu3wefIa6SqzYOVIVfrC/54k3vFrt9n7lwzLX39tBI4jKV6KQ5AhqX2J+InZUOp9d3J2+fw==
X-Received: by 2002:a17:902:ab1d:b0:188:f5de:a8e4 with SMTP id ik29-20020a170902ab1d00b00188f5dea8e4mr11050853plb.133.1669231027538;
        Wed, 23 Nov 2022 11:17:07 -0800 (PST)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b00180a7ff78ccsm14790814plh.126.2022.11.23.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:17:07 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for zsmalloc (fix)
Date:   Wed, 23 Nov 2022 11:17:03 -0800
Message-Id: <20221123191703.2902079-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123191703.2902079-1-nphamcs@gmail.com>
References: <20221123191703.2902079-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use get_first_page(), and add cond_resched() in retry loop.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e2bd41f37b5b..ab4fa17a0fad 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2488,12 +2488,13 @@ static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
 		remove_zspage(class, zspage, fullness);

 		spin_unlock(&pool->lock);
+		cond_resched();

 		/* Lock backing pages into place */
 		lock_zspage(zspage);

 		obj_idx = 0;
-		page = zspage->first_page;
+		page = get_first_page(zspage);
 		while (1) {
 			handle = find_alloced_obj(class, page, &obj_idx);
 			if (!handle) {
--
2.30.2
