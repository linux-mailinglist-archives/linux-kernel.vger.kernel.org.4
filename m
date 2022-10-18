Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7923602EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiJROwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJROwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:52:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E7D994F;
        Tue, 18 Oct 2022 07:52:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q19so20817024edd.10;
        Tue, 18 Oct 2022 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdDndPV91SgyMkTQ4AOZFrCVVQ8EFi+AlwFk89m7OCk=;
        b=jwtBcSs6qlzBVVm91NsjwcTCP82c4aIoxUossafUf6XaZ2aVFUsQcqfvzeYwmUNdEa
         5jBy455pdXEKITguIhHME9Rp+sMEXzqwaIa4YydgLm45obZvK1SJfajY4o4gFcXkQNwy
         wl0Boi6R9GqyvJ9Rf7wEz53UC+9Yah51GgptczMSH9f7o0DGX8aQN4Ffvq0zc1BYa0x0
         QgM8qx9+buDMSmJ1TUetY3v/J4yLMOIQBBrq6sQAV7fHJZ3j+lMchRDWZA6EWBdZ1W/C
         HCSQEvhZMqqMNFhO8OhhxlR/Gg/tHfPfFDk9OwoYcFeuDWriKsoZ9odzgftCCRv05ssB
         8YIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdDndPV91SgyMkTQ4AOZFrCVVQ8EFi+AlwFk89m7OCk=;
        b=MCZ7Kh5cBhnl78mKz/dhF6O8EQ3JG+/W4ZssBbXjRMU+gopO4N13p2+TBeKh88hQaP
         g258FuOahn864Rv3ElzvbvWRZnQl/Ccuux5zLxGEC9Peb23MCyJ0CWGUXQ0wuschl4No
         kvxicGptY/I6pbbOkKwvOlx4xVa7FgGu9qIqaMpz4wDMo4/XMLQK1lH4Eq/Nvawv+B2T
         rt7b3fIVEA9Xus3HxOyuZ8x7CL55i3PfI9vabYkoB7FO0ogGizsbzR+n8Ol2ZCOaLyRf
         zYYHk2RWSK+M+SlHo1TEQ+GPeEVLLLf28SJ4yhFZgdhboEV59tR3SxyPGYnMrQAUFepc
         g4PA==
X-Gm-Message-State: ACrzQf2yoEPSNLszYyEoA5rbb/Ad35Ldmc0Lw+WNnwIlZh5zw6ttfgbO
        bnE3fW+V2ks5JbTLzc3W7MZSJ8kVKhv7PA==
X-Google-Smtp-Source: AMsMyM4nlHReoog0AoDXBjeuOIWhgm+BBc6vmW4PoHknsNjVcIkvHFcirWG7Yt2b6HMWAjQN4AhdZg==
X-Received: by 2002:a05:6402:c7:b0:457:cd5d:d777 with SMTP id i7-20020a05640200c700b00457cd5dd777mr2891686edu.245.1666104729452;
        Tue, 18 Oct 2022 07:52:09 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402028200b0045bd14e241csm9033063edv.76.2022.10.18.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:52:08 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] zram: use try_cmpxchg in update_used_max
Date:   Tue, 18 Oct 2022 16:51:54 +0200
Message-Id: <20221018145154.3699-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
update_used_max.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, reorder code a bit to remove additional compare and
conditional jump from the assembly code.  Together, hese two
changes save 15 bytes from the function when compiled for x86_64.

No functional change intended.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/block/zram/zram_drv.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 966aab902d19..87711ddf4b54 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -188,16 +188,13 @@ static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
 static inline void update_used_max(struct zram *zram,
 					const unsigned long pages)
 {
-	unsigned long old_max, cur_max;
-
-	old_max = atomic_long_read(&zram->stats.max_used_pages);
+	unsigned long cur_max = atomic_long_read(&zram->stats.max_used_pages);
 
 	do {
-		cur_max = old_max;
-		if (pages > cur_max)
-			old_max = atomic_long_cmpxchg(
-				&zram->stats.max_used_pages, cur_max, pages);
-	} while (old_max != cur_max);
+		if (cur_max >= pages)
+			return;
+	} while (!atomic_long_try_cmpxchg(&zram->stats.max_used_pages,
+					  &cur_max, pages));
 }
 
 static inline void zram_fill_page(void *ptr, unsigned long len,
-- 
2.37.3

