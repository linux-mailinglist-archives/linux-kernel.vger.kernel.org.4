Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929866889D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjBBWeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjBBWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:34:18 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7706952E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:34:17 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-51e4bb90e78so33996807b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqEbaoXKZhduzvtpNpkhhcX7LiSnTOQP98iiJKeE854=;
        b=FwHExR9nBYi6inpOGnmsjd7ibbGtNobjrt2tyzYYMtoKUTFuTxaY9aTWYxwDthzwdc
         Hj6zHwKuIomOMJN9GRyzs3YnN8G4CyZbrbd4PXn4CrTHr1ncOrUFedjXXVc/Mi2PBW+8
         A63NL9q7koYpwx8Au2YscoIZMxpUszainMvI6J91No3l7AsWWxMq3JqS6XkIEuYD+KGc
         R8A5JUbHv5FDxHd6Dzo5oI5ewynbmyYS+qN1faBZPTJS4E0DCt1hBwyED1MW13LcCuBd
         BR7whP2z8utCcejOBa4n2l5QlSOxeoMOSfnluehxFUjHfedZpbuImBCZ6InVlYgwT2Wz
         cXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqEbaoXKZhduzvtpNpkhhcX7LiSnTOQP98iiJKeE854=;
        b=JdqM2i0KCh18qM9nLrwn3wHc+ypCh8XOq35NGonNkDQzJUWFHSEwixtj/6TFAHCEFi
         Je0kVh4NO0F9W7QaoBzIKzLmoSe7X8Vrlzrcr8kFOIpnokHCHrtzOyiD6ft3LbaIM2XS
         geC1CupmcdDgR9ehUVZHFftuhONrGydqQJbU++ZMYdvcV09IrD5zOuRCmsjkm0VDMCdN
         9b7QJ0S0tuqv3XNLnX/mKYKHCpw4pr3cBgrX1GAfv5Y2a7IT88EMf5ZGE6GHVvb6mbN2
         /ALWkLFzCpRMEvztTIHH6OYFN9XsplLg2ue9MBVmKTP+j2vIrAvZHHQFTfA3sZdRsmTe
         KkGg==
X-Gm-Message-State: AO0yUKXZj8tnlttufZJVYvLIKDfjIPbgs8Blyngm666JlxVI2lYnWp4J
        jwAZX7JrH92TOE3UG+SrxGiYN/I8UjLg92abLAoF4WLP7EH66ufssE3MrNwITxdIsaGEFape/c9
        Z1UQIZ+C8XOAwYVXOOpoZqzYsuyDU/S7e8GQBE9eWKKBSdkF7OmrwvW74Ccgfgm3ASd33+sk=
X-Google-Smtp-Source: AK7set8UaV0r0NZuhQ8G+FsGVuwZQ1AKnrYwh7onI0XO/lhshYe9phB4s5+gktVA++2Rz1Jf+oi8Ll9G3Glt
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:7355:0:b0:521:db02:1015 with SMTP id
 o82-20020a817355000000b00521db021015mr7ywc.5.1675377255510; Thu, 02 Feb 2023
 14:34:15 -0800 (PST)
Date:   Thu,  2 Feb 2023 22:34:08 +0000
In-Reply-To: <20230202223409.2812443-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230202223409.2812443-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202223409.2812443-3-jstultz@google.com>
Subject: [RFC][PATCH 3/4] locktorture: Add nested locking to rtmutex torture tests
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
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

This patch adds randomized nested locking to the mutex torture
tests.

This was inspired by locktorture extensions originally implemented
by Connor O'Brien, for stress testing the proxy-execution series:
  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/

Comments or feedback would be greatly appreciated!

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/locktorture.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 27d92ce36836..5fb17a5057b5 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -506,6 +506,28 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 
 #ifdef CONFIG_RT_MUTEXES
 static DEFINE_RT_MUTEX(torture_rtmutex);
+static struct rt_mutex torture_nested_rtmutexes[MAX_LOCKS];
+static struct lock_class_key nested_rtmutex_keys[MAX_LOCKS];
+
+static void torture_rtmutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_LOCKS; i++)
+		__rt_mutex_init(&torture_nested_rtmutexes[i], __func__,
+				&nested_rtmutex_keys[i]);
+}
+
+static int torture_rtmutex_nested_lock(int tid __maybe_unused,
+				       u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nlocks; i++)
+		if (lockset & (1 << i))
+			rt_mutex_lock(&torture_nested_rtmutexes[i]);
+	return 0;
+}
 
 static int torture_rtmutex_lock(int tid __maybe_unused)
 __acquires(torture_rtmutex)
@@ -570,11 +592,24 @@ __releases(torture_rtmutex)
 	rt_mutex_unlock(&torture_rtmutex);
 }
 
+static void torture_rtmutex_nested_unlock(int tid __maybe_unused,
+					  u32 lockset)
+{
+	int i;
+
+	for (i = nlocks - 1; i >= 0; i--)
+		if (lockset & (1 << i))
+			rt_mutex_unlock(&torture_nested_rtmutexes[i]);
+}
+
 static struct lock_torture_ops rtmutex_lock_ops = {
+	.init		= torture_rtmutex_init,
+	.nested_lock	= torture_rtmutex_nested_lock,
 	.writelock	= torture_rtmutex_lock,
 	.write_delay	= torture_rtmutex_delay,
 	.task_boost     = torture_rtmutex_boost,
 	.writeunlock	= torture_rtmutex_unlock,
+	.nested_unlock	= torture_rtmutex_nested_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
 	.readunlock     = NULL,
-- 
2.39.1.519.gcb327c4b5f-goog

