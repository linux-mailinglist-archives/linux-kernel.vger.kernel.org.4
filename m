Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1033D70B504
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjEVG1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjEVG13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:27:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE07A1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:27:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-970028cfb6cso36757066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684736846; x=1687328846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2l9Y29vvbcuVlicsL/pc2oxU1nu4jLH8yjGCxlB3M8=;
        b=QjiMznfkRXOT9X3gOMhMmB1SY/wuXlpmp0Tbk8Q/PhcuC1dkescNZsoNpNerNfOiA+
         gVCmXg/YtMLHg+B9qzbQ/Fj8lPaUFx6XymbKnQ9iVUzOFmuZFUl+RYJtLWrY+qFFiSmq
         oSWX0s35Wxuw9Vr4FBDHnl65tsqnK36m7R4vdhMOWel/ni44MWgV8pWPWEpzM7DqImbt
         vrZXy5AfF7KN+aPvmUqhK+0yjzOJJRdv2Di5lNur2bwFOp4krcPDxF1V2shokBWAKGs5
         oSSfKnwMhNDJbW99iEMuzXeFtBFowXzsw3oivHwTSPA0GraK3XGZ4BkbhBH5Vt7hTi9y
         4yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684736846; x=1687328846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2l9Y29vvbcuVlicsL/pc2oxU1nu4jLH8yjGCxlB3M8=;
        b=fKDEn0wFNXNhFpKBNXu7hH9n61voYWsAYuml+yskGQaG/eX9JXeLRhmEpf+JZ8MZi4
         Zso2TCwyXA1Dr3LJYNm2uPErHmtB3UDX2YEAktdKqYElHwpj9Y3BgpsN0Crx6zBz19G6
         wsivVSJ3C/BgM+hlEiRVZ6DwSOE58ejXmF/ZNS3Thtf4LntXwXXIUxC36Dxbuyl1Wm9k
         Ds5eWoyjV08ZAdnk9EUjpp3XWlWbPW5GI6ZHtlqt4H9Wuy0iIGiwmawuME691SWYYf0Z
         kaZrO0IXAwr4YdvbeRtwiRCFSQqMRLc72GFZzWgk9KJan9MtWi6YiBLHPmEI4S3kf9gV
         U3YA==
X-Gm-Message-State: AC+VfDye2UeYlpDLRE7xZhHF6QJ1D+W7lT89ZoIFtKlBSrDVC5dgPPyk
        0S94VYdtpicG71cV7qx0vCs=
X-Google-Smtp-Source: ACHHUZ5MuwmobKbV5DlqE1aoz3C+SGFqVC5v1CEELfybpKhKOgp9GXMPZTZQuW8ukxGiv7RfGmLkPQ==
X-Received: by 2002:a17:906:fd85:b0:961:78c2:1d27 with SMTP id xa5-20020a170906fd8500b0096178c21d27mr9002943ejb.19.1684736846224;
        Sun, 21 May 2023 23:27:26 -0700 (PDT)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at. [80.108.76.242])
        by smtp.gmail.com with ESMTPSA id kg17-20020a17090776f100b0096a6bf89259sm2594808ejc.167.2023.05.21.23.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 23:27:25 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/microcode: move microcode_mutex declaration
Date:   Mon, 22 May 2023 08:27:12 +0200
Message-Id: <20230522062713.427998-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.40.1
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

The microcode_mutex is only used when CONFIG_MICROCODE_LATE_LOADING
is enabled. Move it into the ifdef block.

Fixes a compiler unused-variable warning seen on gcc.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 3afcf3de0dd4..4f6ebadba2fb 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -49,20 +49,6 @@ bool initrd_gone;
 
 LIST_HEAD(microcode_cache);
 
-/*
- * Synchronization.
- *
- * All non cpu-hotplug-callback call sites use:
- *
- * - microcode_mutex to synchronize with each other;
- * - cpus_read_lock/unlock() to synchronize with
- *   the cpu-hotplug-callback call sites.
- *
- * We guarantee that only a single cpu is being
- * updated at any particular moment of time.
- */
-static DEFINE_MUTEX(microcode_mutex);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -323,6 +309,20 @@ void reload_early_microcode(unsigned int cpu)
 static struct platform_device	*microcode_pdev;
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
+/*
+ * Synchronization.
+ *
+ * All non cpu-hotplug-callback call sites use:
+ *
+ * - microcode_mutex to synchronize with each other;
+ * - cpus_read_lock/unlock() to synchronize with
+ *   the cpu-hotplug-callback call sites.
+ *
+ * We guarantee that only a single cpu is being
+ * updated at any particular moment of time.
+ */
+static DEFINE_MUTEX(microcode_mutex);
+
 /*
  * Late loading dance. Why the heavy-handed stomp_machine effort?
  *
-- 
2.40.1

