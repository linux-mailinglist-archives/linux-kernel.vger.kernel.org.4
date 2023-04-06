Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB856D8CED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjDFBqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjDFBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:46:43 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291C729B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:46:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2E41B604ED;
        Thu,  6 Apr 2023 03:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680745598; bh=7gR9b1/jHxuRqJoe09x+E/k2KTBJTWA8CRBAC0RautE=;
        h=From:To:Cc:Subject:Date:From;
        b=MyndSgiCAD/vVHTTf0/fc+RGYboQSxt7IORW0hy1Q2oVMsIT1+6vJGuUx/TOzXUzR
         +SwpUiMcng8qjQ5niW66D/o96zRwDQa2B5ftMgrQ502eAfUDYUPlSuiDhHBNuDvF7y
         5r7y6/p5EfjAewG83YBBpDbux/RmGFQzM1Q59ky0suq2o/Gi8AejkDmcNjX057nlaA
         c5zKLrWKzJMsz5UUGKSaiKuRCobxFijC0mTZZfOvgaAaSmj8ZUPXk8beDPVjvK6hvj
         kFluan4EngQuFvzctpaPyzL+DV/JXQLNXWw9HvJ1EW4W8dw9Q3FXo450DI5soLxUmP
         LiZfm7xGUkyGQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id whKfdZ4Z2Dov; Thu,  6 Apr 2023 03:46:36 +0200 (CEST)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 2826D604EF; Thu,  6 Apr 2023 03:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680745596; bh=7gR9b1/jHxuRqJoe09x+E/k2KTBJTWA8CRBAC0RautE=;
        h=From:To:Cc:Subject:Date:From;
        b=Li7H4LzmaibgVaTZZxB/xo1NLZg8ktDcCg9FQEDHFefKydb7dMaLxf4h+SUHD9kOB
         Fc3puyGd7U1xAziahi/5FAv3OIqmGQi151FWIaDNssDAuapm7hQ4pU1+lzLkxG/9k4
         /jCufV4j+0bOF4Z9rSxg8UCI3lU2foMCrNzgJ9avlQagdV4Qk7hkzZ8oWvdAU3OtBD
         nSB+cjk/NRC2abDMWgGQZF7VuGMXh0U8fuwoNrTGkV1wtxPaMhFKmD/kZeD4B/BaMP
         EbMZ5vZn47RypZ4EwgUnKgwgevLbPx/pctaVRZU0rBNZNzurgi7notNnjJjTMpgmKS
         /LgzWZtlx6kgg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v3 2/2] Revert "lib/firmware: fix a memory leak with multiple calls of trigger_batched_requests_store()"
Date:   Thu,  6 Apr 2023 03:43:24 +0200
Message-Id: <20230406014324.31171-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d59ff9027c628f0e9be344b28f3576566a274f2f.
---
 lib/test_firmware.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 51377b9ab6e3..454992bfdb2a 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1036,11 +1036,6 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
-	if (test_fw_config->reqs) {
-		rc = -EBUSY;
-		goto out;
-	}
-
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
-- 
2.30.2

