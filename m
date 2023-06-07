Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D23372535B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjFGFb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjFGFb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:31:57 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B30198B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:31:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b291d55f52so1222469a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686115915; x=1688707915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=os/aeqRhsyR2udmNtFJcHkFZKaZyNQcEib6HfkQ0L18=;
        b=HHf4ZsFDOATneFcjMagAeFdAmQa0S3zkFPR6Kl71dO6kSzG4yeJDphbAmWiXLpVWnk
         LibMuVLNT0qp7vStwD2E6gBmTwULqAq+v6LJKNY8Z6B4wfnKBJ59oYvBvOQoFET93b+d
         1XWVy5sGRtsP4Q2A/XHEaaMj446yXhLNHvTxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686115915; x=1688707915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=os/aeqRhsyR2udmNtFJcHkFZKaZyNQcEib6HfkQ0L18=;
        b=NwT3Q7gYx0xpqn5QAo+iiCsXt83MH+0lh0TieRd1i0U2MBMorieHDOyIMSghcmefJI
         zxiD6kbfA4xXeKfv91SyW0SzdXc+1GoxLEgcVEhcLNd+Htcozy9npjoo1ZKiDJb+ArFP
         UAsx+mhedyhvcT5Mf+QgKWFZWmeicnugQf1DOxjpCWVlXf09mU8yTlS6nX4CziP92IuC
         cBzxmjiaRwfPHF3mBVv1ysBr4GiblBlN6CwUcB4WQfrGHpScOxKzgKAzd1MxKX2WmUET
         c1UZAwGwtvnbdxqbeAjyTPbDhTZQYQ6NTxNG2YYb6USplMf5U2JvYecKR79yqudkBD/v
         QFew==
X-Gm-Message-State: AC+VfDzW5d2Pkf6SS5+JK9ii3vqECI4O6/03NUAeYh5lF4EnF95sshr5
        hVg9MggX8Etz+4q6jRS4+sjiNg==
X-Google-Smtp-Source: ACHHUZ5lMJIND9Kzi4ibR4p+GOc+LHJey4+fB1q0UaEPsfdK6Vz/9m2eHCXPfGlL9pY/laVGtRBz3Q==
X-Received: by 2002:a05:6358:1a9c:b0:129:c89e:46cb with SMTP id gm28-20020a0563581a9c00b00129c89e46cbmr951145rwb.15.1686115915057;
        Tue, 06 Jun 2023 22:31:55 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a706:dc8b:addd:1237])
        by smtp.gmail.com with UTF8SMTPSA id b10-20020a63cf4a000000b0050a0227a4bcsm8336856pgj.57.2023.06.06.22.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 22:31:54 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH] mm/khugepaged: fix iteration in collapse_file
Date:   Wed,  7 Jun 2023 14:31:35 +0900
Message-ID: <20230607053135.2087354-1-stevensd@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Remove an unnecessary call to xas_set(index) when iterating over the
target range in collapse_file. The extra call to xas_set reset the xas
cursor to the top of the tree, causing the xas_next call on the next
iteration to walk the tree to index instead of advancing to index+1.
This returned the same page again, which would cause collapse_file to
fail because the page is already locked.

This bug was hidden when CONFIG_DEBUG_VM was set. When that config was
used, the xas_load in a subsequent VM_BUG_ON assert would walk xas from
the top of the tree to index, causing the xas_next call on the next loop
iteration to advance the cursor as expected.

Fixes: a2e17cc2efc7 ("mm/khugepaged: maintain page cache uptodate flag")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 mm/khugepaged.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9d39d65b73..2d0d58fb4e7f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2070,7 +2070,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
 
 		xas_lock_irq(&xas);
-		xas_set(&xas, index);
 
 		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
 
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

