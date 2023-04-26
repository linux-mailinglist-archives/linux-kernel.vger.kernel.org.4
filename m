Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220AE6EECE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 06:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbjDZEMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 00:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbjDZEMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 00:12:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB826B9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:12:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51f597c975fso6706707a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682482354; x=1685074354;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1WEqmaMBFmHP4p7ngRgW+kux9X7VvJXBfEqvQ44Wow=;
        b=FkNan6seMjrCrf/+Y0Ne53q39DQC2hptzm8MXKt6vLlLuxLwlRNRrFs8YFuWKByRS5
         M/sOGNSLfOa+fFffafOUQbpHFS0qET5gxIGdgyOdiEkYC6o3QcUFEZHP5lmslR1DqJr6
         3cYklHnsd6GZ6g2uL9oLhcZV6gT1NXzKcDAMiuH5eZ0WL+xX/hAoyhxLBZBWACuQFCC5
         G18s+WD22+5jJCyrORTFE0lIQhE0QNJ0M8avMMIU5aA8ET3uLmcegPdswv8wvy0RxAKP
         CAdzT/QLHCoAAtACqUg73dXNGlInjK7+wI2M99AS12hM4rJwpItoZNt7jPF9P9LlVnCO
         zSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682482354; x=1685074354;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1WEqmaMBFmHP4p7ngRgW+kux9X7VvJXBfEqvQ44Wow=;
        b=Do+SwR2I9LRoGpZ7wVI8q4HlewOJpiFKGEDuyqwkwmZ7O6NrQzDnhi/MAovWTf8R0w
         /wQf099jmL9lmEh/QQww+xxff/LErISn5n6p/JbioXw0WQ8xZci76Fboh9PWayi8eZZ9
         Zn5EymKdB4uu9eTlmQSI7VsL1p9sZGaC382dMDRhzc8pX9rhqeTaEFD7ffpivLlthNlC
         KoW4oFhy+DbMvDLohNeIR4Kz0ihrIFJRBtaffx1I0z2kY9Ng55V614gWKv3FqBu9m1S4
         bdReJjW7icCdnmSmQhT4QxUHdLw9Fdx4c1wfuB7WFXNbVQiGRL/fG7YCD5cExJYdO+D3
         2Sfg==
X-Gm-Message-State: AAQBX9fs4vHa6BBeEtkHo/DfRL1R7IwgzkwLErDxIVt5HqXblrXRjm6d
        bxe2VzrMLXZigKUuVIN5zQU=
X-Google-Smtp-Source: AKy350bN3ku3tn8Ik9slYIdmFWsMuTaJMXfPG00UyeUr8poZu/xi8hZysYSE9D9VZJN7JMNKfEPt0A==
X-Received: by 2002:a17:902:dacc:b0:19e:ab29:1ec2 with SMTP id q12-20020a170902dacc00b0019eab291ec2mr26919278plx.65.1682482354637;
        Tue, 25 Apr 2023 21:12:34 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001a68d613ad9sm8983193plz.132.2023.04.25.21.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 21:12:34 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Subject: [PATCH 2/2] erofs: replace global decompressors[] with stack memory
Date:   Wed, 26 Apr 2023 12:10:27 +0800
Message-Id: <e9d0a320fb45d74f1f602dd77f685d1bae59325c.1682481589.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
References: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
In-Reply-To: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
References: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

Note that only z_erofs_decompress() is using the decompressors[], so no
need to keep it as global resource, just use local one instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index f416ebd6f0dc..91d91bdd068f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -368,25 +368,24 @@ struct z_erofs_decompressor {
 			  struct page **pagepool);
 };
 
-static struct z_erofs_decompressor decompressors[] = {
-	[Z_EROFS_COMPRESSION_SHIFTED] = {
-		.decompress = z_erofs_transform_plain,
-	},
-	[Z_EROFS_COMPRESSION_INTERLACED] = {
-		.decompress = z_erofs_transform_plain,
-	},
-	[Z_EROFS_COMPRESSION_LZ4] = {
-		.decompress = z_erofs_lz4_decompress,
-	},
-#ifdef CONFIG_EROFS_FS_ZIP_LZMA
-	[Z_EROFS_COMPRESSION_LZMA] = {
-		.decompress = z_erofs_lzma_decompress,
-	},
-#endif
-};
-
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct page **pagepool)
 {
+	struct z_erofs_decompressor decompressors[] = {
+		[Z_EROFS_COMPRESSION_SHIFTED] = {
+			.decompress = z_erofs_transform_plain,
+		},
+		[Z_EROFS_COMPRESSION_INTERLACED] = {
+			.decompress = z_erofs_transform_plain,
+		},
+		[Z_EROFS_COMPRESSION_LZ4] = {
+			.decompress = z_erofs_lz4_decompress,
+		},
+#ifdef CONFIG_EROFS_FS_ZIP_LZMA
+		[Z_EROFS_COMPRESSION_LZMA] = {
+			.decompress = z_erofs_lzma_decompress,
+		},
+#endif
+	};
 	return decompressors[rq->alg].decompress(rq, pagepool);
 }
-- 
2.17.1

