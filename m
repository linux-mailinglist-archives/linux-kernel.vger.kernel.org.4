Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAA62E16C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiKQQUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiKQQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4127990C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 353FF62129
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA21EC433C1;
        Thu, 17 Nov 2022 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702006;
        bh=b8SJPZGZ+txO7HP1C54y9gMTbCClkB0uwv9/7GbEZFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OW1AjMasFfvc0E26IdmOL4Y/yGHr9/+Md6Y5DrdKmS2qWR6XUIgqm6XUZgrYaZpZ8
         2NQl/9JJfo42f+vCoBdpGs2JBPWWZYSUcdeF8xr3caHlWV/KIF723H+gYdHlMczdxc
         zNwDrDZh7lLSH++35TY2UZgQNOVluuqUWcG213uKabNs2rcXH1bfoRdLQuiXTSQm9t
         JWmgIaLtvj9RAKNmDEnZNnl4erBGKySKgr0Ef/dmKap+NRFYtFbQI3hA8CG82D1Ykb
         ff+uZGUYA8koVpTX5iVzzUYuM+dVkDGIvug12+jhblKrTzaRTkdZYVV+ew2j2BmR8Q
         lIj/OlQ72y+PA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 08/20] habanalabs: skip events info ioctl if not supported
Date:   Thu, 17 Nov 2022 18:19:39 +0200
Message-Id: <20221117161951.845454-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Some ASICs haven't yet implemented this functionality and so the
ioctl call should fail and the user should be notified of the reason.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index ee43017eb563..b6abfa7761a7 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -123,6 +123,10 @@ static int hw_events_info(struct hl_device *hdev, bool aggregate,
 		return -EINVAL;
 
 	arr = hdev->asic_funcs->get_events_stat(hdev, aggregate, &size);
+	if (!arr) {
+		dev_err(hdev->dev, "Events info not supported\n");
+		return -EOPNOTSUPP;
+	}
 
 	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
 }
-- 
2.25.1

