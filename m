Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE6686593
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBALvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBALvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:51:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A6D6186F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:51:47 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q9so12299653pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 03:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlGu/yguMdOnorRbAMGf2/LPCl7TfmrafuP3w+VjRZY=;
        b=qcfksjVRYHXXbFbWxhg4FV35oZcmFIR8xCcpzOz3Oc55PjYEki4RenvHgU1lxDZup/
         FtNxEApg9HgN6naCG7UNBcU1qeSEtEeELMd9ToaJvHHeNHgaGET8Df8HxPZSbarzA/WZ
         BU2fIcI+iJt41Ordz+dBHmDPmw5t3FKrA6OeCL1RXyk5PZi6EPu6g3gcsPGewYK1wf8M
         L/QUzVXP/8341NgBlLQvXsGr07sFn3FlOYlFLo2Lq6/Ztbv6xsfB9J8M4YyMF7mm4fHL
         bb0HpXYy+fN0NCs6EGg/5ZuSnHSkOnIVxyYQdMWzIDbFMkm0BZM0tzsRYY/Obl1e5z2M
         QOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlGu/yguMdOnorRbAMGf2/LPCl7TfmrafuP3w+VjRZY=;
        b=FZVqWbt19QgxCoiDqdMpP9Of+yvDV/6YThqVAAakT+fv35lmIvZr9TD2E3kSrdGmzj
         Vl2ng0cAkEFmi/qGbEEnhOyk9O7zZUPb56Oza1t6Vvlgl/QwhoWfN1Xl42xJl2+s6KRW
         RIB29gy6UP90YdSVJg24ufhpAF8tNiH469fadvyujisbNPerE+O8v2E12PeuK2k/0+4m
         nsHSpmTVF66ZAxERe84P/bdrkEKmqg1etoh7tX6E1ukDKz8KdIOrRrR8CVs+PghwTR9y
         pDaZeoaRDjpiiec3XqsWqI8M41aTlBSw113xRyyeSey/n0H9O9L+xdAm9MGiEWkdgbzt
         RdnA==
X-Gm-Message-State: AO0yUKXj8dr5Mf77EZ3GHKg1lugo2MjODMX0VvKFDGg4HGHdmDN3IxS5
        IwfhdSnMLTnNJFp32w9E4o0=
X-Google-Smtp-Source: AK7set+JXFrURQfeXo4giun6cXyoIz7ajUrc8QD9TTqDu7fnbzAcOFVVieNIVgiAB4AakpZU9C/hjQ==
X-Received: by 2002:a62:1d4a:0:b0:58d:a981:b97c with SMTP id d71-20020a621d4a000000b0058da981b97cmr1701979pfd.34.1675252307320;
        Wed, 01 Feb 2023 03:51:47 -0800 (PST)
Received: from min-iamroot ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id g20-20020a056a001a1400b0058bc60dd98dsm4123488pfv.23.2023.02.01.03.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 03:51:46 -0800 (PST)
Date:   Wed, 1 Feb 2023 20:51:42 +0900
From:   Hyunmin Lee <hn.min.lee@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Mike Rapoport <rppt@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4] mm/vmalloc: replace BUG_ON to a simple if statement
Message-ID: <20230201115142.GA7772@min-iamroot>
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
v3->v4 : Use only one if() for three conditions
---
 mm/vmalloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74afa2208558..3b7e8856be35 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1587,9 +1587,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	int purged = 0;
 	int ret;
 
-	BUG_ON(!size);
-	BUG_ON(offset_in_page(size));
-	BUG_ON(!is_power_of_2(align));
+	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
+		return ERR_PTR(-EINVAL);
 
 	if (unlikely(!vmap_initialized))
 		return ERR_PTR(-EBUSY);
-- 
2.25.1

