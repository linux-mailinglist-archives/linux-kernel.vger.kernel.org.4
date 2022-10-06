Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8935F65DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiJFMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiJFMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8E9E0C3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd3ek9lr0+3lr0pFZrCWvq5bzuM9iwLSGj27oiriJtw=;
        b=U78xo8ieNCU/HbEM2WA7cHovrxqyIg4XrJHDSmOg/aE10Al7G6JOXyyREJUJclrjxjDW4V
        8rJ9lBZqoWggDqVszw8OqE4vvK4NPqf2ZY41VUklcJoSIYGK7Re9o6xyQtgII9Hb9M1TQB
        SHg7KWGtB3XsapCur2cLU3IW3Iqfsi8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-p2JCQ44zPWKUra7Sji7BVQ-1; Thu, 06 Oct 2022 08:22:16 -0400
X-MC-Unique: p2JCQ44zPWKUra7Sji7BVQ-1
Received: by mail-wm1-f69.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso502708wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd3ek9lr0+3lr0pFZrCWvq5bzuM9iwLSGj27oiriJtw=;
        b=OhT2FuJfbvpovVif0bpmWgf2w+49fJVDD3RUpKkzG2+PeBNJqkE9GFO+zYntZPGAC6
         /uK83TUdT0thqIs+YLgOF8d7qhua2iPPHdoDBb3XOoUzbT985ewQpAS9RQ1f6E5y2ssP
         EGrMuWPrKYOfIIZWyr55PE7fisY2qJQ1md7ff4ZOzzKak3h+OFLWVg/nDySTWX3+bHE9
         iesmhr/KQBv0peirqKAqNNHuGvSjkEFQZJ443DbFlqyS+xFHpgWA1pTg51V+8vElWPYs
         ugZaMQZEj/YR6K7EgkPMjhTnHr/mXGL39FRswNl5DJUfAw8LAwn3vAVBng+fK39BrEwR
         YFbQ==
X-Gm-Message-State: ACrzQf3c11oiKI77TtnKPZ59VkptFHFeFnZmHzpSkjuVCfi+zVZe7vWz
        5yblsHTOuTJie6ug63otsE6faULXgDIFAQty3NECF6bppTz3Sb3rTyIKq0b+H2d1U6FtOV490HZ
        v1HuyYvMM/d4CQVZnjE0KH/bh
X-Received: by 2002:a05:6000:1d8d:b0:22e:6371:65b6 with SMTP id bk13-20020a0560001d8d00b0022e637165b6mr3047106wrb.657.1665058935156;
        Thu, 06 Oct 2022 05:22:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7CgZbASqqSidmHgofT701/lhaYz5Pr8fVsGmau+bso0aHUIBuOg2UB+JmzaIBsI+vIRTA21w==
X-Received: by 2002:a05:6000:1d8d:b0:22e:6371:65b6 with SMTP id bk13-20020a0560001d8d00b0022e637165b6mr3047091wrb.657.1665058934983;
        Thu, 06 Oct 2022 05:22:14 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:13 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 3/4] lib/cpumask: Introduce cpumask_next_and_wrap()
Date:   Thu,  6 Oct 2022 13:21:11 +0100
Message-Id: <20221006122112.663119-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221006122112.663119-1-vschneid@redhat.com>
References: <20221006122112.663119-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This leverages the newly-introduced CPUMASK_NEXT_WRAP() macro.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/cpumask.h | 22 ++++++++++++++++++++++
 lib/cpumask.c           | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 286804bfe3b7..e0b674263e57 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -272,8 +272,30 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 
 	return cpumask_first(mask);
 }
+static inline unsigned int cpumask_next_and_wrap(int n,
+						 const struct cpumask *mask1,
+						 const struct cpumask *mask2,
+						 int start, bool wrap)
+{
+	cpumask_check(start);
+	/* n is a prior cpu */
+	cpumask_check(n + 1);
+
+	/*
+	 * Return the first available CPU when wrapping, or when starting before cpu0,
+	 * since there is only one valid option.
+	 */
+	if (wrap && n >= 0)
+		return nr_cpumask_bits;
+
+	return cpumask_first_and(mask1, mask2);
+}
 #else
 unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+unsigned int __pure cpumask_next_and_wrap(int n,
+					  const struct cpumask *mask1,
+					  const struct cpumask *mask2,
+					  int start, bool wrap);
 #endif
 
 /**
diff --git a/lib/cpumask.c b/lib/cpumask.c
index f8174fa3d752..c689348df0bf 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -44,6 +44,29 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
+/**
+ * cpumask_next_and_wrap - Get the next CPU in a mask, starting from a given
+ *                         position and wrapping around to visit all CPUs.
+ * @n: the cpu prior to the place to search
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ * @start: the start point of the iteration
+ * @wrap: assume @n crossing @start terminates the iteration
+ *
+ * Returns >= nr_cpu_ids on completion
+ *
+ * Note: the @wrap argument is required for the start condition when
+ * we cannot assume @start is set in @mask.
+ */
+unsigned int cpumask_next_and_wrap(int n,
+				   const struct cpumask *mask1,
+				   const struct cpumask *mask2,
+				   int start, bool wrap)
+{
+	return CPUMASK_NEXT_WRAP(cpumask_next_and(n, mask1, mask2), n, start, wrap);
+}
+EXPORT_SYMBOL(cpumask_next_and_wrap);
+
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
 /**
-- 
2.31.1

