Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB266980C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbjAMNHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjAMNHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:07:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A96A0F7;
        Fri, 13 Jan 2023 04:55:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q64so22360258pjq.4;
        Fri, 13 Jan 2023 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsWWNsdpNjTB2VBSLYn0Vv+ThteiHXaE0eF90drIroU=;
        b=jw/U1HdoO/Dz+am38/OqoBsoLg8BR61wM+jUsPnDaNkAwE4B29eGhePNvtzmWj6wVJ
         /Q4gnAs9UG13D61PNbzgLjoQNerqrRraS1tOJS9Pctu+WtTFmXDaP5lCXituOuJeybmd
         nSxGE+ijE/XA0IsRNAoz4mD8malCkNhOr8kqE0x7xDmvj0ptadlv9ddhEKJRgIUw4Adv
         EFrhHdaCPXAxb2IkLhw0aEZGlIP30hv9QQokcjEmAbywqcVTuEhNjHnTLFdTo2N1DBJM
         uXh8AY04VBMNsVaUerOS+NLzuDCMdYOcLq8J/UmvRRbyDmQZMQ7oMdQ7VsXCsCixbCHm
         raLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsWWNsdpNjTB2VBSLYn0Vv+ThteiHXaE0eF90drIroU=;
        b=Dsvz6JJab5dKmIDdIFxywhM1+xl+7OiswVQCr4ZtHNAER675ixEMHxKeN/G3qjkxUi
         /o+nAeJKkeABgrW9SZX/9XKIigO3HeSz7ZUc9iPiv8PI2VwrUwaTt/Nw6CJcvtAlp3MJ
         +vEnO+wfKznhRMM7r8ljgecfpbvCrLMuMu4YSNen9ziAZzejbvoenRVrzmnZ1ZubswCt
         EA8KyX0MlP67Ia4suQSqg0avL/qYSHBfoARg+PO1nVb22I7q2acK2sb9qbfLvgcJEwyH
         p59I27qric9a0fKPK8fGmZv2LQJCdL+IJLEzy5MnZd55kfbioPJTEXeAlbce48eCbezH
         uNTw==
X-Gm-Message-State: AFqh2kpn92DJ8s4dVNvT2OK59hc1J4xbnXH14IjCwEIu5QCUmh2IOLMe
        X7BFn+3tqzgZ66LtijBx8Jo=
X-Google-Smtp-Source: AMrXdXva7g6vrlLuNHV4hwIZ2OcqM1hopd7TzibCfqtIM/fCw2eOLHrOlykDH+DDFAryNRpkT9FBjA==
X-Received: by 2002:a17:90b:215:b0:225:bf26:4928 with SMTP id fy21-20020a17090b021500b00225bf264928mr82095085pjb.38.1673614537773;
        Fri, 13 Jan 2023 04:55:37 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.142])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a284200b0021952b5e9bcsm14287494pjf.53.2023.01.13.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:55:37 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] trace: Add NULL checks for buffer in ring_buffer_free_read_page()
Date:   Fri, 13 Jan 2023 20:55:01 +0800
Message-Id: <20230113125501.760324-1-baijiaju1990@gmail.com>
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

In a previous commit 7433632c9ff6, buffer, buffer->buffers and 
buffer->buffers[cpu] in ring_buffer_wake_waiters() can be NULL, 
and thus the related checks are added.

However, in the same call stack, these variables are also used in
ring_buffer_free_read_page():

tracing_buffers_release()
  ring_buffer_wake_waiters(iter->array_buffer->buffer)
    cpu_buffer = buffer->buffers[cpu] -> Add checks by previous commit
  ring_buffer_free_read_page(iter->array_buffer->buffer)
    cpu_buffer = buffer->buffers[cpu] -> No check

Thus, to avod possible null-pointer derefernces, the related checks
should be added.

These results are reported by a static tool designed by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
---
 kernel/trace/ring_buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c366a0a9ddba..45d4a23d6044 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5626,11 +5626,16 @@ EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
  */
 void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data)
 {
-	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_data_page *bpage = data;
 	struct page *page = virt_to_page(bpage);
 	unsigned long flags;
 
+	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
+		return;
+
+	cpu_buffer = buffer->buffers[cpu];
+
 	/* If the page is still in use someplace else, we can't reuse it */
 	if (page_ref_count(page) > 1)
 		goto out;
-- 
2.34.1

