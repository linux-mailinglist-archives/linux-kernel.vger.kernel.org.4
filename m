Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF78726D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjFGUmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjFGUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:42:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D171BFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:42:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-565e6beb7aaso101439207b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686170526; x=1688762526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBb/m21VOzpehsx4+LoexEFaCduVhzoAeAL4XX5q9W4=;
        b=Hwtv+SbUu8c8KvXFebn7Avxp+XTEIb3kS48H1hT2CGQrjM/umWsJTef5cMGYD8uZSI
         VcL1k0J4xlsh8sB+Qxzy4uL1MzUPPhHneRKcn9zpW/tBp6RCeu2aFcyQENborlyqWQWa
         bS7rya9PvxD97pEK2vRgMwKIm5Sg1rasj7no8y1UuASgbmhV7de8xCpy+it+Kx9gpm0o
         yY1wEi9+Ufa7WQBOJ0xmnoaDz2+vBy0eL22VLQ+n5nKGldy4rfkQl8d85thWAgCIqPhy
         lgNchK7LwSxy0mmGjVI5AFxyh4d0GZ9eBJTngpG/qOeYA8NJvbzWMv3JCt/L40WT/yxK
         euQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170526; x=1688762526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBb/m21VOzpehsx4+LoexEFaCduVhzoAeAL4XX5q9W4=;
        b=TdqACaMwhbZYzcVAWZFZFXanMfGCXjtipzF3eKAdbJpLinHcHNKij1qLc9SJAFvB2J
         PJGgAneWOfGvBkz7VN7rYRxM1Kx5hC4B5fXGZeTlmoIu9M8MeTdqDpAr4X6cD9gckize
         h5pP2WEM6rtSnbc1E5U1NjAdUZBvUTu7M1E/V4Bvj3JvYPu89zaLkylp5antwuugUAdU
         Xgzv6NnXvUg/OE1jHh296ibDnVhBO38kraGQFneCAUGmJu2hPd6CV0jvgZLqRWslWnOx
         U3LLx/YB+g701Kktdkru1CgCC+VWTGPTVUwDiyExqKkeqojJYL8BPFMyckDZGD/eSoS7
         lAWA==
X-Gm-Message-State: AC+VfDyK/BwJpOFkcA1gpBEW1MSAOYQ/mePymArviGrNPxrcGpiUl4Gy
        NCInjJG/1iEw9Os2cv7npbE=
X-Google-Smtp-Source: ACHHUZ5X+ydgADrjCCMbbaa3S7v3z69O0+LUwZNR+az9uFAc8X0BR+Wru/3Svw3sqbnkNxgyeVnXpg==
X-Received: by 2002:a81:9253:0:b0:565:edf7:69c1 with SMTP id j80-20020a819253000000b00565edf769c1mr8559529ywg.36.1686170526094;
        Wed, 07 Jun 2023 13:42:06 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id v16-20020a814810000000b005688deeefc2sm4972938ywa.20.2023.06.07.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:42:05 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-afs@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] afs: Fix waiting for writeback then skipping folio
Date:   Wed,  7 Jun 2023 13:41:20 -0700
Message-Id: <20230607204120.89416-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607204120.89416-1-vishal.moola@gmail.com>
References: <20230607204120.89416-1-vishal.moola@gmail.com>
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

Commit acc8d8588cb7 converted afs_writepages_region() to write back a
folio batch. The function waits for writeback to a folio, but then
proceeds to the rest of the batch without trying to write that folio
again. This patch fixes has it attempt to write the folio again.

This has only been compile tested.

Fixes: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_get_folios_tag()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/afs/write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index a724228e4d94..18ccb613dff8 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -731,6 +731,7 @@ static int afs_writepages_region(struct address_space *mapping,
 			 * (changing page->mapping to NULL), or even swizzled
 			 * back from swapper_space to tmpfs file mapping
 			 */
+try_again:
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				ret = folio_lock_killable(folio);
 				if (ret < 0) {
@@ -757,6 +758,7 @@ static int afs_writepages_region(struct address_space *mapping,
 #ifdef CONFIG_AFS_FSCACHE
 					folio_wait_fscache(folio);
 #endif
+					goto try_again;
 				} else {
 					start += folio_size(folio);
 				}
-- 
2.40.1

