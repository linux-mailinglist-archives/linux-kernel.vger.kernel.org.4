Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072487091C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjESIht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESIhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:37:47 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B8C2;
        Fri, 19 May 2023 01:37:45 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-64d2467d640so1597603b3a.1;
        Fri, 19 May 2023 01:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684485465; x=1687077465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=987mpInVG0PZHy5kjEzU+JieR5EpUHHUhR1GenDgCYU=;
        b=MsUT7WZUb5YdMB5UfmC224fC0FcSpWPwUn+VOdC71Yk7vcxkoB+8m8HeLvHxy0EOAn
         1ZKX+222RbQ9cGGTBPReXrOajSp+QZpc07NlxT/lJMdr42i17FauBHwUqOKIZTYO6a3b
         xShKoqGyDR/fFBhKVafBGXswrxRt/s2U7SjyO5A+oerwqGwTIk3qt7fCdcLR36mdN3ml
         XrxEFFdhP2Z2S3MrPs6GODGhqap+4wf5goXHy1FulernUtIj7qFaEQ7WBedIul5iK8ER
         +Ro/dpuDNxoKd6cwGI7z5em4qMFtZpzVZrpMlKzdcDmng9fu5GpPEPsu3Rgz5JNwH1Bj
         J0Rg==
X-Gm-Message-State: AC+VfDzUzDRiq1fMBaPM6oANNFqIEE4MaOpx2lfTmWEZwQPxUQ7W05bK
        VGwelgKLbgyJN2Ks1DCDDg==
X-Google-Smtp-Source: ACHHUZ58aIFVREO0uE6opjgnkNbCYwTgasZHWRUgSz/Ah30xUr81YOqzO9z/t7t7gtw51A8uAeAYBg==
X-Received: by 2002:a05:6a20:3950:b0:100:9969:8cf with SMTP id r16-20020a056a20395000b00100996908cfmr1488553pzg.49.1684485464718;
        Fri, 19 May 2023 01:37:44 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id h4-20020a63c004000000b005346b9a7fe5sm2565367pgg.22.2023.05.19.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 01:37:44 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, sunliming@kylinos.cn
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH RESEND] tracing/user_events: Prevent same name event per process
Date:   Fri, 19 May 2023 16:37:40 +0800
Message-Id: <20230519083740.232401-1-sunliming@kylinos.cn>
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

