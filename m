Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350DD73173C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjFOLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbjFOLjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D363ABE;
        Thu, 15 Jun 2023 04:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E7D263968;
        Thu, 15 Jun 2023 11:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC8DC433C0;
        Thu, 15 Jun 2023 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829119;
        bh=vgy54zVLHfKxQrPWgzf6k7yx1TAALDUu5NoFA/xkWhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUhPuSYqUiTMj+9pyfE3aG8zYu3WmxXoBZLGb3qGB92QdtGT75nxfXlghtq8rIgBo
         7jHTvNWvI1i1hHEW3bzvfGJwmV9+92hxYtwbC9XNIqo4YLwSuAvwfMzlxvZDqoy5zA
         VR/6OM3STrmrRNHG1to3oOgaXFyi/nrg53B81ULJwdDDwY6hQuRjYEEgqW4P9I2UJw
         oQzAd8Y/iURuHVU4h4zGmcdfAwp8RrYtFX46t5aurc/zuHrWnxdZaxThRkAy4KlB4f
         e80pGgq37VOHMi39oljxdgMjDltadn3MI6oKx685bM0ydi8KFSjpV6+CE7E0z600I3
         zr1OcHZjw9PmA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/16] media: cec: core: disable adapter in cec_devnode_unregister
Date:   Thu, 15 Jun 2023 07:38:08 -0400
Message-Id: <20230615113816.649135-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113816.649135-1-sashal@kernel.org>
References: <20230615113816.649135-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit fe4526d99e2e06b08bb80316c3a596ea6a807b75 ]

Explicitly disable the CEC adapter in cec_devnode_unregister()

Usually this does not really do anything important, but for drivers
that use the CEC pin framework this is needed to properly stop the
hrtimer. Without this a crash would happen when such a driver is
unloaded with rmmod.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/core/cec-adap.c | 5 ++++-
 drivers/media/cec/core/cec-core.c | 2 ++
 drivers/media/cec/core/cec-priv.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 4f5ab3cae8a71..ac18707fddcd2 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1582,7 +1582,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
  *
  * This function is called with adap->lock held.
  */
-static int cec_adap_enable(struct cec_adapter *adap)
+int cec_adap_enable(struct cec_adapter *adap)
 {
 	bool enable;
 	int ret = 0;
@@ -1592,6 +1592,9 @@ static int cec_adap_enable(struct cec_adapter *adap)
 	if (adap->needs_hpd)
 		enable = enable && adap->phys_addr != CEC_PHYS_ADDR_INVALID;
 
+	if (adap->devnode.unregistered)
+		enable = false;
+
 	if (enable == adap->is_enabled)
 		return 0;
 
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index af358e901b5f3..7e153c5cad04f 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -191,6 +191,8 @@ static void cec_devnode_unregister(struct cec_adapter *adap)
 	mutex_lock(&adap->lock);
 	__cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false);
 	__cec_s_log_addrs(adap, NULL, false);
+	// Disable the adapter (since adap->devnode.unregistered is true)
+	cec_adap_enable(adap);
 	mutex_unlock(&adap->lock);
 
 	cdev_device_del(&devnode->cdev, &devnode->dev);
diff --git a/drivers/media/cec/core/cec-priv.h b/drivers/media/cec/core/cec-priv.h
index b78df931aa74b..ed1f8c67626bf 100644
--- a/drivers/media/cec/core/cec-priv.h
+++ b/drivers/media/cec/core/cec-priv.h
@@ -47,6 +47,7 @@ int cec_monitor_pin_cnt_inc(struct cec_adapter *adap);
 void cec_monitor_pin_cnt_dec(struct cec_adapter *adap);
 int cec_adap_status(struct seq_file *file, void *priv);
 int cec_thread_func(void *_adap);
+int cec_adap_enable(struct cec_adapter *adap);
 void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block);
 int __cec_s_log_addrs(struct cec_adapter *adap,
 		      struct cec_log_addrs *log_addrs, bool block);
-- 
2.39.2

