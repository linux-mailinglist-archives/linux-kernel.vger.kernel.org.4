Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2056E6CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjDRTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjDRTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED4C66A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:21 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id me15so9555374qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845200; x=1684437200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7sno8AaRf5ATInZUw+i9Aey3v69SOK+YNtRO/2P9OU=;
        b=x7kihz2Xek9Oawcxi+XxZhyApuNkNkSuXAlGa0k24xE/zxYmZiL9Tjnypqyo29xZrW
         Nsmvw/Opca5Epg2iXzQaqdiJrL5rqFjWGypHqp5urO1vUn8xS+vqGK55FJzonBr1mCwf
         wGaiiiFg2tItrhXI7KwlkaJG/RDfu09WqpY33e+D80EVxDPradvBJJ12Je5vjNrE+TPi
         ts+YdchVOie8BtYVf5YyCDVqV+r9hhn3Nl1kzyCzI5gGydNCC6lEPeXQFfpGWMSh2+pi
         CGhIO6Il7AoD+ydlRVCr5v40EZuhLfXbDgvfOUIzqKX+MJNjjoo0qr3XT7MqqIkU6bO/
         IqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845200; x=1684437200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7sno8AaRf5ATInZUw+i9Aey3v69SOK+YNtRO/2P9OU=;
        b=NrTVueUMFASXhcrND38dhLe/koeJIvmgA8lq+TDM2rBb43oK/pKgidf8gEMMOwRIuQ
         cxz2uIydibwwg66ycuyaR3oLYy+CSwTzRI2IjuCqVtnbSzjC96a9FH8ZwAMvEJJWLWdr
         ThBu8+D3eHD47DsoS8IYZ4cLCSxLGazSlrX25Lww5a1J4H+iElMIK8vLln6STnbUs4+j
         5C/01vgdD2IVFWSrR1PrUZrii65d5bkfCwNVA3sp7HirIJfZ8mzmZ9WgMldgYt4Me7na
         QaQodiEz0KMiN/hYd7SllEmIdKcjBPP7hTweriHljNV7oxf3Q52EP4tKPd5RB+yTT45z
         S9vA==
X-Gm-Message-State: AAQBX9fihF4B3AVTid7L/Lbk1RdpjiY23/IgkYpDvzCIMipxuPJguJya
        pVwn7+b5dM4hhAAMziDkPtGQKA==
X-Google-Smtp-Source: AKy350Y2WvA1kj6Bsm7oquBxOdrZDbffru8om2OFKpHsG6Pe1CEinFIFTzd6IhJxiRR2FIVaaYlT9A==
X-Received: by 2002:a05:6214:c4b:b0:5ef:807b:2a96 with SMTP id r11-20020a0562140c4b00b005ef807b2a96mr11066482qvj.21.1681845200482;
        Tue, 18 Apr 2023 12:13:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a0b9500b0074e04516389sm659536qkh.35.2023.04.18.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:20 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 01/26] block: bdev: blockdev page cache is movable
Date:   Tue, 18 Apr 2023 15:12:48 -0400
Message-Id: <20230418191313.268131-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While inspecting page blocks for the type of pages in them, I noticed
a large number of blockdev cache in unmovable blocks. However, these
pages are actually on the LRU, and their mapping has a .migrate_folio
callback; they can be reclaimed and compacted as necessary.

Put them into movable blocks, so they don't cause pollution, and
subsequent proliferation, of unmovable blocks.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index edc110d90df4..6abe4766d073 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -488,7 +488,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	inode->i_mode = S_IFBLK;
 	inode->i_rdev = 0;
 	inode->i_data.a_ops = &def_blk_aops;
-	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
+	mapping_set_gfp_mask(&inode->i_data, GFP_USER|__GFP_MOVABLE);
 
 	bdev = I_BDEV(inode);
 	mutex_init(&bdev->bd_fsfreeze_mutex);
-- 
2.39.2

