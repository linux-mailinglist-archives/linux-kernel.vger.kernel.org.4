Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414F173E0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFZNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:35:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D581E60
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:35:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa99742be2so8281715e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687786512; x=1690378512;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSXSrL5SBC6uysg7fDXpV4R+sOE/vGqBgFIZWIbj7pw=;
        b=EDg/JYJGZHQwgJsLcFq9/ITSErd0gEgwbs2B4EI87mfwR+DHdGWPwKDMv96ICBrWM4
         WqFunED0vhQtUzVRkuue+yeasq5UfMt+tCQb64KjCfQOaHx/ZBopTIlpSZqdCxdlVVff
         ohEobd+9qAxavA6NVYulWWiCbgLdb12y2VmU9/5Vc9rBOcjdHWaieY8Rm+VrF+WMUkpa
         JhHcnCU4tVj8s3SN1dgNsC2VAv59kUZxtH1zpBvcrASH8tImi/R6hx076/3JKSBF1BFo
         kE0LxRzEhDCEiegJ7Pf8uHAe/Uk50OQACxhG8bh0XWCn6DkcLcHyWE6XacRHV8Pm0KTr
         syxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786512; x=1690378512;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSXSrL5SBC6uysg7fDXpV4R+sOE/vGqBgFIZWIbj7pw=;
        b=WGCKODlph3qafiF1n7XcznuGsJBqiu5KN21DRqJvsbn9oLLWw3mkIswyCTK3L25XFr
         rvhn8KZhZXURGAzFvTMnaa5g0yi9Tpxk6y3Q5WCc1r0uBUrmVl1guryhDzw2RkRX9Sjf
         A/xculdXbmDcovSRIqpnzpeR1fnFv8jxcFHe1rV6PANwdzkG9xulEtoejswiz3UyDpYq
         Q9Gcgi51pdF81QjSWpX4SlYKZhtWWCEyodg9qznkqSN+EoCKkXkpfixZ8IuGog/pJTSv
         +v8ZScXwgZY4XF8+4EjZjMGowHx3cAHAzPH4LinBkYE6EeLmDYgQzvL0XNlR8eUHDTyo
         oqkw==
X-Gm-Message-State: AC+VfDzw7ExFhe5eD3VFyaSfbAJlzhxUn+51oStlgBBtubslXQkkBSDS
        rc6yJ6YGz+nmUzOsuSDUm8JQkQ==
X-Google-Smtp-Source: ACHHUZ7WdbGtDIPRhHdOfpa04nv2W0iY1lsc6UFWYGvhTfoDiKA98kj0m9x9EYimTM6Ba0V8jGNOxw==
X-Received: by 2002:a7b:ce8a:0:b0:3f9:8c3:6805 with SMTP id q10-20020a7bce8a000000b003f908c36805mr21926578wmj.7.1687786512617;
        Mon, 26 Jun 2023 06:35:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b003fa9a00d74csm2125136wmo.3.2023.06.26.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:35:10 -0700 (PDT)
Date:   Mon, 26 Jun 2023 16:35:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tracing/probes: Delete dead code in
 trace_eprobe_tp_update_arg()
Message-ID: <f657e0c7-46c3-4e8f-a472-35ec98229660@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was recently refactored and now the "ret" variable is always
zero.  Delete the check for non-zero.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This code was changed in 1b8b0cd754cd (tracing/probes: Move event
parameter fetching code to common parser)

 kernel/trace/trace_eprobe.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index cb0077ba2b49..b5181d690b4d 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -797,10 +797,7 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 		return ret;
 
 	/* Handle symbols "@" */
-	if (!ret)
-		ret = traceprobe_update_arg(&ep->tp.args[i]);
-
-	return ret;
+	return traceprobe_update_arg(&ep->tp.args[i]);
 }
 
 static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
-- 
2.39.2

