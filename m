Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDF7310C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjFOHdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245003AbjFOHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:32:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE62D4D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:32:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666785456adso966176b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686814358; x=1689406358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdSuqedJEIbRKqsNMW9S5G/OsjR68rCgzUTpBoDLnEM=;
        b=iU852+gDGJfi782GaPH9x2wg+XeTiQfHnMpKe82njSX7LmSgor6PAYAv0eEFGaz83T
         V469KupOqNbHHXNJ4Jefz2GB3bC4LZjS2faO6A6T5HWzH2FFEcITh2Zsgk5/t3sKWY44
         NkzEhL0j/+VTAue8L4PvlYkIgx+veA8rgIpczK6FpJUpuYTWFAXj5VvB6se0797A+t3J
         mgGiwwWbHp4YJ3r4k0RWOusTLSUkzwa+q0OoRPly9mGKor87OeO/SXxdU8wAQ+Wd053g
         AJyBa0S3RjgNzLNNkJdtpb63/NRDm0Z0H1NOH05Zft4GUThQFhik4A5One3CXwpQ3lUh
         nI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814358; x=1689406358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdSuqedJEIbRKqsNMW9S5G/OsjR68rCgzUTpBoDLnEM=;
        b=btavRuI+MKAxS7h8q4JqYnohJI3aOtc4/+0F0gxUBMCSatwKtrmOv/oA7ZmKiEXCM/
         a9Ved9B6TLTVBA2HRvadunPSAkiWpLYOAIvYpSibnQzShYYYb8IJjFFHRUMNoJXXo0/I
         kcEjguYH6kryy5BYx8kAeznZqxTzUjKT2k93SCLEw1pjYc8dSyOppJZ19w2cMOdAbCZf
         JyrsTyDnzj3rueT68K8Yeve/3CZ3E7FaI4n2TXVVAP4z+h7dXRTFoHYG04Qwd4c2DnHJ
         g1JHbDXFV8DAspCLbJ7N344/twHonbr2u1L736ykI1M1KueLc43+LUKmQ3uXJKgUnfg/
         NzLA==
X-Gm-Message-State: AC+VfDyOurpp5Fm0gzOzTPHDPF5qHQPqJFwi1iYBMtya0tGyn2HBPk5J
        3V4j8O75uar2HeOuqdg4FJ/P4g==
X-Google-Smtp-Source: ACHHUZ4ZYicTCAv+YpqReGd9GPg56Oefou00qAt0MRGEPlWBC1x7p3+Wj+Oqo6p7TyYjCIjfGMiy2A==
X-Received: by 2002:a05:6a20:42a6:b0:10f:f8e2:183c with SMTP id o38-20020a056a2042a600b0010ff8e2183cmr4686446pzj.51.1686814358308;
        Thu, 15 Jun 2023 00:32:38 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001acad86ebc5sm13352570plg.33.2023.06.15.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:32:37 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] mm/memcontrol: do not tweak node in mem_cgroup_init()
Date:   Thu, 15 Jun 2023 07:32:25 +0000
Message-Id: <20230615073226.1343-1-haifeng.xu@shopee.com>
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

mem_cgroup_init() request for allocations from each possible node, and
it's used to be a problem because NODE_DATA is not allocated for offline
node. Things have already changed since commit 09f49dca570a9 ("mm: handle
uninitialized numa nodes gracefully"), so it's unnecessary to check for
!node_online nodes here.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..c73c5fb33f65 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7421,8 +7421,7 @@ static int __init mem_cgroup_init(void)
 	for_each_node(node) {
 		struct mem_cgroup_tree_per_node *rtpn;
 
-		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
-				    node_online(node) ? node : NUMA_NO_NODE);
+		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
 
 		rtpn->rb_root = RB_ROOT;
 		rtpn->rb_rightmost = NULL;
-- 
2.25.1

