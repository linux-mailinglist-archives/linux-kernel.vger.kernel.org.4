Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7A651256
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiLSTAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiLSTAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:00:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D8114D17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id js9so10055637pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNW8A16mCA3HvLKh5wBxi0WsnpxyoQsg0W035rUDdlU=;
        b=SjsPir/GRG0O5nhdNnhsaE3MhQHqJZ4mVl/THUD4eCydfYFbtbpemySFb+Ft5Wdx5U
         2MrDiiZASOzg8/oHQZoGZFNeTeGjXDbgTDDOlSs6tLS6zQk1tzOsRZos8c0IR8miW92d
         XShpB9RiypeH8hMu1FE4S7AUJDYfQ3+9P9pQf6ZPJMJBhHCIwPruDMC6aOy6HctXFevj
         g9tBhlQDX3N1yS+QcdS+/VZhPcmlP+SuchHqDbQjIulJD6bCkDFcBWPKFCTTNnibzw40
         FUXZN88VJWNIfWZ1wzctW56tuC23pAApGc0qxk11gf4vEEwEKzDO3uURBz3G9z0MXAFU
         yHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNW8A16mCA3HvLKh5wBxi0WsnpxyoQsg0W035rUDdlU=;
        b=ZwDubtLYKdepH8XPwhlbNpbugkBUQRsNdmuYNz6PzxV4Pb383+fvqMhBcr1kVdBDP0
         j3gTm6RpjXeYGAJjNhtwbzpp/5qWKk9vlsQn0WHED1Il6P40yFpIs16QCoYTp7HeoybV
         pmRf9CrKIXCqfpWt3Smbaf8HFDrX/cYYN9lwt11x5KBg6gBtNBGbbUc7Sn/Oq6ig4U/R
         J1tcDRa8x8wQd9fffyGrFnLnq+Q/cCx0L60j5A3kzvGVqb6iI8kVPNisbtxwn2cj64eF
         MuCT4c8wU1FXAVGDZ1+1NEME/JfaIToT8OmKX+SmZUCRV1zCbEcCnKIVHpwE7DvNEo2g
         qDSw==
X-Gm-Message-State: AFqh2kooQeGpYtjSbgg4CHbI0gndepYQi+RcEDZqoQGsFBbx4Ql1PWoc
        I4OBupa6uyZAKkZSYS8EJSY=
X-Google-Smtp-Source: AMrXdXue4571aidkiNSZgU3GJnAm6ssIl5Vm/3VAGWBWSHwRJxQCuxfwEu2/ilYQ+rpJ1+1QRO2McQ==
X-Received: by 2002:a17:902:8343:b0:191:2b76:612c with SMTP id z3-20020a170902834300b001912b76612cmr2600746pln.62.1671476362679;
        Mon, 19 Dec 2022 10:59:22 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189847cd4acsm7480790pla.237.2022.12.19.10.59.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Dec 2022 10:59:21 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 2/4] swap: avoid a redundant pte map if ra window is 1
Date:   Tue, 20 Dec 2022 02:58:38 +0800
Message-Id: <20221219185840.25441-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221219185840.25441-1-ryncsn@gmail.com>
References: <20221219185840.25441-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

Avoid a redundant pte map/unmap when swap readahead window is 1.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/swap_state.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2927507b43d8..af8bc123b7c4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -727,8 +727,6 @@ static void swap_ra_info(struct vm_fault *vmf,
 	}
 
 	faddr = vmf->address;
-	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
-
 	fpfn = PFN_DOWN(faddr);
 	ra_val = GET_SWAP_RA_VAL(vma);
 	pfn = PFN_DOWN(SWAP_RA_ADDR(ra_val));
@@ -739,12 +737,11 @@ static void swap_ra_info(struct vm_fault *vmf,
 	atomic_long_set(&vma->swap_readahead_info,
 			SWAP_RA_VAL(faddr, win, 0));
 
-	if (win == 1) {
-		pte_unmap(orig_pte);
+	if (win == 1)
 		return;
-	}
 
 	/* Copy the PTEs because the page table may be unmapped */
+	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
 	if (fpfn == pfn + 1)
 		swap_ra_clamp_pfn(vma, faddr, fpfn, fpfn + win, &start, &end);
 	else if (pfn == fpfn + 1)
-- 
2.35.2

