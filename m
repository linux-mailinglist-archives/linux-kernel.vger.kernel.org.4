Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D856718F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEaXYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEaXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:24:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC2A0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:24:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b025aaeddbso32965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685575461; x=1688167461;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//XmFHkVZeMqVlzDIiq/XgAHXTXCaE3pApcXQx7fg54=;
        b=KljlptW6Z04+/MrR85fn54p+Dp+SZj+SLehmefgTM3k6ENFld4XBXpdmhCzp7uH+n5
         3mhupxEX/4VQMvBu3FuJIo/8m4k137lExCakL6Dil74fDAtlQx/gfkiwsesHfO0rTdQc
         8djhVBO9FEFXl0b+TXUxyp9bPpr/oBuTWgqtw74w+iJxjCs0PJtbY4ImNZtPRAcFcAqg
         LWIMPzIbQuQpHhrGrF0VnsmrsEmHzF9UQ/CfdZHQV5NE6aL5eKMv3VIgdboL0Jr7zTRw
         OjhaaKrjFGqhAms20DJsNe5D1FvQt4oB3emV00NC9oKDEJcUokY1MdDu7xRk8v2FQQiu
         zpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685575461; x=1688167461;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//XmFHkVZeMqVlzDIiq/XgAHXTXCaE3pApcXQx7fg54=;
        b=HribiDLQf6pFsurEnfzgAXV8m1q847o5/i4Ol3wSFlB54aXt8fh6a14iB7N/xBSa3q
         2i/U4O6yME07IQSREkTUb+TX8bcQ7v1fH2xyiX+ansirlqgWLjyH0DPtHmfmXbE9c936
         zutnQPL9UZIn0EonIq6fCzl89WAs3JD+RXHLaUaR8M0q6bNxjdOKE62DfE/x9rNhwP4Y
         QiYxdCg1ESUd2SuGzIPx/ww2SihSvlnkI2VNshyO8ZzOd5u4YT9ZJ504/mKFtwiccuGM
         WUqv3W/eBNbx90naZNnrtmGOUQ2x9ATXovUnBGNNOKRS0JUC7Ht2jNVBO9cfffrNba4r
         T5hQ==
X-Gm-Message-State: AC+VfDwjLeBo/XcfOD3oO68DDC2iN7BhEl6/trbDyHTxPFIS1boiQVQL
        9FCF12IKgKg5+K2JReWg6TDS8g==
X-Google-Smtp-Source: ACHHUZ601px8x8ARrLMc2iXSlf6DDgVgdz1nPF0ZJ45XeK3AvHQxFABh95TtLog/24oW6ARNxcLIxA==
X-Received: by 2002:a17:902:e54e:b0:1b0:4a2:5920 with SMTP id n14-20020a170902e54e00b001b004a25920mr26191plf.19.1685575461555;
        Wed, 31 May 2023 16:24:21 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902b49300b001ac5b0a959bsm1948642plr.24.2023.05.31.16.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 16:24:21 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] epoll: ep_autoremove_wake_function should use
 list_del_init_careful
References: <xm26pm6hvfer.fsf@google.com>
        <20230531015748.GB1648@quark.localdomain>
        <20230531-zupacken-laute-22564cd952f7@brauner>
        <xm26ilc8uoz6.fsf@google.com>
        <20230531152635.e8bb796bee235977c141138c@linux-foundation.org>
Date:   Wed, 31 May 2023 16:24:20 -0700
In-Reply-To: <20230531152635.e8bb796bee235977c141138c@linux-foundation.org>
        (Andrew Morton's message of "Wed, 31 May 2023 15:26:35 -0700")
Message-ID: <xm26bki0ulsr.fsf_-_@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

autoremove_wake_function uses list_del_init_careful, so should epoll's
more aggressive variant. It only doesn't because it was copied from an
older wait.c rather than the most recent.

Fixes: a16ceb139610 ("epoll: autoremove wakers even more aggressively")
Signed-off-by: Ben Segall <bsegall@google.com>
Cc: stable@vger.kernel.org
Change-Id: Icca05359250297f091779c9dcf4fefea92ee8c93
---
 fs/eventpoll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 980483455cc09..266d45c7685b4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1803,11 +1803,15 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
 static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 				       unsigned int mode, int sync, void *key)
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
-	list_del_init(&wq_entry->entry);
+	/*
+	 * Pairs with list_empty_careful in ep_poll, and ensures future loop
+	 * iterations see the cause of this wakeup.
+	 */
+	list_del_init_careful(&wq_entry->entry);
 	return ret;
 }
 
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
-- 
2.41.0.rc0.172.g3f132b7071-goog
