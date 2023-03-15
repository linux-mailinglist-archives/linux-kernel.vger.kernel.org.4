Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6096BAB11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCOIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCOIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:49:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DA45BCA1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so1150053pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678870191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnnMb4Et7WhpEe76RPSGsI6qWidW0Ymzw0QUU6G4yao=;
        b=MldnmFi+QRjEcfycD9KY0bZvSKUHkvSL3UtA0U/PWvEzo8AB2GYhsOMJ9Yna93phsr
         3pmBXGrj79AYyoeIfCO7JsUKNVP8tmqlS8mY/FTf5EtAxhPN1xd1Fm9/pzGq/ZdxfhQz
         eU2tuyfglF9o3N9mm4hhAzPHlUfBjcvnSq9Nb2s84Jjh61ufX2fH3XB7ShgyRL4j80Ax
         QyS9p698XnwvyGRgs0e4BrNF4ilCCsUmxrRDQcMuw618JIheaRe7R9Qmg/xhef7MwYkb
         GmW1c4Xe7Xs5vN1n3/NKD+0FvXsYvic5EsCMGBEC3z5N+9iBqt2u48HdxYZQHcZIPME0
         idug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnnMb4Et7WhpEe76RPSGsI6qWidW0Ymzw0QUU6G4yao=;
        b=TOCfPVzWCZst/cKGnOi7IDqEWlI3YVQcbrEmcmo4kE3UDFLVpK32+H90PI4l3/8Wif
         mtGdA9CKA0IjXFaK3MqDuSSF12lWZDrOk8BTIBG/9ZfRU+ZJrCY8cvkToJDFPtP6p7Dc
         LdXEyXUii5N9ctvEOIiaTFKSxbjzsJA65o+WrqAO2IpKMtW6ngIRmpxCwWquZH7qfDka
         FuKmg2i8NH76Ni5XF/w6ZVn7G5SkpI7Br/QlVS97Oruvyn2zDsyNYBHMmJluGb1tVTDG
         ilqmJNTSOALxY1tyQ6c5f6LXUs3TH8HH2ffUlBUICut90mDFupJUABbzbDJe/KzQ/oUo
         +Sug==
X-Gm-Message-State: AO0yUKWVsgE78ScfeIuwHSFGDzzE/TG3yZsNu5DPfsqxRBVG2PBkeR4F
        FDONjth5NueT6tvgaUhdeWtQzUWUcjQ+T7TeqOQ=
X-Google-Smtp-Source: AK7set8ONEq6R2DicXybExxV1KAqb5LJDX736BB8nt9+Drt0g4Wcxf32rD3Zg0NHbWPaIIoqz/KYqA==
X-Received: by 2002:a05:6a20:7d88:b0:cc:32a8:323d with SMTP id v8-20020a056a207d8800b000cc32a8323dmr15446982pzj.28.1678870191517;
        Wed, 15 Mar 2023 01:49:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id e29-20020a63501d000000b0050be183459bsm593527pgb.34.2023.03.15.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 01:49:51 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pcMpQ-008zeV-50; Wed, 15 Mar 2023 19:49:48 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pcMpQ-00Ag6X-0S;
        Wed, 15 Mar 2023 19:49:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yebin10@huawei.com
Subject: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
Date:   Wed, 15 Mar 2023 19:49:38 +1100
Message-Id: <20230315084938.2544737-5-david@fromorbit.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315084938.2544737-1-david@fromorbit.com>
References: <20230315084938.2544737-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

percpu_counter_sum_all() is now redundant as the race condition it
was invented to handle is now dealt with by percpu_counter_sum()
directly and all users of percpu_counter_sum_all() have been
removed.

Remove it.

This effectively reverts the changes made in f689054aace2
("percpu_counter: add percpu_counter_sum_all interface") except for
the cpumask iteration that fixes percpu_counter_sum() made earlier
in this series.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/percpu_counter.h |  6 -----
 lib/percpu_counter.c           | 40 ++++++++++------------------------
 2 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 521a733e21a9..75b73c83bc9d 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -45,7 +45,6 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
-s64 percpu_counter_sum_all(struct percpu_counter *fbc);
 int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
 void percpu_counter_sync(struct percpu_counter *fbc);
 
@@ -196,11 +195,6 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
 	return percpu_counter_read(fbc);
 }
 
-static inline s64 percpu_counter_sum_all(struct percpu_counter *fbc)
-{
-	return percpu_counter_read(fbc);
-}
-
 static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 {
 	return true;
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 0e096311e0c0..5004463c4f9f 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -122,23 +122,6 @@ void percpu_counter_sync(struct percpu_counter *fbc)
 }
 EXPORT_SYMBOL(percpu_counter_sync);
 
-static s64 __percpu_counter_sum_mask(struct percpu_counter *fbc,
-			      const struct cpumask *cpu_mask)
-{
-	s64 ret;
-	int cpu;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&fbc->lock, flags);
-	ret = fbc->count;
-	for_each_cpu_or(cpu, cpu_online_mask, cpu_mask) {
-		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
-		ret += *pcount;
-	}
-	raw_spin_unlock_irqrestore(&fbc->lock, flags);
-	return ret;
-}
-
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive().
@@ -153,22 +136,21 @@ static s64 __percpu_counter_sum_mask(struct percpu_counter *fbc,
  */
 s64 __percpu_counter_sum(struct percpu_counter *fbc)
 {
+	s64 ret;
+	int cpu;
+	unsigned long flags;
 
-	return __percpu_counter_sum_mask(fbc, cpu_dying_mask);
+	raw_spin_lock_irqsave(&fbc->lock, flags);
+	ret = fbc->count;
+	for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
+		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
+		ret += *pcount;
+	}
+	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL(__percpu_counter_sum);
 
-/*
- * This is slower version of percpu_counter_sum as it traverses all possible
- * cpus. Use this only in the cases where accurate data is needed in the
- * presense of CPUs getting offlined.
- */
-s64 percpu_counter_sum_all(struct percpu_counter *fbc)
-{
-	return __percpu_counter_sum_mask(fbc, cpu_possible_mask);
-}
-EXPORT_SYMBOL(percpu_counter_sum_all);
-
 int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
 			  struct lock_class_key *key)
 {
-- 
2.39.2

