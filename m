Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805546FDA69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjEJJIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEJJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:08:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599F2680
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:08:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so10951082a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683709712; x=1686301712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jY6ohWt0SiEOpD+GaXhJR12rpojr2gafwTd+y3U4lgE=;
        b=dgs7sb1bhyKMn9gNX8gJw1oa0vsL3dNqXLVgQVEgqrf4Ym0n9kugYLl5pLHHhUxtSW
         FNooMdlmHa9Qmd2S1JTvv1A1eXRT/7Ml6IFNTDOSc9+TY0StE2f3xVVVaBwWGUJuOECO
         R8GXuGxDzghWh8O6ai+Pv7wWXsp8uG7N58Dc8NvMiTF034Hw6cUdiNuvxDrgs4n3nGPv
         5Uf1vqGDeXxUyE1VNLuWze3RqNunJFH1HGKLhZxoTd0HgMob4uegnJSgVqFlzQoHODWM
         DGqXj0BGBgEnMZiktvo7fgcFU5IXgd/ArrP64VuVDqeP2GrVLtcKWyuYWVFTASqhdDxg
         vsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683709712; x=1686301712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jY6ohWt0SiEOpD+GaXhJR12rpojr2gafwTd+y3U4lgE=;
        b=bbs14zCgXFVIuBOJjUcjySh6T8WfyzSXtLJ1lbrmsOVB7jdU25xGFXGa7oavO+8sxe
         V4hmXbYvDH/ifMgc5dAeZB5rN5TJxWefRg9ZZ4ho436OME7Vb1+ct4jjlOob5LTEenEo
         gt4EbGQRGizQ/f4swFy8arBUPJeOits0jvPZjJfSzo9tPe7JqGc0SJjipWf3Qk90pfUj
         YrXSxb1OWW0XfOIAklmWtb+V3ezrcLgRO8HUmOTc4KNuEaf9Pg+Q3uX+vrSvZLbxtuGx
         Cnyito2j/tqqyTbFyllQ4SBkf3XOW8RfHK3fLcNNfLUM8X/SBhlI0HrmjfMi5yPEEPzL
         LCSw==
X-Gm-Message-State: AC+VfDy4nXqpAeiva788T5kxvm7AfxaOLcQSatFtf2qtbTceRj0Rj+Hy
        FivoMmCDKx+6F+ujKe9w36E=
X-Google-Smtp-Source: ACHHUZ4tVcaB13/9zdmOHWNFweUSiksBeeFfkvUoZEaFmbc0DSWlfsakHy3k5zaGVLVwkn1NLoN1Ig==
X-Received: by 2002:a17:907:2687:b0:94e:16d:4bf1 with SMTP id bn7-20020a170907268700b0094e016d4bf1mr13278593ejc.66.1683709711884;
        Wed, 10 May 2023 02:08:31 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id hz17-20020a1709072cf100b009664e25c425sm2440333ejc.95.2023.05.10.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:08:31 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     rick.wertenbroek@heig-vd.ch
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memory_hotplug: Fix format string in warnings
Date:   Wed, 10 May 2023 11:07:57 +0200
Message-Id: <20230510090758.3537242-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format string in __add_pages and __remove_pages has a typo
and prints e.g., "Misaligned __add_pages start: 0xfc605 end: #fc609"
instead of "Misaligned __add_pages start: 0xfc605 end: 0xfc609"
Fix "#%lx" => "%#lx"

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..9061ac69b1b6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -325,7 +325,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	}
 
 	if (check_pfn_span(pfn, nr_pages)) {
-		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
+		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
 		return -EINVAL;
 	}
 
@@ -525,7 +525,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 	map_offset = vmem_altmap_offset(altmap);
 
 	if (check_pfn_span(pfn, nr_pages)) {
-		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
+		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
 		return;
 	}
 
-- 
2.25.1

