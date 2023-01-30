Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0C6818A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjA3SUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjA3STs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:48 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639A13C2BA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:46 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id g16so5499454ilr.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDBpxnP3WW9swXg1k4cZKHfZtZE3TZaenciQ4HYVSSE=;
        b=X/CZ32PzybOGyUPFRfQEvln6em78Y8z7fw7dS0qUVAcPU0jM24vCrdyAXpMX86E3v4
         rwqns0iXGjl9lJsiwE0GiiN1qMHr/Zp87SiMsYzz7MjQdYBd90sqIBWVY4pNOJJvMqkO
         KDvBdv6kyx3gXmruz3ypb7S4kkpkOKtEgKFUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDBpxnP3WW9swXg1k4cZKHfZtZE3TZaenciQ4HYVSSE=;
        b=aE+L8VvOrroYJNHRPFGQM+rtR+CfIHMJVAc6qxsFYpBsJZLnt3gdvKwkiTZlmkoMxJ
         CHHOr7lSNhpYdFkTVgXYMairH+ebmjG6QvuPMjWX+nYvAslVMyt6ZaLuYi78fCqi5u1m
         Xirl2xJfN2JOdg/VmjrolYq5l6UYZEnmbnk/kB7gNUZ00utjpkl7lYkJ48S4wP3uD/NR
         TeyFvK1MAjZ8I7rTB4ynlTuHTzjwO/aAxWgzY8zUfOFIXjH7XU0f/MEC3JEvrppo66y1
         OfEWI+oCgHPpCrrt9XctihVhxkELtc7FjCEEbYxwd+iTI7QDN5lOzaULy31wPct+Rqdt
         gmjg==
X-Gm-Message-State: AO0yUKUL+g2lwJfxS8MLR8UQhFkt99ZIeLQ0gBxbOmXXddEfRebla8N5
        h2VC8yQHY0xx5mHKIjiCwl23C+D4wNIzddMJ
X-Google-Smtp-Source: AK7set+JK0jrnU7jJ0V7j6pBAtQRf+/FzY8gPrCgkQmJMoSWDMUaoOXgAWkdKZFezB6o8YO50+0VuA==
X-Received: by 2002:a05:6e02:16cc:b0:311:27d:f81d with SMTP id 12-20020a056e0216cc00b00311027df81dmr2065954ilx.28.1675102785983;
        Mon, 30 Jan 2023 10:19:45 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:45 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 7/9] tools/virtio: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:13 -0700
Message-Id: <20230130181915.1113313-8-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A few spots in tools/virtio still refer to this older debugfs
path, so let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/virtio/virtio-trace/README        | 2 +-
 tools/virtio/virtio-trace/trace-agent.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
index b64845b823ab..cea29a2a4c0a 100644
--- a/tools/virtio/virtio-trace/README
+++ b/tools/virtio/virtio-trace/README
@@ -95,7 +95,7 @@ Run
 
 1) Enable ftrace in the guest
  <Example>
-	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+	# echo 1 > /sys/kernel/tracing/events/sched/enable
 
 2) Run trace agent in the guest
  This agent must be operated as root.
diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virtio-trace/trace-agent.c
index cdfe77c2b4c8..805942d02e9f 100644
--- a/tools/virtio/virtio-trace/trace-agent.c
+++ b/tools/virtio/virtio-trace/trace-agent.c
@@ -19,7 +19,7 @@
 #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
 #define PIPE_MAX_SIZE		(1024*1024)
 #define READ_PATH_FMT	\
-		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
+		"/sys/kernel/tracing/per_cpu/cpu%d/trace_pipe_raw"
 #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
 #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
 
-- 
2.39.1.456.gfc5497dd1b-goog

