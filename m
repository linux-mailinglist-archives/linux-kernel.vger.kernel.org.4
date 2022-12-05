Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF96420F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLEBBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiLEBBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:01:10 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678812AC8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 17:01:06 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id i12so7305251qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 17:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XQiQTDYJ2jY/fTbAU6ju+a6cwLf1VHUEdZD/PoKH6D0=;
        b=Zg8MJRjfsHEIk0G0RZ9mM9jssIp+D4MW8a9QIFQyMCw+6+QCRDGnT1jiw2jue1OAEF
         BsE2Svp+Gg9zHgen7JkXvd+jlbGlKw+Wh1VlKcWj8+qjYLNxzjsBzpeNo6PzW7LPOnt+
         Y2NSPCppRVgbet5aFy6hNmRzAH57yk9zjwUCMPE8Rjts+zR2k6H+3egA1nUiC+DuAfK1
         EvbLwTL4pgfRnzGsYR+HTdaAj+LLCIimd312sUDYO/MMl1vuf1r+IdmlhDDi3UIZX8jg
         2p7l/11X0CNvW518g5V25ardOKcLsa2ZZS3Fk+Rr+KdIgpJ6RuO/jg27nU/XsOtJwpbw
         DTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQiQTDYJ2jY/fTbAU6ju+a6cwLf1VHUEdZD/PoKH6D0=;
        b=1orpS+yg1QJwNvULVusLCCeL9CBvessVdqddadj5e4yoLbDDeIKLm86fxitiSKCUIm
         8c2x8dNIxkkCmWlrzkQkPoXwWNaNeYTC8fWz6OhE7nIpvJ2pdm2SqVGSFv/Fyxc1ZNR3
         eUdcBm2UvZwITpc5QZf0vInOa90pUJAVzRbSW+RdgA0J6ZMhEceNLoMVsRQdmoyLZvwZ
         Nr4iN1rlNpC2nhJKGejDT1KC2MjdaCAKAM4Bgjk+p8zXDcaD52gotky05wTuGe4ozX8i
         U671K315mfBBqDTqZy1QZxECnSf2V5nRlT64N2vnFYHGyhT2SjFALUP2MpWIVDq9sHsh
         0T9w==
X-Gm-Message-State: ANoB5pk5xw73EF/Mgmw+wUME4OwD/YvSD5lnZIqZuQX18s2fj/oxqShX
        KNRkrHBEHuEicy6UVAjVszlUQw==
X-Google-Smtp-Source: AA0mqf7hqtOBz59DeGLCi7IQRtjH8Fqm+J2TV230sQLghZnCBhi10bNddh2dbeznHyMciZ5mdHhDCw==
X-Received: by 2002:ad4:4343:0:b0:4c7:b0f:675c with SMTP id q3-20020ad44343000000b004c70b0f675cmr25171954qvs.23.1670202065815;
        Sun, 04 Dec 2022 17:01:05 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s14-20020a05620a254e00b006fb9bbb071fsm11147542qko.29.2022.12.04.17.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:01:05 -0800 (PST)
Date:   Sun, 4 Dec 2022 17:01:03 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: memcg: fix swapcached stat accounting
Message-ID: <b8b96ee0-1e1e-85f8-df97-c82a11d7cd14@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd been worried by high "swapcached" counts in memcg OOM reports,
thought we had a problem freeing swapcache, but it was just the
accounting that was wrong.

Two issues:

1. When __remove_mapping() removes swapcache, __delete_from_swap_cache()
relies on memcg_data for the right counts to be updated; but that had
already been reset by mem_cgroup_swapout().  Swap those calls around -
mem_cgroup_swapout() does not require the swapcached flag to be set.

6.1 commit ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
already made a similar swap for workingset_eviction(), but not for this.

2. memcg's "swapcached" count was added for memcg v2 stats, but displayed
on OOM even for memcg v1: so mem_cgroup_move_account() ought to move it.

Fixes: b6038942480e ("mm: memcg: add swapcache stat for memcg v2")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/memcontrol.c |    6 ++++++
 mm/vmscan.c     |    3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

--- 6.1-rc8/mm/memcontrol.c
+++ linux/mm/memcontrol.c
@@ -5741,6 +5741,12 @@ static int mem_cgroup_move_account(struc
 		}
 	}
 
+#ifdef CONFIG_SWAP
+	if (folio_test_swapcache(folio)) {
+		__mod_lruvec_state(from_vec, NR_SWAPCACHE, -nr_pages);
+		__mod_lruvec_state(to_vec, NR_SWAPCACHE, nr_pages);
+	}
+#endif
 	if (folio_test_writeback(folio)) {
 		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
--- 6.1-rc8/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1346,11 +1346,10 @@ static int __remove_mapping(struct addre
 	if (folio_test_swapcache(folio)) {
 		swp_entry_t swap = folio_swap_entry(folio);
 
-		/* get a shadow entry before mem_cgroup_swapout() clears folio_memcg() */
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		mem_cgroup_swapout(folio, swap);
 		__delete_from_swap_cache(folio, swap, shadow);
+		mem_cgroup_swapout(folio, swap);
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_folio(folio, swap);
 	} else {
