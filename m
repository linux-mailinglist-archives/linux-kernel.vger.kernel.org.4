Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176C6660C4A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 04:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjAGDqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 22:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGDqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 22:46:07 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E7A479F4;
        Fri,  6 Jan 2023 19:46:06 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s67so2429453pgs.3;
        Fri, 06 Jan 2023 19:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5qWs5TiJGPW/EDw2KXWPEsaSCWYGVrAbslcVFl/3Fs=;
        b=ENOpYNSHLdAw8M7jVxZB36nReGHj1lYS24BKg3kFkBwK8ulOg3Pm9toeeS/Hi9t0Wd
         8qazqF0YRhSFRo/IHR6B0lofhKUECIGpVQl4IpZBgY8aG4iXlYkaeCKXG2vqpvjjh+cD
         ZlC8g0/jno0r2vAmUVYhHkMMsod79vob9vmZrC4o7aqOKegqKtcRwKTFv4625k7jYUOt
         qRbMIaRPtDoTN7e/bo6k6S/y17bo+uWdWYlsAYy0fo8WCH7rCw2DO/NwhItbRUefXniY
         QQUJIud7vFlnVSccMoNrPHh6tXvxd1SNcvicU1NSAf++SypGt+SSxJ4T/cdyYW3xhgEA
         I44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5qWs5TiJGPW/EDw2KXWPEsaSCWYGVrAbslcVFl/3Fs=;
        b=a1p1gyGLssG6IOSHJUPAs+XJNfg1cVix/ZEl1lYuoS/FUARPCE+YBhVByHhbchxVX3
         8NZ9cbi2k/0Q+2qHWsg7B46Yd6WeI+K6T46BNOZjVs2gmQiSGHZDd3/ai6p9KJ5aZDBB
         Tcv34EQ+25aL56gdglmhGKBrhcHq3AYYkcv+mgEz7HncrA+IUpjn/FMaB7OJU155y6i8
         6xya/uuBfrF6saJS/4zKTNsaA7rCOInzxmflnQOd2NbJY4+xA8pPVE6jmVxpx6UBFxVa
         Dz/Eg2m0S8OPUK+cwoxxSHIwvcJXNWzcCa+A4TXanJB0Kzwe7Oq0ejE5BrmTVI6G7dTD
         beCQ==
X-Gm-Message-State: AFqh2kpQgkcVJ8uxYgVkoCmBcqrZTidLvnOL05LHilRvC003K5qMCPCu
        wS1MhKEQcoo98LVdWkeng9qwjEdLI1jlLA==
X-Google-Smtp-Source: AMrXdXuR1f31pwTbK0sCnbcwpIHLCVlNIyMugsZvi/LSaGtkdI0bkMgkpj2w0VaXnyVG337iMubWUw==
X-Received: by 2002:a62:19cd:0:b0:580:9935:ffdb with SMTP id 196-20020a6219cd000000b005809935ffdbmr45809242pfz.20.1673063166296;
        Fri, 06 Jan 2023 19:46:06 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79882000000b0057447bb0ddcsm1802669pfl.49.2023.01.06.19.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 19:46:05 -0800 (PST)
From:   Quanfa Fu <quanfafu@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Quanfa Fu <quanfafu@gmail.com>
Subject: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
Date:   Sat,  7 Jan 2023 11:45:57 +0800
Message-Id: <20230107034557.1156022-1-quanfafu@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Since this memory will be filled soon below, I feel that there is
no need for a memory of all zeros here. 'snprintf' does not return
negative num according to ISO C99, so I feel that no judgment is
needed here.

No functional change intended.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
---
 kernel/trace/trace_eprobe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 352b65e2b910..cd1d271a74e7 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
 	for (i = 0; i < argc; i++)
 		len += strlen(argv[i]) + 1;
 
-	ep->filter_str = kzalloc(len, GFP_KERNEL);
+	ep->filter_str = kmalloc(len, GFP_KERNEL);
 	if (!ep->filter_str)
 		return -ENOMEM;
 
 	p = ep->filter_str;
 	for (i = 0; i < argc; i++) {
 		ret = snprintf(p, len, "%s ", argv[i]);
-		if (ret < 0)
-			goto error;
 		if (ret > len) {
 			ret = -E2BIG;
 			goto error;
-- 
2.31.1

