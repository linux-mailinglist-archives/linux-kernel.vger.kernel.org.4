Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095036B6862
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCLQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021813E08E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678639621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aq3TEq6gMO/54SF3iFz3GDnLmsdqOfZlgKAyUVosWkE=;
        b=B4vD4I0tGKhNvvrgmQo9fs10GjTI/L5/nxbuXLVEO4m/U6fHTNjJMH+sZlXZRx3/nyepJ2
        C7wUujh5P784pN0tef3XMNHqkuaSggET2CT0SMNyT65K79PkY4cDhe+pNLt9ORTpAgXoO5
        RgglVhm4Y7o87V300PaRTS2CmL9hG6w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-cLM3dsyJNWOEtsuUZdb2Ug-1; Sun, 12 Mar 2023 12:46:54 -0400
X-MC-Unique: cLM3dsyJNWOEtsuUZdb2Ug-1
Received: by mail-qt1-f198.google.com with SMTP id k13-20020ac8074d000000b003bfd04a3cbcso5695857qth.16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678639613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aq3TEq6gMO/54SF3iFz3GDnLmsdqOfZlgKAyUVosWkE=;
        b=Ogac5XfWqrHdbCWxRAJsnlXnX1CZuf27dvvpd/jYI5uTntKe0r+5UQp6cxoc7qsGc1
         akqiZwdtk/aB/D3z3iOWiCO9NG/RUBUFH0Vxzbus7aldTMWSQ4lLtBCMghzKbfNAebeD
         lgoFlZsVaXwR+u/hwGpNM48IlaA82mjxJKdEpGGuIDAUrMdjLGHNdJhTf8Ju4oLJuqnJ
         Lv+SmW19Hygx5TpeYRBHpYC/8PUVyzuFJ7R4I+NfICFknynKcFrA0NWxc739JiDis1dw
         ZfDJcV3V83mgsBjZEJ1nfnk0gxs6rfiw8zdgDmd4eHHnnC+2gk38UsnuTRqQI45b3/Jy
         +bpg==
X-Gm-Message-State: AO0yUKV0C7Iegq+993D0syMXCYlrn/BH8S9FMRO3k7HUd5MoVa9O/IJI
        wZuLET/79pTggW7lXNCy5H+SjAryJCN6wP3ranNiFWkJIPxGnMIxCXDQuswQ8GTz81UGlFS/bRT
        LL8LR5IOKEtO/tENvVLcZY0lm
X-Received: by 2002:ac8:7c4f:0:b0:3bf:d974:8ad5 with SMTP id o15-20020ac87c4f000000b003bfd9748ad5mr20090974qtv.61.1678639613537;
        Sun, 12 Mar 2023 09:46:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set+E2G5ifKW1D7prnPEIp+831ufaDl25jApEazP+eWPPhM9XjPq++iVYXn6q1WGwCWsYEYOehA==
X-Received: by 2002:ac8:7c4f:0:b0:3bf:d974:8ad5 with SMTP id o15-20020ac87c4f000000b003bfd9748ad5mr20090956qtv.61.1678639613309;
        Sun, 12 Mar 2023 09:46:53 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a13af00b0073917fae4f8sm3751948qki.25.2023.03.12.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 09:46:53 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     pmladek@suse.com, akpm@linux-foundation.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, john.ogness@linutronix.de,
        linux@rasmusvillemoes.dk, ben.dooks@sifive.com,
        fuyuanli@didiglobal.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] kernel/hung_task.c: set some hung_task.c variables storage-class-specifier to static
Date:   Sun, 12 Mar 2023 12:46:45 -0400
Message-Id: <20230312164645.471259-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports several warnings
kernel/hung_task.c:31:19: warning:
  symbol 'sysctl_hung_task_check_count' was not declared. Should it be static?
kernel/hung_task.c:50:29: warning:
  symbol 'sysctl_hung_task_check_interval_secs' was not declared. Should it be static?
kernel/hung_task.c:52:19: warning:
  symbol 'sysctl_hung_task_warnings' was not declared. Should it be static?
kernel/hung_task.c:75:28: warning:
  symbol 'sysctl_hung_task_panic' was not declared. Should it be static?

These variables are only used in hung_task.c, so they should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/hung_task.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 322813366c6c..9a24574988d2 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -28,7 +28,7 @@
 /*
  * The number of tasks checked:
  */
-int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
+static int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
 
 /*
  * Limit number of tasks checked in a batch.
@@ -47,9 +47,9 @@ unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_
 /*
  * Zero (default value) means use sysctl_hung_task_timeout_secs:
  */
-unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
+static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
 
-int __read_mostly sysctl_hung_task_warnings = 10;
+static int __read_mostly sysctl_hung_task_warnings = 10;
 
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
@@ -72,8 +72,8 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
  * Should we panic (and reboot, if panic_timeout= is set) when a
  * hung task is detected:
  */
-unsigned int __read_mostly sysctl_hung_task_panic =
-				IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
+static unsigned int __read_mostly sysctl_hung_task_panic =
+	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
 
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
-- 
2.27.0

