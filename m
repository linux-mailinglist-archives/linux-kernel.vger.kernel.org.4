Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95868720C31
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjFBXGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjFBXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC8BE41
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685747161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyXRkWA/Qyu248n5VoGdUO1zEkK7SG2+W3IdaIl8SN0=;
        b=baHed5dzHUU0Hc8DS2o2c9Kwlp0UBj6y4Or0HrZkCVJso7tvLYfJmWIbMiIEp/MTqZsscW
        uYDqEztQReM7qtnpZ786BfOfNrnTE6A4WS0fNFe27RiuWDz8sqQg6U4dZEzQ25uh4YUAKP
        ZBqDmfbqUXa0YzvttD5JAccyT5wIRgQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-tFWCiDYEN1qvNS7TYzwrOQ-1; Fri, 02 Jun 2023 19:06:00 -0400
X-MC-Unique: tFWCiDYEN1qvNS7TYzwrOQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6262552799aso3404776d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685747159; x=1688339159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyXRkWA/Qyu248n5VoGdUO1zEkK7SG2+W3IdaIl8SN0=;
        b=C6bkR6fx2pYQc0s336zgtrjDwVZOsdUnkU0awZKc8Z6iJWyFZMrklGsxciZkoqKCNM
         SYijLYdIWvqbjXsxYycafQEYJqgWkW8PP9eikquXkWHKcKNVxyguaTHUFI5w9IF9fxeG
         WWAys/fsUKmhbyl3dxWbcHE21vdXDA7BfyLm3PbydSk0CNu/S3OJ6HMCXeXMW62uNUtf
         O3U6KXmvBb3cLxwJ36mgKl2R54zfih1lhCJ/CvF+8hIXJXmz/VepFXh3ivDNFjmKfijC
         phfHe+yjcT4EMqeVyM/6SN/NApPyGBLrsHYkXO/sLr45Qz4h94dXz0A+L9aIXvrbO0Of
         8Qfw==
X-Gm-Message-State: AC+VfDzQVeej2r1Fq+LCaazbWnu1D8+O+6ef7+Misx1X9qgNpiEHCHqG
        5uMN1xSeGRi7SFXO/pf44UhauZfTpRpf4iaeK2SFj5RGeFpS5gBGSj4qJxrHciLsMGeOT0hYl6V
        LdYLkHsSksLyFhb05fBRIht0CkS8Qmptof3MMo4TfZakvSPZvevpFOZm67uqV0lPKDdfcFcBoXp
        iZGl9ylQ==
X-Received: by 2002:a05:6214:d62:b0:625:88f5:7c62 with SMTP id 2-20020a0562140d6200b0062588f57c62mr13309546qvs.2.1685747158875;
        Fri, 02 Jun 2023 16:05:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5K/eCfNpPKf45g/q2kzlcqwhCRJBvumaZFGiMfEQCGequsfufGMuuFCvVjqmP0/3XBibmk/w==
X-Received: by 2002:a05:6214:d62:b0:625:88f5:7c62 with SMTP id 2-20020a0562140d6200b0062588f57c62mr13309502qvs.2.1685747158456;
        Fri, 02 Jun 2023 16:05:58 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id px13-20020a056214050d00b0062607ea6d01sm1400792qvb.50.2023.06.02.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 16:05:57 -0700 (PDT)
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
Subject: [PATCH 1/4] mm/mprotect: Retry on pmd_trans_unstable()
Date:   Fri,  2 Jun 2023 19:05:49 -0400
Message-Id: <20230602230552.350731-2-peterx@redhat.com>
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

When hit unstable pmd, we should retry the pmd once more because it means
we probably raced with a thp insertion.

Skipping it might be a problem as no error will be reported to the caller.
I assume it means the user will expect prot changed (e.g. mprotect or
userfaultfd wr-protections) applied but it's actually not.

To achieve it, move the pmd_trans_unstable() call out of change_pte_range()
which will make the retry easier, as we can keep the retval of
change_pte_range() untouched.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 92d3d3ca390a..e4756899d40c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -94,15 +94,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 
-	/*
-	 * Can be called with only the mmap_lock for reading by
-	 * prot_numa so we must check the pmd isn't constantly
-	 * changing from under us from pmd_none to pmd_trans_huge
-	 * and/or the other way around.
-	 */
-	if (pmd_trans_unstable(pmd))
-		return 0;
-
 	/*
 	 * The pmd points to a regular pte so the pmd can't change
 	 * from under us even if the mmap_lock is only hold for
@@ -411,6 +402,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			pages = ret;
 			break;
 		}
+again:
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -465,6 +457,16 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
+
+		/*
+		 * Can be called with only the mmap_lock for reading by
+		 * prot_numa or userfaultfd-wp, so we must check the pmd
+		 * isn't constantly changing from under us from pmd_none to
+		 * pmd_trans_huge and/or the other way around.
+		 */
+		if (pmd_trans_unstable(pmd))
+			goto again;
+
 		pages += change_pte_range(tlb, vma, pmd, addr, next,
 					  newprot, cp_flags);
 next:
-- 
2.40.1

