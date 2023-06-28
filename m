Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43B741360
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjF1OFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:05:14 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:39632 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjF1ODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:03:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E48661342
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA91BC433C0;
        Wed, 28 Jun 2023 14:03:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qEVli-002phL-2s;
        Wed, 28 Jun 2023 10:03:38 -0400
Message-ID: <20230628140338.707970985@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Jun 2023 08:54:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        sunliming <sunliming@kylinos.cn>
Subject: [for-linus][PATCH 1/3] tracing/user_events: Fix incorrect return value for writing operation
 when events are disabled
References: <20230628125448.007243475@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

The writing operation return the count of writes regardless of whether events
are enabled or disabled. Switch it to return -EBADF to indicates that the event
is disabled.

Link: https://lkml.kernel.org/r/20230626111344.19136-2-sunliming@kylinos.cn

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8df0550415e7..09f7d9167b8e 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2096,7 +2096,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return -EBADF;
 
 	return ret;
 }
-- 
2.39.2
