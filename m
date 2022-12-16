Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6501964E909
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLPKDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiLPKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:03:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027074A58A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:03:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so1837301plj.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUvTdIY3gvw667yEWXGZFZNpXg0OCgQk69zGL2Ac07I=;
        b=qOAYVCpfFnc4NmMnw6dM2WcH06R/D7V7bS5+pgXu+TDnsFI7T+VnweyBf5tpmKvrsG
         dxfZGoa8t+/j9ptBAWZ2TLh8vNU4opTZDk5usPfr4bZnlBVIkhyfFGKFqnlB/4IiatA8
         f0GdmUrc9WWIBtELMwp9faqndC03l6/63tkPqr8NqAirvObmetOz2xyN7bvyecOU0QaS
         0OQeVDi9alrkbtGxZdZ6RnF44CLCiPp89MdaXh5+NhYOljtsZSStSJ9edQ4Gy6GL3Ftu
         s6MwqCKTL8AvA5FSwEyuaMxpkEk09uWRWRusClqDFMsKA/AKDpz1wMNowuwyBqf/4c/d
         w65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUvTdIY3gvw667yEWXGZFZNpXg0OCgQk69zGL2Ac07I=;
        b=R1JamUfqCOjcLdpvbstYVEgdxlgqylvqv3qPldFoGhT05f18EkCZP1FooaVGNeCf5Y
         nJ7l4vlYnGa/4lWotkBywOy7EwberdcqFusf3rPJvb716IObBsdQPUsff6ahvTg6P/hc
         wv02KAY6ahOwOyFtJNKgFZz+jCZzIsp/4r7SvU/D304VZ735aYMvCFilmA2opCyGdD0G
         mlf8fF+6l+WMSMwGuQM+Q1uZnt5HfAhmncUjlQ565s0alia05byi7PNhSa9rqR3TWVBF
         m/HAM9i1mojKUhluBdKkvh0J3MKQLIqpsActYW8tXEXGPPqCvRPftn6DgX37HFC+iIWV
         Rl+w==
X-Gm-Message-State: ANoB5pmHfcLtOwmvJL+bh3VtiwpIVo0zVPrcrZhgTiznCnNrp5LkzGqU
        WZnc5K9EnBBsZwWyfKNnzfA=
X-Google-Smtp-Source: AA0mqf7rfPR7MjwLaQooPfipd42Wabr+nEX2WAIKjRoXoGoid3gEvtchJf+iEfRHCm7vS+eifNmy8Q==
X-Received: by 2002:a17:902:e38a:b0:18f:7fb3:fe11 with SMTP id g10-20020a170902e38a00b0018f7fb3fe11mr18934276ple.19.1671184992470;
        Fri, 16 Dec 2022 02:03:12 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id b4-20020a170902d50400b00182a9c27acfsm1178645plg.227.2022.12.16.02.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 02:03:11 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] memblock: Fix doc for memblock_phys_free
Date:   Fri, 16 Dec 2022 14:03:03 +0400
Message-Id: <20221216100304.688209-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock_phys_free() is the counterpart to memblock_phys_alloc.
Change memblock_alloc_xx() with memblock_phys_alloc_xx() to keep
a consistency.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..d036c7861310 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -836,7 +836,7 @@ void __init_memblock memblock_free(void *ptr, size_t size)
  * @base: phys starting address of the  boot memory block
  * @size: size of the boot memory block in bytes
  *
- * Free boot memory block previously allocated by memblock_alloc_xx() API.
+ * Free boot memory block previously allocated by memblock_phys_alloc_xx() API.
  * The freeing memory will not be released to the buddy allocator.
  */
 int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
-- 
2.25.1

