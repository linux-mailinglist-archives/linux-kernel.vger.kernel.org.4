Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9077C66C726
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjAPQ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjAPQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:28:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC72CFE9;
        Mon, 16 Jan 2023 08:16:14 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so22532389wms.2;
        Mon, 16 Jan 2023 08:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/E+8L2nNxeWkA6s3DUbOSQakN8jVIdhHcZDVIHwYps=;
        b=VR7Ib1BBKuYLVSp3WIWB4DRQO+8D4J76bPB7KlZ3Jt4l0TERYiSe7a4+8GA21ZG2+X
         co3XvgAsRR9S1UpfeVUfczUZe5h9Vtcsxbrq21VDtSv/J0yEFn99C64WLd5sdWH/MLPw
         HlkoN0CsB0JMfw7okqZwRUEbz5jPdzxuBPBVQUH98Ub6rIeUYxChkzLvzjfPCvrgLQwm
         F05PLtcBRkZgJbNvyXgbCmXDB4U/LVkh9F6r1IBWbQg/27hQ9ctCEV/UQ18EDT8uWAtM
         ZGNJex0qAGLce+9EFs2Ht8SUhFyoJk9YVCUAELtPhl92CxDYgVkkIdCoJcN2UMU62ffC
         k0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/E+8L2nNxeWkA6s3DUbOSQakN8jVIdhHcZDVIHwYps=;
        b=NfzrG4w2l0pQ5xnW0RyN3v4EOjhrzE99+AbzHbWZwooEiemY1Qp4nwXHgL9bgJRk96
         azAGMz2TX6W9mZkpCEbgcOcqe4V/r7mRh9gavUj0vnh/9qlkkconK5obY14s0qNFBrKz
         oZ/U4BidIMAGgB81f1Ln/MKlFYEbaIO4Z0dVtolDb9zx0gsei0DsH4zqrtNBFrRiqpyf
         +1mg5B2/HcMpEeQ5d3gIC/sOJokCFoQZLgO4eUjJewAhrzfWnFoSyeF+H9PAlqkDXKbM
         hRa0gKTT9G4CmL2KjNn9l/7rBzYVRnW0etAK6gbIQeoxnr5a2F+WvsKWrumHysfkJNe5
         2F9A==
X-Gm-Message-State: AFqh2kqDrwBj1Ej7Wckj8w4vt9pczlnzsdf7UrLXt0OI3dDJPf2ipurH
        J/zDVjgHdypyYiUQ9HmtcjrQm2nDiWfGZrsq
X-Google-Smtp-Source: AMrXdXsgdvbCYVjrLvXsZb1bY+dKxiaYrFzVfelXx3yOCP1qxGF3nM9FHiJjEyC4aQYxfnFmCmKhEA==
X-Received: by 2002:a05:600c:540c:b0:3cf:7704:50ce with SMTP id he12-20020a05600c540c00b003cf770450cemr7266wmb.38.1673885773414;
        Mon, 16 Jan 2023 08:16:13 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm32545526wmc.34.2023.01.16.08.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:16:12 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] rv: remove redundant initialization of pointer ptr
Date:   Mon, 16 Jan 2023 16:16:12 +0000
Message-Id: <20230116161612.77192-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The pointer ptr is being initialized with a value that is never read,
it is being updated later on a call to strim. Remove the extraneous
initialization.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 6c97cc2d754a..7e9061828c24 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -516,7 +516,7 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 	struct rv_monitor_def *mdef;
 	int retval = -EINVAL;
 	bool enable = true;
-	char *ptr = buff;
+	char *ptr;
 	int len;
 
 	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 1)
-- 
2.30.2

