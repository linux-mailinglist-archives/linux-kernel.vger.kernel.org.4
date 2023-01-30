Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F38681D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjA3VoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjA3VoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:44:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E38A50
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:57 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e6so4863124plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQAnzIUAKIo9PYy8DfeQ6dEwBvy6hOjFsZ5eeKz+fAM=;
        b=NjXIlAyiR0deTTuNNGqVsVHStl1zv2yUiMk8LF3V+2UtWWEHxxEmH/WvTi38H+n0Km
         efIzZVLPFI6fFsWKBixvsI+LtIvzevHWJ+BRJCXj74j2duQD4H9Xu/hhpB7rkZLpWRJL
         U0KGKvqNkZBhudk97/JFB/sv/NyIDA94Lxd5odZrq3EoWC9vFm2nFt+OblfVQNGS0T+8
         wr1lJMCeholQggE+m5KdhOi/3J+J2T7MTpg4IYHPjkee38uGJP/1vgLjpoW86/G+iRBJ
         XDS0eY0nC4YtjetJpiyTakPSzkVZ3XPBLhNeygirPQljkPeCsB2exIMM9QmJ7hRAYQ21
         vjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQAnzIUAKIo9PYy8DfeQ6dEwBvy6hOjFsZ5eeKz+fAM=;
        b=nOnmvRjONIiTu0eQ6k2ztj92ciG8RHig4OQIUWNN/HgKETMn+xdiODPD64OsNw9HLy
         WlVASQZtVy2HMZe0LNLEc+XzefiV8l8qdtcrgAlNITqiLNTtd2Crdq4mpThfzC7uSJK0
         3eootd8lQIDRMXLOaHoEqYgYiTehpVDV4u5laOwwDq4Ff0Fci4jM9QNSIb8f2qC37zlM
         MbHnHmTLwHTd+58bU9/Lme+HrJD17EGX9gXC0PQQpBmZbyGGkX45QoTHdz9CozNVjvlV
         S+UfICbuPTBp/ZyL3AQ0jZpXHefyhfO6xk2jggHMVZqrmSLVpdfFnmogEEle2ZKA82XI
         9r2A==
X-Gm-Message-State: AO0yUKV10KJ1roVsa5Ujgi3b1BDZSrOOGmkeC5zk4kVHgvPkf6xAy/HH
        33Jt4cE5lhlyUzvZaj55aj4=
X-Google-Smtp-Source: AK7set+50P1Topiogo/75E3Ef3QePYzzis+t8Ra6SjIFk0sHPphfrVD3y0rm/SQHvyF6Hg/a1Kiu+Q==
X-Received: by 2002:a17:90b:3ec2:b0:22c:2166:3eca with SMTP id rm2-20020a17090b3ec200b0022c21663ecamr18852242pjb.6.1675115036961;
        Mon, 30 Jan 2023 13:43:56 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id d5-20020a17090a628500b0022bbad75af6sm25156403pjj.1.2023.01.30.13.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:43:56 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 2/4] mm/migrate: Add folio_movable_ops()
Date:   Mon, 30 Jan 2023 13:43:50 -0800
Message-Id: <20230130214352.40538-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130214352.40538-1-vishal.moola@gmail.com>
References: <20230130214352.40538-1-vishal.moola@gmail.com>
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
in migrate.c more readable.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/migrate.h | 9 +++++++++
 mm/migrate.c            | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 7376074f2e1e..c88b96b48be7 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -123,6 +123,15 @@ static inline bool folio_test_movable(struct folio *folio)
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
index b971edbf32fc..fcb2e9fa1953 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -990,7 +990,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			goto out;
 		}
 
-		mops = page_movable_ops(&src->page);
+		mops = folio_movable_ops(src);
 		rc = mops->migrate_page(&dst->page, &src->page, mode);
 		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
 				!folio_test_isolated(src));
-- 
2.38.1

