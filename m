Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD036AB4D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCFDDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCFDDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:03:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6754193DB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:03:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ky4so8788482plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 19:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wneh97F1nMdoO/GWBYTh+FCpx49GDmImprYvE+tMGQE=;
        b=mvYZTLnMDzqZPw0EObR6IP1bqYOQ6tPuLXfY7xHMKAH7j8jrQKrS1JHwphC8/GTqe8
         4xxtq5FjexX8PsrMWL7aNFe4yld29ji2KCki8LpGN4790OXnMpAYGVp4kBbZ8dnrGrMM
         1iaerc/FEIt5qb6xFS4ynYEU4aqQLjswq24G/gyhza1Ko09zCMolEnZT0FghHnmhV3jd
         YNShaiXqZWYoYDQ28qel8wZxtFO2dTktPcZUK9juVERYV2Qci7OCO+tFoKztyLx2HIQI
         KwOSOxHWUoWK0jJtLXLy49s/JkMdmbPQXVvuPpP7ByYWalcW31aBRc7j5Erzq35nNXj2
         STNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wneh97F1nMdoO/GWBYTh+FCpx49GDmImprYvE+tMGQE=;
        b=oy77jmu3TJrTwm/IQYCJCAH8SyFl2ioUj+HYVemOEG3zY7AabPoMKUd4Auwa8jCVb2
         OGdQzm4Sar1qsjGePFVKOYwasxfnLTCyFOVmVQ3Z1nEDaEjEeExB65bCyF4gsEfLzPJo
         B+oX3+n6ghNbMukAriaQpoHfa/jp7ddc35rmA6uO8VQGgp8xd+neyvXj7NZWBBqc34pl
         Jlv9ByxSexfa6ifto89xjUK/BGkgafDlP5Kv73N9His0ozIAUWsOaH2hSshRemxhM9QI
         3E950Xs2chsyD0oZFbx/XxEaytcbyU/51di5/VlhQxnj6sHYBAtBJJcboRozf/Kn7suX
         TUlQ==
X-Gm-Message-State: AO0yUKVNd4xjwcxRn5YT6quN0Z/urnPU2sicocFDGmB+9p9DqpnYS1zE
        PGYkX8+VRKvWjJuY0YwV0w+zcqt/oQ==
X-Google-Smtp-Source: AK7set9ZT3V2MdQmOCnCAefBY22UCEzOMyO2IU0j9xpnm0GrmRPbiXTc8e7zd/VuGWUzN5tbfyDKKg==
X-Received: by 2002:a17:902:bd93:b0:19c:be03:d1a3 with SMTP id q19-20020a170902bd9300b0019cbe03d1a3mr8853729pls.40.1678071814870;
        Sun, 05 Mar 2023 19:03:34 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:34 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 2/6] lib/decompress: Introduce decompress_method_by_name()
Date:   Mon,  6 Mar 2023 11:03:01 +0800
Message-Id: <20230306030305.15595-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
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

The zboot image packs the compressed file in the data section. Instead
of starting with the zip file header. It records the compressing method
name 'gzip','lzma' etc in the zboot image header.

Hence it is easier to decide the decompressing method by the name than
by the magic number.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/generic.h |  2 ++
 lib/decompress.c                   | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/decompress/generic.h b/include/linux/decompress/generic.h
index 207d80138db5..077f15ce77b9 100644
--- a/include/linux/decompress/generic.h
+++ b/include/linux/decompress/generic.h
@@ -37,4 +37,6 @@ typedef int (*decompress_fn) (unsigned char *inbuf, long len,
 decompress_fn decompress_method(const unsigned char *inbuf, long len,
 				const char **name);
 
+decompress_fn decompress_method_by_name(const unsigned char *name);
+
 #endif
diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc64..8dd6f87e885f 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -2,7 +2,7 @@
 /*
  * decompress.c
  *
- * Detect the decompression method based on magic number
+ * Detect the decompression method based on magic number or name
  */
 
 #include <linux/decompress/generic.h>
@@ -82,3 +82,15 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
 		*name = cf->name;
 	return cf->decompressor;
 }
+
+decompress_fn __init decompress_method_by_name(const unsigned char *name)
+{
+	const struct compress_format *cf;
+
+	for (cf = compressed_formats; cf->name; cf++) {
+		if (!strcmp(name, cf->name))
+			break;
+
+	}
+	return cf->decompressor;
+}
-- 
2.31.1

