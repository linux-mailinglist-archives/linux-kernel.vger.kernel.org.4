Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C3676296
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjAUA4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAUA42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:56:28 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0595B595
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v23so6783855plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihs1lPGJTYH/n9uC2fe/fD/dm6RWAiMecmovGp89G+Q=;
        b=A9nMCXlGrTqywtDFEfUariM/BfBgw9tPr05X918ldhS3Cu8cLbDOnUt4IHI8cDjU9w
         49nw+/16Ryq22+rCTZUVMFGLFZgWulbUbprCZ3vfI16Ud7B4bZMF/ZhNzKbC6LVlsUJt
         +K2qy/EK67DYDoA200hvQRXG09r5dkMibL1V0xjVkIytwR2rScU+j9AFwwdm0E9ly3z0
         SdOngM9jmr/53yHpdGwpEJ5Rn8wauhFJvD0MPQPIeKc9YtCtyrQ2Jq6H6ChN9/yey34J
         IQ0ZHqHln+eSb16AVAJJ7e+F4T25/ZoIbc2UwK7MDGBqBQCoiu4t4lkWgyXBhouCouZK
         GcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihs1lPGJTYH/n9uC2fe/fD/dm6RWAiMecmovGp89G+Q=;
        b=qe7AQGDFuycajMaRxKe3IcmfxJmAof4Y71H9l3XA4fAWL1HnMmZmn90rrOOBzjx+OO
         AhBV0xNYa0cGR0p31Ud0LDESBcHvh02VP0hCetRr75RH78vS0eqh9+WFUhbBvq4H0rHL
         CKlsSCiTFmvqBR4IlU6rhy1J8ulITInEh29TSIGtS2X4yABa9pDrYDOdEwwqmAmAcgBx
         DJVLl6juq7ampEadB0YL4KlIm5mKLkWklXhimHXBpmDwSC/aoivV6zmUS4jn3gFcXXZG
         K7Mhl4+N0vxIpUoNDsWam2aCqO4IIRxBnqxKLxJAyMxKMoLD4a0Lp76cOecPpsTj1srT
         ZEfQ==
X-Gm-Message-State: AFqh2krmVnqsJxuu7L8ftu6j5gLouZITaLoofXmjZXdKmihrawBuDizY
        tuhEJ7zVSqBaT7G6iK8ZckM=
X-Google-Smtp-Source: AMrXdXvL7hanGT1T1ZbT+ZacwQm3dlBDi8+nw4wDgXRp1QQbt4DzagEkee9xVp1F7Ltbp5BGj7kUjQ==
X-Received: by 2002:a17:90a:b002:b0:229:932:a0f3 with SMTP id x2-20020a17090ab00200b002290932a0f3mr17793784pjq.27.1674262587454;
        Fri, 20 Jan 2023 16:56:27 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id pc3-20020a17090b3b8300b001fde655225fsm11314371pjb.2.2023.01.20.16.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:56:27 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/3] mm: Add folio_movable_ops()
Date:   Fri, 20 Jan 2023 16:56:20 -0800
Message-Id: <20230121005622.57808-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121005622.57808-1-vishal.moola@gmail.com>
References: <20230121005622.57808-1-vishal.moola@gmail.com>
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

folio_movable_ops() does the same as page_movable_ops() except uses
folios instead of pages. This function will help make folio conversions
in mm/migrate.c more readable.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/migrate.h | 9 +++++++++
 mm/migrate.c            | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3ef77f52a4f0..bdff950a8bb4 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -122,6 +122,15 @@ static inline bool folio_test_movable(struct folio *folio)
 	return PageMovable(&folio->page);
 }
 
+static inline
+const struct movable_operations *folio_movable_ops(struct folio *folio)
+{
+	VM_BUG_ON(!__folio_test_movable(folio));
+
+	return (const struct movable_operations *)
+		((unsigned long)folio->mapping - PAGE_MAPPING_MOVABLE);
+}
+
 static inline
 const struct movable_operations *page_movable_ops(struct page *page)
 {
diff --git a/mm/migrate.c b/mm/migrate.c
index a4d3fc65085f..4c1776445c74 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -973,7 +973,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			goto out;
 		}
 
-		mops = page_movable_ops(&src->page);
+		mops = folio_movable_ops(src);
 		rc = mops->migrate_page(&dst->page, &src->page, mode);
 		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
 				!folio_test_isolated(src));
-- 
2.38.1

