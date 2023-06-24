Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B986B73C6F1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjFXFbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFXFbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:31:32 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA53272C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38c35975545so1123520b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687584690; x=1690176690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXozlQ7AGAAc+Nx/NUdVZ9+4KpO/wevqL//8Wl3bnA8=;
        b=hEVV1PKnoqRDlkdskPail3UwTi3zNM443LUxpwYsTN8oCAj3XIMmoMXFJnsnxbV+DF
         wzOj3dtWSlkKaMPk+9t+QowWS3A47K6hiYh9dpNM6u2Wfey5nHSVhk3Ym5ox5sYyZzes
         K0dyi1ixw9OexMvrCK8P+ImImK/L+xRxsbVYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687584690; x=1690176690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXozlQ7AGAAc+Nx/NUdVZ9+4KpO/wevqL//8Wl3bnA8=;
        b=KaGdV4zt/2+uH50VPwk65i0F93uGfBHVyeyKpgcrIgED5ixT/uq4AbjT0zGQPlZcxu
         O1oMcRcwq0iglQ57n6+p9hirlpjTguozG9HZvI2OmDqxHQjQtecwdQ0JA+r3H2xGOFsR
         JgWg0Ie+TTyBhduy5mO2v41yhTGEY6NP21jq/dIMcdD85uVNz/ECdUBusfn7w2hYv+Sz
         ZD9Q9wb16DoBiwcvtczwQzrI0xC22fQV2eZiWYPRgQW5yd+mdVHZpy0u2f1NP46fKZY4
         VQX2MxfdpxZFB47dlhNHMkEt10e0W5Wy7RS6ppPDMytwhYnlRZyVDqsU/pZkDDScAokR
         EAlQ==
X-Gm-Message-State: AC+VfDwD4zKzUdbwR8QIK/Q1cqVkjNGv55ha0L4MY391t0fmiGStC3++
        vSmxcXktdC7lD+10lt9UjuiCgA==
X-Google-Smtp-Source: ACHHUZ5mbSYPloXGVoYuwedg5AUrAtc+B9JDYGgNuwbVgnUzI6YASvLhcPdKURnsv6EOXnYZm8NkVA==
X-Received: by 2002:a05:6808:1524:b0:3a1:c0bd:c51f with SMTP id u36-20020a056808152400b003a1c0bdc51fmr270508oiw.28.1687584690736;
        Fri, 23 Jun 2023 22:31:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d7fc:8a97:4a18:6a18])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0c1000b002563e8a0225sm567069pjs.48.2023.06.23.22.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 22:31:30 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/3] zsmalloc: move migration destination zspage inuse check
Date:   Sat, 24 Jun 2023 14:12:15 +0900
Message-ID: <20230624053120.643409-3-senozhatsky@chromium.org>
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

Destination zspage fullness check need to be done after
zs_object_copy() because that's where source and destination
zspages fullness change.  Checking destination zspage fullness
before zs_object_copy() may cause migration to loop through
source zspage sub-pages scanning for allocate objects just to
find out at the end that the destination zspage is full.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d60eaedc3b7..4a84f7877669 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1620,10 +1620,6 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
 			continue;
 		}
 
-		/* Stop if there is no more space */
-		if (zspage_full(class, get_zspage(d_page)))
-			break;
-
 		used_obj = handle_to_obj(handle);
 		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
 		zs_object_copy(class, free_obj, used_obj);
@@ -1631,6 +1627,10 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		record_obj(handle, free_obj);
 		obj_free(class->size, used_obj);
 
+		/* Stop if there is no more space */
+		if (zspage_full(class, get_zspage(d_page)))
+			break;
+
 		/* Stop if there are no more objects to migrate */
 		if (zspage_empty(get_zspage(s_page)))
 			break;
-- 
2.41.0.162.gfafddb0af9-goog

