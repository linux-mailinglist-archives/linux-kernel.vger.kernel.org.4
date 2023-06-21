Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898BC737B18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjFUGIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjFUGIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:08:39 -0400
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE30172C;
        Tue, 20 Jun 2023 23:08:39 -0700 (PDT)
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-3a03ff70c1aso836538b6e.1;
        Tue, 20 Jun 2023 23:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327718; x=1689919718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5/ibBv767hMPWz9rN9brRTXkDseA5y39L5B6lIVEsY=;
        b=VZSPm7x4p9SqeUbWPbzoYr3PEsy0B6fXgeEqrT4qw96zCt4RQlEaiwDGQijlrB9SxA
         gxwexRxJnP0+VP2YrHQScojJFmaZ8q6+ROc61buctbnzxeA1FRK6WuZ2BKX6/eSDn/55
         N+axYlh37HUqDOEzMf3WzZ/rCzRJ6cjfAO/nysHQeBmHMAEIsiMHDgUdT4g2Y9ZLxUBS
         XUQqtqjh+4w2Pru+yvT4CKkIPtHdIw0y9hJEH009SyGPTGADEMeLLGcuHl7ZXCRCnatI
         zH4Hlb1YojHjnP9l7+iNllOTUFwJ0EfF2Kqe1VuSpPa/NRQKFltYL2O3Q5edba1YNPBe
         dRgw==
X-Gm-Message-State: AC+VfDxleMMxJmY0cbmVQv5JYsT2mGAl1GjPjacn/nthHnIJqiwnF9Fm
        jI5XA33X/l9M5xU0NxSqpg==
X-Google-Smtp-Source: ACHHUZ7pDI+7OOHhAviNtXk4kP8st4badHVapsOBMfyv6deuqqy8RsiADE+LLn57e5VwMD2+/YWV7A==
X-Received: by 2002:a05:6808:f88:b0:39e:1d17:d689 with SMTP id o8-20020a0568080f8800b0039e1d17d689mr14321758oiw.56.1687327718239;
        Tue, 20 Jun 2023 23:08:38 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d28-20020a630e1c000000b00528da88275bsm2323621pgl.47.2023.06.20.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:08:37 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     kelulanainsley@gmail.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 1/3] tracing/user_events: Fix incorrect return value for writing operation when events are disable
Date:   Wed, 21 Jun 2023 14:08:24 +0800
Message-Id: <20230621060827.151564-2-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621060827.151564-1-sunliming@kylinos.cn>
References: <20230621060827.151564-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The writing operation return the count of writes regardless of whether events
are enabled or disabled. Switch it to return 0 to indicates that the event
is disabled.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 1ac5ba5685ed..c085ff829a58 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return 0;
 
 	return ret;
 }
-- 
2.25.1

