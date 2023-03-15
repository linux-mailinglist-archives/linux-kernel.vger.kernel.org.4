Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728106BBBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjCOSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCOSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE95C11F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:29 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c19so17158418qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8211cyBB4kTZ+AoCUX/adSsmWMNuX2PRJRyfmzY6D90=;
        b=gWHdyoQf2y0I1HPFYIar0tUQRiVknNSQwaBNxnbH7Qfl1No9xGKFXwNubvPdNvRyLo
         RvW+m4q92o6a8CkGIzEqSvjJ8KB/P8vzXqIUgN+zAPeGACWv9hbrGIEwBmK8Wpv17Hvn
         d0TsWzvSpDnCZHNNzd0Wg4zo8RJrZAhpKWq+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8211cyBB4kTZ+AoCUX/adSsmWMNuX2PRJRyfmzY6D90=;
        b=rPA3w8UWkUkyTDICJ3ASTRCNpubMr9mzerA2OaRavEm+T1N7bOU6V76CRz15FurbZd
         qoiWWHprO/Ced54+cCZQCe4kz+9BdIyRUPz5nvNmPr9mCQR8kZgTCt3drbdCKgeYcJX2
         KkWw8487+s0W+K2y1N9CaTvCqcGY/7sUbyhAb/l9i7nKLnl15rXPKTiFgN4QQBeLvt19
         1TRdOT7D8sSkVJ5FGm20pmE7QXp2UtGA29CuEBsvZLYGodEWQ4T3Cn+W3d3ZPtWBxjIA
         SJ9jIEvzx9tdu9HXN1dms3AuZz4v7q9AGmoDMvmClKsj/DH0FhcLrbLzdF+ujLhvmSUT
         Soyw==
X-Gm-Message-State: AO0yUKXuMEyJV37SZs+/gnFrbXnNdsVV6uIH5hnb9v5OPdo93YOyzg3C
        2bqlAdDF8yJEmGbICLDKhB7rfQ==
X-Google-Smtp-Source: AK7set9uIn8Ta7wQBmeCK7IdANCeFnOqIyykiuYtn+YddgTV6X7PADH3YtLb3R/Ps5MImEn1Jiz7PA==
X-Received: by 2002:a05:622a:1a88:b0:3b8:588c:40e9 with SMTP id s8-20020a05622a1a8800b003b8588c40e9mr1502647qtc.19.1678904368531;
        Wed, 15 Mar 2023 11:19:28 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:28 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] lib/test_vmalloc.c: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:51 +0000
Message-Id: <20230315181902.4177819-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
switch to the new kvfree_rcu_mightsleep() variant. The goal is to
avoid accidental use of the single-argument forms, which can introduce
functionality bugs in atomic contexts and latency bugs in non-atomic
contexts.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/test_vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index de4ee0d50906..cd2bdba6d3ed 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -334,7 +334,7 @@ kvfree_rcu_1_arg_vmalloc_test(void)
 			return -1;
 
 		p->array[0] = 'a';
-		kvfree_rcu(p);
+		kvfree_rcu_mightsleep(p);
 	}
 
 	return 0;
-- 
2.40.0.rc1.284.g88254d51c5-goog

