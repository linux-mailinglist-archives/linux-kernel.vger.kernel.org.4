Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8901A6DE9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDLDdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLDdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:33:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F030CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:33:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso10292921pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681270420; x=1683862420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uORCuChqwLHpOxIbmgNJnio3yJBiEdHJ+lWbTU5t64=;
        b=EY+T4dWr20dwDkfIfDkqK5o56CYiz4LwEfmJpb0SPfOVQcgdlDGRxPoPhzpe9nhs2I
         X9zx1XtdEqsX00yIlgoI2O0Ks8eXdahMZqMEx3gLZsRCQn5gurfFQz1abmI9Bfv2soDk
         W/HP3vprqx5lDD5w6TDWcqIcK++O6cI0L2P2T680tHYlcb9qMRS1HIRfhqEy/2OH0qEk
         itiifvd2SbG5hYD+Nae+/tiey7VoNdNQaa3jFoc3KEroqGSCIDTNnx1z9OQAMdVnvo5g
         WFqks0Z96WiMP/SBm5URB89pPkclBWGqHfp9Q7P+Iu2TiIfbi6018Wk5bcDznWouaRv+
         9V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681270420; x=1683862420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uORCuChqwLHpOxIbmgNJnio3yJBiEdHJ+lWbTU5t64=;
        b=UTjhShyP6jgf2NijdmXQFa8O+x95uKpQU01Wy3X8NqaRe9QcrZZoCLpH6clzP8JgV+
         zl3IL9lIRwCxv+3zXoprnL4TF8xvLUhNkgofi2IAp+Am67TSNZFbPtOyJkmVGClalcZA
         gGFQy7DXQIcNTz4YFN/iqQGFdZu8QP16Xq+VM7ZmGSXfI/djNFCDuPJjCuebZeQ9zE0v
         UDKHozPc5VHex9IsGCWz4jvYNXh5LzvU3HdnD2z/WphrX24VTA5dKp96tXyszUTBfEuB
         aQOoiVBCBqT61FvPNf6BeR4jnsC9zB6M21wLBKJL1NGSLjDWET0OEJl0u+Yv4OYREOxk
         XyKg==
X-Gm-Message-State: AAQBX9dpVEN/etWBenifF94d74zXr9jInQlzXE0+xVy4k5tgG3m/oHgt
        sZVrZs5vILOLq+gquHgDVzXmtZCILuU=
X-Google-Smtp-Source: AKy350ZbJZZCiKk16AIojU3xiHZrRyc+NyDKl5JXSo7FSKABAywGcw8P2iH+mr9t5BQYq8pkjyruSw==
X-Received: by 2002:a17:90b:1a85:b0:23d:10f2:bda2 with SMTP id ng5-20020a17090b1a8500b0023d10f2bda2mr22489817pjb.30.1681270419930;
        Tue, 11 Apr 2023 20:33:39 -0700 (PDT)
Received: from mi-HP-Pro-Tower-480-G9-PCI-Desktop-PC.. ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id bf2-20020a170902b90200b001a64ed4621csm2930603plb.182.2023.04.11.20.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 20:33:39 -0700 (PDT)
From:   Chuang Zhang <zhangchuang1909@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        zhangchuang3 <zhangchuang3@xiaomi.com>
Subject: [PATCH] BINDER:Allow tracing of binder_txn_latency_free
Date:   Wed, 12 Apr 2023 11:33:32 +0800
Message-Id: <20230412033332.342521-1-zhangchuang1909@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangchuang3 <zhangchuang3@xiaomi.com>

The author forgot to EXPORT and need Export
binder_txn_latency_free trace point.

Signed-off-by: zhangchuang3 <zhangchuang3@xiaomi.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fb56bfc45096..320cf08805d4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6604,5 +6604,6 @@ device_initcall(binder_init);
 
 #define CREATE_TRACE_POINTS
 #include "binder_trace.h"
+EXPORT_TRACEPOINT_SYMBOL_GPL(binder_txn_latency_free);
 
 MODULE_LICENSE("GPL v2");
-- 
2.34.1

