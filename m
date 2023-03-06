Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D2E6ABDF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCFLOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCFLNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:13:54 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CB81F5D5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:13:29 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id b7-20020a056402350700b004d2a3d5cd3fso8112498edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678101206;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1YDcalZhdE7jkjuSChjdb8BwAiaOVabLcoERtRrllCw=;
        b=GQwsOOCwt1r07r7xKoYaCxR+u6XnS4orZ/5XRefQQxUFaCbyY2q5e5ZsvfxrpiDk9b
         SrwfsLoY5AOl6cH4+pIVBvvhMqLtXqfcy8LnJd9LtbA2puKgHz3XhwV1m7uKOrmoNcNZ
         hlyU8r2pyRGzu9SodZfYSbjLIs3eumpGUHxxGs8nswjvWh3ypHGXOhXmf3Z5y6t1yOHB
         PTUpGiRLo6SLlJ2eRtuMJJ71s3LG+L1Kf4lQq8GLOrUWsBFN7Z2GeK1vc6pd+PR5FSOz
         of5RXfO0kfqI0FEwSmJNakpzkIV4EY5XB1gC9vzImzS4WsgaqVPUR1M2jpo5c9uPmEJv
         OH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101206;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YDcalZhdE7jkjuSChjdb8BwAiaOVabLcoERtRrllCw=;
        b=lOiiwi1P7anCUDzimljItuCCtcGWj5N5TP/dsQ9dkXofVbp3MFru5Z8lkvuDdS1+ah
         fpwnJgv8B7rEjLuYyXwYRT3U4wuAUVL/TTvIyIiYc21ahjibQ2DcJ732Czf1dmYGo5Ly
         9pviYCB9cRvN1GbZqinaOyZ2y85yDT6i8TzZ/pBv9M7OTQwrKgHvWOWu20ozOLclC5Vo
         kGpKF+OWB2QKPPRXWz8ve4fQMlH1DGc1IilzRVy67kR8iWMNzwKEv41MTHpiGZTJS9NO
         PZJAQR5EX2x5+2+FzHf7lEDD+8a7TEKOMm1Dn9fvtPtz5fp6YlKrWv6tD6faNNlv+e9W
         6y2Q==
X-Gm-Message-State: AO0yUKUc5Gp4zP2SZ8HZQxl4l0x/pvUKs5SSJjWj7kT5M31+ETCNVxCp
        /RCdWcHNTQaPk3Z18EIXnIWM0nJ1cq0=
X-Google-Smtp-Source: AK7set/52SkcXdTHtfRNAJvdgql1aIbZ/I0TQcEPsji0Ir0BgvHo9ob16KHkabtruxTJf8Mfuwju3r4XkNQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b93a:5d85:6f2c:517d])
 (user=glider job=sendgmr) by 2002:a17:906:ce38:b0:8b1:30da:b585 with SMTP id
 sd24-20020a170906ce3800b008b130dab585mr4991214ejb.6.1678101206445; Mon, 06
 Mar 2023 03:13:26 -0800 (PST)
Date:   Mon,  6 Mar 2023 12:13:21 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306111322.205724-1-glider@google.com>
Subject: [PATCH 1/2] lib/stackdepot: kmsan: mark API outputs as initialized
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, Andrey Konovalov <andreyknvl@gmail.com>
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

KMSAN does not instrument stackdepot and may treat memory allocated by
it as uninitialized. This is not a problem for KMSAN itself, because its
functions calling stackdepot API are also not instrumented.
But other kernel features (e.g. netdev tracker) may access stack depot
from instrumented code, which will lead to false positives, unless we
explicitly mark stackdepot outputs as initialized.

Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/stackdepot.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 036da8e295d19..2f5aa851834eb 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <linux/kernel.h>
+#include <linux/kmsan.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/percpu.h>
@@ -306,6 +307,11 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	pool_offset += required_size;
+	/*
+	 * Let KMSAN know the stored stack record is initialized. This shall
+	 * prevent false positive reports if instrumented code accesses it.
+	 */
+	kmsan_unpoison_memory(stack, required_size);
 
 	return stack;
 }
@@ -465,6 +471,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	struct stack_record *stack;
 
 	*entries = NULL;
+	/*
+	 * Let KMSAN know *entries is initialized. This shall prevent false
+	 * positive reports if instrumented code accesses it.
+	 */
+	kmsan_unpoison_memory(entries, sizeof(*entries));
+
 	if (!handle)
 		return 0;
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

