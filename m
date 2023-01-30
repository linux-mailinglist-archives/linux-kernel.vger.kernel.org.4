Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BC6818A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjA3SU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbjA3ST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:56 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F33D096
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:47 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id l7so3610651ilf.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zzfg2bQz7c4Lu8nEbe0ztijhF1MDO6gwSQkkAUdaXs=;
        b=dmwVKpndVGSPOlMA/VgslRy1ADofot5yp07aOLyY9jXTSZcsSneVlwFSDFj0CE5724
         oI/cyicC+vcD2yb/HjemHEX5yLv5dEBWoEL3jle5pKfIh0+mwcKT9uIb12rZGMz4s4SU
         E3EM3F019eEjjTS1fosUInp5XbLpSSmqRMmi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zzfg2bQz7c4Lu8nEbe0ztijhF1MDO6gwSQkkAUdaXs=;
        b=qdHTmjBFtYXE3HTvuM3R+9NDuSj6XmJu0ZUBEPX3fmpDgy+yRIvpjcMdUY51znIlD/
         WdavjOrefvHfu2VcPIAE1tOQ2I16CSFBduy0huBG7vKl2BUnwWjvFLN3CxsF6XXEDMxk
         d8leujR2LjyBOKS9dDcXjjEhClp95otxz0lnlkvSNRuBuJg/odgYwa7SXP25xJ7XZBvo
         AXXE6dYroO338ChiwAIt5+pThxRGXikeYDc3EknYMfcXj544k01b6v0IPNDOP778rHK9
         Ow76wmt+elDX60sG+F09yHgOCzaIOqmaRUO+RHnOmvCCkBtkhkjFz5daZgG1DWAjDVgy
         H7Pw==
X-Gm-Message-State: AO0yUKWMXSs76Pn4QDrQ2G9EyDuOeDn4s6dhP6+VPW5MtoAmliOme/p4
        wi+v2Fw/YTSyBNa7BnW4ruVxfyi768gl63RI
X-Google-Smtp-Source: AK7set+ky9CHQsy21ct37ZLpWjENrtFy5wpnLexQn1n3RC31YGc9290nOHzz+0kP9SR0o/XTPU1x7Q==
X-Received: by 2002:a05:6e02:144c:b0:311:478:f273 with SMTP id p12-20020a056e02144c00b003110478f273mr1692297ilo.11.1675102787162;
        Mon, 30 Jan 2023 10:19:47 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:46 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 9/9] tools/kvm_stat: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:15 -0700
Message-Id: <20230130181915.1113313-10-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
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
2.39.1.456.gfc5497dd1b-goog

