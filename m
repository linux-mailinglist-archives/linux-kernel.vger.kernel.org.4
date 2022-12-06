Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30864479B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiLFPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiLFPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1782AC6C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:02:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so15027735pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6szhuV271WBRooPiUYxdjBS9FRctTnZzx3+BuNL+4Q4=;
        b=Z8e7g8VSkg7JqHkBqAjKdN+QFOCeoevDFoGXwOSAd/ee3qA5UWiZXi7Xby+6W+6LXD
         4TIjYL9Ufdb4C2aZ3GsGXLaCICrkTQOgEsQ2gEIiM1EBmjFWB5wpWVyVQ/1/7i661MBg
         rsyxjrSh1hIQJGUbYpSgIhT2a55Msluvqmhps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6szhuV271WBRooPiUYxdjBS9FRctTnZzx3+BuNL+4Q4=;
        b=atMc0olNMvQ/wcrYfs5s8b2Vvxk9Fea5aT8THF4Yrz1EVx3fUlchSexE7HdjbUPeSo
         YzxJQwWpR33bPvHZ27t5gKCiIKMjGJBW2pBM2Guj2bbMgElzA9hSQ7qVvskj6h38eyCe
         pkXu8iwly5oMbCTZ+6vTJpHTs4JVUNLyo5GZkrhEKHTfRdATjaeOkw05qe7VG028zVqN
         OZT8YO5bjo+36WS6dz3PXAaCp9cSqhzKzyOsg7fa2M5oghnH3l2iPXv5P4UXxbQrE0Xx
         tu4qQ1aZfBSKNtluoRThKC2DfdRcmzPQS5fdlGzTxAOwCF8R+K3Aw3uJNi3hKDvLIVic
         xJTw==
X-Gm-Message-State: ANoB5plgYcRtZIy3xc/PfLq5tdMMIrpDZ86mxx5zQRZm+EGjx04xG9xL
        G/MyQfGVEQaHvBy6StzaGYhhZQ==
X-Google-Smtp-Source: AA0mqf73o+/ioSQzoTjsLzlyHEzPeoFPnI5gs96npnnroF1tNidRpEvUBkwQWbI4ZJLPCmhoyBrZqg==
X-Received: by 2002:a17:90a:1bc2:b0:218:8bdb:de3f with SMTP id r2-20020a17090a1bc200b002188bdbde3fmr85820069pjr.225.1670338975208;
        Tue, 06 Dec 2022 07:02:55 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3343019pfu.61.2022.12.06.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:02:54 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Tue,  6 Dec 2022 15:02:31 +0000
Message-Id: <20221206150233.1963717-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206150233.1963717-1-jeffxu@google.com>
References: <20221206150233.1963717-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application won't be able to modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example: 3> shall be right after 2> in steps below.
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.


Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index ec70675a7069..92f0a5765f7c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	/*
+	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

