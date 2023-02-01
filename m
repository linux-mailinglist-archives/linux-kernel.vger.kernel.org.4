Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B46869A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjBAPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjBAPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:10:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20E56A5D;
        Wed,  1 Feb 2023 07:10:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ml19so28755693ejb.0;
        Wed, 01 Feb 2023 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhev8pughE32czPvaqr1hnewEVhkAHaQpP6Xqs+9d/I=;
        b=I0Yz0URD7aG/WEZFb91AhJOqAM9Svs5gUZnPvEyipLUwAuuxMoV4egTWKgmrqQUlFE
         NPD9W7xEbBqgw657uIcFOrDyaypDLshT+crSYGoL6atspA5SmDLQSmiT3C/jKFJ2BebT
         0PStnMFMhVhO1+tFAPEEoCXo2+Mplg2XmKX51qw0Gaw5HzVWWw5odGpbv+ncXV5VHLPp
         us03GnHlSiwyn8iNPeICxim/iofFxgAMpGkL0B5SJlTJ8RVFeuaVC9z7+gF58qH5kul9
         JUaRglao/0qg/re9KkFJgoVDlQKOBYzo7J/yQbkYG2KYGTWiV7PCGMvnH4G6kgIBjMUM
         fr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhev8pughE32czPvaqr1hnewEVhkAHaQpP6Xqs+9d/I=;
        b=GkBPPpzauyIrZlQJUdKnIoa1FOiMN+JhjX2QJNrLMQGI6Ymth98ANHIN0K8O0v3Zek
         g00BGBKUjQu6W5izd+9P7CloKUHBUVsceL4Lo5EFT1lJrUNmliSNbrqR5EQgoYfawLV1
         2v7ZHq5R4AXFlf1f3NsG5rFAPLhj7oJkgUrkGXT/5tKNzhLQe6GjUassUhxmk6FlBUqr
         fK+Y3lnYrBOIfk4ah58aWlpX/0x6jpvkPxwztmoePW861QcslDGUTh6XeRdwAjGw6W1W
         8uj4ul++ILcyOiCCF8O+FYOzKtBlfLeRR7a0YSgSFBQjneMgh8Ue9ieY3OsbGGPOS686
         GLCw==
X-Gm-Message-State: AO0yUKXflUObqNHnDBC4R+tFBPQsBzsDFq3jnwPnsNd93UfRpSx3CwGi
        VlQZWNX7FiiX18yx+aPs9h/exDoceb560A==
X-Google-Smtp-Source: AK7set/kFtylWE7vcTfTSRoSkGtwuJ3gyIQC6o7CLS7udUW6PY1nLq0EZtHONJhqFmq9CFcxcjetoA==
X-Received: by 2002:a17:906:a1c6:b0:878:816f:8691 with SMTP id bx6-20020a170906a1c600b00878816f8691mr2420872ejb.71.1675264199463;
        Wed, 01 Feb 2023 07:09:59 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b008845c668408sm6627147ejc.169.2023.02.01.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:09:59 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
Date:   Wed,  1 Feb 2023 16:09:54 +0100
Message-Id: <20230201150954.409693-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150954.409693-1-urezki@gmail.com>
References: <20230201150954.409693-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a single argument invocations a new kfree_rcu_mightsleep()
and kvfree_rcu_mightsleep() macroses are used. This is done in
order to prevent users from calling a single argument from
atomic contexts as "_mightsleep" prefix signals that it can
schedule().

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 094321c17e48..7571dbfecb18 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -957,9 +957,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr: pointer to kfree for both single- and double-argument invocations.
- * @rhf: the name of the struct rcu_head within the type of @ptr,
- *       but only for double-argument invocations.
+ * @ptr: pointer to kfree for double-argument invocations.
+ * @rhf: the name of the struct rcu_head within the type of @ptr.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -982,26 +981,18 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
+#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
+#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
 
 /**
- * kvfree_rcu() - kvfree an object after a grace period.
- *
- * This macro consists of one or two arguments and it is
- * based on whether an object is head-less or not. If it
- * has a head then a semantic stays the same as it used
- * to be before:
- *
- *     kvfree_rcu(ptr, rhf);
- *
- * where @ptr is a pointer to kvfree(), @rhf is the name
- * of the rcu_head structure within the type of @ptr.
+ * kfree_rcu_mightsleep() - kfree an object after a grace period.
+ * @ptr: pointer to kfree for single-argument invocations.
  *
  * When it comes to head-less variant, only one argument
  * is passed and that is just a pointer which has to be
  * freed after a grace period. Therefore the semantic is
  *
- *     kvfree_rcu(ptr);
+ *     kfree_rcu_mightsleep(ptr);
  *
  * where @ptr is the pointer to be freed by kvfree().
  *
@@ -1010,13 +1001,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * annotation. Otherwise, please switch and embed the
  * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
-	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
-
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
 #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
-#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
 
-#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
 	typeof (ptr) ___p = (ptr);					\
-- 
2.30.2

