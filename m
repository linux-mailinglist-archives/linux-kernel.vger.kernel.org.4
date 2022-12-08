Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB49647549
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLHSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiLHSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:03:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38676AE4F4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:03:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so5464233pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ltPbBrCKZDS7mJn+bR+RqAKCWGPP/Hc1SQkH2hWVmXg=;
        b=hRgCXWOPDDo7RlbXFKoM69xuCbwt8WjzTaUsg01akGxMhNwABD12DyylexVFkD/7Mu
         M+qrq5HV/MDlhFQ2jxpJkr9HNBE7YMfEZaXVGRTNrwlZFE00eokpEecQWj3j6JrbPCbA
         1zHxzkaBVjYkjr1s2oWBVUR/5nbzmiSc+/4+6qJl50hF8eFgPh9NnQuk0lo+FhfUqNe6
         F3QleTfoMD2zNv1+SBcEq0q4ftrAofnh81ysKVSlErGBas3RbClmzj9QYTQztCMaIqID
         gUiM72cYqHlrpjl8RiTv3askqJOawjDqYKnOo2KlhUkvFGpDTtXyhTuqVoXIozJUmNZa
         Jslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltPbBrCKZDS7mJn+bR+RqAKCWGPP/Hc1SQkH2hWVmXg=;
        b=S8GbmdEaaJ15ZfSu89GZnVlKJeE2tH/TE8XGzvRWNebysPFY7GUehDE84EXQCGVG0b
         xMTrBfJk1IVFdCYcz3hQJ1iNm/sqWerwxAIe7qr/Vui2ojXOX4JSfhEtSc9kTCeVcjfX
         MhDFvswpvCwi2DDSL7tekgo8hFF6Nq6RssRyabUHXKTZ1pM/k0G91jumERUvN6wCMWP3
         rWznlWXlrfpl3DLU2DGtvFv4JW81F6nidahWbkln8/E4nx2zxFRK7us/Uo8AQPsy/bQp
         aSGrN6xI2iV7RoLL25JZ+mVNhmYuKN3CZEe7oavR9X7hQVl4wCaQZAIeqow+cOkR2zMz
         n3AQ==
X-Gm-Message-State: ANoB5ply8ySWdXqsekZBmbo+21OrIE+1FfirJGQla69sU6ee9CF80pVJ
        VPNgRtyG6VGWik56JRWplvc=
X-Google-Smtp-Source: AA0mqf7l35N5CcqRRUA9kCptWivxf7XeTYnN81QwD1VXUWMNcNSdS0Hq0NDpeaJYmfVtAUqrHE18Iw==
X-Received: by 2002:a17:90a:7606:b0:219:823e:6726 with SMTP id s6-20020a17090a760600b00219823e6726mr2920444pjk.19.1670522617801;
        Thu, 08 Dec 2022 10:03:37 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id x23-20020a63db57000000b004785e505bcdsm13377909pgi.51.2022.12.08.10.03.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Dec 2022 10:03:37 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 5/5] swap: avoid ra statistic lost when swapin races
Date:   Fri,  9 Dec 2022 02:02:09 +0800
Message-Id: <20221208180209.50845-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221208180209.50845-1-ryncsn@gmail.com>
References: <20221208180209.50845-1-ryncsn@gmail.com>
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

__read_swap_cache_async should just call swap_cache_get_folio for trying
to look up the swap cache. Because swap_cache_get_folio handles the
readahead statistic, and clears the RA flag, looking up the cache
directly will skip these parts.

And the comment no longer applies after commit 442701e7058b
("mm/swap: remove swap_cache_info statistics"), just remove them.

Fixes: 442701e7058b ("mm/swap: remove swap_cache_info statistics")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index eba388f67741..f39cfb62551d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -418,15 +418,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	for (;;) {
 		int err;
 		/*
-		 * First check the swap cache.  Since this is normally
-		 * called after swap_cache_get_folio() failed, re-calling
-		 * that would confuse statistics.
+		 * First check the swap cache in case of race.
 		 */
 		si = get_swap_device(entry);
 		if (!si)
 			return NULL;
-		folio = filemap_get_folio(swap_address_space(entry),
-						swp_offset(entry));
+		folio = swap_cache_get_folio(entry, vma, addr);
 		put_swap_device(si);
 		if (folio)
 			return folio_file_page(folio, swp_offset(entry));
-- 
2.35.2

