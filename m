Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA78373AF85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFWEkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFWEkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:40:36 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493852126
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:40:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b71cdb47e1so280626a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687495233; x=1690087233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A39gdokmxlm4U38P/Zql/B/dp1bRrgyGGMBd2ncXVBo=;
        b=Cbp1e0QDlBoMFSQUoDU44b/Cu4zloKVkubwfpVG0voArrICkUtyxlHNDLJm7uQaPWs
         yMtq2C3UOdpl3PwFBZ6fbcJm75BISUhsaIgsCU5qiVlrVsBW+skGS0Karwa520O8DOTP
         ScA5bFfNO0Evz3c7RIm+D6tZD1CBxKd0YmmyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687495233; x=1690087233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A39gdokmxlm4U38P/Zql/B/dp1bRrgyGGMBd2ncXVBo=;
        b=YOhcC/C4bL3dkjLwTN/HxBHP3iYC8TUJKMYNFNleZQZoE0ij+mvPk5TW9EsqauVjVN
         c25SnukxJ764oT4Dx3/BcVXn9i2CXnV/murWNnF35CvBNyVoMxaS8oi8LbL2XudEYBIf
         ieBsPBwSIRCpVN+G7qXZjxmtycNk4cTVMHcoKrZA8beZ7uU9xWIVV/wOSZM5k93/3RmY
         FqwGkMzc2ISpdm2JUA4HxIyePUsitKD4K+HOwo0+kXWXD7SDLbAFc9rv0dVZdVB8nmxk
         PVr0ekf9t8bYx29EyDpDd6IH1myZWzD9LvsnmlBI8QkbLMqZ1U00G4Af+rx5WQR8xCqZ
         sEYw==
X-Gm-Message-State: AC+VfDwV3sS0tIz+rEnyWsZ1RikC4IAP6ylHjHtc7zmNYq3fTrhf5KKw
        kgtzW/0rO6BeGS/WodSykPqu6Q==
X-Google-Smtp-Source: ACHHUZ40SAmzVB3zyhbJ6Kmva/XRtgJ/rNm6Czlb8EAz6WtSXnsypo+QCnvyyJ2uHG4IQuWlO/8oRA==
X-Received: by 2002:a05:6358:edc:b0:12b:c378:b090 with SMTP id 28-20020a0563580edc00b0012bc378b090mr14548296rwh.26.1687495233523;
        Thu, 22 Jun 2023 21:40:33 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b00666e17004a4sm4237350pff.58.2023.06.22.21.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 21:40:33 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <AVRomanov@sberdevices.ru>
Subject: [PATCH 1/2] zsmalloc: do not scan for allocated objects in empty zspage
Date:   Fri, 23 Jun 2023 13:40:01 +0900
Message-ID: <20230623044016.366793-2-senozhatsky@chromium.org>
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

