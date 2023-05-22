Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE4070BB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjEVLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjEVLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:14:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE4D1BD7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:09:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f683e8855so488862466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753739; x=1687345739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2bGuuQYL8b+xbvuLn4PcYekQUWt9yPN5iQ314l4lMI=;
        b=PvB7xNb9ygkZOuxzTtzRZdOhB6MfhJSa/XRAM+BYE1xoLfv+ewUOyX4VD8Bu0FXaOK
         AXlUTKkyIK2WVRsD39QMuEntv1HpM65yERdXpxKJXgRGMC2pW3R98Ogtx7X6mgbxBHMR
         ldToVDFezt0XeMtgZh1MaqlUYU2be1G2xPupT/rIWTKOSu/1KFkLMDIX1H3BLSGe29sO
         Fg3kOpF9fGfKN44fAOhFpBwP9Z7IQ03rJSGvaYH1M1Nh+mhzwxadyfvgGc5HplBYwh3q
         fzDEE5gFHzKH0XnCa9ZqMPOjoi2odYahJQNJL0GrEIc+/7U+m3d4QYr1A8eWf9czKONh
         1f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753739; x=1687345739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2bGuuQYL8b+xbvuLn4PcYekQUWt9yPN5iQ314l4lMI=;
        b=LM+YizE6+kL5AztjvEBeZDF2GFzwha7k4U7RwKQMWpQlC5JMNqhm1KAaaA4hnrtFXG
         I+ptpKfoouk7VR7SZ4jMnWH5LYpFJbEPIn25e2fgpOTir9iXRdc9x0XOiPxB1LdxkKVw
         4JxJiZPhuaMmSJT9IH+CEFap64ewL8A4YegG5M925mtJjfbLzXnbZXmk7BxyGqCDO80q
         crpYZFF/lkCakuVppPU8RhlbCkwCaUIMlOPz7mkOAUa3CfE7Z+igvy0lxslRqXvH/38T
         sAPSZIo8sqZarYSnVIjPaVByT64/qm+gvC9vezWjPoAd/w9IQIILTwniNusmkN+z4ogW
         eltw==
X-Gm-Message-State: AC+VfDxni/6dRANrTBhGmZVtLDUdQTocIkGfh3Lvth9xfnRtwkM7H1ap
        i9al701hyGLJ2IqiC8NtpXA=
X-Google-Smtp-Source: ACHHUZ7OjSrTldnv+rUkfYY8jX9+e0NK8wBEQHN/GocoDZWHojfGcLerDTURKKOgb/QQDOHh1JKUqA==
X-Received: by 2002:a17:907:a42a:b0:96f:a7d9:6e86 with SMTP id sg42-20020a170907a42a00b0096fa7d96e86mr6231547ejc.1.1684753739445;
        Mon, 22 May 2023 04:08:59 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:59 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 9/9] mm: vmalloc: Scale and activate cvz_size
Date:   Mon, 22 May 2023 13:08:49 +0200
Message-Id: <20230522110849.2921-10-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
References: <20230522110849.2921-1-urezki@gmail.com>
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

Scale a zone size to number of CPUs. Each power of two
value adds extra 100 * PAGE_SIZE bytes to a zone size.

A maximum zone size limit is set to 4M, it is reached
if number of CPUs=1024 and PAGE_SIZE=4096 bytes.

For 32-bit or single core systems cvz_size is set to
ULONG_MAX. It means that a pre-loading technique is
deactivated.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8054b8bf6c18..a5e6956a8da4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -806,8 +806,6 @@ struct cpu_vmap_zone {
 };
 
 static DEFINE_PER_CPU(struct cpu_vmap_zone, cpu_vmap_zone);
-
-/* Disable a per-cpu caching. */
 static __read_mostly unsigned long cvz_size = ULONG_MAX;
 
 static inline unsigned int
@@ -4490,6 +4488,19 @@ static void vmap_init_pcpu_zones(void)
 			spin_lock_init(&z->fbl[j].lock);
 		}
 	}
+
+	/*
+	 * Scale a zone size to number of CPUs. Each power of two
+	 * value adds extra 100 pages to a zone size. A high-threshold
+	 * limit is set to 4M. It can be reached if number of CPUs=1024
+	 * whereas a PAGE_SIZE is 4096 bytes.
+	 */
+#if BITS_PER_LONG == 64
+	if (i > 1) {
+		cvz_size = fls(i) * (100 * PAGE_SIZE);
+		cvz_size = min(cvz_size, (unsigned long) SZ_4M);
+	}
+#endif
 }
 
 void __init vmalloc_init(void)
-- 
2.30.2

