Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB565F0964
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiI3LAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiI3K7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:59:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE717B523
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:37:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m4so6188536wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=opcYLHBFYUInTSSKrfc+T85BEqPL++kCd/mhT+P9K8Q=;
        b=Zunqaf42yRazlVaCz+p3FTJw+yxM7vvPb2+BMvxh0Q8/k83DtM7V24lwooufy4hpI2
         Jg2mhNK0GC/we7ogEZ52w5v8j3jyCQVFh3AZsGmitjMLqEJeYHE4PBceRO1V5czE6tKO
         FvLLpRIX2Hh0GgEn6obNCVGgmlw+YRKJuqe5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=opcYLHBFYUInTSSKrfc+T85BEqPL++kCd/mhT+P9K8Q=;
        b=NL0wVHVZxIcsxbv9FaQMw/e+qBkGVlfpABnD7ppSBez9a9B4yzMm89zDDOFk2NtkrB
         RERsIMckkMZr0If9g+2l64ULM2M5VGFSlUgfxKj+MjtehQoGfgGghMQ1WyOzVmiHS9BM
         x8Ciq99CzRYZYk0sbzx5hbZWYjulJyz741QwOWjXKP35nksp3Er1IB3yKtrPn8R1jdcJ
         HVKMQYe3YGYvKAdHy3Q/KmBUClXjvGzx6u7xOWxrRx8k1EnbQaTOtqp0VQvyFDyBKleV
         MACxhULU+VuGiLPmZt/2uLavn9YhOcrEREmsCd+xHOctuD2zVf8bX90PWUsPwIcLo7kU
         AaWQ==
X-Gm-Message-State: ACrzQf2RLPm0Ga3TCV/LhyaIGTuzCT8f6EejUOY5qtsVriv5h1lXBOMw
        9CsrtOLbNKMSlienmFKsimDZT8uP5grum+r9
X-Google-Smtp-Source: AMsMyM5oMvmtmMosdWbrf3EOZ7Uo8V6qQYNRWBirQkE+RDrLDHiggbRv79iYim+nY7NSRwtLHk6jiw==
X-Received: by 2002:a05:6512:c13:b0:49f:9a2f:8b86 with SMTP id z19-20020a0565120c1300b0049f9a2f8b86mr3002980lfu.413.1664533635506;
        Fri, 30 Sep 2022 03:27:15 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g12-20020a05651222cc00b00498f23c249dsm254543lfu.74.2022.09.30.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:27:14 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: slub: make slab_sysfs_init() a late_initcall
Date:   Fri, 30 Sep 2022 12:27:12 +0200
Message-Id: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, slab_sysfs_init() is an __initcall aka device_initcall. It
is rather time-consuming; on my board it takes around 11ms. That's
about 1% of the time budget I have from U-Boot letting go and until
linux must assume responsibility of keeping the external watchdog
happy.

There's no particular reason this would need to run at device_initcall
time, so instead make it a late_initcall to allow vital functionality
to get started a bit sooner.

This actually ends up winning more than just those 11ms, because the
slab caches that get created during other device_initcalls (and before
my watchdog device gets probed) now don't end up doing the somewhat
expensive sysfs_slab_add() themselves. Some example lines (with
initcall_debug set) before/after:

initcall ext4_init_fs+0x0/0x1ac returned 0 after 1386 usecs
initcall journal_init+0x0/0x138 returned 0 after 517 usecs
initcall init_fat_fs+0x0/0x68 returned 0 after 294 usecs

initcall ext4_init_fs+0x0/0x1ac returned 0 after 240 usecs
initcall journal_init+0x0/0x138 returned 0 after 32 usecs
initcall init_fat_fs+0x0/0x68 returned 0 after 18 usecs

Altogether, this means I now get to petting the watchdog around 17ms
sooner. [Of course, the time the other initcalls save is instead spent
in slab_sysfs_init(), which goes from 11ms to 16ms, so there's no
overall change in boot time.]

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

The numbers certainly suggest that someone might want to look into
making sysfs/kobject/kset perform better. But that would be way more
complicated than this patch, and could not possibly achieve the same
win as getting the sysfs_slab_add() overhead completely out of the
way.


 mm/slub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4b98dff9be8e..dade5c84a7bb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6070,8 +6070,7 @@ static int __init slab_sysfs_init(void)
 	mutex_unlock(&slab_mutex);
 	return 0;
 }
-
-__initcall(slab_sysfs_init);
+late_initcall(slab_sysfs_init);
 #endif /* CONFIG_SYSFS */
 
 #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
-- 
2.37.2

