Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C010267828A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjAWRFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjAWRFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:17 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1641714
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:12 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r205so10909846oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJTWO2OBrXE35+2ST38bazfrcM89QJcHIOlGqfogZ20=;
        b=NSgjC4hw3fEAnNl7SM0zZQjjJtjRvXkPMrmVnBT32ZBngvEkPukpqb5qQFusr1IW2l
         mEuBPgVWKLc4iYnfp0G67SkL5iJg8kRMUs51J/jV44M5Hxtl+7fET9rc2rczoADtB4Nj
         hmYLfi4G8LVKiw5v/UkyvyI4ccoDGf198WfeFl+kIsfNVB+khlUSI5d9UWwu+ySIg6qP
         UfiuTEqFgoZMwG/hO7JtE5Qo4t4GdoJ3FLvrwkLJfQ++q3yu2+l5RjoSe9bJOULtNmKq
         hogj8oFn/iRz3PC1y1jQTMMb/0ry+uFYKbAI389Cj7PSaVvdzQAGaC+V2Lhib2zuMTi3
         IsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJTWO2OBrXE35+2ST38bazfrcM89QJcHIOlGqfogZ20=;
        b=UmicGrHW7d6E7tXgzgQf7/YiDGvzHKSk5vOiyNPlyi64sjWmRGIyhVL5zW7RjtwRh6
         dvsCyUfJYvldI6holVhZMtjuKZ7hCi9KcbNtg3tNEiJgR6vrNAQCgax/2wwmsMfDoYRM
         si3FJQOCVQYvFQmHrziS3b28Jofvs1+KyYIEFUDYK1TZ51iarqhO6WXjjI4jeamiLl8n
         EuwN9MnVTr0sE5oBTXJLFbOz5kh1v0gcjxCAp7v2Fv50FsUSlvONDuFYjbeX/R11shFj
         ifB49AzK5hcS9r3BVgT/GdZJmkQ2HGEEHmTlLkN9xe0jQI+gHfRBzdbbOi/xDt88K+uO
         JeDg==
X-Gm-Message-State: AFqh2krpJs40ncxBA0bt7HtF1Xw3KgINx31BqRz1pO2zkcnNh6V9Zgec
        vYhnEg4966k707HMW3SCHINb782nUFE0eg6Te9v1Eme1kKC0VrXIpdcKpg5FsjuU3D2YJHghH7P
        bBJuNNeU2bvvV373eRZC4aXWE+2kAa9hvuWZwiReWxuUjgMH2NvjYGxhiqlH6Nng6qK/NoAkGyP
        1/bAWpGXwri5yz
X-Google-Smtp-Source: AMrXdXuwAu7Phr7hWIyFW8DqKNxzBjmiQoF9ywUbD8dPtf/ETIlI/OPtYt0DkjFc7YBiZevXoCyc2A==
X-Received: by 2002:a54:4009:0:b0:364:3792:97aa with SMTP id x9-20020a544009000000b00364379297aamr12138081oie.10.1674493511610;
        Mon, 23 Jan 2023 09:05:11 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:11 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 3/9] mm: kmemleak: propagate NO_SCAN flag in delete_object_part
Date:   Mon, 23 Jan 2023 11:04:13 -0600
Message-Id: <20230123170419.7292-4-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123170419.7292-1-george@enfabrica.net>
References: <20230123170419.7292-1-george@enfabrica.net>
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

When part of an object is deleted, propagate the OBJECT_NO_SCAN flag to
the 2 new created objects.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 mm/kmemleak.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 2b9c9ad68806..5882f60d127c 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -772,7 +772,7 @@ static void delete_object_full(unsigned long ptr)
  */
 static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 {
-	struct kmemleak_object *object;
+	struct kmemleak_object *object, *o1 = NULL, *o2 = NULL;
 	unsigned long start, end;
 
 	object = find_and_remove_object(ptr, 1, is_phys);
@@ -792,11 +792,19 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 	start = object->pointer;
 	end = object->pointer + object->size;
 	if (ptr > start)
-		__create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL, is_phys);
+		o1 = __create_object(start, ptr - start, object->min_count,
+				     GFP_KERNEL, is_phys);
 	if (ptr + size < end)
-		__create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL, is_phys);
+		o2 = __create_object(ptr + size, end - ptr - size,
+				     object->min_count, GFP_KERNEL, is_phys);
+
+	/* Propagate the NO_SCAN flag */
+	if (object->flags & OBJECT_NO_SCAN) {
+		if (o1)
+			o1->flags |= OBJECT_NO_SCAN;
+		if (o2)
+			o2->flags |= OBJECT_NO_SCAN;
+	}
 
 	__delete_object(object);
 }
-- 
2.37.1

