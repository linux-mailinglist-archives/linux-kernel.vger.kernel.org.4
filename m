Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C802688CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjBCBnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjBCBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:43:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0922A0E;
        Thu,  2 Feb 2023 17:43:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFCE761D4B;
        Fri,  3 Feb 2023 01:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA1BC433EF;
        Fri,  3 Feb 2023 01:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675388586;
        bh=8zWI8bpAWD3oVlVykWtql5OSUtDYRERkD7toqAUb7R8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sSzjqSKG0c2v4pEaoyOyx0z3psnCdMrbABrkOsIQ7QR3fJYvsCR9bTr4H4GLesSt2
         iFE4qI/QNPP83WUAsy6rsNZwOjk3r7pmuVDXSZ32g3gQGxHw/3bE5O0RJaLjpm17a4
         UapoOYxj85CAZGh3VE5OuQOPT9oA9XvEUxW/AjzRNhRpLQq80yCu7yu4g+qgHI2dUo
         5Mv7cjr1cMqFvM+/kton+7O9uFxzionWH7MdobojY0Gx97PiWCfwfqrmtwwJHfzHFM
         Ws2y3TFkDkt9vjP/M9/Du0L4a1lskYOIP/6w9kdurWRuldvah7clBRFP0HASL94ALN
         15C9AAS1x6uzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D608B5C0DE7; Thu,  2 Feb 2023 17:43:05 -0800 (PST)
Date:   Thu, 2 Feb 2023 17:43:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 9/8] Add kvfree_rcu_mightsleep() and
 kfree_rcu_mightsleep()
Message-ID: <20230203014305.GA1075064@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvfree_rcu() and kfree_rcu() APIs are hazardous in that if you forget
the second argument, it works, but might sleep.  This sleeping can be a
correctness bug from atomic contexts, and even in non-atomic contexts
it might introduce unacceptable latencies.  This commit therefore adds
kvfree_rcu_mightsleep() and kfree_rcu_mightsleep(), which will replace
the single-argument kvfree_rcu() and kfree_rcu(), respectively.

This commit enables a series of commits that switch from single-argument
kvfree_rcu() and kfree_rcu() to their _mightsleep() counterparts.  Once
all of these commits land, the single-argument versions will be removed.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f38d4469d7f30..84433600885a6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1004,6 +1004,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
 	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
 
+#define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
+
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
