Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0581972EE54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFMVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjFMVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079D1BD3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+etnUAQLV4NR7aCVrXKWbeziVnwWOuYfO0O45I26FE=;
        b=X+LsFmVuAb+J+kUzExri4EsyTs8FY9mvGRF58p10AYaZDRP6HlZufjx/wGrP8QlUs0hDjk
        s+yaGIGjnTTyvsFtDMXExoH/SZfWqc+qqh7EvLiFEq6EYcBUrPynVFpdJ/GllSfIaRgr8I
        0T84nMwlxCHtkeG4DY1487XMtTU1atk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-N_KwzfysNCSjx2fTyoimkA-1; Tue, 13 Jun 2023 17:54:03 -0400
X-MC-Unique: N_KwzfysNCSjx2fTyoimkA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f8283a3a7aso13777301cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693242; x=1689285242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+etnUAQLV4NR7aCVrXKWbeziVnwWOuYfO0O45I26FE=;
        b=AYS6A7xHwr8AUU90mM8VRAkicmlyjemGPL2s8RmgAHlYr/N0xxUZyroi4xyxEO1RNp
         GumhL83+lWFlQYQIi+B6nRXeFU2Q9sx2siGBcYzUh3XAFJuqRcXx7D5VZyHdm0baEYj8
         T/JU6T+mYYQJdT9jtjMVI2oiZu9kjzA0/LySE1K/kIVfvVNlxjUXiNhJw2VyE4UtfNpU
         S1WuXsVLDpkBGD4KMMeKuo5j4GKsOlDHZIYJPzM7HKddeDyKzdIbZRIAiojX+8Jjn+n0
         3HI0bp4tnKYhuAXvx3dTj/Az9JeUcIO0D/aL1INzQoq0hh5jVWAEgzdAO6rWvByEQhLm
         Ytgw==
X-Gm-Message-State: AC+VfDxSnCdJ2LrH383rr3XvkN6kC2DjjiSvzitywKhqrJ0512CJBXbr
        tP0AlY4S+5cyqfUpVH2XDAlyQkZ31rFF/e1Nh/YDtkimAIuWFThb29TQ63Oj0pUHgymuqQgmjJ+
        AiyWuFRGAxA3w+mabYFobV+DajCxa3uYBD+gmOzibKYNEi63cOP1dIOOwYxeMu3z8n8LC6UHCIO
        pbDQlB2A==
X-Received: by 2002:a05:622a:288:b0:3e3:c889:ecf9 with SMTP id z8-20020a05622a028800b003e3c889ecf9mr18140069qtw.1.1686693242232;
        Tue, 13 Jun 2023 14:54:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63MJGi+Hqlnli2JVzskYtPLZcbne7s+MQZPsj8TgX9mGHr+EIA5dm91k8Xq113ELiGPseUlA==
X-Received: by 2002:a05:622a:288:b0:3e3:c889:ecf9 with SMTP id z8-20020a05622a028800b003e3c889ecf9mr18140043qtw.1.1686693241922;
        Tue, 13 Jun 2023 14:54:01 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:54:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 5/7] mm/gup: Cleanup next_page handling
Date:   Tue, 13 Jun 2023 17:53:44 -0400
Message-Id: <20230613215346.1022773-6-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613215346.1022773-1-peterx@redhat.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only path that doesn't use generic "**pages" handling is the gate vma.
Make it use the same path, meanwhile tune the next_page label upper to
cover "**pages" handling.  This prepares for THP handling for "**pages".

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8d59ae4554e7..a2d1b3c4b104 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1135,7 +1135,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
-						pages ? &pages[i] : NULL);
+						pages ? &page : NULL);
 				if (ret)
 					goto out;
 				ctx.page_mask = 0;
@@ -1205,19 +1205,18 @@ static long __get_user_pages(struct mm_struct *mm,
 				ret = PTR_ERR(page);
 				goto out;
 			}
-
-			goto next_page;
 		} else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
 			goto out;
 		}
+next_page:
 		if (pages) {
 			pages[i] = page;
 			flush_anon_page(vma, page, start);
 			flush_dcache_page(page);
 			ctx.page_mask = 0;
 		}
-next_page:
+
 		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
-- 
2.40.1

