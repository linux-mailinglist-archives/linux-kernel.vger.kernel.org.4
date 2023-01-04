Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3434365D25C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjADMTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbjADMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:18:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF60A14D17
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:18:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so23695906wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 04:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHMgOCfBnekqEjjX5jdxKzkmOrq/OhhRkWXkA6bEgN4=;
        b=oLLNue/KQ4/VRO/ad0YLFe6X5X7R8bP5WJ+JR5pjtM8F5JJKRljjVXm4CLTmRe8M06
         8at6sfEtuxmBXbmzMG4Fqd8m/TCdiTxYKIdnuVBsPGOr8we4DmCa6jvi3Ef8tDn9kCfy
         UiEWF6R8BUi6bopmd44uGdzgSbonoxE3feericK8SWJxHUu3Vsw4xse7ZseaLds/YJ7i
         UCIKSvMSeHxCJSRJ8pqPvR8nt2s86fQ2aNjdc7I3P++n4hxoPIlN0mA9IpX9RCZH0zki
         ahKK6q+YUWcG+2yq3A4Y58IZXBuprVqmixq7xETu+nB+K/frul+Gk+ABj0LeJdrYh27S
         bnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHMgOCfBnekqEjjX5jdxKzkmOrq/OhhRkWXkA6bEgN4=;
        b=TPVJz0bG8bgQA+iY5449PXKjzw1AJ5WADMHLOBYP7WJvAqpiRwP3gofy7KRjR31KKV
         1LjwFuCmA56aB3VX6v/pR6APzBQcTTUP3NyAlEIc+5cpqoOl1EN6qaNBqd6A9PTS5ueE
         wppEsUSetKuL+mvojd5+Wjh2qyPzB3snBDZZustHWc1joVPrDPSzdMUiYOhmsWyF81UV
         BroYIKy27dpkWEXiIt+0nZqk2+87K+FKlNkZwwPjkXLPBECmY9ZYDPacUnCon8VQZlZe
         uDkLK91DD7x6LzO7IP/1tH4WH+VRYTERnS9v/uo72RklAdhgWId3CE7Dq6q6WkUUVVLr
         Pigw==
X-Gm-Message-State: AFqh2kra1pnz33WnftnyHQCRXwYSK75gu8IMHWlNXiFD+03Uqjb2gEFp
        yUdZTyEY7UxmOqtZxlnWojE=
X-Google-Smtp-Source: AMrXdXvwQasIqJ6ZlDtE/7Ns0uTduzr20whGAySg10LTvFhXhHHQaifMllKQuKEoMCooKfcEd2Gvnw==
X-Received: by 2002:a05:600c:3545:b0:3d9:a145:9ab with SMTP id i5-20020a05600c354500b003d9a14509abmr14213841wmq.39.1672834732345;
        Wed, 04 Jan 2023 04:18:52 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003d990372dd5sm32570985wmq.20.2023.01.04.04.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:18:51 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] mm: Remove a sentence from kmap_local_folio() kdocs
Date:   Wed,  4 Jan 2023 13:18:45 +0100
Message-Id: <20230104121845.15770-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
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

In the kdocs of kmap_local_folio() there is a an ambiguous sentence
which suggests to use this API "only when really necessary".

On the contrary, since kmap() and kmap_atomic() are deprecated, both
kmap_local_folio(), as well as kmap_local_page(), must be preferred
to the previous ones.

Therefore, remove the above-mentioned sentence.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 44242268f53b..7b0085a61e67 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -120,8 +120,7 @@ static inline void *kmap_local_page(struct page *page);
  * temporarily mapped.
  *
  * While it is significantly faster than kmap() for the higmem case it
- * comes with restrictions about the pointer validity. Only use when really
- * necessary.
+ * comes with restrictions about the pointer validity.
  *
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
  * disabling migration in order to keep the virtual address stable across
-- 
2.39.0

