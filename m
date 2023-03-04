Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149376AA7E2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCDDsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCDDso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:48:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4E1BAD1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:48:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u5so4771707plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEq3MDoFcR7yz1bLKCGz9x04eW60/3Ets++p8vd9Ctw=;
        b=OSN6KWn7hEXJmiSwcCwf+j4CxdT8wPCagEal0qiSFk+/V8atkJMsWd9LYZUtjmsPXr
         9CRmtA+NB7lVYdNh98oMEGUcsk0IzMtp3hVLlNUeYtTmnR1IdOQSDJgHlTb/6bPe258k
         cYr52SWQApBs9ogj8FNmQ3LcCt0GmMZsOzeLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEq3MDoFcR7yz1bLKCGz9x04eW60/3Ets++p8vd9Ctw=;
        b=ySC2RAwZ2egMCRKbD9JvSFdPlwekXOFlIT5yB5Syv01FGoAUcEzQYA11V9rM+RHooz
         o3Xf26QVWjjfczelKx5rjY8T/mz2G4fo45zRnqjbHtLwM7k7KA3TJRuJEa6rkR4k1Gol
         f2QI3xg2c/7wvcARltn8K57941dN5/4vFcA64PQSW+WfyLUASnGME8uXAIhCN8CEQDxL
         kKFMW1/JDz+Nh+6ZUmWI4T5JUvMBJLDoKWBWd0AF+u3JZQy2m7L86+TaqWimFYecy9hU
         t9plrJ/FAqsE5/59xIf4DvrQ+BdL2jk2qtEhR3s7XUvvbHEv+n7ABJ6jWbpREf2TxZ37
         rEKA==
X-Gm-Message-State: AO0yUKVNqql9V+0IDtT15/xD0l3M+68f0z5Gj82VOgjz2E9FM6kKabzB
        ejX35AdJ/3NEDzuQyIM6cDeyQw==
X-Google-Smtp-Source: AK7set/tt+odDA27bkzjmHOQ+zF7n6+n5T9hL7wxUbL0XcZs6V/tJCFYEzPfag5hO0XniqIk8YzmhQ==
X-Received: by 2002:a17:902:ce92:b0:19e:27a1:dd94 with SMTP id f18-20020a170902ce9200b0019e27a1dd94mr5079134plg.35.1677901723382;
        Fri, 03 Mar 2023 19:48:43 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6ac2:6eee:5465:7ee6])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902c18600b00199025284b3sm2249204pld.151.2023.03.03.19.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:48:43 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 1/4] zsmalloc: remove insert_zspage() ->inuse optimization
Date:   Sat,  4 Mar 2023 12:48:32 +0900
Message-Id: <20230304034835.2082479-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230304034835.2082479-1-senozhatsky@chromium.org>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This optimization has no effect. It only ensures that
when a zspage was added to its corresponding fullness
list, its "inuse" counter was higher or lower than the
"inuse" counter of the zspage at the head of the list.
The intention was to keep busy zspages at the head, so
they could be filled up and moved to the ZS_FULL
fullness group more quickly. However, this doesn't work
as the "inuse" counter of a zspage can be modified by
obj_free() but the zspage may still belong to the same
fullness list. So, fix_fullness_group() won't change
the zspage's position in relation to the head's "inuse"
counter, leading to a largely random order of zspages
within the fullness list.

For instance, consider a printout of the "inuse"
counters of the first 10 zspages in a class that holds
93 objects per zspage:

 ZS_ALMOST_EMPTY:  36  67  68  64  35  54  63  52

As we can see the zspage with the lowest "inuse" counter
is actually the head of the fullness list.

Remove this pointless "optimisation".

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3aed46ab7e6c..abe0c4d7942d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -762,19 +762,8 @@ static void insert_zspage(struct size_class *class,
 				struct zspage *zspage,
 				enum fullness_group fullness)
 {
-	struct zspage *head;
-
 	class_stat_inc(class, fullness, 1);
-	head = list_first_entry_or_null(&class->fullness_list[fullness],
-					struct zspage, list);
-	/*
-	 * We want to see more ZS_FULL pages and less almost empty/full.
-	 * Put pages with higher ->inuse first.
-	 */
-	if (head && get_zspage_inuse(zspage) < get_zspage_inuse(head))
-		list_add(&zspage->list, &head->list);
-	else
-		list_add(&zspage->list, &class->fullness_list[fullness]);
+	list_add(&zspage->list, &class->fullness_list[fullness]);
 }
 
 /*
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

