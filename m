Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B237472522C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbjFGCqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjFGCqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:46:07 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F21990
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:46:01 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-565cfe4ece7so76002967b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 19:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686105961; x=1688697961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y4cpQu1sdYA6+2nMRyH32rTc0BdepZfuCueHh8wgQ4=;
        b=HMoDpGxwfm87j/JEZXDRmv8x4x6KJh3hyX7ilOvqVJ6AfoAy62VEps/FuPtBsHKt8W
         22opKIRkZyYSrWJSKXnqP4327VC02fGAaVCifGAbR1PyecXRmeuamMLje03HuElZXvKz
         WdjrWXHC1g3ddYePoXSJC2emmxFXOD+8Gvzu5kABh4BnsW/YxvzkZgb8rU8XVy/aJX0a
         lbAsG/BdRxNJLoKxr4sODzLTqxpaRjBrFDNKk9A0T9pJkdOPoHto/GZj8hQ+shSVWXfP
         ErUrk9txBu+8Kv/B4fyl156GlVGw3a9Kte+WdTpstYTvP16ZSVE3FlXnlAA4XLQaZwv3
         oeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686105961; x=1688697961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y4cpQu1sdYA6+2nMRyH32rTc0BdepZfuCueHh8wgQ4=;
        b=hAly3cOkAtHes6B3WqN7Fc0BJBS7rVSTpUJ+NuzwjfAkfow1V2BuskV2shW0yJltiP
         fQ5YOk5cfLqbR95BRZpC6ujMZ6+8OzaGSicbV8cSYlLCoKEMMDthW9STR1g4zxdWf0I/
         HkPm5f+7HZwqwPwlhzmiOV2KWUU6HXwGZfmF+pT6wd2bF/QdJ3as/O/zbcgnA+r4JBOu
         KfXaNfRDdPZv8CQJIMq+XttgLzvzU22NDEkC4QdkiJV3RQ10UEuPioJO9MfHMgDr7m4v
         0SuLjT6dHvHhLtaIc+x95iw3ac911bMgveZLrDt8Nez6SWmexX9KOWu08ZrildSO5xA+
         8rBQ==
X-Gm-Message-State: AC+VfDzvqYg4bL/KtltAIfk5zlI1NElRZVL3BSbriXeNGFpMnG7Kzi/x
        D0rTSYPdmLL4i3OAcYRv768qur5lm87ObMPfa7tMoA==
X-Google-Smtp-Source: ACHHUZ4dxus19P+lyr4IEn4CBH2WtiWiSxvheWcDTyK4wXOCaDNWuqPT3y483yKgCqbU9DznKrv//w==
X-Received: by 2002:a81:770b:0:b0:568:be91:c2b1 with SMTP id s11-20020a81770b000000b00568be91c2b1mr5223033ywc.9.1686105961046;
        Tue, 06 Jun 2023 19:46:01 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b0063b898b3502sm7386477pfi.153.2023.06.06.19.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 19:46:00 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     david@redhat.com
Cc:     rppt@kernel.org, mhocko@kernel.org, osalvador@suse.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 1/2] mm/memory_hotplug: remove reset_node_managed_pages() in hotadd_init_pgdat()
Date:   Wed,  7 Jun 2023 02:45:48 +0000
Message-Id: <20230607024548.1240-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f125f0db-30fe-5452-4669-3e48f7856569@redhat.com>
References: <f125f0db-30fe-5452-4669-3e48f7856569@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

managed pages has already been set to 0 in free_area_init_core_hotplug(),
via zone_init_internals() on each zone. It's pointless to reset again.

Furthermore, reset_node_managed_pages() no longer needs to be exposed
outside of mm/memblock.c. Remove declaration in include/linux/memblock.h
and define it as static.

In addtion to this, the only caller of reset_node_managed_pages() is
reset_all_zones_managed_pages(), which is annotated with __init, so it
should be safe to also mark reset_node_managed_pages() as __init.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
v2:
- unexport reset_node_managed_pages()
- mark reset_node_managed_pages() as __init
- update commit message
---
 include/linux/memblock.h | 1 -
 mm/memblock.c            | 2 +-
 mm/memory_hotplug.c      | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f82ee3fac1cd..f71ff9f0ec81 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -128,7 +128,6 @@ int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
-void reset_node_managed_pages(pg_data_t *pgdat);
 void reset_all_zones_managed_pages(void);
 
 /* Low level functions */
diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea06ab2..da4264528e1e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2122,7 +2122,7 @@ static unsigned long __init free_low_memory_core_early(void)
 
 static int reset_managed_pages_done __initdata;
 
-void reset_node_managed_pages(pg_data_t *pgdat)
+static void __init reset_node_managed_pages(pg_data_t *pgdat)
 {
 	struct zone *z;
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..65e385f34679 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1210,7 +1210,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 * online_pages() and offline_pages().
 	 * TODO: should be in free_area_init_core_hotplug?
 	 */
-	reset_node_managed_pages(pgdat);
 	reset_node_present_pages(pgdat);
 
 	return pgdat;
-- 
2.25.1

