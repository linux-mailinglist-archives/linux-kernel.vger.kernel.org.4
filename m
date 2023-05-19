Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE84570916A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjESIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjESIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:10:46 -0400
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CA10F;
        Fri, 19 May 2023 01:10:45 -0700 (PDT)
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-53467c2486cso1779539a12.3;
        Fri, 19 May 2023 01:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684483845; x=1687075845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=987mpInVG0PZHy5kjEzU+JieR5EpUHHUhR1GenDgCYU=;
        b=JAZLfwwxYWQ8KiHDAPJJ17/K9CKsxHzPdQxIZftfR/vyT7Nupvycv1hepDWbLbbyJT
         +EZIUtM1pBg/YlJDQzegC7KXrcxJV0KNzM/dIbQYfkvfmNnoHUFgJJXpcc+Mu7B26gYY
         BrBwwyNkdtMB2sh8oO0BRFqGqSjOxyiBLQny96OJnzlMX7djk8sKBIyXaJP5HQCPo8JU
         piWqBPzbg++kVwiFY1m++vz9sNlKBkrn/riGB90s0FITkhsyy3+8WNumTB2m9GL+q3XR
         1aX628bbCSU7RNXbA/OMjXRSxS6q7EyMup/2xm2SzeCjFVHXyFkOjTbJaxSt8AN8TfY2
         CL1A==
X-Gm-Message-State: AC+VfDz0YzGtbcRkhpKIZOHCERICI6j5Mseg5NyQ/78L6yHHz3RFJvn5
        uJNapJ9nFVKTFHpMjeEHe2hTfJtsr5vn
X-Google-Smtp-Source: ACHHUZ7iGK2EO49ZKc2WzlQ+7fTX0dt6vcfnJh76yzz+dgju2PZ2PAPvdyF8S+/4PkfLrBp4GkqxfA==
X-Received: by 2002:a17:902:f1d3:b0:1ae:4b45:27b2 with SMTP id e19-20020a170902f1d300b001ae4b4527b2mr1654059plc.20.1684483844624;
        Fri, 19 May 2023 01:10:44 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id jb20-20020a170903259400b001a1b66af22fsm2830041plb.62.2023.05.19.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 01:10:44 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, sunliming@kylinos.cn
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] racing/user_events: Prevent same address and bit per process
Date:   Fri, 19 May 2023 16:10:35 +0800
Message-Id: <20230519081035.228891-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User processes register name_args for events. If the same name are registered
multiple times in the same process, it can cause undefined behavior. Because
the same name may be used for a diffrent event. If this event has the same
format as the original event, it is impossible to distinguish the trace output
of these two events. If the event has a different format from the original event,
the trace output of the new event is incorrect.

Return EADDRINUSE back to the user process if the same event has being registered
in the same process.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..4ef6bdb5c07c 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1996,7 +1996,7 @@ static int user_events_ref_add(struct user_event_file_info *info,
 
 		for (i = 0; i < count; ++i)
 			if (refs->events[i] == user)
-				return i;
+				return -EADDRINUSE;
 	}
 
 	size = struct_size(refs, events, count + 1);
-- 
2.25.1

