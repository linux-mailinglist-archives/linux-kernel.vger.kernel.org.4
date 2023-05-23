Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1840470E462
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjEWRxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjEWRxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:53:03 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741F97;
        Tue, 23 May 2023 10:53:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AEAF510093B;
        Tue, 23 May 2023 17:43:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 203ED100DEB;
        Tue, 23 May 2023 17:43:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684863797; a=rsa-sha256;
        cv=none;
        b=EChbPCwA1ffSlewxfORC2zHVVzCPh7FQnov+WoDZENstEfie6yxRwfyKr0dUF7tmb6iUhP
        n7PFgxfjjGpDYfHODNiJGGhiKbeyrIbvfDnSdqoOOQlW3AOFMybXt14wiqj8lKfTTq4b6U
        Qh6gaFue5rDavUTlVubcahLqw4HlOL+sf0nVsw3tFVB2+a8khqCdPQlx6T+nNs+kt7OFlY
        sRLYbK895Dtkccm0h2J+XXATdjJZ73QhBIDbVRgT2+uCb0CajeeL2mTBl/ofM8t8juY3Ju
        cEo7BgLvX3AgsUzfrEkJdiGQBsO+66FvXA9qMFzwRN4mRgSCkiy2lEZIHmXl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684863797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Tje9Mwoj4FsyACWirLPbg/M4HFVqtb+/SIEh21bnKKY=;
        b=buJ1JRTlSr9Gxwq0oQD2uqmndLw8JaCJy5znF/AFH9vWUJjeggc43ue10BE2sMpC1hYyTW
        lBjYAtT12oiyTBfwBlFLSbBOH9sNsDWQy3tzPrZmUqYb1bsyP3X92Rb5fSjvHj2ab9S7UP
        5yXc4m6uTep6i6ikL4N/rV/poMbzJIR0Pq7XtRFea2qlFXNDbhDZUx8RF78m/6SOOqUAB1
        joG9Kc47UIxHlc8Gv2GXoGcUeKpgeSTxVoPfhzlsiPL1HvJ2ndK1bhCyK6gAQrt7AJHwc4
        AhDX/bzEJxwVhpkn8zzjp0WzEILWYidDxtGkcWQ5Sn0vnK62DZo4tnq4jF/wbA==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-qfmcz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Language: 3c77e26b695f5b3d_1684863797487_1350713200
X-MC-Loop-Signature: 1684863797487:3321212046
X-MC-Ingress-Time: 1684863797487
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.246 (trex/6.8.1);
        Tue, 23 May 2023 17:43:17 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4QQhVr1Jfrz28;
        Tue, 23 May 2023 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684863796;
        bh=Tje9Mwoj4FsyACWirLPbg/M4HFVqtb+/SIEh21bnKKY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=U8s7WDeMIYFkVRmc4zGrRuOpx2K4QR9N4YBRxJwrKGweeiaTZ31JJAwXXE9p7HHXo
         rq+M5WfcbWehRDppjnOWfqfuj8jLshWhETfGT5u7bPB246gKkkLU5eKoX8zPKyPmS6
         lChvmq90BtYKUxdfAV9DSZyfvONDv7uKa3iOJlO9DHWFjYjU7xtT+/7aY+AfzqQ1RY
         YtqCfPh31j5JNKY1vfbZYbq2uqojz6QyV7b1gxyDgCRWVvHGDH4CH2uWKPZ2kT5S7f
         US7kp/z4eUwN+q/ADYiajfHcYjLJt7UEap6eRFLixZ6xwmL4L5UVOoUsmVZIAC1wfb
         1cwuqMuvSpgxw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/4] rcuwait: Support timeouts
Date:   Tue, 23 May 2023 10:09:24 -0700
Message-Id: <20230523170927.20685-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523170927.20685-1-dave@stgolabs.net>
References: <20230523170927.20685-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcuwait utility provides an efficient and safe single
wait/wake mechanism. It is used in situations where queued
wait is the wrong semantics, and often too bulky. For example,
cases where the wait is already done under a lock.

In the past, rcuwait has been extended to support beyond only
uninterruptible sleep, and similarly, there are users that can
benefit for the addition of timeouts.

As such, tntroduce rcuwait_wait_event_timeout(), with semantics
equivalent to calls for queued wait counterparts.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 include/linux/rcuwait.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 8052d34da782..27343424225c 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -49,9 +49,9 @@ static inline void prepare_to_rcuwait(struct rcuwait *w)
 
 extern void finish_rcuwait(struct rcuwait *w);
 
-#define rcuwait_wait_event(w, condition, state)				\
+#define ___rcuwait_wait_event(w, condition, state, ret, cmd)		\
 ({									\
-	int __ret = 0;							\
+	long __ret = ret;						\
 	prepare_to_rcuwait(w);						\
 	for (;;) {							\
 		/*							\
@@ -67,10 +67,27 @@ extern void finish_rcuwait(struct rcuwait *w);
 			break;						\
 		}							\
 									\
-		schedule();						\
+		cmd;							\
 	}								\
 	finish_rcuwait(w);						\
 	__ret;								\
 })
 
+#define rcuwait_wait_event(w, condition, state)				\
+	___rcuwait_wait_event(w, condition, state, 0, schedule())
+
+#define __rcuwait_wait_event_timeout(w, condition, state, timeout)	\
+	___rcuwait_wait_event(w, ___wait_cond_timeout(condition),	\
+			      state, timeout,				\
+			      __ret = schedule_timeout(__ret))
+
+#define rcuwait_wait_event_timeout(w, condition, state, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __rcuwait_wait_event_timeout(w, condition,	\
+						     state, timeout);	\
+	__ret;								\
+})
+
 #endif /* _LINUX_RCUWAIT_H_ */
-- 
2.40.1

