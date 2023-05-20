Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4670A5B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjETFbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjETFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98708E45
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684560627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5R/eziRcvPt6iSCgjIp0QHa49sOUGI4wJ6ZtOXpi8M=;
        b=QaqpxSkZeArAwek5DzyB7IhZi8FgVd/Ah82clFJPSa+u7YTVT1xeqoicMgqxQAA5K/+o9V
        Z9NIuSDjbJRR7yLndethCsjwbb0qyRG39kuT4m9Y21zKLeRLXiXaZ1+Ak8WLHKbzfNn4Fq
        ycFkyFdvAJ++3mBxayQ7wYcyop8MA1c=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-tUjRo-zJNqWNpOjXdrH_Wg-1; Sat, 20 May 2023 01:30:24 -0400
X-MC-Unique: tUjRo-zJNqWNpOjXdrH_Wg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-54fa8068805so2686181eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560623; x=1687152623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5R/eziRcvPt6iSCgjIp0QHa49sOUGI4wJ6ZtOXpi8M=;
        b=RXrVPKqhSnnh3P52+qM36Q4PGdZKc45s3AZqT/JSUTwTghTzw9R/fpxV/u946M7oQi
         MUcj4oz4eFeB921kyqhYCBzMm+scIAgDLITllqq5pCW1nue34UQsUntSQ7FeQ5D0fbLS
         8ffAmCULS+eVx4kCWxsVSgkheX3WfePqVeJz6U/vg0N4YuG99sBui+8gVnXQLg1qAjPl
         YC1ltMr761EG7Ieg3LysYTU5SeOn6k+Ob+yPBM499TaVJDGjx2T7eV4rPE6wPD2wP9yO
         gFREYhgQErWogHQaXV3wZhpE+twFFKfPEJ6ohqZ+NEFY9bz8LT1m2lhQgOo+5Yu8eSyQ
         thLA==
X-Gm-Message-State: AC+VfDxmbbWapzgH20xFVo+1MYVvFKJV8bCe2mhSxsdOzpyxGF8SFsL0
        guP+rAPjm75cWosthwwPJR6OCL/71kxfiYjAtWeWUVJpcxkL0knWXiJcqrxAa8HQy2jnCdJkNUK
        KB/z6COpkHo9eb107JSzThvZ2
X-Received: by 2002:a54:4084:0:b0:389:72d5:f16f with SMTP id i4-20020a544084000000b0038972d5f16fmr2408184oii.28.1684560623805;
        Fri, 19 May 2023 22:30:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A0W4HoYMf/xUd3PGw3uwZk5Jkp2rgdxrbOEmM8UvnmIJl3NhXZog88XAfQsdp6q4b+mgawQ==
X-Received: by 2002:a54:4084:0:b0:389:72d5:f16f with SMTP id i4-20020a544084000000b0038972d5f16fmr2408178oii.28.1684560623624;
        Fri, 19 May 2023 22:30:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
        by smtp.gmail.com with ESMTPSA id j14-20020a4ad6ce000000b005524555de56sm365494oot.36.2023.05.19.22.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:30:23 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] smp: Change signatures to use call_single_data_t
Date:   Sat, 20 May 2023 02:29:58 -0300
Message-Id: <20230520052957.798486-4-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520052957.798486-1-leobras@redhat.com>
References: <20230520052957.798486-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller of smp_call_function_single_async() now makes use
of call_single_data_t, which is a size-aligned typedef of
struct __call_single_data.

Changing smp_call_function_single_async() csd parameter to
call_single_data_t makes possible to warn future callers if they
are using an unaligned csd, which can cause it to be split between 2
cachelines, which is usually bad for performance.

Also, for the same reason, change generic_exec_single().

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/smp.h | 2 +-
 kernel/smp.c        | 4 ++--
 kernel/up.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 91ea4a67f8ca..e87520dc2959 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe..919387be6d4e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -361,7 +361,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, struct __call_single_data *csd)
+static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -645,7 +645,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * Return: %0 on success or negative errno value on error
  */
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	int err = 0;
 
diff --git a/kernel/up.c b/kernel/up.c
index a38b8b095251..df50828cc2f0 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	unsigned long flags;
 
-- 
2.40.1

