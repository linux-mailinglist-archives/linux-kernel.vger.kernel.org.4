Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF892602B13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJRMDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiJRMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:57 -0400
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E858CE22
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:02:53 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id 3so13868664pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H25EslXoLm9NA6np/ZGYDcJiS+NnA+nx4L/XVPPvjI=;
        b=Y00ldFc/sSnQfZYYDt7aGs+O4XQJUQV6IeiYc2OiI8UVelOxaz/esfI5FSWXU3VKNx
         WVzQGcmhSByRaP8vqFkEUw8AF5YwK2JtNlmgRgZUkMcwRniAPw5mDlkOy5xOqgh2WK7a
         CTbGGDSZk6dk0zM/71dNdz0T7oE+cggEG8f/lkFHs2EoP1lrl4pA00hVctjW1UfjbDxo
         kqqob4qxMZf2BYvUtZOLW0ciwLaS6JLclu5JfKVJJQyeBw8c/LBpExWzWxfEKc4lQEJk
         KU8qVE9i0Mmus3GyZa+z4aUj8FFm/NDemrKbVODF9M/jIEqELoI1mS4wAAKtZY8/M4Ac
         5P1Q==
X-Gm-Message-State: ACrzQf0ch5YvcTUbV2S7pU/ikS29j2Wn84OQgpU880mC6VEPDYrFrPcP
        Xqu8dOaUUPO0vHdIRpmwGQ==
X-Google-Smtp-Source: AMsMyM6xASfErJnpjelEQ975LhMjTaj8jM0UqqPs2qjW50x5DyaezB7TaYz5sk09408asoycokcjxQ==
X-Received: by 2002:a05:6a00:124e:b0:565:ba3c:58bf with SMTP id u14-20020a056a00124e00b00565ba3c58bfmr2622233pfi.82.1666094573180;
        Tue, 18 Oct 2022 05:02:53 -0700 (PDT)
Received: from localhost.localdomain (ns1002484.ip-51-81-243.us. [51.81.243.185])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm7893851pga.73.2022.10.18.05.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:02:52 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 5/5] ring-buffer: Delete interface for setting absolute time stamps
Date:   Tue, 18 Oct 2022 20:00:56 +0800
Message-Id: <20221018120056.1321426-6-sunliming@kylinos.cn>
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

Commit efe6196a6bc5 ("ring-buffer: Allow ring_buffer_event_time_stamp() to
return time stamp of all events") make ring_buffer_event_time_stamp() have
the ability to return time stamp of all events. And there is no user about
this interface. So remove it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 include/linux/ring_buffer.h |  2 --
 kernel/trace/ring_buffer.c  | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 2504df9a0453..b7bcf2ee0945 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -186,8 +186,6 @@ void ring_buffer_normalize_time_stamp(struct trace_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct trace_buffer *buffer,
 			   u64 (*clock)(void));
-void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs);
-bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 
 size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu);
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cb261456216f..68947652e46d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -551,7 +551,6 @@ struct trace_buffer {
 	u64				(*clock)(void);
 
 	struct rb_irq_work		irq_work;
-	bool				time_stamp_abs;
 };
 
 struct ring_buffer_iter {
@@ -1876,16 +1875,6 @@ void ring_buffer_set_clock(struct trace_buffer *buffer,
 	buffer->clock = clock;
 }
 
-void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs)
-{
-	buffer->time_stamp_abs = abs;
-}
-
-bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
-{
-	return buffer->time_stamp_abs;
-}
-
 static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
 
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
-- 
2.25.1

