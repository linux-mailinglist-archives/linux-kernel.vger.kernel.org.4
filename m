Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CACF6CF8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjC3Bxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjC3Bxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:53:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B09F;
        Wed, 29 Mar 2023 18:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6159B82581;
        Thu, 30 Mar 2023 01:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA94C433EF;
        Thu, 30 Mar 2023 01:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680141209;
        bh=3XmANaFzBt3a+2sASRW3pZzJKWGwytosBj+PU3cNreY=;
        h=Date:From:To:Cc:Subject:From;
        b=vBpMJ4k4UCgp74JR3KKcFqw9mZDJn651IODDcgfoSH2hVylUD6bbLyLUTq23qYkLS
         o718vQ/9nOb+TcuEbi9fRfq26mS3I1l8Z5ztvcZJetA8asvxeqbQ+qJGbgT9tWcX4N
         zOuz1BZxX6+xqHdJpJscAfZjhyPBXEK0nflyuNgUqCfCpo9l/5m19fgp/VzMb8RiUA
         VeR5nzuJsAw9J6o3vIKtboOWRVq4HU3tVnGA0YL4lP7TKC3mkyqkd/WT+pio3FTNd3
         sU5dKfZAN7XjBTZCirUCBQ+bRcn23bRSQ7ZoDVD688i2NaMZ/rSAM1XReEQPlDNqMe
         YaV7a3Ur/53vg==
Date:   Wed, 29 Mar 2023 19:54:02 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Message-ID: <ZCTrutoN+9TiJM8u@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC-13 (and Clang) does not like having a partially allocated object,
since it cannot reason about it for bounds checking.

Notice that the compiler is legitimately complaining about accessing
an object (params, in this case) for which not enough memory was
allocated.

The object is of size 20 bytes:

struct ec_params_vbnvcontext {
	uint32_t                   op;                   /*     0     4 */
	uint8_t                    block[16];            /*     4    16 */

	/* size: 20, cachelines: 1, members: 2 */
	/* last cacheline: 20 bytes */
};

but only 16 bytes are allocated:

sizeof(struct ec_response_vbnvcontext) == 16

In this case, as only enough space for the op field is allocated,
we can use an object of type uint32_t instead of a whole
struct ec_params_vbnvcontext (for which not enough memory is
allocated).

Fix the following warning seen under GCC 13:
drivers/platform/chrome/cros_ec_vbc.c: In function ‘vboot_context_read’:
drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript ‘struct ec_params_vbnvcontext[1]’ is partly outside array bounds of ‘unsigned char[36]’ [-Warray-bounds=]
   36 |         params->op = EC_VBNV_CONTEXT_OP_READ;
      |               ^~
In file included from drivers/platform/chrome/cros_ec_vbc.c:12:
In function ‘kmalloc’,
    inlined from ‘vboot_context_read’ at drivers/platform/chrome/cros_ec_vbc.c:30:8:
./include/linux/slab.h:580:24: note: at offset 20 into object of size 36 allocated by ‘kmalloc_trace’
  580 |                 return kmalloc_trace(
      |                        ^~~~~~~~~~~~~~
  581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  582 |                                 flags, size);
      |                                 ~~~~~~~~~~~~

Link: https://github.com/KSPP/linux/issues/278
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/platform/chrome/cros_ec_vbc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index c859c862d7ac..b5a584f5469a 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -20,10 +20,14 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct cros_ec_device *ecdev = ec->ec_dev;
-	struct ec_params_vbnvcontext *params;
 	struct cros_ec_command *msg;
+	/*
+	 * This should be a pointer to the same type as op field in
+	 * struct ec_params_vbnvcontext.
+	 */
+	uint32_t *params_op;
 	int err;
-	const size_t para_sz = sizeof(params->op);
+	const size_t para_sz = sizeof(*params_op);
 	const size_t resp_sz = sizeof(struct ec_response_vbnvcontext);
 	const size_t payload = max(para_sz, resp_sz);
 
@@ -32,8 +36,8 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
 		return -ENOMEM;
 
 	/* NB: we only kmalloc()ated enough space for the op field */
-	params = (struct ec_params_vbnvcontext *)msg->data;
-	params->op = EC_VBNV_CONTEXT_OP_READ;
+	params_op = (uint32_t *)msg->data;
+	*params_op = EC_VBNV_CONTEXT_OP_READ;
 
 	msg->version = EC_VER_VBNV_CONTEXT;
 	msg->command = EC_CMD_VBNV_CONTEXT;
-- 
2.34.1

