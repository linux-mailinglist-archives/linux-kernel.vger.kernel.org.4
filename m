Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD3638445
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKYHKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKYHKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:10:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC6218A9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:10:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn7so3214777plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpI09D4mWcHJ7/K+doiGSv8YTaJguLCmdZoe5Iuc0aI=;
        b=Dp9qdYV3Qk2KwfyXvm+XfGzKSUxj0sUur9Ht8R5nXrw3GNf57sNHPQO1lNfJ/yj5ks
         ixg6x1HISo5F3qibG9UOBzghU/3isXfTPfG4g+x8+xMdBVSY1OHeJ9t7P0Wv9USubbbP
         UrYZzT5galnrH7u280HXSGOXCA7/cGSIdN+zsa9PPRI1YTjBzgolztLkYZaHENa14AZI
         dl388W8iHhl+E3sJz1VZq+9TXkYe6QZQKYQlo+rd/gZUP9rbL+X50IlBbFf/3adj1nWA
         Uan/AzmsYhiABaYo8ywM4yGvKm5k1/C1Br5pVoAxnFPJgKHLqMeUxJU9v0pgG2LvIvW8
         cDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpI09D4mWcHJ7/K+doiGSv8YTaJguLCmdZoe5Iuc0aI=;
        b=QZnYlzlLpaJkqK6KrRH1qqRYT7M3VKAwtCast3tD8XE4YKE8A2XzgUK/rammUgIjx3
         N1FemkMknLvwzRfNNXIBuNM1DTNXLOtXH4u/Z0h84ysPa2pwcOM228EXsbSRWwgj4ZfX
         rq5fmdZPdhD1JPTKpk0KmYMd2cktwLX5bZkZOfxUvOqdqNJatXd4gqR0cFnGjD74KLND
         PL8U4QZePsj0XsnN87H9qKjKQxnlkJb/uIl100qGR6lpGkdm8P4mpYIVkKDnTGrjkJkU
         ltXcPSrA9Lne8QMi1g17SFJoyJMB0AQRkeWqqcjFYVmdFAwo4bXt2na+7mcEQV0jBzoS
         iHeQ==
X-Gm-Message-State: ANoB5pnWQWHmDxM21jyXM+cqxgP758mZqgj2s/uO6m/K4V3xA2rgC+xX
        P3NXAckm/zXLm5u1gH0IsLw5nA==
X-Google-Smtp-Source: AA0mqf7V43Xz2Moi9FjtIMiTzYXGtNAY8tk5vkxd3bX6vBsI50geRZURKPxgk7qALSZm0Tv+Nb7QXA==
X-Received: by 2002:a17:902:c611:b0:189:58a6:851d with SMTP id r17-20020a170902c61100b0018958a6851dmr6900338plr.146.1669360234978;
        Thu, 24 Nov 2022 23:10:34 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902710500b0017d97d13b18sm2555352pll.65.2022.11.24.23.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:10:34 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] filemap: Fix some misleading comments
Date:   Fri, 25 Nov 2022 15:09:59 +0800
Message-Id: <20221125070959.49027-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The users of filemap_write_and_wait_range() and file_write_and_wait_range()
interfaces should set the lend parameter to LLONG_MAX, rather than -1, to
indicate they want to writeback to the very end-of-file, as several kernel
code paths are checking the 'wbc->range_end == LLONG_MAX' conditions.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 mm/filemap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 65eee6ec1066..c6d066a39425 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -661,7 +661,8 @@ EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
  * Write out and wait upon file offsets lstart->lend, inclusive.
  *
  * Note that @lend is inclusive (describes the last byte to be written) so
- * that this function can be used to write to the very end-of-file (end = -1).
+ * that this function can be used to write to the very end-of-file (@lend =
+ * LLONG_MAX).
  *
  * Return: error status of the address space.
  */
@@ -758,7 +759,8 @@ EXPORT_SYMBOL(file_check_and_advance_wb_err);
  * Write out and wait upon file offsets lstart->lend, inclusive.
  *
  * Note that @lend is inclusive (describes the last byte to be written) so
- * that this function can be used to write to the very end-of-file (end = -1).
+ * that this function can be used to write to the very end-of-file (@lend =
+ * LLONG_MAX).
  *
  * After writing out and waiting on the data, we check and advance the
  * f_wb_err cursor to the latest value, and return any errors detected there.
-- 
2.20.1

