Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2273AF86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFWEkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFWEkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:40:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8932136
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:40:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668711086f4so198524b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687495240; x=1690087240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXozlQ7AGAAc+Nx/NUdVZ9+4KpO/wevqL//8Wl3bnA8=;
        b=JZkAmcGHq0XM4nsbfCm1f7kHv9MXYtpNPYSkjpMZEj94i95KEaw66wEhaDEXP14a0u
         v8UJKbJSz5QSo+cbz1k/Jn3kM0ZCI73rrZrfiPok1GnRO+rKCsXMtzz+f6LH0ISwHvNg
         PomoU6ex9zABeAcfQIPJ3ly1lyoWkasiGVFMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687495240; x=1690087240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXozlQ7AGAAc+Nx/NUdVZ9+4KpO/wevqL//8Wl3bnA8=;
        b=LWGS31mHYN1GZsYJA0ZT4U3AJSAUrTOxJJRnazQJ0QKUktCK7wyYJey2aBIvgZZljR
         nWmrYbKPU6noFzESznC+umR78oQiVs7qfM/lSmdaMwleiIe9e9vGjQZIy0/yYV6UG3BK
         UKVz+tEEjq6UjWflEFWjQr0nqhIrdGaxSVq/g4UdIGVkFdT/sUROyoJ7Hm8uuOG8DHxV
         jlNqdb/FVc8rW/i40AfCV0y1ADI0l9ZF66F3A/CwQ1941KmIR8ithjbs2s+8frOXmT18
         4GmMJ4Eag8CKxdPbTei9ubR+OP8g7O+Wi+7r6YVSfEQ89MfbvtN5X+oWubn9NfNUcxqN
         HlIQ==
X-Gm-Message-State: AC+VfDw7nhR7ymSTYcKMsrI7dRpFWFcUcIn/ssLbZmKM0tu1Pl6UaAla
        rPG+IRfAV1czhtijRTN6zDhimQ==
X-Google-Smtp-Source: ACHHUZ4n1mZuM7TTU/iqzcSryywffqB9jdQbsWlWm4H5TvuH/7J0J6/AUoSNwQC5ppUUQt0Nu5rzTA==
X-Received: by 2002:a05:6a00:1309:b0:64d:42b9:6895 with SMTP id j9-20020a056a00130900b0064d42b96895mr39202386pfu.5.1687495240030;
        Thu, 22 Jun 2023 21:40:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b00666e17004a4sm4237350pff.58.2023.06.22.21.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 21:40:39 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] zsmalloc: move migration destination zspage inuse check
Date:   Fri, 23 Jun 2023 13:40:02 +0900
Message-ID: <20230623044016.366793-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230623044016.366793-1-senozhatsky@chromium.org>
References: <20230623044016.366793-1-senozhatsky@chromium.org>
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

