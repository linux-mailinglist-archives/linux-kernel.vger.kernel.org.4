Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE91C676780
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjAUQvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjAUQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:51:24 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477529157
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:51:21 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so7911026plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZovHyG/JpUH+pY/fH2R14bs5kwFX52yjY42y0LexOA=;
        b=WEs/T877kJvvj+Xt2ox/4hyjxSXspRn2vIszadiqsRFo6SRyPJuwdWNteiH0fCBTvj
         OjpRaVZPNwxHILhB1oOeBtQ/XWbvdCMnZaqHHx1l7EyFpGRfGcCIFgTkGH30esw50mn0
         hRiazeumVwpD+RvVw+lhece0xaHuTvY+DdeTwrtwzXevrFFF+CsnPx0wDvYW9DplUdER
         iXsZaY7PYYwqnqBc13qeHVv4BpCWSFT5HXbK2jno4qUvx8Uk3/8b7FfxlpWmjJID2SRw
         NY7zlxlXS+eJ2GFdj2I8hJLCBD8AxoUMU1Rzr38XEHC9cxLe7G+CVeLwox6LrM2U+mNJ
         rGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZovHyG/JpUH+pY/fH2R14bs5kwFX52yjY42y0LexOA=;
        b=JMrE2bYxIXB6KvoCLb3/FW93TUXzXHwS/Z+3+5aoagCrEdk4A2lTpdUvxstXsrx6gr
         zufDlmI7aIVwgGJk372O9wWxul6GuVDO/XN52lYWNLPOawDW3v/RMN5DIOkubVAXQyhw
         y9KqBfeMkfiGrpcKEusp5LkkfE48erXUkyEUpuN85cNkrgjAivWkHTbf27mul5A27vuk
         UyVUZFS4PSa90A1bV0o3zLG80savUdYlUeg4NNCdob+dxCqn1YBTsPFQ0NaX+3R4vPIp
         5WrM4TeKbnEWehugYXUvz/z36rlVKiN9ZXCgza5iEkvwc7dhggQ7LNgaJxbeB4anf551
         SOWQ==
X-Gm-Message-State: AFqh2kpsVXaZWXAHtJ3VsnGVMjATcX++1dgygWogNptaL+RALKPDCdMz
        H0UKJvydt2gTmVvHQF4VtGs=
X-Google-Smtp-Source: AMrXdXtCS8p6EsQhK+/R5Q8h5CQtyDZ/9gAZRA+IzHhIqIfzJqxZO9uUJcK0+ZWK5IiyFVLtdu9FKA==
X-Received: by 2002:a17:902:cec7:b0:191:3993:801e with SMTP id d7-20020a170902cec700b001913993801emr24925006plg.56.1674319880444;
        Sat, 21 Jan 2023 08:51:20 -0800 (PST)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b00194cf9d5fbcsm5113166plk.167.2023.01.21.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 08:51:19 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable] mm/page_owner: record single timestamp value for high order allocations
Date:   Sun, 22 Jan 2023 01:50:54 +0900
Message-Id: <20230121165054.520507-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating a high-order page, separate allocation timestamp is
recorded for each sub-page resulting in different timestamp values between
them.

This behavior is not consistent with the behavior when recording free
timestamp and caused confusion when analyzing memory dumps. Record single
timestamp for the entire allocation, aligning with the behavior for
free timestamps.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/page_owner.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index f0553bedb39d..80dc8f4050fa 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -163,6 +163,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 {
 	struct page_owner *page_owner;
 	int i;
+	u64 ts_nsec = local_clock();
 
 	for (i = 0; i < (1 << order); i++) {
 		page_owner = get_page_owner(page_ext);
@@ -172,7 +173,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
 		page_owner->tgid = current->tgid;
-		page_owner->ts_nsec = local_clock();
+		page_owner->ts_nsec = ts_nsec;
 		strscpy(page_owner->comm, current->comm,
 			sizeof(page_owner->comm));
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
-- 
2.34.1

