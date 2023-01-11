Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF46652E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 05:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjAKEjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 23:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjAKEie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 23:38:34 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C807640
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 20:38:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9EA3E4245E;
        Wed, 11 Jan 2023 04:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673411911; bh=3mwbRHlRhjEn6d7ialc4jgg5I5MLJj7InHbf8EL6vA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gtOdbdn7hRKNeJrKJRvmsoB4h2WV3TdpgzrVGVcpQ+O/RUW4pAwhiS3d5c65/H4lv
         pJhXSXKrNTs7s8odh9yDMffyHuPvieDbG3RC7gWLalFhXhltp/ytsHX1dcIN74JUES
         tPz+pwugBCo+WOiapqL9nubi4zzwg1YjNgeqC0Uy7U4oVr9O0cH9ApVemrOaEE+SCW
         +UjamWWPMvp/gXVXdzpdunJkBp7+G2p/42WU82fSJUFtZej9YELwvVRIXWvMx8JlS/
         2YzLZGzn2w7Py8Wv3Bsjf4QEBty+FrMl0s1LX8po9TVKPCwyiAPUG2eAjpeeXyJnrB
         1e+lPNgb1sjBA==
From:   Hector Martin <marcan@marcan.st>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 2/2] nvme: Handle shut down controllers during initialization
Date:   Wed, 11 Jan 2023 13:36:14 +0900
Message-Id: <20230111043614.27087-3-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111043614.27087-1-marcan@marcan.st>
References: <20230111043614.27087-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the spec, controllers need an explicit reset to become
active again after a controller shutdown. Check for this state in
nvme_enable_ctrl and issue an explicit disable if required, which will
trigger the required reset.

Fixes: c76b8308e4c9 ("nvme-apple: fix controller shutdown in apple_nvme_disable")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be562a4e1aa..84e5db192ff9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2410,6 +2410,19 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	/*
+	 * If the controller is enabled but shut down, we need to disable it to
+	 * reset it and have it come up. If the controller has completed a
+	 * shutdown and is disabled, then we need to clear the shutdown request
+	 * and enable it in the same write to CC.
+	 * See NVMe Base Spec 2.0c Figure 47.
+	 */
+	if (ctrl->ctrl_config & NVME_CC_SHN_MASK && ctrl->ctrl_config & NVME_CC_ENABLE) {
+		ret = nvme_disable_ctrl(ctrl, false);
+		if (ret)
+			return ret;
+	}
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
-- 
2.35.1

