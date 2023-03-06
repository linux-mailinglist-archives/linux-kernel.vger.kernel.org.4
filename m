Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756006ABFE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCFMwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCFMv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:51:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7402B609
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:51:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so5114418wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 04:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678107116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xf3l4GRdn5RdXOF0TrzQkV+XhTtN1QTwo37gy5enBAY=;
        b=eykxkvNNtMYSWf6ufwdJrWSX6oeFvtqDQdklHyj2cOoxMKF7g8mNivFFRO9bCSD69+
         7+go8HWk9r0E+UAM8VNsYaOsHREzYxdFNykPSpJCqDWjOyWFxznwNrIK2AKlHTbF9dkq
         EPwTmVznTwgAPK3FxL3a+yoPv4fd813hpQ9iMV/kRUqtpuuL4k+opXneFZYKo3i9c5Wm
         ZU7eW+7wpz9e+OrD1m1uT7QH0xJDNVPzWaTOE1L5zZzcqyHkSZHutSJ10LkmJeQIhO/J
         GchdAs1OyPK0I82uGMXocbMt+pCe+OFDk4EzrQFZlVdz2OMfRiBXWuPrfXvl15ejZNM0
         RmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678107116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xf3l4GRdn5RdXOF0TrzQkV+XhTtN1QTwo37gy5enBAY=;
        b=TLHobKda+Lx0Ba/Alq1nmEHKWvFVnPF8cqoM9kDI57lJP6UxpmnqMx7YITNr9ZMQzU
         MESpyyrW1hnusZskzJCH3hJ/XBMlLG+JW9oueOfDR2jMwyBAafLts7jpPqSu+n4MrrK8
         guQ+yvo34FUzNWkANbqDP7RPa1ybaOKLdCUU4ybnCnDHom/3elLV924OrC6TG9zOPine
         J5An2Y6BBYCwHiIdYP3ZhP+c/gG/YSURwu5WLkOK4E/tXxzv1E50Cl0lj+1d3t6NgBHR
         Va5/HSMgtUjt/ROmuiFE71ODqLm4V7uQ7//Ybssr0dR+7VYv8ZI6Qu5HxKZqsxeo1tw1
         sPDw==
X-Gm-Message-State: AO0yUKVxdL63TYuU8XmI12K2/yevfQPbRMm8jqRV1TJa9u9uTVj6HIT1
        SW4hNnMRx2I+mjWdvasLcnU=
X-Google-Smtp-Source: AK7set+2yrs+YiBtqHO9+iAcYjzjqd5KZX6XCzFKoPEmLbVCWs2+tGhpnpy2FYDxbEnA/gEz/lF5cA==
X-Received: by 2002:a05:600c:310a:b0:3dc:555c:dd30 with SMTP id g10-20020a05600c310a00b003dc555cdd30mr9256513wmo.27.1678107115653;
        Mon, 06 Mar 2023 04:51:55 -0800 (PST)
Received: from localhost.localdomain (host-79-43-1-179.retail.telecomitalia.it. [79.43.1.179])
        by smtp.gmail.com with ESMTPSA id h6-20020a1ccc06000000b003e118684d56sm14161383wmb.45.2023.03.06.04.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 04:51:54 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/sysv: Don't round down address for kunmap_flush_on_unmap()
Date:   Mon,  6 Mar 2023 13:51:50 +0100
Message-Id: <20230306125150.12166-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The kernel virtual address passed to kunmap_flush_on_unmap() has no more
any need to be rounded down.

Therefore, delete the rounding down of "page_addr" when passed to
kunmap_local() in dir_put_page().

Don't backport without commit 88d7b12068b9 ("highmem: round down the
address passed to kunmap_flush_on_unmap()").

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/sysv/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 999bceb99974..e2d26eb78af7 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -30,7 +30,7 @@ const struct file_operations sysv_dir_operations = {
 
 inline void dir_put_page(struct page *page, void *page_addr)
 {
-	kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));
+	kunmap_local(page_addr);
 	put_page(page);
 }
 
-- 
2.39.2

