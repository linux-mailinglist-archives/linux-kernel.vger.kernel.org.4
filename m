Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2676F6BD9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPUJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCPUJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:09:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DA7D589D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:09:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id er8so563662edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678997344;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHN/Ln1IovZ6Hx9JhApOw2Gnmfs/AmjzfLFkuqocZX8=;
        b=WzkNFfBWBww8zzM1Q9L3W4zSLIp4uHv1k7rEusyoPJiN5VB4fZSviMv7b6O5b80V1t
         4E/T8j4z7ZToHHmuE0Nik+/7Jl5R0GZPCwxezRt87nYboGgFIOYz8LQy8a5tpyuMPVRm
         dVwaj3M5AW3eYnpKkUc7pvKn65dKq6dOqoArHsXurwdEF0QhrLGf0QUrAin55MSdhxoS
         FU+lt/V3o/XTR6CWJwzo2dvLai6GcL+m1YlJt66uMAXQWOYoqNTj6PT0gUnknQDXiKpA
         sIEzIjYHsLvRFyLYHNjwjd3JgtKxmyi8X/n712HALyOasXrwER6CayF3y92p9W4npP+s
         RIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997344;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHN/Ln1IovZ6Hx9JhApOw2Gnmfs/AmjzfLFkuqocZX8=;
        b=UT0xiKflaEkRLybcGloKlDaKHEP0iKK0bQm5/THrSFt3Zn9IfSNjtfRp5nps/1OTRB
         LLNRvJVxjgaHARn2WB+kNtY0WvuEb11NuYbCJYiw8qorZCk9uTcHOHLvpT4io8I+oj9x
         MpbaisQTJqEvvFZQr/lEZKKbnR5hL53g09MMd8sihlQrhx68sBnNWg8gFqprO7k0+IHE
         SWzG2DPCpceEr0eR2J+8e+4DDtUK4RyDewoCU5tE4eJ/SJpPdr8/FngjFnsWjeW6+CoM
         Qr9yu/rxbajeAFl68PA+EjM5cPSLAqB4Ji7Re4OksfWiAg4kERAqgWGBpzwOY4li0ap9
         fdsw==
X-Gm-Message-State: AO0yUKX5B4JzM8o9EZOFyOSgz8AyQXdovvIlM5IwePwodwNVSZ9g7oAM
        NZNvntufwfl+rPRpDcxc0NK+MNG9FmhKAqZS2N8=
X-Google-Smtp-Source: AK7set81oiNPrE8vkbeu7pQdjLkL8wD6hNrnulxVCL/MBkw4pJPubMpiV7nef1JMGKpn4Wn8Ip/4Ww==
X-Received: by 2002:a17:906:140a:b0:921:1c2c:48 with SMTP id p10-20020a170906140a00b009211c2c0048mr10677630ejc.49.1678997343861;
        Thu, 16 Mar 2023 13:09:03 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.53.192])
        by smtp.gmail.com with ESMTPSA id m14-20020a1709061ece00b008b980c3e013sm35935ejj.179.2023.03.16.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:09:03 -0700 (PDT)
Date:   Fri, 17 Mar 2023 01:09:00 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBN3XAsItCiTk7CV@khadija-virtual-machine>
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

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---

Changes in v8:
 - Fixed a spelling mistake

Changes in v7:
 - Fixed a grammatical error

Changes in v6:
 - Initialize module parameters in init instead of probe function.
 - Change the subject and description
 - Change format specifiers of module parameters to "%li"

Changes in v5:
 - Convert module parameters datatype from int to long.
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

