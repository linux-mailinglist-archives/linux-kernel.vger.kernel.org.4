Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256F96E67B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDRPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDRPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:00:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61797;
        Tue, 18 Apr 2023 08:00:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fl25-20020a05600c0b9900b003f17b89ddfbso678604wmb.2;
        Tue, 18 Apr 2023 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681830020; x=1684422020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sLNEn4tBiA7Lkr9LNv5/UOC0rrF3XRNRmsS5gVdI9k=;
        b=sImgZb1wcOoQgjNgCvJtfJlnGv2KUSccaVn8vuk+DKUNMXDz5u8gM7IwEVmH4EqxEP
         I59BYxMb/1tGKNV27f5bgVgWINug3yBDTvjZFBa8rkQUTG4sPb42bvR5D33QtLz9pFsL
         ioTZTnyGFeBIDrfurqt5bt7OPoYHzKVTfAyj+z+cDmN1nxkwxZ68T4dHX11Hdv5VaLLQ
         sqeRIhJkg3mI1CfQtC5bStKYu1Vwcw/XzE5DZ3lRmI09KyRRfD1Z2dfsXhNb91L81YBY
         8XtpmDrkC4d4zk6R8d/zskRUU+3y/v62hH67SOIsB4WJ6J6KhW07ynVGtTdLqpQWBnTm
         +U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681830020; x=1684422020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sLNEn4tBiA7Lkr9LNv5/UOC0rrF3XRNRmsS5gVdI9k=;
        b=apRSuPj4Dwch27mpVYAUOINKuHSlnLtQ3E4t4WsjCcqbDeWI0STE/wGSqc6YHUVnOl
         2bLKU4ZnAbFrAFEoIruyGm01TF372NOrEsz+jiBmuQwsoO7fbj2zYv+QqI3N3ld5zLHD
         z5jTHLcB0XpxdQKzRBYOlIKK8Q1jU/6Jmw90adh6spZxJpQfZnE/d3i2QkCpQid6GiaS
         VqcEXZYrTL4KkFxVrHpxTBMdVzEt851ZKpwQsNrWBVTqjuY8TDKoe2mCtcRBswHfjYnc
         jVj9GoLoNO6n6H7b6gpVtcKG9WCV+ykYUCNg5AbwoS0A/01cDY26qtiBbf/0IAX/2Tie
         hTBA==
X-Gm-Message-State: AAQBX9drwUGfCRZqicUWac9tZpTRFUQ93P7BzdrC+c7SCivAR9/wQ6iT
        q/WuYv0uGFKl2SrV2el74F0=
X-Google-Smtp-Source: AKy350ZeeEfRz/61M2eIo6oFMHMHMc4ozqTmwr70hcLoN4Y/jtiuwghQgqPcULSL3FXlozxnZ7zcyA==
X-Received: by 2002:a7b:c40c:0:b0:3ee:5519:fae1 with SMTP id k12-20020a7bc40c000000b003ee5519fae1mr14216520wmi.12.1681830020331;
        Tue, 18 Apr 2023 08:00:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003f177cda5ebsm3160137wmg.33.2023.04.18.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:00:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] rv: remove redundant assignment to variable retval
Date:   Tue, 18 Apr 2023 16:00:18 +0100
Message-Id: <20230418150018.3123753-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable retval is being assigned a value that is never read, it is
being re-assigned a new value in both paths of a following if statement.
Remove the assignment.

Cleans up clang-scan warning:
kernel/trace/rv/rv.c:293:2: warning: Value stored to 'retval' is never read [deadcode.DeadStores]
        retval = count;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/rv/rv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 7e9061828c24..2f68e93fff0b 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -290,8 +290,6 @@ static ssize_t monitor_enable_write_data(struct file *filp, const char __user *u
 	if (retval)
 		return retval;
 
-	retval = count;
-
 	mutex_lock(&rv_interface_lock);
 
 	if (val)
-- 
2.30.2

