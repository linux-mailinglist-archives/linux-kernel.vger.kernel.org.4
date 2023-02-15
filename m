Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5242F6987F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBOWeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBOWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:03 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D06B3A851
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:01 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d16so2120ioz.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnWb0/c3SYq7VOjFth5MeHXAYmHB31VnBFWZUTQPvpw=;
        b=kC+gHfVdbRJlKuA2eO3yNTVt7DH6c/TA0/kfK1ldKXFTz8jF7IfNK0GsqoCDlFaey+
         Ot5LcebAIg2SwBu3bz6JxTwqg50CJu1GANhWz5aFxR+pABZYHwDTNFIl1ylVCSJBriro
         ftvYlS/DyAxzJSjMvhjrfJadtr3Xe/GVoDQlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnWb0/c3SYq7VOjFth5MeHXAYmHB31VnBFWZUTQPvpw=;
        b=GBpoTZT5GpfKauIwe8jb36YVg+FkahpMDv1L5Sj+rZew9UCkPq2a/uwt8c7Qql6pNq
         Fhapj2C398Klhz59kGaNhtp9Ely5eHmQW8gTwUVRH5PAF+aKl8ear2HtevaEtBeUm7bw
         jh9mEzS91ZfTKbE9xCzY5NeBH9vDpzD0LTDsnDna3as/YqzvkATcdGsjmL9FTf7EHmgb
         uqP1AzK6/v1RxhiDxsT2i9BKOqdmso85nih1tLNZQgJzE/xHl5kV+8FV84p3WMdtOLUr
         pQoawUvz4odW2FsuAQDYHvB+wdKyJ5CXFvlVJ0Hovoo/sgaQ1sJ48ud7xJCg/uL7OJIm
         l4Xw==
X-Gm-Message-State: AO0yUKVxbOGBRXskP+y5PG/YHouzBYPJBhAZlpYSkIl2/7nEoOs/ZL8d
        anErj3uaZKl3x84qKqOTf00jG/wmK2ot2PIP
X-Google-Smtp-Source: AK7set+LWFNoW1FRruwyMQqPtFjjrfVj8AiheRpZcLSgqEnBWe2webNydnur3ykK3IxtsLkMcuwgOQ==
X-Received: by 2002:a6b:7118:0:b0:734:2621:58e2 with SMTP id q24-20020a6b7118000000b00734262158e2mr3155532iog.20.1676500440593;
        Wed, 15 Feb 2023 14:34:00 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:34:00 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 4/6] tools/kvm_stat: use canonical ftrace path
Date:   Wed, 15 Feb 2023 15:33:48 -0700
Message-Id: <20230215223350.2658616-5-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

A comment in kvm_stat still refers to this older debugfs path, so let's
update it to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/kvm/kvm_stat/kvm_stat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kvm/kvm_stat/kvm_stat b/tools/kvm/kvm_stat/kvm_stat
index 6f28180ffeea..15bf00e79e3f 100755
--- a/tools/kvm/kvm_stat/kvm_stat
+++ b/tools/kvm/kvm_stat/kvm_stat
@@ -627,7 +627,7 @@ class TracepointProvider(Provider):
         name)'.
 
         All available events have directories under
-        /sys/kernel/debug/tracing/events/ which export information
+        /sys/kernel/tracing/events/ which export information
         about the specific event. Therefore, listing the dirs gives us
         a list of all available events.
 
-- 
2.39.1.637.g21b0678d19-goog

