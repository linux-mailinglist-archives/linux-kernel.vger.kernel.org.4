Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B38722C7A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjFEQ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFEQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:29:31 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58332CD;
        Mon,  5 Jun 2023 09:29:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8A6FB60246;
        Mon,  5 Jun 2023 18:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1685982567; bh=WOFBObb7fNZ6dNK1wt7KbaxyzDpH4Lj4Oddwsx60Ejk=;
        h=From:To:Cc:Subject:Date:From;
        b=FLpxxZB53bNHq4SmNCdFWGEkxdJX1NQ50mpTZRKeWauPZ6pswEiGn0p/6bAdqPqiU
         t2nwo4qNbc4LcdUEKIqir53/lNH3u3XrrqXSwUzYnvoMt4WC4nK1XYUm1iHVoL2Gfy
         mofUB9PRRYLSi66v7bJBJjCzkQQ/8ynzEx0MpN+R8IZ6SIS0sioOlLT6uYGHuR9aj2
         hpBsP6aEnG7D1KpOMGwmxGCgbfobhQXXlohRRWQeN9DZ8x8owcTfVHtN9zoJzFdJo+
         TmO9XUBy3cTiq8REPKh+/dl+pW30bAGreoBIZCQxqUIJjtHz6bfi3j2urR0Mmn/YW3
         ZEXD5pGaCoKAw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kdB2rX-AJi90; Mon,  5 Jun 2023 18:29:25 +0200 (CEST)
Received: from defiant.. (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 5603A6023F;
        Mon,  5 Jun 2023 18:29:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1685982565; bh=WOFBObb7fNZ6dNK1wt7KbaxyzDpH4Lj4Oddwsx60Ejk=;
        h=From:To:Cc:Subject:Date:From;
        b=h9RrNejkayeLnip/IpcM2zC44UDnsI6CHA7owAxW79J1v7lS5ycQW4jiC4M06mlX9
         xJjJGURGqcQ5UQo+DWKvkZSNoegmzlPuIIx1C4yR24vWzec382gyz7osHS7EhVJhG4
         tOuOeN5Aa6DXavZAMXWzMoLT4QJGe0BkYaceN/QDFPVpQWgNU8MAejQkQO14M0rx26
         pdHvFK/4JN24nPiqsWpfja+sYJ2K3XHMEEGtqTG7z9i1GTdGje8qKDDoDb5rCwXzQe
         KSAQgZ5A6TP6/cFQzT4ZMb9wTy6KCtYAMVLnhS6paXmHs4xtNlJu1qGVrTZ9EEdZUD
         LDXiX5Y49M0uQ==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v1 1/1] test_firmware: return ENOMEM instead of ENOSPC on failed allocation
Date:   Mon,  5 Jun 2023 18:27:47 +0200
Message-Id: <20230605162746.614423-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FILL_THIS_FORM,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of situations like:

	name = kstrndup(buf, count, GFP_KERNEL);
	if (!name)
		return -ENOSPC;

the error is not actually "No space left on device", but "Out of memory".

So, it is semantically correct to return -ENOMEM in all failed kstrndup()
and kzalloc() cases in this driver, as it is not a problem with disk
space, but with kernel memory allocator.

The semantically correct should be:

        name = kstrndup(buf, count, GFP_KERNEL);
        if (!name)
                return -ENOMEM;

Cc: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 lib/test_firmware.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 1d7d480b8eeb..add4699fc6cd 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -214,7 +214,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -671,7 +671,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -719,7 +719,7 @@ static ssize_t trigger_request_platform_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("inserting test platform fw '%s'\n", name);
 	efi_embedded_fw.name = name;
@@ -772,7 +772,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -817,7 +817,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
@@ -868,7 +868,7 @@ static int test_fw_run_batch_request(void *data)
 
 		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
 		if (!test_buf)
-			return -ENOSPC;
+			return -ENOMEM;
 
 		if (test_fw_config->partial)
 			req->rc = request_partial_firmware_into_buf
-- 
2.34.1

