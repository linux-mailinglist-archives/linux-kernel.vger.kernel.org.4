Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAE6BD584
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCPQ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCPQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:26:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CDFDCF74
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:26:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so9968915edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678983978;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tq9EloIOrvY5/fg4afrdweAWwminMwCYXdVtfBekJJE=;
        b=cw3rjSEGK+0p/49S3Xj1+e7O2ekfejgTU5RjO5XdZQtqtn33Yh/B3oKpY3XDhJwkV4
         yFRH45tK1yixf57tFZwFOAmujjqqwUrBSAOQvu83BrSCZEbBC3PDC4BnswQt5YSAOYxd
         eywb4L+27uqmoQIZeb5Yn2uSV+yUvXyix+TUlWALlSn1GI3mzVQmHrGXrjnDPzzpMtTV
         bKRILpSGTVSvJd1YGmIhz8ZT05cW6BKCxvZqhAAE5sm4yzeiRw3+hkzyOt+hSWcxQreo
         AfLUeOwBxxpMHJd7gL8ujcycVPG3mXvY7lhCOzLopMAQU7C78g7lhB87qc8UZqgb381H
         gJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983978;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tq9EloIOrvY5/fg4afrdweAWwminMwCYXdVtfBekJJE=;
        b=xioxvKqzXX/Wj5ffM2yfMZ+UCF07uH8P/DT13zjDsOXxPzVQeneYXt8JW5dDBTZoGo
         qtndd1lOB6zTxiPM0QlKryKa54kUtLkUlHdhbzeQ2UOZvSL8uEpnmWCfY4B5v1ekkR7e
         i/ik/hyEH4pGtvq/X49N9Ly7EQTO8H09IIjy3zGX/ah7Zm0bbAcTIrNY+S03D/hDFtFC
         T1riJz1R3yc2WPXapgteb38WFNnVgGQ8UhpUCFkxjXxBvjKGRe0RjF73v2bwdVhS+ns0
         PI0OhkyLhzbeksPU54F+DXrc7gDwY+PLo/J5ahUAveFCi+/nDkNL7khm1M7YWag+c87z
         qTWA==
X-Gm-Message-State: AO0yUKVwi/sbrt6r0Ss61iam+lc46iU7Gojw4uj/vnGG1pUpj6ljabAu
        qe+zMvWvF/Q0hsS2+POtP3HcUZ5RhnT8xDRr
X-Google-Smtp-Source: AK7set9Vw7B+XWw8ayTWXYyKCvtT84Uld87Ok1F8mAjj713LfTnYbPEZxxmNfkipMvifLKsr+DgUxQ==
X-Received: by 2002:a05:6402:1507:b0:4fa:4a27:adba with SMTP id f7-20020a056402150700b004fa4a27adbamr164329edw.22.1678983977591;
        Thu, 16 Mar 2023 09:26:17 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id g24-20020a50d0d8000000b004fd29e87535sm4052660edf.14.2023.03.16.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:26:17 -0700 (PDT)
Date:   Thu, 16 Mar 2023 21:26:15 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBNDJwFHE3vIFS3+@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the module parameters, read_timeout and write_timeout once in
init().

Module parameters can only be set once and cannot be modified later, so we
don't need to evaluate them again when passing the parameters to
wait_event_interruptible_timeout().

Convert datatype of {read,write}_timeout from 'int' to 'long int' because
implicit conversion of 'long int' to 'int' in statement
'{read,write}_timeout = MAX_SCHEDULE_TIMEOUT' results in an overflow.

Change format specifier for {read,write}_timeout from %i to %li.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---

Changes in v6:
 - Initialize module parameters in init instead of probe function.
 - Change the subject and description
 - Change format specifiers of module parameters to "%li"

Changes in v5:
 - Convert module parameters's datatype from int to long.
 - Link to patch: 
 https://lore.kernel.org/outreachy/ZBMR4s8xyHGqMm72@khadija-virtual-machine/

Changes in v4:
 - Initialize timeouts once as suggested by Greg; this automatically
   fixes the indentation problems.
 - Change the subject and description.
 - Link to patch:
 https://lore.kernel.org/outreachy/ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine/

Changes in v3:
 - Correct grammatical mistakes
 - Do not change the second argument's indentation in split lines

Changes in v2:
 - Instead of matching alignment to open parenthesis, align second and
   the last argument.
 - Change the subject and use imperative language.
 - Link to patch:
 https://lore.kernel.org/outreachy/ZAxNYw2rFQkrdtKl@khadija-virtual-machine/

Link to first patch:
 https://lore.kernel.org/outreachy/ZAZSmPpB6fcozGa4@khadija-virtual-machine/

drivers/staging/axis-fifo/axis-fifo.c | 28 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..0a85ea667a1b 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -103,17 +103,17 @@
  *           globals
  * ----------------------------
  */
-static int read_timeout = 1000; /* ms to wait before read() times out */
-static int write_timeout = 1000; /* ms to wait before write() times out */
+static long read_timeout = 1000; /* ms to wait before read() times out */
+static long write_timeout = 1000; /* ms to wait before write() times out */
 
 /* ----------------------------
  * module command-line arguments
  * ----------------------------
  */
 
-module_param(read_timeout, int, 0444);
+module_param(read_timeout, long, 0444);
 MODULE_PARM_DESC(read_timeout, "ms to wait before blocking read() timing out; set to -1 for no timeout");
-module_param(write_timeout, int, 0444);
+module_param(write_timeout, long, 0444);
 MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timing out; set to -1 for no timeout");
 
 /* ----------------------------
@@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
 			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-				 (read_timeout >= 0) ?
-				  msecs_to_jiffies(read_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			read_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
 			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				 >= words_to_write,
-				 (write_timeout >= 0) ?
-				  msecs_to_jiffies(write_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			write_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -948,7 +944,17 @@ static struct platform_driver axis_fifo_driver = {
 
 static int __init axis_fifo_init(void)
 {
-	pr_info("axis-fifo driver loaded with parameters read_timeout = %i, write_timeout = %i\n",
+	if (read_timeout >= 0)
+		read_timeout = msecs_to_jiffies(read_timeout);
+	else
+		read_timeout = MAX_SCHEDULE_TIMEOUT;
+
+	if (write_timeout >= 0)
+		write_timeout = msecs_to_jiffies(write_timeout);
+	else
+		write_timeout = MAX_SCHEDULE_TIMEOUT;
+
+	pr_info("axis-fifo driver loaded with parameters read_timeout = %li, write_timeout = %li\n",
 		read_timeout, write_timeout);
 	return platform_driver_register(&axis_fifo_driver);
 }
-- 
2.34.1

