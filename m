Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373866D1D96
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjCaKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCaKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:05:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C912C335
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:59:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ja10so20766932plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680256746; x=1682848746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3Imsv5UXjIU6+jF5fHueU/SbtIe7EZ54LbcEh0yngg=;
        b=eNFqrrDvToe7K30uj4UJdlWR29i2x/3BZZ8yfzzbmfaNxY2ly4sLki8zpCNb1tZL8F
         99yx1GqbvY+SYJq73zokyHO5yYeHmQJnsTNl0v83o99fAHuJVEQ3iu2Ib16n74m+GBc6
         KsAfwyAiBRByPWGUGz3IRg5l0F2ly8Lt9XpJTZa82a9YVQ2YPetXTMGz0Qeub1rUNOGq
         74U77/tjinuH4nZi8bz3ljpHvUvL6IyDLCusE4TSbGa1lAuOTOJGObcYtPfUSr5/0dr9
         I6hoGTcoXl3etTMWvHtCYFopuFOlpdoY+jFPcvbTuHhYFNSPp/ax5X/xyzQpFYZJgU8p
         5rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256746; x=1682848746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3Imsv5UXjIU6+jF5fHueU/SbtIe7EZ54LbcEh0yngg=;
        b=MrSRfvKtNoxt7yrPhnKgdoEIm0htRMhudAlbi8V/Q76nziFaR+sC5efPdNPyWrqQmy
         LzWpYhz3eqkfswioMiRbQUQwRvy8ZGFlRzDN1cW3a53qEQBHUPsqUVqYAxlcqnV+BuFc
         oZA7Qy7P3zyayV9IyCUJYH1nTfZZ2UIlknZOoDGlh+KitgGegJLN94lWvMh0ByXF3Mq0
         rAzebXNt4Agrwji0SwX970YQXU5JOcwh0Y+BlZPWE7KKJP/vhKCHS2Re73yO948wXafn
         VRmwpQGOD+eg0rDoKtwXt3+4ODv0+6R0xZAyLKU0kSfBdmM71Ayhtr60LS/6QTrqyVyx
         OEPA==
X-Gm-Message-State: AAQBX9dLqEDZjmgcA22/1VYiCPdKiHINA8yxp9RWvTcVlGoURQvBSF0S
        Q4hmcm31WRBX4I9vtaVYMeD7qcvBME9BcOPDcKo=
X-Google-Smtp-Source: AKy350ZvNVoMyY9lLBRfiHq5wFZ9JCFpE32CoNb4IXzzebKUTJLtkfr4e6FPbV2oDHIPcOpa6wvfrQ==
X-Received: by 2002:a17:902:7593:b0:1a2:8871:b430 with SMTP id j19-20020a170902759300b001a28871b430mr5594577pll.2.1680256746575;
        Fri, 31 Mar 2023 02:59:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id oo5-20020a17090b1c8500b0023b3179f0fcsm4687782pjb.6.2023.03.31.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:59:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, lstoakes@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/2] mm: swap: use folio_batch_reinit() in folio_batch_move_lru()
Date:   Fri, 31 Mar 2023 17:58:57 +0800
Message-Id: <20230331095858.51810-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In folio_batch_move_lru(), the folio_batch is not freshly
initialised, so it should call folio_batch_reinit() as
pagevec_lru_move_fn() did before.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 57cb01b042f6..423199ee8478 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -222,7 +222,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 	folios_put(fbatch->folios, folio_batch_count(fbatch));
-	folio_batch_init(fbatch);
+	folio_batch_reinit(fbatch);
 }
 
 static void folio_batch_add_and_move(struct folio_batch *fbatch,
-- 
2.20.1

