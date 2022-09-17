Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219795BB57A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 04:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIQCE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 22:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIQCEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 22:04:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42C4BD118
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 19:04:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso1480516pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 19:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O+FIio6F6Ys8FBmVz4T0afCK9bRS+Qa/vDTw2yhOvu8=;
        b=HvqeBkQZ12yau4o1p4emYOFo9Wtma4Gh0/I52ysNYy9+x1M+bIiH93n0rUzaJa7k97
         Rcxjmwtg2JMY5nfB9GvR6LkWBvZeDf6v0spq+ka0rycytEVp/Tk8GJu1pTU00zlh6/W+
         0oLM5W8odWAOWMnaVI6xq+6Lnpw0qZC3Um5kdCVLrZdj+uiioawhbCpJ0p+LvGYdrwDf
         xxlPQFjKK7sMhwiso6M/Oly2AY+KhZKKd3yF6GEO6phegsrODuBiG1w0yNexRyThQvht
         e9WASIqxxE6lkY0qlIhd11pL6Jn0pUU7B5hbv5aKnX1DQ5dp5mKQzAynxGXodrJ6RbZm
         51Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O+FIio6F6Ys8FBmVz4T0afCK9bRS+Qa/vDTw2yhOvu8=;
        b=TgMUNK13dzxGjxDG6QHLdOlD8rpwp5TXT6+WY75AR18ifnr+sFa9MUSJAiZesY3Zil
         HwQyC8SNhTOvYUMT8p6JMBeUylFTGlZB/GMfvC0zBLBvN2rZ4/DIZt+XsnBEmcVgdXEl
         Fmc+5hJYf0VIWi2oxOn0hTnvqZpKaXPJaCTHgRwvph8qhfnTPBKTOnS3y4+dykbPJRC1
         vqeprjcmMje9WbSJfH7/z2oQNhZxTwrTvFeXyVX1Pxf4Qf0vQGW+bTHydGqljB1azoRZ
         110Riz42TS5kaq2U/v/Mq9jP+IFg7iG0Hv+Lu5tNKcgV2jn4XSxjmjhz2sZDLOU3fDq4
         T5Sw==
X-Gm-Message-State: ACrzQf1lLkKnbCsNFTz1veElme7REuYP4UwN9pirYrkvzgfnoWsKdfZf
        0JzRN4i8WyOOKCrL1YE6+q1WVUUG88HpzA==
X-Google-Smtp-Source: AMsMyM5M9UUbdU/XWMWjAm8z/fw7jvFZK2GacApIMM2guNdlt51nfjbT6DN5S+eWMulnGRCtxGayzA==
X-Received: by 2002:a17:902:f548:b0:178:44b:4ea9 with SMTP id h8-20020a170902f54800b00178044b4ea9mr2616760plf.77.1663380255845;
        Fri, 16 Sep 2022 19:04:15 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id z18-20020aa79912000000b005484d133127sm6213790pff.129.2022.09.16.19.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 19:04:15 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, rostedt@goodmis.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] kernel/trace/trace: check the return value of tracing_update_buffers()
Date:   Fri, 16 Sep 2022 19:03:53 -0700
Message-Id: <20220917020353.3836285-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of tracing_update_buffers() in case it fails.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3005279165d..0e367e326147 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3305,7 +3305,8 @@ void trace_printk_init_buffers(void)
 	pr_warn("**********************************************************\n");
 
 	/* Expand the buffers to set size */
-	tracing_update_buffers();
+	if (tracing_update_buffers() < 0)
+		return;
 
 	buffers_allocated = 1;
 
-- 
2.25.1

