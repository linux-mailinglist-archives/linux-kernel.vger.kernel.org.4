Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245E96E54FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjDQXKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDQXKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054542D60
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681773005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9KwBP9Man5SYvHcbBmo3b28W9QLZLArX7nGl4kEM31Y=;
        b=bI/Xv1C7FFLj6ay58uoCuJm3z0YNE3gZk2RyQxoggrGlRZ9clBuV6UBxtHICDX6yGKbwO2
        jgXaIjphqHEqAJ6lpPTRIZVmHq40OaiHs5Yjm3mLbdgR2oN12I1pkNzhMc/Ejl5ldYP54V
        FsQl3FvS5WNeXZ4yQ/31Rar1T+ILyJA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-YCT7JLDXNtiEzYQ3tp7DUQ-1; Mon, 17 Apr 2023 19:10:04 -0400
X-MC-Unique: YCT7JLDXNtiEzYQ3tp7DUQ-1
Received: by mail-qk1-f197.google.com with SMTP id s72-20020a37a94b000000b0074def2d4b31so1965518qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681773003; x=1684365003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KwBP9Man5SYvHcbBmo3b28W9QLZLArX7nGl4kEM31Y=;
        b=A2PZpYDu/vcrspDkg4Wz2v8naeLo4PULnOesJfY9JJjQQujtEne0A9Gf3A4WxF5W1A
         7juI/Ir34l7BVf4TmZn+6kwuKvnT3Wv85+C/CuhW5O2lgQTfsAxof4yJjfv7HnBMdZOF
         4tA1pPUNek/jkICUZ58lw8+prp1RVyD/dTM0RMR5EQmmvMcyijf82qLR0sP8uBot/t2x
         dZaosZUWYFEL2QR4dK9trOAgImWjGFCH4sE0C+crWCgtuqvFTA8GbnuBTKodCleGPLeu
         XvOxyKD3LRyMn3/CvH/6w97p9mZntZ32qvKpzQ0UHcvW/8fgX8P0xbnk5BgEj84R6w2h
         BONA==
X-Gm-Message-State: AAQBX9f5B+1JIPFw1R8YdU5HonlN1FTNQoUh3/aqwj+saTYNz+a84So5
        5dponOSORO+IVW4X9RBURFCd2FKQzmfi700p8FLU9K8Slst1tplqX9Rl3dPsLDrv/ieboCd6HJh
        BiSnrJJOc9o7aNx4tFO37M6ya
X-Received: by 2002:a05:6214:202d:b0:5c8:403a:22f8 with SMTP id 13-20020a056214202d00b005c8403a22f8mr20199720qvf.5.1681773003530;
        Mon, 17 Apr 2023 16:10:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350bd/2/c5QbKCswcHJPCu2Ivyl4odfLfeqheGCnBG0dmlgXXCyJCkdUwofowvXv/jLIeXWkPpw==
X-Received: by 2002:a05:6214:202d:b0:5c8:403a:22f8 with SMTP id 13-20020a056214202d00b005c8403a22f8mr20199697qvf.5.1681773003276;
        Mon, 17 Apr 2023 16:10:03 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b6-20020a0cbf46000000b005ef465ad69bsm3337943qvj.23.2023.04.17.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 16:10:02 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mcgrof@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] module: remove use of uninitialized variable len
Date:   Mon, 17 Apr 2023 19:09:57 -0400
Message-Id: <20230417230957.3221615-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build reports
kernel/module/stats.c:307:34: error: variable
  'len' is uninitialized when used here [-Werror,-Wuninitialized]
        len = scnprintf(buf + 0, size - len,
                                        ^~~
At the start of this sequence, neither the '+ 0', nor the '- len' are needed.
So remove them and fix using 'len' uninitalized.

Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/module/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index d9b9bccf4256..f0619170bd3d 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -304,7 +304,7 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 		return -ENOMEM;
 
 	/* The beginning of our debug preamble */
-	len = scnprintf(buf + 0, size - len, "%25s\t%u\n", "Mods ever loaded", live_mod_count);
+	len = scnprintf(buf, size, "%25s\t%u\n", "Mods ever loaded", live_mod_count);
 
 	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Mods failed on kread", fkreads);
 
-- 
2.27.0

