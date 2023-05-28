Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C57137CB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 07:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjE1E5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 00:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1E5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 00:57:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCCC3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 21:57:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b011cffef2so19265935ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 21:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685249861; x=1687841861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y6SJGnovLiW1BoHqtSjmRrQb/vTyNZoHyEISBDMwbA=;
        b=f5k02EKxhAvkYidpXyd20gp3sjqbISQ4DaojJsrLhOh0xaot16gvc13qeYQWhsKsnh
         vAiPTlw/TLiYmYViH5K8eZeZw86cRgaWpdEGzxoAQSzs7iTu3uQZQGl+65Nfx0b5Tegc
         Es/VwvgRnzX5j5ergaJ26f/v/t+uSH1ClGicW7y8aHOyXLS2RkrVlaCRZdCcFzGAfwPT
         O8xyRAwl9m0w8dyc6+kZnKlVgl/SXrXhGvjUsyfGgeqUoDA6YaHfIROfB+sOCqDB78Bj
         nb9a1ZWLNWIp40ALZe22tviMag4+9jvDTPK9FFHl2vU+CP6vz2s9MGvMENHJXQIktYYy
         9q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685249861; x=1687841861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Y6SJGnovLiW1BoHqtSjmRrQb/vTyNZoHyEISBDMwbA=;
        b=IsOlwseE/76NjcQMhWXU3HYecO1kljE92qAdSJRT0Y/jvOAnL2hEkRVS6G1tDgqm9I
         l86zbf/77HKKmkBDiAo4hMRwiwJXue4UWLysnl+/qLNXboOUfSAox3X1ki7SKnGixyn5
         V3a6Yl+0FEQLDwKjM3nL7FJx3Yl+vyzLOWwiOE2r6tWRESQCmERsyOwnTlPkpsiymptL
         iVavA24EO9vQmuKn4Ck5mm7xikKLABD1NP0iZfJa71lZ3eFbITRVxKn96sn/QDiB1K6v
         J5gwCJ9JyEuGdboEALzmnfdGeso+aMTeaSkAA9u3UrpHJGdkyX5yH+0n0zMETqz52an5
         BcvQ==
X-Gm-Message-State: AC+VfDxVn/AuQrkgzquqCWy6XiHBui4mQ9vnNeKv2GpIgfLfPngQaRrd
        UKNV2DISuKePK6Pfksoy1ie7Pg==
X-Google-Smtp-Source: ACHHUZ4ckyNj+w7EKCUYiU5f/DGbrjXYoq3bFTp0qyuz4Xu0prfsInCKjHWsYGBiCH31AimtFZdqrA==
X-Received: by 2002:a17:902:da8b:b0:1af:de3d:bbe3 with SMTP id j11-20020a170902da8b00b001afde3dbbe3mr8514621plx.26.1685249861061;
        Sat, 27 May 2023 21:57:41 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b001b02bd00c61sm1659595plg.237.2023.05.27.21.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 21:57:40 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/mm_init.c: remove free_area_init_memoryless_node()
Date:   Sun, 28 May 2023 04:57:20 +0000
Message-Id: <20230528045720.4835-1-haifeng.xu@shopee.com>
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

free_area_init_memoryless_node() is just a wrapper of
free_area_init_node(), remove it to clean up.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2d91bb52c619..93821824271a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1752,11 +1752,6 @@ void __init setup_nr_node_ids(void)
 }
 #endif
 
-static void __init free_area_init_memoryless_node(int nid)
-{
-	free_area_init_node(nid);
-}
-
 /*
  * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
  * such cases we allow max_zone_pfn sorted in the descending order
@@ -1867,7 +1862,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 				panic("Cannot allocate %zuB for node %d.\n",
 				       sizeof(*pgdat), nid);
 			arch_refresh_nodedata(nid, pgdat);
-			free_area_init_memoryless_node(nid);
+			free_area_init_node(nid);
 
 			/*
 			 * We do not want to confuse userspace by sysfs
-- 
2.25.1

