Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A227C602B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJRMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJRMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:46 -0400
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606ADBEAEE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:02:01 -0700 (PDT)
Received: by mail-pf1-f193.google.com with SMTP id 3so13866614pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jWVRhQ6epTs90NrUPxMtzvO66wlX5P0y7vobtFY478=;
        b=W2nXKLmnsDHbUSuk2LpzIXUTXX4hUBY3Idwx+XwNAgiW0jpc0HAhVYDMAmOTHhwNqI
         r0Wz7Sz+dt7K+IXNeSQplJUQ/E3LzQRtJc+jH+J9qYuh62Aracg8H2n5N7ro7R3OXFso
         qToU/EqXTVhjS3lbQlZCE1B5exdbeevtDLk07FZcbYN5qWMNMDEb5Fw1JNv6WcJOswdM
         s2chtN7D+LZdqLL+b4fCZogwtx66+Dui17Q0BxiyJfIVa8Yd3pOFWGXbg+8Yh09Hos3M
         MPGjOMnEexVDCH3vYjA7yHNCFoqrY7Ve/gNSmYZn5UK1QNQVeCcDK2A350b+eaxxF71y
         9kYg==
X-Gm-Message-State: ACrzQf1p8avJ4Fq3VUbZLGxEZqwU/sdnYCR12bsUgrScUcRnTL9xvpE2
        8aElov9QafOI/IObIN9OGQ==
X-Google-Smtp-Source: AMsMyM7Exzp+nxEFvLMo9bs7vX/L/rCLKQQpJYWVkCKjUCfsbuhMiCn4kc26F3Bv0fwTuMUUvVRH9A==
X-Received: by 2002:a05:6a00:1689:b0:557:9105:cf85 with SMTP id k9-20020a056a00168900b005579105cf85mr2851209pfc.55.1666094520961;
        Tue, 18 Oct 2022 05:02:00 -0700 (PDT)
Received: from localhost.localdomain (ns1002484.ip-51-81-243.us. [51.81.243.185])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm7893851pga.73.2022.10.18.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:02:00 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 3/5] ring-buffer: Remove add_ts_default to simplify code
Date:   Tue, 18 Oct 2022 20:00:54 +0800
Message-Id: <20221018120056.1321426-4-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018120056.1321426-1-sunliming@kylinos.cn>
References: <20221018120056.1321426-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable add_ts_default is not necessary when absolute timestamp is
removed, so remove it to simplify code.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/ring_buffer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ab0aef15f82a..cb261456216f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3666,7 +3666,6 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct rb_event_info info;
 	int nr_loops = 0;
-	int add_ts_default;
 
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
@@ -3688,10 +3687,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 
 	info.length = rb_calculate_event_length(length);
 
-	add_ts_default = RB_ADD_STAMP_NONE;
-
  again:
-	info.add_timestamp = add_ts_default;
+	info.add_timestamp = RB_ADD_STAMP_NONE;
 	info.delta = 0;
 
 	/*
-- 
2.25.1

