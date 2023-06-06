Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF5723874
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjFFHLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjFFHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:11:08 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41392C5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:11:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BDD43601AE;
        Tue,  6 Jun 2023 09:11:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686035465; bh=UJK34aq/lMucjhp/a7/aUCCcSIOTJuKOc3zJhvpqDX0=;
        h=From:To:Cc:Subject:Date:From;
        b=oDhWwwPRXn2uDir6vnNDGoUYZCRa+F7dlRNW0WmR8pB4icDGJ/6lEMBdzHoiNKMkI
         RISqX4RK/EiNVE1AWm3UGXGC52ArzYkdCxc8N4xQqSCJOeGnqHLg8hZ3OmaTL3psf+
         MpIsyEtZ49RMRk8nrLARHisBjrGm0VMaogwTkmbsxJ6OCqr60Pk/X1RNfWhSrTlJ8e
         +VgERmsUkQEYX1ueppI8GWn3lJ3TWuw6gXY0LFO58l/Z4uz+GMbfPUfNJfo5Xj17z/
         pB+YbZJU2EDupeAO9RBPirpnnVy+HRH6pWPLlEUNNlJFtHXrahw5eVVVKZqnZn6iVi
         OYhGm5MjkerGA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uUg_2SDxUHnf; Tue,  6 Jun 2023 09:11:03 +0200 (CEST)
Received: from defiant.. (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 74DAD601AC;
        Tue,  6 Jun 2023 09:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686035463; bh=UJK34aq/lMucjhp/a7/aUCCcSIOTJuKOc3zJhvpqDX0=;
        h=From:To:Cc:Subject:Date:From;
        b=O15qSqTKKP14s7UI4/49Xm8k+X71oE/uB6zkgtUgj5tsVv8Y4puiwXzRzKXWnD1WV
         JMz2JKf+G4fXkvRhil0rrAEK69ybGH98GNLqJ2PlUP3u5zDcpxzCi2He7MSqcFddte
         VOWsFtDSFk6277kV7j6A7qHYn2wAyKbm6CEgX+m/ySxnT/D7Hk4AidXVD/Tku2EMp+
         iEiyvk5yKdOAhcFm9yOU2YnFvlK33jgN92Witj+pD/FfjxrOkn+aJzZ7VlNE8MEbde
         dfdNJqbYHu5P4bOCrSuVcCzrDJy6jBM3vhWhmi0UEyRmQs9mnMbr/Nyn2NfrLdQvyg
         W0cIQAnlOlMFA==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
        Scott Branden <sbranden@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/1] test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
Date:   Tue,  6 Jun 2023 09:08:10 +0200
Message-Id: <20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FILL_THIS_FORM,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of situations like

	name = kstrndup(buf, count, GFP_KERNEL);
	if (!name)
		return -ENOSPC;

the error is not actually "No space left on device", but "Out of memory".

It is semantically correct to return -ENOMEM in all failed kstrndup()
and kzalloc() cases in this driver, as it is not a problem with disk
space, but with kernel memory allocator failing allocation.

The semantically correct should be:

        name = kstrndup(buf, count, GFP_KERNEL);
        if (!name)
                return -ENOMEM;

Cc: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>
Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
Fixes: 0a8adf584759c ("test: add firmware_class loader test")
Fixes: 548193cba2a7d ("test_firmware: add support for firmware_request_platform")
Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 v1 -> v2:
    - minor clarifications in description and subject line
    - added Fixes: lines
    - added Cc: to authors of the fixed commits
    - removed Cc: stable as suggested

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

