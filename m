Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88776633234
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiKVBeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiKVBdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:33:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E8E06A8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:33:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p12so12206135plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUuSpc6C+EWicKThxRXH7zHFoDctbTavto9TGkNgwqg=;
        b=YDCgA5iLVRHov7CSFOzKyS+DAzYZ+IvJ03MR4Sv4SfTmjSMDNZHUUzCIBVUVmFT8uv
         JKfDo3JrYanqKt0RTFkeqYj5Xjo4DBrmSVvRJ5wQxDqvUUOAUjRDPWUmuyTB3qkQmO0D
         TfDuOJkS0w5/G+upcxqS2TjbFjppHHryLmxW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUuSpc6C+EWicKThxRXH7zHFoDctbTavto9TGkNgwqg=;
        b=cInZVNf3ukrSbid4Cp3Kz+O9DvwS4e+CYCGmxU2lPGc0vx0uMld1g2+9ANSj81OFxP
         8AOb3Sas+gJuYiNhfcP/t5vZAwv1wNncSPbArb3uvndm4KCf38AfCHaJgA8zsjFyyBlh
         rImRJMA05wNWLtJmZdxtEV8+CcwL0KSFCtwYQve/C/raIg+GdP0f21D0eOqXN3cEgh3u
         A0UPoc0V2XjjqUJILvNSONJ6oMhZn/pWS/X/sQ4r4umEgfRj9UA+maIqv6ByCMWjDJ1Y
         4iTlrKMkfLZKScrbDSXzwJVxWvuqjA0QnGIm6NWtll3mNRbVqkzUqQmr2mIVnQmYMiu4
         pozg==
X-Gm-Message-State: ANoB5pksXqUTgu74X1nm7t5yUY2fZot4PgyKoR5e7WeD0jdoJlF41G/T
        8ovRIwDpOs4eCDmE4gpFGPzwqQ==
X-Google-Smtp-Source: AA0mqf6zJWogoV5nxKMvF6nyC8Z6yvR1VPsIHS4jgbNLHnlHUKp6nQ/kja+nbliKuq1b2daPYDrBaw==
X-Received: by 2002:a17:90b:364f:b0:218:b6d0:2529 with SMTP id nh15-20020a17090b364f00b00218b6d02529mr7023070pjb.75.1669080833896;
        Mon, 21 Nov 2022 17:33:53 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:9797:eb69:44a4:a633])
        by smtp.gmail.com with ESMTPSA id z22-20020a63e116000000b0046ec0ef4a7esm8099914pgh.78.2022.11.21.17.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:33:53 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zswap: do not allocate from atomic pool
Date:   Tue, 22 Nov 2022 10:33:38 +0900
Message-Id: <20221122013338.3696079-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

zswap_frontswap_load() should be called from preemptible
context (we even call mutex_lock() there) and it does not
look like we need to do GFP_ATOMIC allocaion for temp
buffer there. Use GFP_KERNEL instead.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2d69c1d678fe..f6c89049cf70 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1314,7 +1314,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	}
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
-		tmp = kmalloc(entry->length, GFP_ATOMIC);
+		tmp = kmalloc(entry->length, GFP_KERNEL);
 		if (!tmp) {
 			ret = -ENOMEM;
 			goto freeentry;
-- 
2.38.1.584.g0f3c55d4c2-goog

