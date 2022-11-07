Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8861FFB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiKGUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiKGUqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:46:10 -0500
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 12:46:01 PST
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A69CDF29;
        Mon,  7 Nov 2022 12:46:01 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 34930E0EAB;
        Mon,  7 Nov 2022 23:39:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Mo1IoZxL2Rc3as4wkOOmjS2i89Ql8ugECSEPpbB7MWg=; b=HSnlfG0Qw9cV
        EUSsAE5gB5l5RsG7gI/yi6CDe4s5N3vm3ieRL+4mVVTCib1v3Qe8hMYO5JyK1oeM
        DkkeZ/pjHPRUfJvXkjb7UBvC3jPj7K8/3mGzx0DIQTljXbUrP99lf9FO/oXxLaBO
        3BSmLZTy88JYSOFHHyVMBYOXodfcWjI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EE6EAE0E1D;
        Mon,  7 Nov 2022 23:39:51 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:39:51 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Sagi Grimberg <sagi@grimberg.me>,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Date:   Mon, 7 Nov 2022 23:39:44 +0300
Message-ID: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with [1] the DMA-able memory buffers must be
cacheline-aligned otherwise the cache writing-back and invalidation
performed during the mapping may cause the adjacent data being lost. It's
specifically required for the DMA-noncoherent platforms [2]. Seeing the
opal_dev.{cmd,resp} buffers are implicitly used for DMAs in the NVME and
SCSI/SD drivers in framework of the nvme_sec_submit() and sd_sec_submit()
methods respectively they must be cacheline-aligned to prevent the denoted
problem. One of the option to guarantee that is to kmalloc the buffers
[2]. Let's explicitly allocate them then instead of embedding into the
opal_dev structure instance.

Note this fix was inspired by the commit c94b7f9bab22 ("nvme-hwmon:
kmalloc the NVME SMART log buffer").

[1] Documentation/core-api/dma-api.rst
[2] Documentation/core-api/dma-api-howto.rst

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks the NVME-part of the patchset has already been merged in
Link: https://lore.kernel.org/linux-nvme/20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru/
This modification is only leftover of the original series. So I've resent
it as a separate patch.

Link: https://lore.kernel.org/linux-nvme/20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- Convert to allocating the cmd-/resp-buffers instead of cache-aligning
  them. (@Jonathan)
- Resubmit the patch separately from the original series.
- Rebase onto the kernel 6.1-rc3
---
 block/sed-opal.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 2c5327a0543a..9bdb833e5817 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -87,8 +87,8 @@ struct opal_dev {
 	u64 lowest_lba;
 
 	size_t pos;
-	u8 cmd[IO_BUFFER_LENGTH];
-	u8 resp[IO_BUFFER_LENGTH];
+	u8 *cmd;
+	u8 *resp;
 
 	struct parsed_resp parsed;
 	size_t prev_d_len;
@@ -2175,6 +2175,8 @@ void free_opal_dev(struct opal_dev *dev)
 		return;
 
 	clean_opal_dev(dev);
+	kfree(dev->resp);
+	kfree(dev->cmd);
 	kfree(dev);
 }
 EXPORT_SYMBOL(free_opal_dev);
@@ -2187,6 +2189,18 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 	if (!dev)
 		return NULL;
 
+	/*
+	 * Presumably DMA-able buffers must be cache-aligned. Kmalloc makes
+	 * sure the allocated buffer is DMA-safe in that regard.
+	 */
+	dev->cmd = kmalloc(IO_BUFFER_LENGTH, GFP_KERNEL);
+	if (!dev->cmd)
+		goto err_free_dev;
+
+	dev->resp = kmalloc(IO_BUFFER_LENGTH, GFP_KERNEL);
+	if (!dev->resp)
+		goto err_free_cmd;
+
 	INIT_LIST_HEAD(&dev->unlk_lst);
 	mutex_init(&dev->dev_lock);
 	dev->flags = 0;
@@ -2194,11 +2208,21 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 	dev->send_recv = send_recv;
 	if (check_opal_support(dev) != 0) {
 		pr_debug("Opal is not supported on this device\n");
-		kfree(dev);
-		return NULL;
+		goto err_free_resp;
 	}
 
 	return dev;
+
+err_free_resp:
+	kfree(dev->resp);
+
+err_free_cmd:
+	kfree(dev->cmd);
+
+err_free_dev:
+	kfree(dev);
+
+	return NULL;
 }
 EXPORT_SYMBOL(init_opal_dev);
 
-- 
2.38.0


