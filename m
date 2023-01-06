Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD7C6605CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjAFRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjAFRkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:40:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B193F7DE18
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:40:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C6B9B810A7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1883C433EF;
        Fri,  6 Jan 2023 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026841;
        bh=lehRB+fMwqiaN+fsr24vSBnpbQfHVQHTL6mnxILFBts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9KaEMH/AY3GqDnRRYPEJoBMGtwMgv+AjV6t5PTvgm/xPvax0GyXmcoFTaHIKYUjf
         E6+10Gx0Zsd3ZLs+NLFgwS6jfv3WprcOXJAUpeKODNOiYxXGlzbJ+5gtviSQ/zQ8o6
         ut4slaiJsNbgznopHReIdiJCcNZwMTHrzgCk0fASbBaE85Is4fM5Jmhoz5/lK8fj1L
         TwD7ZQf+YCAL1yAuzJf4hVtWNxw6IZwiskQti0MUj3BdeQ9DYPAIe1NcZ8Kk8bWjH/
         Uo5K3kBHkNHUZ4bFa8hnobyxxNGOl+jzr23GcfFp4lVDXzWA7KrH4BYXkilwLnG4C5
         /AJpyeph2OkoA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] include/linux/page-flags: add folio_headpage()
Date:   Fri,  6 Jan 2023 17:40:26 +0000
Message-Id: <20230106174028.151384-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106174028.151384-1-sj@kernel.org>
References: <20230106174028.151384-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard idiom for getting head page of a given folio is
'&folio->page'.  It is efficient and safe even if the folio is NULL,
because the offset of page field in folio is zero.  However, it makes
the code not that easy to understand at the first glance, especially the
NULL safety.  Also, sometimes people forget the idiom and use
'folio_page(folio, 0)' instead.  To make it easier to read and remember,
add a new macro function called 'folio_headpage()' with the NULL case
explanation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/page-flags.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 69e93a0c1277..5a22bd823a5d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -285,6 +285,14 @@ static inline unsigned long _compound_head(const struct page *page)
  */
 #define folio_page(folio, n)	nth_page(&(folio)->page, n)
 
+/**
+ * folio_headpage - Return the head page from a folio.
+ * @folio: The pointer to the folio.
+ *
+ * Return: The head page of the folio, or NULL if the folio is NULL.
+ */
+#define folio_headpage(folio)	(&(folio)->page)
+
 static __always_inline int PageTail(struct page *page)
 {
 	return READ_ONCE(page->compound_head) & 1 || page_is_fake_head(page);
-- 
2.25.1

