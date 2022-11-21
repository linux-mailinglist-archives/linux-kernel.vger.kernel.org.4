Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD48631AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKUII6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKUIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:08:51 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF482165B2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:08:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so4158558pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctzOaxaAqUph8NY0exPI9fEfZOLZGp5hg2p+b/QRssE=;
        b=KN3b37Ytia5wSuCz2QSXTAaiZbNm4/cnqhN8yPeNbPDdsHxlqAwx61CEagM5n8uSEJ
         33yO1yGeBq9VBNl+5UWa7YqniTRmqkb27J8IuKA5+Fb/HJwZnS1L4K8Fvl6JUtSN9X8S
         VUchU5umNRq0uAjYx8FET0BMrzHqqfK2bksAh1GER/ngds1mA5rcgpAf7t/Gq+q2PT2p
         4CbTQvpj511arCvwfTxO43IFEMpJ187SKn4abM/3L0q7tVCiEZ2UgHi/sLWHG5gaV3sm
         8x62zURvIRN7RcmiXE3ocSlQaincr5pi/WDX2sV2+rznkDu9MR+9JPiLfjxDee/zVEQu
         6vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctzOaxaAqUph8NY0exPI9fEfZOLZGp5hg2p+b/QRssE=;
        b=HjA0LBl4Rg+4hj/otz/FxQstnwxZiKhGUE+t9wURx9wa/kXzROOlGiIxa0958zyuCl
         FZJKp9jOFFg0GC8manXi/lgFiOZ6Kzbn5oKaol6JOM6U7eM5y8oVBPmQA71RngSXOPzv
         8BgmguyKRO0+/ZHFrmtlDWfuJiJWIoMqc+WlE4J7brnPthXZxYtAT99y6JD4KrLQI0+F
         R0BeIO65WkWRqEVijghdFIEjQ+FWaxppU4tPpY7ebsUABynpTvARoL2/rxJ7OOZWYJ0E
         BLrDq3+E+ntvTcXbMea9VbcOKjfwR/e0xa4NOxIYcsCJSg1UId8OIZ1KszAVruMGu9G9
         +/Jg==
X-Gm-Message-State: ANoB5pkiqY/sL7Jh/IlEb5ZROlqbX1rERmkGsnKDGWS6H4FZ7XCIVWTm
        onSTltH5sOEYbHdTOf2yVcaDp8z/lAs=
X-Google-Smtp-Source: AA0mqf70XZR8CQp0u90f/M8l0BV+uwjhbs2OfT0Ah/22jNxxFNCCBj0Q/k4MPiTWdmL/Qru1f0FPzw==
X-Received: by 2002:a17:90b:1d45:b0:218:6db5:fd98 with SMTP id ok5-20020a17090b1d4500b002186db5fd98mr20273666pjb.164.1669018128222;
        Mon, 21 Nov 2022 00:08:48 -0800 (PST)
Received: from localhost.localdomain ([47.242.114.172])
        by smtp.gmail.com with ESMTPSA id bh6-20020a17090b048600b00218847a356bsm5929506pjb.9.2022.11.21.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 00:08:47 -0800 (PST)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/perf: Use strndup_user instead of kzalloc/strncpy_from_user
Date:   Mon, 21 Nov 2022 16:08:31 +0800
Message-Id: <20221121080831.707409-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses strndup_user instead of kzalloc + strncpy_from_user,
which makes the code more concise.

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 kernel/trace/trace_event_perf.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 61e3a2620fa3..05e791241812 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -251,16 +251,12 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 	struct trace_event_call *tp_event;
 
 	if (p_event->attr.kprobe_func) {
-		func = kzalloc(KSYM_NAME_LEN, GFP_KERNEL);
-		if (!func)
-			return -ENOMEM;
-		ret = strncpy_from_user(
-			func, u64_to_user_ptr(p_event->attr.kprobe_func),
-			KSYM_NAME_LEN);
-		if (ret == KSYM_NAME_LEN)
-			ret = -E2BIG;
-		if (ret < 0)
-			goto out;
+		func = strndup_user(u64_to_user_ptr(p_event->attr.kprobe_func),
+				    KSYM_NAME_LEN);
+		if (IS_ERR(func)) {
+			ret = PTR_ERR(func);
+			return (ret == -EINVAL) ? -E2BIG : ret;
+		}
 
 		if (func[0] == '\0') {
 			kfree(func);
-- 
2.37.2

