Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B156774B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjAWEyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjAWEyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:54:32 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCED16300;
        Sun, 22 Jan 2023 20:54:28 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E87C164192D;
        Mon, 23 Jan 2023 04:54:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 70D8E64195D;
        Mon, 23 Jan 2023 04:54:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674449664; a=rsa-sha256;
        cv=none;
        b=ImMqazVmDdiYiyy4T8DQDNMqBUBsMhWiBWfed15G8xCACjH45fZCWNGpbN4Qh2nDR0BkGr
        dndKhye418ojkK2azX7n6aKXBzw2xH7tQW+Aoj7u3ZwwzI0ozD+EStciVxqxW99RYtXxRV
        faU2iFH+YJa4toYSGUxuB8BHIa08A2CpZwU5Gon5OXTU67R6ubaUintcG8uqqRoWvg205U
        KD+AwCfhSTRGwe11DIUlWRfXolaEbxZVxpR2eoXBeOpIGxr1D+KDROB8euw1ysj3VMz0g5
        WNBCMHv5jCQgaYErdpcuB/d4OZ4TfXtOCcUR18tuzhBZcR1Vc2nvvBQgOiao7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674449664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=vbcZfruUbBzOF8WQf68Hk9Z+hEN7LKtKbqNXJ1lZQkQ=;
        b=1LXrUbwb8TV9uBaG+JxjwSLz1sd9r5us2V7BaxEw73DGAELn7RXBiANsJ/cITBPPBREREb
        0BzQCcfBZfqoXUeQFM+WPmoYjRr0u2sVDoh4l7Z2hBMTYPJF+S3khnvoqBaOiTBoW7pUUs
        sXZXCc33nw9le9ZyZrDucIriB7q42H5QGWyZnxcM4KJA+uHtsS0AsLMVZefsTUj3oc31Ga
        Fmbb6VMwvinrSYZ+ZRABWfa8ZiLtWUnMLjqqqX45ZISHn40LqfdoGcGk80Xos5NbptYFVF
        BbbwEq9frMYhC3JexTKikKNTB4cL8w9/PIR4D3WVsurXEFA1c05xnY3zw6XUBA==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-4t69s;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Company: 3003ec916aa51658_1674449664733_1924223447
X-MC-Loop-Signature: 1674449664733:2878493279
X-MC-Ingress-Time: 1674449664733
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.227.175 (trex/6.7.1);
        Mon, 23 Jan 2023 04:54:24 +0000
Received: from localhost.localdomain (unknown [104.36.25.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4P0d7365CBz32;
        Sun, 22 Jan 2023 20:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674449664;
        bh=rkuO71o7esLy5vIPjIKCbuF52AtcXpX1PFhA0SxaUAc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ooshBhQZKSQD4DvBkJ77sV3s0dkNRJ+brFnBlUgMId9eWrWsS9rWJUhRHzWs28qv5
         GKvPRWhiADu+HBPsddyBLvJikt7s391lArMqJZq2ANgiFm4UkzqgKHcy5eqPgMXFkN
         v0fe6eGA1pmyZNGOCq4V8TDQRphLqn3Yy0ExpDxN1+GPJpE7yUVNFTmJtZYjkWVR9x
         y9/wpJFrbe0WI9DJkfz6z44OGIKsNsl2EEOrqxFg5807QRwuUTiRXoiPJdCsCNk/D0
         mXJjpbxtTOgMoIOVP6nFUteHHQJZVETcxLu1Qu7WlvHIBOEFOd5oC80VB3crNi/pww
         bXjPakJv3qWcQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     bigeasy@linutronix.de, dave@stgolabs.net,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Add a comment for the existence of task_is_realtime()
Date:   Sun, 22 Jan 2023 20:27:29 -0800
Message-Id: <20230123042729.30268-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.0
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

... such that users don't wonder about it when we have rt_task().

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 include/linux/sched/rt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index 994c25640e15..7a5003c2cf2a 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -18,6 +18,12 @@ static inline int rt_task(struct task_struct *p)
 	return rt_prio(p->prio);
 }
 
+/*
+ * Returns true if a task has elevated priority which is the case
+ * for RT tasks (SCHED_RR and SCHED_FIFO) as well as SCHED_DEADLINE.
+ * A task which runs at RT priority due to PI-boosting is not
+ * considered as one with elevated priority.
+ */
 static inline bool task_is_realtime(struct task_struct *tsk)
 {
 	int policy = tsk->policy;
-- 
2.39.0

