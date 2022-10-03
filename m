Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6DC5F3298
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJCPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJCPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917BBF4C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vikRyGRx44R+pUt2VG/nhewaVPQwv7B4yL3TDMhKXBE=;
        b=FtBxqa/4roFjcquQezFuJgJZ5L/hAIDiF4Atwe94QkXyidYJ9fkevMX2C6Mlx5zDlDYWeZ
        W6AnVzMqNYxk/A8fKede5QsEbL7bC35wMJ7dFLFRY91K85ZQcDuiYdEgpBL0oSQhguVP9h
        n74VGn+58jYKRoVoJta4ausjzcolExE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622--qI3bnORNl-FSTp-GLGv8Q-1; Mon, 03 Oct 2022 11:34:49 -0400
X-MC-Unique: -qI3bnORNl-FSTp-GLGv8Q-1
Received: by mail-wm1-f69.google.com with SMTP id f25-20020a7bc8d9000000b003b4768dcd9cso3001882wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vikRyGRx44R+pUt2VG/nhewaVPQwv7B4yL3TDMhKXBE=;
        b=wEvgQ9xGF4HBJviUdie/mEVlpAoK0fTlicYn21O6tUssZNIIDS/6V43xWbS78g1qZ1
         upx7vgdJWIds1HCMNKkI1c5FohgCemGbJdw/K82021Myl35QFFbQa3aCcsoO0o7LY7di
         d/uj0g4TCLH5ol/dQDvMPoVNzn6myOBWTW2xx/VZ3LbeVtphaxiMqyYjDNWeJwv5zuQw
         tfu3Yx2rNUrXgBZh3CdZYPh+sUYAMRlgujCmB/bnm2dWAqerA9EOJ2QTNij51NTcpRnN
         FBqDj7+R42F2tKCZjpExGUqGkMLHB0OszmGQw09jIaO47361oFjzh2hmCCEtU2ofPxvp
         uviw==
X-Gm-Message-State: ACrzQf1YlGeh6tBcReLNrxKraZnewfdWEeYPbY0+6brQSmFlWvIp1oFO
        iZgKfN1eEMScAsctzQ2Lm4AC9mFIqVxvwiPQPjXP7d3oekau9ebNgi5y7Ml9doy09b6QFCLWBLt
        QzeatxD7VUZvVeBnOumJ8k4Em
X-Received: by 2002:adf:eb83:0:b0:22c:f295:19a5 with SMTP id t3-20020adfeb83000000b0022cf29519a5mr10121221wrn.457.1664811288674;
        Mon, 03 Oct 2022 08:34:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6AxGBSuoH8QT0vvHb78KjtqGJutdJ99UqNDldM3189qAbHyo5YXUfrzbcxW+MhznI3xOosZw==
X-Received: by 2002:adf:eb83:0:b0:22c:f295:19a5 with SMTP id t3-20020adfeb83000000b0022cf29519a5mr10121206wrn.457.1664811288506;
        Mon, 03 Oct 2022 08:34:48 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:47 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 4/5] lib/test_cpumask: Add for_each_cpu_and(not) tests
Date:   Mon,  3 Oct 2022 16:34:19 +0100
Message-Id: <20221003153420.285896-5-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the recent introduction of for_each_andnot(), add some tests to
ensure for_each_cpu_and(not) results in the same as iterating over the
result of cpumask_and(not)().

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/cpumask_kunit.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
index ecbeec72221e..d1fc6ece21f3 100644
--- a/lib/cpumask_kunit.c
+++ b/lib/cpumask_kunit.c
@@ -33,6 +33,19 @@
 		KUNIT_EXPECT_EQ_MSG((test), nr_cpu_ids - mask_weight, iter, MASK_MSG(mask));	\
 	} while (0)
 
+#define EXPECT_FOR_EACH_CPU_OP_EQ(test, op, mask1, mask2)			\
+	do {									\
+		const cpumask_t *m1 = (mask1);					\
+		const cpumask_t *m2 = (mask2);					\
+		int weight;                                                     \
+		int cpu, iter = 0;						\
+		cpumask_##op(&mask_tmp, m1, m2);                                \
+		weight = cpumask_weight(&mask_tmp);				\
+		for_each_cpu_##op(cpu, mask1, mask2)				\
+			iter++;							\
+		KUNIT_EXPECT_EQ((test), weight, iter);				\
+	} while (0)
+
 #define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)			\
 	do {							\
 		const cpumask_t *m = (mask);			\
@@ -54,6 +67,7 @@
 
 static cpumask_t mask_empty;
 static cpumask_t mask_all;
+static cpumask_t mask_tmp;
 
 static void test_cpumask_weight(struct kunit *test)
 {
@@ -101,10 +115,15 @@ static void test_cpumask_iterators(struct kunit *test)
 	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
 	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
 	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, &mask_empty, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, cpu_possible_mask, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, andnot, &mask_empty, &mask_empty);
 
 	EXPECT_FOR_EACH_CPU_EQ(test, cpu_possible_mask);
 	EXPECT_FOR_EACH_CPU_NOT_EQ(test, cpu_possible_mask);
 	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, cpu_possible_mask, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, andnot, cpu_possible_mask, &mask_empty);
 }
 
 static void test_cpumask_iterators_builtin(struct kunit *test)
-- 
2.31.1

