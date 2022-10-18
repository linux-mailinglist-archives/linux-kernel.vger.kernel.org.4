Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB9602393
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJRE5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJRE4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:56:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3DDA344A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:56:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c24so12738440pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M5hW54OP3FcHBFbXUW0BvyRXPUP5sF32vTgPzuINJw=;
        b=OpPjLqj+j0EF5h4VtuAZp6f+eGdl/5fSvLw56hi7HO01ZV6gqL3LhfNt4tuqvbFZWL
         B9Zo2V1IhStyc8xGnpweJqdk5JOPtoGtNyRZvNKx+nA/GCWy7rPkstTlJfT4GGbEyOzL
         khin31KlV69YEer+c0KA1hT4XmJY8qBrHD7bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M5hW54OP3FcHBFbXUW0BvyRXPUP5sF32vTgPzuINJw=;
        b=mSJf3fII1EzdyIqhmJCm1b5h3fZo7jkWmbPJjnQrG2wxPRQyXZBafUEUVD5/Lp9U6f
         Zp4T5u+7obVYrace19qMkzd6KQgYu4CaBZIneVEUaHXEbeB/5uyuCx8/GQN5vMHFwUNJ
         MDAgFnrn6M4O8HlN9k+1/Y2FLEzvTHdyMXvwl4E+tcjVbhxGOg2Yxx74ALst+KiBIao7
         +6cNMI67zgzJoZFSsHqKMGNF9V/j9IVMdGZDk6fbFgBVtrR4ODg01SH6JFo/mSknDvNw
         GWek+I6KzwNl9wNKcd7gf1OqRwBOEd4ICm4PByUwPe0XvMmqa5KPBtdnwtqU8NOTcxep
         1Zfg==
X-Gm-Message-State: ACrzQf2n3RTG1f2NAhK10wQsVD1CrIl0/4MBosdvrhdUmFP0hCL7e9gO
        EWy/xNl8WsYNjGAmxSg896jCpw==
X-Google-Smtp-Source: AMsMyM6MKM49SbK5pAtcJa9D193BGaOIJJk0SqOeD46rdK86Nh8j/RagnI/d8Ulw0ikvj1yWjSgb+w==
X-Received: by 2002:a17:902:e5c3:b0:185:53ee:60e3 with SMTP id u3-20020a170902e5c300b0018553ee60e3mr1397002plf.71.1666068964804;
        Mon, 17 Oct 2022 21:56:04 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:17a9:73b0:c262:eccd])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017b69f99321sm7549220plf.219.2022.10.17.21.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:56:04 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 9/9] zram: Use IS_ERR_VALUE() to check for zs_malloc() errors
Date:   Tue, 18 Oct 2022 13:55:33 +0900
Message-Id: <20221018045533.2396670-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018045533.2396670-1-senozhatsky@chromium.org>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid type casts that are needed for IS_ERR() and use
IS_ERR_VALUE() instead.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6b56f6f2ce82..422e3cfd2ddc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1506,19 +1506,19 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	 * if we have a 'non-null' handle here then we are coming
 	 * from the slow path and handle has already been allocated.
 	 */
-	if (IS_ERR((void *)handle))
+	if (IS_ERR_VALUE(handle))
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				__GFP_KSWAPD_RECLAIM |
 				__GFP_NOWARN |
 				__GFP_HIGHMEM |
 				__GFP_MOVABLE);
-	if (IS_ERR((void *)handle)) {
+	if (IS_ERR_VALUE(handle)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
 				__GFP_MOVABLE);
-		if (IS_ERR((void *)handle))
+		if (IS_ERR_VALUE(handle))
 			return PTR_ERR((void *)handle);
 
 		if (comp_len != PAGE_SIZE)
@@ -1685,7 +1685,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 				__GFP_NOWARN |
 				__GFP_HIGHMEM |
 				__GFP_MOVABLE);
-	if (IS_ERR((void *)handle_next)) {
+	if (IS_ERR_VALUE(handle_next)) {
 		zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
 		return PTR_ERR((void *)handle_next);
 	}
-- 
2.38.0.413.g74048e4d9e-goog

