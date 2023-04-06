Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108AD6D8D92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjDFCkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjDFCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:40:14 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D76A1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:40:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 52C4B604ED;
        Thu,  6 Apr 2023 04:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680748812; bh=6iwS9N1f6yrv/fRw39XrCWuxjT36x9tRB2CPp+lKkJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hArmBPqdR26Dnktm4X4gsuV7iRzcf0d4rwHyNceBMzE48kG0mhIaMhI5SzOG5oE4p
         EYcohcFuOiEwPvJ9gM/Zxnd/bCMr5ysWkRQmnXzj+RquKimXbokyJCDUApAdxiSmQi
         bzu6yjbhCkZJq+WZvGDGqPBS4+5rroghTxcvVXYUlGX6XP5Il137UKRNdC4NKYyD8v
         /L3Z99Wg5KPC8hB4WHkh0LekBfTrkhU7+Smq2duZLRxtgSKtH04vtqgW3GXIdH1JP8
         EyaRGFvlJ1+lT/jwhpgLfu95xuZtc5CBP0/VmdCJs6EQYYtz1pBlUgmh98d1ithVEZ
         dWs1He3A7XGCg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YXHVEz7GHrb0; Thu,  6 Apr 2023 04:40:10 +0200 (CEST)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 291A5604EF; Thu,  6 Apr 2023 04:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680748810; bh=6iwS9N1f6yrv/fRw39XrCWuxjT36x9tRB2CPp+lKkJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6/mxp6Jpy2wUOPN2PBz8o/HiaUMgegmeEJrcGbp4Q9rlJcyOw2QYBeZFsm5mWh0S
         ouhEOuuyZOh7SJ0sNkWpcKnQbmU3YMaBaFDrFz867N/wUqPpVENPDgPhDs6+N2k/8P
         vsVwgUb/bh0bb67FNaCvjv22Llomkx/bMQe4qiKW3OvIVVPkyRDNJuQQF6w2SGV/cj
         R/90jI/OxkfyBCmCPc/zPDdzUJrRupHv85e1tK/tRtL6ao8YpGGMLYrT+NbH4sex8x
         +Wy+MlYFCXUr6rVEGM6MyC8j2Lhfbd5KyUkwrnXxjwGEabgS/E6pXL7ZqqGfWmMdK0
         f+XusOOXRYxDg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 2/2] test_firmware: fix memory leak in trigger_batched_requests_store()
Date:   Thu,  6 Apr 2023 03:53:19 +0200
Message-Id: <20230406015315.31505-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
References: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
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

trigger_batched_requests_store() and trigger_batched_requests_async_store()
both caused test_fw_config->reqs ptr to be overwritten with the new call to
either function and the vzalloc() call, leaving the old memory object
unreferenced.

Semantically the most simple and prudent solution seemed to be returning the
-EBUSY errno in this case, rather than permitting a kernel memory leak.

However, this did fix closed only these obvious leaks, not all that are
present in the test firmware loader.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Tianfei zhang <tianfei.zhang@intel.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-kernel@vger.kernel.org
Suggested-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 lib/test_firmware.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 272af8dc54b0..b81f5621626e 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -919,6 +919,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -1017,6 +1022,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
-- 
2.30.2

