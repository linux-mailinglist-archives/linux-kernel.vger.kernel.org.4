Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29386C677A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCWMCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjCWMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:01:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700D1FE9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61199B81CED
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F1C433D2;
        Thu, 23 Mar 2023 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679572790;
        bh=hhPbL79oPMdtDe7maqPTdafjDuPMITrYj4jgPoVH1Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdLQR8S7HwWTgjH50FDeeSUqXWGo4+fmBddMMbOGV8fam6vbmTsBm1LzANxUs1fkm
         TPBv/1tebFkcRlg08L0fIioLsQbG99cRIqtzhoFxLQ19qEmItnHCo/1T/Mx/Bbva83
         iZl063I623DZhNP4k6nGPyUFFzg7MI/6tngGxcxH+RbQQuyx8b91Kdj9L9xhqvdTjq
         VyHP8zdPBWUWM5dRHA90ZVSmE7ssEMXP5WTICb8myhmdzKrCofE+WHVjFP46n5zryQ
         s8yiXAqPZvgJO8w+Rf++/GOnAKcBn9kLpYHLi5IQQKGKZ8ceGkA/HYqvKinawYfrtT
         uqmU9SAVV4bxA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: vmalloc: mark zero_iter() static
Date:   Thu, 23 Mar 2023 12:58:36 +0100
Message-Id: <20230323115903.1483668-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323115903.1483668-1-arnd@kernel.org>
References: <20230323115903.1483668-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The zero_iter() function was put into the global namespace,
apparently by accident:

mm/vmalloc.c:3448:8: error: no previous prototype for function 'zero_iter' [-Werror,-Wmissing-prototypes]
size_t zero_iter(struct iov_iter *iter, size_t count)
       ^
mm/vmalloc.c:3448:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
size_t zero_iter(struct iov_iter *iter, size_t count)
^

Fixes: d9cab54f7737 ("mm: vmalloc: convert vread() to vread_iter()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fb216495fe5a..55f5d6fc8629 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3445,7 +3445,7 @@ EXPORT_SYMBOL(vmalloc_32_user);
  *
  * Returns the number of zeroed bytes.
  */
-size_t zero_iter(struct iov_iter *iter, size_t count)
+static size_t zero_iter(struct iov_iter *iter, size_t count)
 {
 	size_t remains = count;
 
-- 
2.39.2

