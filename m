Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C5A74540F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGCDLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGCDK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:10:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71CE41
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:10:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668730696a4so1958459b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 20:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688353858; x=1690945858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIyh0ew5U0seEYIcxjwMCqM1A8TvNowG5EtVwwrRxDw=;
        b=rOU6Gqec5plFmlctl5RSdw6jzpxvGI3dRVoCEUiV0YnvIJAjbIiDStVodQsYl+f+rR
         EXo4GF12Q8HwM3qfgC1UnexVEHeMa0uMR3UwFkSeh/7QodopOg1YiubZ+GIgjW8yVfwJ
         uOZqeDeLqIKj7i4n+WyuVhgGRR8LlLMRuT5eUR9VAKoC9v9S05DZQlCSHvstih52BCh8
         4hiY2w0fVWlxe4FKU/W0bPrx+d5VJntCje79HQ2a/Uz9l3CAugfb9MvjGdodCvuEeF68
         Y7XS5E137rvd8C0Q6MzrC4zIyf1QdqOGW6nhuO3EZTZ2QUJ5yOCLDwhKf1O5FVY896SI
         kApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688353858; x=1690945858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIyh0ew5U0seEYIcxjwMCqM1A8TvNowG5EtVwwrRxDw=;
        b=IUeFMIFfAc/xgox9VJgkHXnG6XvPZgojur0PJg93mR6NMVTHCaEyIT5BgNcW4DOzrK
         miV7o2eiZzHLgZPJ9bBRgxPc+YkIvDkOfhis0qc7zHJyNsBdwcgtzbJtmVYOdmnK9M1n
         VQ9UtQLTPGUwhFGHwsJv3nJsi1jXgc13EGOifvSuFaGE7T6bGoxylbwdUHDoB4HKmenW
         ZLVjUYS+5KAageImIVnQ0iQc2QgcYH7zQ58yCSVVketAUl+M/0VJehLxJyZQKSB5yMjH
         EMtf3So2zvs2wr5IPefLY4Qclv+RhMSkL/XcPdjv82oSdfs2CaHCmZzSSluL7OP6A/gt
         5u9A==
X-Gm-Message-State: ABy/qLb7k80+EY4kIlLR6OXhHORfyHvucUATFl5LFVmc2Wo+go89U+ES
        WmlHi2VAaWUgaIcr9+DsIYI=
X-Google-Smtp-Source: APBJJlESa2fM5VtRr4lKEDEClzMC6buf632yepbQFvaKwg1Nd/krtdlQ0CpGPI3/n4AOksRIoqrblA==
X-Received: by 2002:a05:6a00:1a55:b0:67f:2ba2:f741 with SMTP id h21-20020a056a001a5500b0067f2ba2f741mr9513321pfv.24.1688353857829;
        Sun, 02 Jul 2023 20:10:57 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id f4-20020aa78b04000000b0064fd4a6b306sm13041496pfd.76.2023.07.02.20.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 20:10:57 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()
Date:   Mon,  3 Jul 2023 11:10:16 +0800
Message-Id: <20230703031016.1184711-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable codec->regmap is often protected by the lock 
codec->regmap_lock when is accessed. However, it is accessed without 
holding the lock when is accessed in snd_hdac_regmap_sync():

  if (codec->regmap)

In my opinion, this may be a harmful race, because if codec->regmap is 
set to NULL right after the condition is checked, a null-pointer 
dereference can occur in the called function regcache_sync():

  map->lock(map->lock_arg); --> Line 360 in drivers/base/regmap/regcache.c

To fix this possible null-pointer dereference caused by data race, the 
mutex_lock coverage is extended to protect the if statement as well as the 
function call to regcache_sync().

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 sound/hda/hdac_regmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index fe3587547cfe..39610a15bcc9 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -597,10 +597,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_regmap_update_raw_once);
  */
 void snd_hdac_regmap_sync(struct hdac_device *codec)
 {
-	if (codec->regmap) {
-		mutex_lock(&codec->regmap_lock);
+	mutex_lock(&codec->regmap_lock);
+	if (codec->regmap)
 		regcache_sync(codec->regmap);
-		mutex_unlock(&codec->regmap_lock);
-	}
+	mutex_unlock(&codec->regmap_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_sync);
-- 
2.34.1

