Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E578743BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjF3MQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjF3MQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:16:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A66E4F;
        Fri, 30 Jun 2023 05:16:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa9850bfebso18878975e9.1;
        Fri, 30 Jun 2023 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688127389; x=1690719389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POwzEyHOdtL57sIqvI2QVvs+UewHf9VWu9YMTjUelI0=;
        b=UZH1mfohLZvRw9Q14mYJsx82z7XymmyTd5ioYGrF+M0DgC5R+kVJhw13vzcPb2ndkq
         YeQ3n40ebC5JCYnuON8zOsLX2wGH05871+Y+R/aGLqf1tomVnkkNHxwsmhWPeqER9qxE
         6+iox4l0rYZdwy8vEKAURpOqcQueeiws1e6odS0RJV9iTseOwq2j5BKP6NLrfiN53+oM
         G/8S1Pv6JNPXR5lRxNvyRxOX0W8PaqpV2uehYNFdZIUHkMlYGfHSo52nsXVe8enUEmWx
         cLSwPzXUBywetlK0DpLbYkWuEWk4PPouxGDPzNyjDKVJDp4Oxg/Ie9j+kqsZKOYyducm
         IKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688127389; x=1690719389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POwzEyHOdtL57sIqvI2QVvs+UewHf9VWu9YMTjUelI0=;
        b=FaCQr40jneljE826tYd6ZsWdgUoJPT9JALTKn4JS0Wmj0VkqIjnxZgQRm131Sm4Mhv
         eU5BomxytCa89kP7BN23DeVceYIeEvRl2y0hnWhYgwpV0vAc/mqyNtOgrekWcl52UpsW
         SSgP4GYAkNMTVnJ3EafbyHCmAwZv1+ufP0KYFI9DvXrsVHQYgwFdtQJSSP0i/3/f27T1
         KpyAgabFtCi8TLT5LmDKd0SuXGrhcvfAbLyKKki+dca7qRak1su0A/t6jYHYdo6DSr7e
         KKBsE/b/VIHHCFaJt28KEbjXHXOHR/1pe0QaB8yT1lgsQHVkjN5XdzGsMvSPrv6zFKCN
         xqSA==
X-Gm-Message-State: AC+VfDy/9M1Qfx9Kkj9FTVcgQQOHX4Kxf1PkNBImH1dQ7+OPwQmcwtEN
        uqwoEhKD6Bj8rwLrGDhMcw02sQZi+dA=
X-Google-Smtp-Source: ACHHUZ52zhXZx/IRbg0hxtxnZXFRkOAYddh5ciotPrMLJWbueVJ/7V66ZOQ5YQlTizVrPV0bj7Lq+w==
X-Received: by 2002:a1c:f70a:0:b0:3fb:c060:8b3d with SMTP id v10-20020a1cf70a000000b003fbc0608b3dmr1884948wmh.40.1688127388962;
        Fri, 30 Jun 2023 05:16:28 -0700 (PDT)
Received: from oberon.zico.biz (77-85-190-39.ip.btc-net.bg. [77.85.190.39])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b003fa95f328afsm14209200wmr.29.2023.06.30.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:16:28 -0700 (PDT)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Date:   Fri, 30 Jun 2023 15:16:27 +0300
Message-ID: <20230630121627.833560-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enable_trace_eprobe() function enables all event probes, attached
to given trace probe. If an error occurs in enabling one of the event
probes, all others should be roll backed. There is a bug in that roll
back logic - instead of all event probes, only the failed one is
disabled.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
v2: Added one-time warning, as suggested by Steven Rostedt.

 kernel/trace/trace_eprobe.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 67e854979d53..6629fa217c99 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -702,8 +702,18 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled)
-			disable_eprobe(ep, file->tr);
+		if (enabled) {
+			/*
+			 * It's a bug if one failed for something other than memory
+			 * not being available but another eprobe succeeded.
+			 */
+			WARN_ON_ONCE(ret != -ENOMEM);
+
+			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+				ep = container_of(pos, struct trace_eprobe, tp);
+				disable_eprobe(ep, file->tr);
+			}
+		}
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
-- 
2.41.0

