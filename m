Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48B68637A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjBAKMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBAKL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:11:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A175245
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:11:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so1484774pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYqzg/T0LaloBHYldjFBFyRxBuHKs2BASAL6cTqmqDQ=;
        b=kYSkjbt3CoDGthjE1muYlphECzFd1NTCJGRUkVfEih4s35VlVL1HTaH0ENL2dd/v/y
         MDCRryUhOxagYtXjQawfsnLxB86PRAu7qiQVrHiJvh5fS+Kk2KAqmBqLsrel6yBc6xs1
         7qZYg2oBnhZNRG9OCZNVuqCNuQrW741VSacLnkGxCeiTV+OKfX68fo9ZYEuoMjN84MYV
         Sgg0Cv40eYoNZFo5xuoMsWmaHj/9mbj6PSqZr8kayz1vRcyj1JOJeUhb0x+CEpgm5a1v
         m4qXJXGM3QRZIrquhuDuaqgvtrqnlyIoolwk9jLlhQa7PNHiA/DuYr2KGA5MbPP2K81J
         D2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYqzg/T0LaloBHYldjFBFyRxBuHKs2BASAL6cTqmqDQ=;
        b=McVSxkr+lRFOhkUIjI/7ZFVuy/mJ6OcT0wqXOTB0NPyUj1dck9CQeySYJaZ2y+R5e5
         D29NhTiNgBoMTZ7JW/HhQG8h+FHqbVobaQ5tJ5wUil+7hL6aj5CB89APPJdqARObfhXm
         7GNDYjhoDs9MfxYb/JaeOu86RiRdLZoCPbzbDUxC4irJZfI1viJfRDcaxwmV6j0vVqfr
         5h896+U1wVKJqzesGeqqKUpKW9yBOoaY2U1ANT0Rif2STisALIvZ1LnHgqkKHV84W70/
         HgnQlr1PN6Hg97c8sAHYEg2TIfnbK6M1nx7/72s1tMwVEkusvjEEyyktRki39J9F57jV
         dzmA==
X-Gm-Message-State: AO0yUKX+GU5Ds5U1N7ro1D44oboYIJ0tiGZZzqfUwLS/F23yEPQZLgag
        6L+vFoTozQZFVOVP3iDSk/PA/ydPzkCZ8w==
X-Google-Smtp-Source: AK7set9yNodUn2+Snq1aZuqL2V8nqcr56KT2NdQkF8cksyL8vJf600SDWYXtNiA+fTEausjp7bM3Vw==
X-Received: by 2002:a05:6a21:99aa:b0:bc:ccea:a969 with SMTP id ve42-20020a056a2199aa00b000bccceaa969mr2451168pzb.26.1675246317753;
        Wed, 01 Feb 2023 02:11:57 -0800 (PST)
Received: from min-iamroot ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id f9-20020a639c09000000b004b4d4de54absm9167806pge.59.2023.02.01.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:11:57 -0800 (PST)
Date:   Wed, 1 Feb 2023 19:11:52 +0900
From:   Hyunmin Lee <hn.min.lee@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v3] mm/vmalloc: replace BUG_ON to a simple if statement
Message-ID: <20230201101152.GA5535@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the coding standards, in the event of an abnormal condition that
should not occur under normal circumstances, the kernel should attempt
recovery and proceed with execution, rather than halting the machine.

Specifically, in the alloc_vmap_area() function, use a simple if()
instead of using BUG_ON() halting the machine.

Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
v1->v2 : Add commit description
v2->v3 : Change WARN_ON() to if()
---
 mm/vmalloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74afa2208558..52a346bc02a1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1587,9 +1587,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	int purged = 0;
 	int ret;
 
-	BUG_ON(!size);
-	BUG_ON(offset_in_page(size));
-	BUG_ON(!is_power_of_2(align));
+	if (unlikely(!size))
+		return ERR_PTR(-EINVAL);
+
+	if (unlikely(offset_in_page(size)))
+		return ERR_PTR(-EINVAL);
+
+	if (unlikely(!is_power_of_2(align)))
+		return ERR_PTR(-EINVAL);
 
 	if (unlikely(!vmap_initialized))
 		return ERR_PTR(-EBUSY);
-- 
2.25.1

