Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF65B7ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiINCRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINCRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:17:49 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465B558E1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:17:48 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id v4so13002352pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=s5628q2IWcL7lPRgxwbc0TKBX+FlmvbMxHcTpQHaeS8=;
        b=asSszdhcFXxMwCjE97nzDbnC6nlt9PooRfmNtSzBz36OKExwwuS7O2iuFFcFJEOc9H
         IZ389Yw+teFVAm7zQNOHsOmzFRSfJNgpBveuwuxlpETLQf1SP3zAjpefMUgmNOhoMlhP
         35c/KCsrW9uegXzGvrYsd7Nj+jcVmHkG5JOmppxXjH+b8af5a1Ose770fLotDFcArFjd
         HOaD2MVmxo3HaDG3jyDVO63NoKSRP95sW7JAaNGG41x9IYeX5NAlGfaDlTt++mW6I4k1
         TgAsGbcpGvPVLlpZqVb6eM2gCMUKjUho7yF9QxdHgR4SXzShSqtGC1ZMaZwJXtP4TyCJ
         VcgA==
X-Gm-Message-State: ACgBeo05HZJrYLS3rrvrcppb7WCWnteUxnW9Pj0zeunlFuY0EwxcrRox
        FAXk9XWgkOeu2+DWdNTob/o=
X-Google-Smtp-Source: AA6agR5vZpY7gIR2rF5G72kS3asgm4sRqIpdVVBPfPXFvxfmLmI3uRvHAF6p/u6pGj/DfFNZVfP7oQ==
X-Received: by 2002:a63:5a01:0:b0:434:8bd7:284d with SMTP id o1-20020a635a01000000b004348bd7284dmr30637936pgb.538.1663121868135;
        Tue, 13 Sep 2022 19:17:48 -0700 (PDT)
Received: from sk-Yoga-14sARH-2021.lan (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b0016f1ef2cd44sm9154461plb.154.2022.09.13.19.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 19:17:47 -0700 (PDT)
From:   Ke Sun <sunke@kylinos.cn>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ke Sun <sunke@kylinos.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] mm/filemap: Make folio_put_wait_locked static
Date:   Wed, 14 Sep 2022 10:17:38 +0800
Message-Id: <20220914021738.3228011-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used in mm/filemap.c, since commit <ffa65753c431>
("mm/migrate.c: rework migration_entry_wait() to not take a pageref").

Make it static.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
 include/linux/pagemap.h | 1 -
 mm/filemap.c            | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..82880993dd1a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1042,7 +1042,6 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return folio_wait_locked_killable(page_folio(page));
 }
 
-int folio_put_wait_locked(struct folio *folio, int state);
 void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..ade9b7bfe7fc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
  *
  * Return: 0 if the folio was unlocked or -EINTR if interrupted by a signal.
  */
-int folio_put_wait_locked(struct folio *folio, int state)
+static int folio_put_wait_locked(struct folio *folio, int state)
 {
 	return folio_wait_bit_common(folio, PG_locked, state, DROP);
 }
-- 
2.25.1

