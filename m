Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C45B9E39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIOPGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiIOPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:05:48 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB36745E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:06 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id h13-20020a056402280d00b004528c8400afso5032923ede.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=vmKBMF2McNFVJqtG6TmpI3MAJxV0RMGeKyj0ZsE0Fyg=;
        b=gEgjEUXtMXLGLmInSdiTVr8SJtUM9dAvRmm9gTPwlvDJlkqKGsf6gLgatpF9No6GIj
         f1Ed6OLsNQPbRAYwMDuikJo5an+hRugAPcYR3d2idcVQVyC6hhx41fffnwLsLvYNGn+7
         fnso7t/d8ggMNfh1yjqm245oFqmKs97l5uauhCjKI2lKnuKK561skile8xyfuBwUMIR2
         k4457FVVXUyo6LArzKfC16VrG33HBknRIw4PTmX8bNDYzxGBz51W2hpuA84deuKw+CD+
         gndPzro+ppcGwFoGvdA4uYw55JH56lxjWCZGwiQPKeGZVtfCO924G4QvZ4U1I6ciker2
         cP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=vmKBMF2McNFVJqtG6TmpI3MAJxV0RMGeKyj0ZsE0Fyg=;
        b=8QpuI22hjU23jBtpHfwV/hYtmGC1GmXv8zGgtWTaRWdLCD68p/6WREuZAcjdXqLxTV
         +iFn+XLkQrU1qZSwItgP9kbwNj74GpZtahRiFe6bm3PlRROcetp9g5o1Kv5S3FXOsN9C
         n/jjntd0uTRy/+HvWyvzPDZodquO2WvrkfwmIua4u38FRNL8jAjOHV+ICWsEN4+cMqld
         WkuinV1UNpVJ1NDUawRyvA70AgrDXEZQDbnUHPqVQHzpAJ2bElIV4pdpvKtSLip2e7jd
         KXzTR4Oyz9TCXoXnsXmznntskACfqwwEw+4ISeV82cXt5XiP28TK/wg73HP/6c0r+I/f
         gcjA==
X-Gm-Message-State: ACrzQf1hyt/yVteO10PQK7ToWeUoX6BUxyT6b9R3mTKoILHFAB2vDv8y
        nhD/e0LKgn1OziGyswCJrUl+j3oUEV0=
X-Google-Smtp-Source: AMsMyM4KMV/DJpiNOvzRLXTErTnexkmGTLdYCR5aeQSVv8s3wGGoLlfOMidq99otIc+vGxZhLpSlcwNoSfA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6402:5112:b0:451:cb1d:c46f with SMTP id
 m18-20020a056402511200b00451cb1dc46fmr254990edd.35.1663254305960; Thu, 15 Sep
 2022 08:05:05 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:44 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-11-glider@google.com>
Subject: [PATCH v7 10/43] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN adds extra metadata fields to struct page, so it does not fit into
64 bytes anymore.

This change leads to increased memory consumption of the nvdimm driver,
regardless of whether the kernel is built with KMSAN or not.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Link: https://linux-review.googlesource.com/id/I353796acc6a850bfd7bb342aa1b63e616fc614f1
---
 drivers/nvdimm/nd.h       | 2 +-
 drivers/nvdimm/pfn_devs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ec5219680092d..85ca5b4da3cf3 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
 		struct nd_namespace_common *ndns);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
 /* max struct page size independent of kernel config */
-#define MAX_STRUCT_PAGE_SIZE 64
+#define MAX_STRUCT_PAGE_SIZE 128
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 0e92ab4b32833..61af072ac98f9 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -787,7 +787,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 *
-		 * Also make sure size of struct page is less than 64. We
+		 * Also make sure size of struct page is less than 128. We
 		 * want to make sure we use large enough size here so that
 		 * we don't have a dynamic reserve space depending on
 		 * struct page size. But we also want to make sure we notice
-- 
2.37.2.789.g6183377224-goog

