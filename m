Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754D73BA31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFWOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjFWOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBABD1706
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaaAtm4E0YzeLzCpC+sle/rLwyV4UWhhjWGc4/kvdNw=;
        b=LeRVe2YosrM8EFo6DWbVO/StP4LggomZjc2H2pqnTRMLTxU/KPVBk5crAHEy3ic7J63IzP
        jwsL37jvGaWGCdEyusG7RjAzmxLyjIRDnunrXeQ9y1aNbCvxskBPbIHNcO0OF+6zcVEuXI
        1RN68cGB4YSLXpjdv/Btc68UdS5VP5U=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-eXSct1RDNYqp0SuVv9vN6g-1; Fri, 23 Jun 2023 10:29:46 -0400
X-MC-Unique: eXSct1RDNYqp0SuVv9vN6g-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39cabe624deso48380b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530585; x=1690122585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaaAtm4E0YzeLzCpC+sle/rLwyV4UWhhjWGc4/kvdNw=;
        b=gDq/ftp1IK/FhgHav3WPPFUGJa4IDAernAQFeSH6Cnfi/419jzbA2e1OqMRKk/L5lk
         bGa2XcKKBd/ZRVkaSwNMG0H3Ia6CLwWxy07O4dPnjYkjW/GY9IPqZcBF+QpQWD/TrSwY
         bJS/QZEiUfvIBHkju8e0zD6hg9DtKczWEMugnLvTF2sTrQcfRWqmAXdstXZSp/QvGPh8
         obeLXLAe1/e3ZMk79yjixswi/xhl2+acYTbRWqLEUEbTgJojeIBKzyrUGasC6n9CuEgq
         9IRTmry6t+9+gRKw7BX+oL5Mmhh2PMTqIgK9toiNoT3KViFzOhkYhOSNKeRtv6ZG9DKO
         nltA==
X-Gm-Message-State: AC+VfDzakg+vI8ZhpvKeU1979PhKyvoBXaUPtmoRktGL/mKUAQpk0u2G
        +hXrpzq8vxxqAa8ZdhwIYs5KRup+aGm3rr7SB4jLOdg/kMa3EUyLlFPKNzoomoAf44MWqr1C2j6
        J83c17Ip0tjQXBvNMxHp7gv4u
X-Received: by 2002:aca:e1c6:0:b0:397:f116:8f67 with SMTP id y189-20020acae1c6000000b00397f1168f67mr15159992oig.0.1687530585229;
        Fri, 23 Jun 2023 07:29:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GO65T8HReZxqXh+dPcy+HPwi177tHnPRkclvjCV4jFXu/xj5JsB/zleCQUHHU+pcmmBAOMw==
X-Received: by 2002:aca:e1c6:0:b0:397:f116:8f67 with SMTP id y189-20020acae1c6000000b00397f1168f67mr15159971oig.0.1687530584997;
        Fri, 23 Jun 2023 07:29:44 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 4/8] mm/gup: Cleanup next_page handling
Date:   Fri, 23 Jun 2023 10:29:32 -0400
Message-Id: <20230623142936.268456-5-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623142936.268456-1-peterx@redhat.com>
References: <20230623142936.268456-1-peterx@redhat.com>
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

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9fc9271cba8d..4a00d609033e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1124,7 +1124,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
-						pages ? &pages[i] : NULL);
+						pages ? &page : NULL);
 				if (ret)
 					goto out;
 				ctx.page_mask = 0;
@@ -1194,19 +1194,18 @@ static long __get_user_pages(struct mm_struct *mm,
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

