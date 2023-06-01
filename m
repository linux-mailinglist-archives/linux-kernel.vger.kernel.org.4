Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDD719352
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjFAGf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjFAGfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:35:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D4D11F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:35:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso28728b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685601352; x=1688193352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo4KpLHyDoqHIBvQ9JqkoTCF1HCKBISMihHQ0OedbcM=;
        b=krWHhOOCJqafMpdTiRylmP4T/OONSeCIK2v322KPtkvuGR0tHxk1/vbaWUhgTmiowG
         xjNQ7rqEV40SanzD9dyiSLZRZIgBlQxXQXNSP8O6URYXAiWpEnwyFyMY0LAS5hRtjPFu
         CGm0gVneZKduAONIbb8nady1sNoc3uTX+YOLQodFNzRT+5M0D65vxdIdm2M/GbRBoFV9
         +0gVub6Q1VS5oX0Kl68IanWEJTNESZlwG9h1oVxkTGF54fy32Eg/SyAVJKH4470PMXRg
         cuWkQ4f+T9SMqBswZouKbIctfH/NLaKqI7HPCNS90frh4OhZFFOXNE419TqUKET2ZwGF
         fnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601352; x=1688193352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo4KpLHyDoqHIBvQ9JqkoTCF1HCKBISMihHQ0OedbcM=;
        b=T7TswpTepxDqPlTGfDQ2Inqrt9XLv6l0AOQjMUWVkBKSDt8FaccH/5VRXUhdnXvIzW
         B+HMVz3bTXNI2ihTs6Jt98bJX+zDl3VQFC7zEccLGjTJ0vzRGs5fyjnPGdlIglzdcOH0
         qFpyUHG4x3v1ZMlNyDOZyihW7b585nHqkUBpQpMRPnzCMTtSCoxj+T4q8BzodvcbLBSl
         5Z4RZzH54jTqLknDgge8tR1p/J61NDn8KWUFGZxhuMk0WoPSouoQLVU0Tm9h99fXi4xd
         Ep4zTp/RlzS4zqa3FEEFgWIPeFPn3cj1UFKzFEt/kCM5xYeeJbM6nBPjwaxXrOPEhnmZ
         JNcQ==
X-Gm-Message-State: AC+VfDxp2YCpWJGvvfJDROjvo0hNBNcA1RtAeuwurUTGognx4BpSbgiC
        pSAZPhSeO09N8meo5SbR1p1lyQ==
X-Google-Smtp-Source: ACHHUZ5spTBejj5IkFva01u/5GywXThuK3IoytVWWM8i2IXBj8gXn1CZt4gbTSfuNNkbfLKuC+MSeQ==
X-Received: by 2002:a05:6a00:1693:b0:647:4dee:62b7 with SMTP id k19-20020a056a00169300b006474dee62b7mr7775708pfc.29.1685601352575;
        Wed, 31 May 2023 23:35:52 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id x25-20020a62fb19000000b0062e0c39977csm4302233pfm.139.2023.05.31.23.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 23:35:52 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] mm/mm_init.c: move set_pageblock_order() to free_area_init()
Date:   Thu,  1 Jun 2023 06:35:35 +0000
Message-Id: <20230601063536.26882-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pageblock_order only needs to be set once, there is no need to
initialize it in every zone/node.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 93821824271a..232efac9a929 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1583,7 +1583,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		if (!size)
 			continue;
 
-		set_pageblock_order();
 		setup_usemap(zone);
 		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
 	}
@@ -1850,6 +1849,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
 	setup_nr_node_ids();
+	set_pageblock_order();
+
 	for_each_node(nid) {
 		pg_data_t *pgdat;
 
-- 
2.25.1

