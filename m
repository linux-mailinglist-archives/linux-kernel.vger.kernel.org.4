Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD025F65DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJFMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJFMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EA9C23F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4FcB3FE0QSiF1o1I/AAbf5Q+pSSTlAAyOWClq2LzM8=;
        b=NhrXCDv6DfF2FRnMzT3KToh6mGY54g4n0iBnkg49D/qtuGNGao0Ajh2KEp+T8gxj8gjOzn
        NwTWz64kEz8yIhhaCXjDPFU253ckF5K8/BHP98/IffIp2Uulj6hr5JwOqOeI1/Mo0pVMjc
        xUITro9IokH0eTMGD2WX6abO12SdJ3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-298-X8ubmx5yOwWjBRnjo2Bh9g-1; Thu, 06 Oct 2022 08:22:12 -0400
X-MC-Unique: X8ubmx5yOwWjBRnjo2Bh9g-1
Received: by mail-wr1-f70.google.com with SMTP id n8-20020adf8b08000000b0022e4d3dc8d2so463564wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4FcB3FE0QSiF1o1I/AAbf5Q+pSSTlAAyOWClq2LzM8=;
        b=5thOFXUar1hmae7SytoLreD3MYNmuN6LMqRaV3r6RLsowMP9SB1CdpeKQOmQuY7NmP
         dTvK+z+8+rfQ85q1LKelar/PX7W9b6Dka8hJiqdqELJoaXmXjRmZO5aFwUAnKOsmdWDI
         vhq2xlyOYL2Hn1tr2uOgezKTiVWuYe0EmI93zR0u19O/L0kOx5u+Cblezj921Jzk8iqz
         xoOD1pFncu7mGTYr8Rhkr+WDZnoUd7OVJyvEHY3EVYO9hSGOgGUvFxQlQpqcMvW5NzRH
         KkfxsRBjMfvaay4nWUVOCHi555oQkS+81SvLuPf1OBT653shMj74L2Py8Q0cnIsBeST9
         BPqQ==
X-Gm-Message-State: ACrzQf3K8vvfVI7XAMxeCGz8y+9bhMTYOn47qblZ8eYvgCZTfOAAoj2f
        f2RqtENult0NxlH9I0rpN/vTaAkksb8ipdW8S52GO7GZoHMPrKQhu7pSEIDwk4zOqg8e6A73msX
        n5UyEG1y6VDy7Yd14LapSpTBR
X-Received: by 2002:adf:ec83:0:b0:22e:51e2:7fc7 with SMTP id z3-20020adfec83000000b0022e51e27fc7mr2889037wrn.229.1665058931880;
        Thu, 06 Oct 2022 05:22:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gzmhI49Qj0vN4kOxPftSNmbMO1JiOhVBd+9Ah9pQSqVNkyp/EMjaNKytALAzdnMHBZZV+Vw==
X-Received: by 2002:adf:ec83:0:b0:22e:51e2:7fc7 with SMTP id z3-20020adfec83000000b0022e51e27fc7mr2889031wrn.229.1665058931748;
        Thu, 06 Oct 2022 05:22:11 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:10 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 1/4] lib/cpumask: Generate cpumask_next_wrap() body with a macro
Date:   Thu,  6 Oct 2022 13:21:09 +0100
Message-Id: <20221006122112.663119-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221006122112.663119-1-vschneid@redhat.com>
References: <20221006122112.663119-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of introducing cpumask_next_and_wrap(), gather the
would-be-boiler-plate logic into a macro, as was done in

e79864f3164c ("lib/find_bit: optimize find_next_bit() functions")

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/cpumask.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index c7c392514fd3..6e576485c84f 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -7,8 +7,27 @@
 #include <linux/memblock.h>
 #include <linux/numa.h>
 
+#define CPUMASK_NEXT_WRAP(FETCH_NEXT, n, start, wrap)			\
+({									\
+	unsigned int next;						\
+									\
+again:									\
+	next = (FETCH_NEXT);						\
+									\
+	if (wrap && n < start && next >= start) {			\
+		next = nr_cpumask_bits;					\
+	} else if (next >= nr_cpumask_bits) {				\
+		wrap = true;						\
+		n = -1;							\
+		goto again;						\
+	}								\
+									\
+	next;								\
+})
+
 /**
- * cpumask_next_wrap - helper to implement for_each_cpu_wrap
+ * cpumask_next_wrap - Get the next CPU in a mask, starting from a given
+ *                     position and wrapping around to visit all CPUs.
  * @n: the cpu prior to the place to search
  * @mask: the cpumask pointer
  * @start: the start point of the iteration
@@ -21,21 +40,7 @@
  */
 unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 {
-	unsigned int next;
-
-again:
-	next = cpumask_next(n, mask);
-
-	if (wrap && n < start && next >= start) {
-		return nr_cpumask_bits;
-
-	} else if (next >= nr_cpumask_bits) {
-		wrap = true;
-		n = -1;
-		goto again;
-	}
-
-	return next;
+	return CPUMASK_NEXT_WRAP(cpumask_next(n, mask), n, start, wrap);
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
-- 
2.31.1

