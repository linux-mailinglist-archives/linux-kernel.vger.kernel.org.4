Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76CC602EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJROiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJROiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:38:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F2CA8B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:37:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so14195298pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwuWy4jARkZiYQhQKKp3kZsxq7qh8bIcksVC/zF6xJY=;
        b=eM6DqSRMVv1I6J8Rz4Q13ykLhUES0rYe2ZYVOe4gWNOOFdM/+7+opEMdjXhtGxPWjZ
         bkpiva/nANsSBAd4nBXwf5CJkXPZHwmTP86j6+lVmWxtrTwFUtpjEBWUaQBk7vPcqxG+
         /WNRm2BiHWURU4dh5cUAPm1sloxCaP5vAwC2ysF+c3V73d8Kd85G8tfakguKHGjXbCT2
         NN/bPmOoeKedMKykOVFqW/7QOoreIvYon+Ktf8REPPEcnQfj4/j3pzg9f+bR/JUxL5Bh
         Z7OYmQTVl6APm14AWCO7NdZE+i3+PGBOSSNLz3zsolKGxdt1BaXfdKu9hlAsH/C09RpX
         3+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwuWy4jARkZiYQhQKKp3kZsxq7qh8bIcksVC/zF6xJY=;
        b=JHRbfdcr2g+i7aMgBD+Hv8mDkgcH1ZOTOigiE/Jp6cYFGtlHKr1I8o9pYRCLRyOe94
         z02dBgJOYo2Cb56OwUNKFwQ/OrynBHHYcjImYec7hKXZ+NUlHxngs9sbiYWaaPp3Nabn
         rEQ5/6fbeD1s+lDd3Kl0rSW+lger7QJN1PWLolBlHi4FAEzvCos7B+nXLHiIkPllPKT1
         5ZAqWZbrrC9nHSyKLXgdno0XdOkzWJ8lfV0ofvP85alWHO41P+GCyA645IXy16oywwwJ
         PemoOBLJjbnlpEra/zitWTdljiIoC4yrbbh5UwcksV9mVMkuGiSI409odqUjqwmxdOVt
         urDQ==
X-Gm-Message-State: ACrzQf3m+0XdAIREcu+m1Eo5yWOK0ogZ3bl68W8+0uw80Ef4nw1rHXfB
        19lpWUHDORiU8hiEtZNXLQyITUmcQ6JsNw==
X-Google-Smtp-Source: AMsMyM54iVDRJ+YG116kjqtwzeL/Vs0TW/7yChUCfXljnPckCF3wWpxsUUte6Jy+ewQHHv1xjgFtGQ==
X-Received: by 2002:a17:90a:c7d3:b0:20a:68a1:85cb with SMTP id gf19-20020a17090ac7d300b0020a68a185cbmr40099316pjb.138.1666103876522;
        Tue, 18 Oct 2022 07:37:56 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902e95000b0017b264a2d4asm8814839pll.44.2022.10.18.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:37:56 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH] mm: folio-compat: fix bug for pagecache_get_page
Date:   Tue, 18 Oct 2022 22:36:39 +0800
Message-Id: <20221018143639.5099-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The folio returned from __filemap_get_folio may be a NULL, it will
causes the kernel crash when access folio->page.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 mm/folio-compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index e1e23b4947d7..37ba33135506 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -108,7 +108,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	struct folio *folio;
 
 	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
-	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
+	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
 		return &folio->page;
 	return folio_file_page(folio, index);
 }
-- 
2.17.1

