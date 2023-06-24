Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7372A73C6F0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjFXFbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFXFba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:31:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CB272C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25df7944f60so931541a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687584689; x=1690176689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A39gdokmxlm4U38P/Zql/B/dp1bRrgyGGMBd2ncXVBo=;
        b=LANh1sDQ0Cqew/nk2fWgtBz4HwaykMfnm7u6tguZ9kC8E+QeXfexEIVbVk2ZI1cxKA
         iQQ1M/FSjdcMGc/TD9zjcogPnBiT5Dm3/lo/jXUz2HCzhl0UochpEpS3Afhg5MXLPkzb
         UbOHYYKYV/58KxdqAgSLYHZjfLyRODgzI9/7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687584689; x=1690176689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A39gdokmxlm4U38P/Zql/B/dp1bRrgyGGMBd2ncXVBo=;
        b=WowbCru6yAG/A3YI7Oo4YssiUTrFS7hTgpNjv7aOYSfBwsWkX00xdZBHC56PIBJp+c
         o/tRisSg/bPKIyQ7EfpmsEoanwosys2fkAPV418UBiC/1GmVNkPffbOd20DZ344HO9lf
         +lPWCh07QIlMibvRJE1A1pvRi9vUpdfv5Cq/6QVNRXt9tpmJ6hZRNb1LzJWkr4/GmXhl
         iihi3PrKYbUNX80bc6jHcj307wqvhTFYd70GWxsHFdrP0tyf7PjgOygnBgB+QmgzqcUF
         oAOz2vRmWVroLzPkr6ClN7UqRXZ/oPN6RNjD2BooEm3xAAWdo5SGjdidOmeawrm+E1OC
         um4g==
X-Gm-Message-State: AC+VfDw1e4jS2FVUOEJPuppXtmkX78Mh4BmdXOrSuk7LWDo2jasfBPbc
        HVEH7bySyz9/0qqd90bfH3zhtA==
X-Google-Smtp-Source: ACHHUZ52NiJUM2vh+TDHLpF+yhX0gxBj2JOBI8yeSeM/qrXW8datRm1xeFixMs2KJoNyN7fYpdbnyg==
X-Received: by 2002:a17:90b:147:b0:25c:571:8670 with SMTP id em7-20020a17090b014700b0025c05718670mr22087582pjb.46.1687584688858;
        Fri, 23 Jun 2023 22:31:28 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d7fc:8a97:4a18:6a18])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0c1000b002563e8a0225sm567069pjs.48.2023.06.23.22.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 22:31:28 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <AVRomanov@sberdevices.ru>
Subject: [PATCHv2 1/3] zsmalloc: do not scan for allocated objects in empty zspage
Date:   Sat, 24 Jun 2023 14:12:14 +0900
Message-ID: <20230624053120.643409-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230624053120.643409-1-senozhatsky@chromium.org>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zspage migration can terminate as soon as it moves the last
allocated object from the source zspage.  Add a simple helper
zspage_empty() that tests zspage ->inuse on each migration
iteration.

Suggested-by: Alexey Romanov <AVRomanov@sberdevices.ru>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3f057970504e..5d60eaedc3b7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1147,6 +1147,11 @@ static bool zspage_full(struct size_class *class, struct zspage *zspage)
 	return get_zspage_inuse(zspage) == class->objs_per_zspage;
 }
 
+static bool zspage_empty(struct zspage *zspage)
+{
+	return get_zspage_inuse(zspage) == 0;
+}
+
 /**
  * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
  * that hold objects of the provided size.
@@ -1625,6 +1630,10 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		obj_idx++;
 		record_obj(handle, free_obj);
 		obj_free(class->size, used_obj);
+
+		/* Stop if there are no more objects to migrate */
+		if (zspage_empty(get_zspage(s_page)))
+			break;
 	}
 
 	/* Remember last position in this iteration */
-- 
2.41.0.162.gfafddb0af9-goog

