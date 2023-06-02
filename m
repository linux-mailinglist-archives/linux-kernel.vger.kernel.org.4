Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D75720C2F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjFBXG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbjFBXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96886E42
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685747165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/N76tvOnLlaQAuSL3pN8eRsyONhrct8MBiAnZh2TuI=;
        b=h087KohY/9Zk9c75R/dGcIsgkLLMfhctZS6UBnp1D5BgCWuvn4B1TtjU1vEyuPYO1cOY7H
        qqUbedAEGMO2h8G6opHop4CwP2sC8eaD1WpN4I6Pyh9d49fn/xEy4hBru0aQ0aQhoHMGAT
        kC/i3cFfoqZd9Us07EDM6mO7S0xUx6M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-rNkeITVuMGi6grhx4f1C2A-1; Fri, 02 Jun 2023 19:06:05 -0400
X-MC-Unique: rNkeITVuMGi6grhx4f1C2A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6b46e281eso3409491cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685747164; x=1688339164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/N76tvOnLlaQAuSL3pN8eRsyONhrct8MBiAnZh2TuI=;
        b=aEd/DYkU0Rj2K0wfTT+pQpeRKlwGMseKpAGwrHs4xvUxngTvbrjJSockYWEAhtFNe5
         DugE2DAfJhNrJ5yOsaEaV2HQXHTpvTiqpt5JvTvxhV7hXme61plLuiT1CGN2L/WLQLMm
         l5To6mbVUvO6hyzOV2HsUeTa7BnuQP9Gi+ktB5dmfexzV6ABzyCaU33h4mt1lTj3aOJz
         3qPodjmw7gkmc691d1yhJhw4FAALbvEsutePjtWEPO55jAwT+RbzvG/TfmPSOWhaF6f1
         MIEpcpSh++QzzE4LmIGVpZS4yRx5IU3q0T01o9BGWpMxfXPHjGbRsNAtF/x7N0mx2HOl
         H2eA==
X-Gm-Message-State: AC+VfDz+4XdPJg9voqAlMUn44FhCEc8uKXEh/9rDD0aHqXJkxOU1MdAk
        6kK+UQBphq2urOxEBP9aaOwePXcXLTpesX407yZpMqaEA9obIsBnt1wn8Mm7+2fz5cif0/vV475
        PyyPv5pIpEmHMDNA36mT1NiXLdGI7M7br691PTB0Y9DcEAMKDzwQCS0dWrQaT23EF2SCRw5oIgl
        6J+lrerw==
X-Received: by 2002:a05:6214:21a5:b0:621:bf0:7609 with SMTP id t5-20020a05621421a500b006210bf07609mr13309574qvc.0.1685747163782;
        Fri, 02 Jun 2023 16:06:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72XzP/ydKQWH7l9Z4c25d5qXfP9a6aS2o8XV1w7zadBGgW02t+vCAEiSwKG40CQBv8aJjIeQ==
X-Received: by 2002:a05:6214:21a5:b0:621:bf0:7609 with SMTP id t5-20020a05621421a500b006210bf07609mr13309535qvc.0.1685747163387;
        Fri, 02 Jun 2023 16:06:03 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id px13-20020a056214050d00b0062607ea6d01sm1400792qvb.50.2023.06.02.16.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 16:06:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 3/4] mm: Warn for unstable pmd in move_page_tables()
Date:   Fri,  2 Jun 2023 19:05:51 -0400
Message-Id: <20230602230552.350731-4-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602230552.350731-1-peterx@redhat.com>
References: <20230602230552.350731-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already hold write mmap lock here, not possible to trigger unstable
pmd.  Make it a WARN_ON_ONCE instead.

Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index da107f2c71bf..9303e4da4e7f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -544,8 +544,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 					   old_pmd, new_pmd, need_rmap_locks))
 				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
-			if (pmd_trans_unstable(old_pmd))
-				continue;
+			/* We're with the mmap write lock, not possible to happen */
+			WARN_ON_ONCE(pmd_trans_unstable(old_pmd));
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
 			   extent == PMD_SIZE) {
 			/*
-- 
2.40.1

