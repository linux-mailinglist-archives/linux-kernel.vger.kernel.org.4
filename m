Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074F06D837C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjDEQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjDEQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:19:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6181F18F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:19:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-503e712b4a1so91786a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680711549; x=1683303549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1To4EWudWGMS35VthxJEVPn4ml+5FfmSSEC6TcGeIwk=;
        b=WIri22gcv76zZgGKYCx26KszTqldyT8X6yf2bGElCpnSwQnDbraJXBaEcsLvbViTwi
         Wf6OppbwwjoohEEzK1A5/liDV7LqBW3U+pWSgPcI2sAOtGe7SGvMHM7NlKuLxBnkEJVu
         4p2OeLHdMa5o7kJzkXZhPrwpx/f6A0w/qLBod8JTmiUwJa7ynfvRx72WCUCdhDaD6jqZ
         ss7ZbhS12KjvH8BLVL2FAslvEWx/EvgaU8lvilFwH731oKKW+7eBCSgxFPjUlSOzeTyh
         UvsT7nM66ZrHANZ3zhZJBAHvN/qa4qxHe/9M3c1h/W180TPinfY65ggffPvVI2HdKL8E
         jPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680711549; x=1683303549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1To4EWudWGMS35VthxJEVPn4ml+5FfmSSEC6TcGeIwk=;
        b=Mn9TRLWAnS+7KORvQqYh7EmF65thdyt/Bg1i1xuEN8ZaNGklCgU6q/zv9FgyG/s9Ac
         JveMTf6t4wFcPnCNPTV90n14SSUKwGG6lTslLbQv8f1M1Ick8+JZWMULCdI8H2mPLkYp
         sy+rtDPNv946fVA0aQ/Sx+aHekIW+zWe2DQSb5T/Vuz3XWy0BBmgzgpmN4BJFnF9GGVX
         OIIrWVDez1owJFkWgmgJGJQBPnRmjyhK0DvM4Dx2DC22GWqPtFgQo/UDfSB1PYPit+SP
         q/TN3GLL7OktnoHLE1Q30pFVt555ddBJjdWiJgAW+O68M0JzKlmGfzUa3mMhv8TF1pWU
         qTog==
X-Gm-Message-State: AAQBX9cMLcp73hqQONRKs7oDZLw55z/Wx+xRbxmyBhDWzf0bMZwuYXRT
        G92sN/sjEGLFZPr/RnsFwmJr/Q==
X-Google-Smtp-Source: AKy350bdafxIOqUOS+kynVUx2lRXuw5T6O0AdkM8E0EzXecvmU2OlBId01ShnGvrgz16ldkfAPZ6zQ==
X-Received: by 2002:a05:6a21:6da0:b0:e4:9a37:2707 with SMTP id wl32-20020a056a216da000b000e49a372707mr2934273pzb.5.1680711548776;
        Wed, 05 Apr 2023 09:19:08 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id x24-20020a62fb18000000b00582f222f088sm10878011pfm.47.2023.04.05.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:19:08 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, lstoakes@gmail.com
Cc:     mgorman@suse.de, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/2] mm: swap: fix performance regression on sparsetruncate-tiny
Date:   Thu,  6 Apr 2023 00:18:53 +0800
Message-Id: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
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

The ->percpu_pvec_drained was originally introduced by
commit d9ed0d08b6c6 ("mm: only drain per-cpu pagevecs once per
pagevec usage") to drain per-cpu pagevecs only once per pagevec
usage. But after converting the swap code to be more folio-based,
the commit c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
breaks this logic, which would cause ->percpu_pvec_drained to be
reset to false, that means per-cpu pagevecs will be drained
multiple times per pagevec usage.

In theory, there should be no functional changes when converting
code to be more folio-based. We should call folio_batch_reinit()
in folio_batch_move_lru() instead of folio_batch_init(). And to
verify that we still need ->percpu_pvec_drained, I ran
mmtests/sparsetruncate-tiny and got the following data:

                             baseline                   with
                            baseline/                 patch/
Min       Time      326.00 (   0.00%)      328.00 (  -0.61%)
1st-qrtle Time      334.00 (   0.00%)      336.00 (  -0.60%)
2nd-qrtle Time      338.00 (   0.00%)      341.00 (  -0.89%)
3rd-qrtle Time      343.00 (   0.00%)      347.00 (  -1.17%)
Max-1     Time      326.00 (   0.00%)      328.00 (  -0.61%)
Max-5     Time      327.00 (   0.00%)      330.00 (  -0.92%)
Max-10    Time      328.00 (   0.00%)      331.00 (  -0.91%)
Max-90    Time      350.00 (   0.00%)      357.00 (  -2.00%)
Max-95    Time      395.00 (   0.00%)      390.00 (   1.27%)
Max-99    Time      508.00 (   0.00%)      434.00 (  14.57%)
Max       Time      547.00 (   0.00%)      476.00 (  12.98%)
Amean     Time      344.61 (   0.00%)      345.56 *  -0.28%*
Stddev    Time       30.34 (   0.00%)       19.51 (  35.69%)
CoeffVar  Time        8.81 (   0.00%)        5.65 (  35.87%)
BAmean-99 Time      342.38 (   0.00%)      344.27 (  -0.55%)
BAmean-95 Time      338.58 (   0.00%)      341.87 (  -0.97%)
BAmean-90 Time      336.89 (   0.00%)      340.26 (  -1.00%)
BAmean-75 Time      335.18 (   0.00%)      338.40 (  -0.96%)
BAmean-50 Time      332.54 (   0.00%)      335.42 (  -0.87%)
BAmean-25 Time      329.30 (   0.00%)      332.00 (  -0.82%)

From the above it can be seen that we get similar data to when
->percpu_pvec_drained was introduced, so we still need it. Let's
call folio_batch_reinit() in folio_batch_move_lru() to restore
the original logic.

Fixes: c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
Changlog in v1 to v2:
 - revise commit message and add test data

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

