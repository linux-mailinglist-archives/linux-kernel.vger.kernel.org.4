Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39B6A6D67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCANvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCANvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:51:15 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6B039B98;
        Wed,  1 Mar 2023 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lGGtK0+LJYr2TlFrW/JiGW5rzeFIGTxQ0thV2EbNA4U=; b=ooQbpOIGFonM7sBOa8Eu9Htgm+
        hePzaTB+SmQWjRjOBXySnTpl2OeEwpnm8WJfywsdlqB9T4lyp7YX82js/r5gzBuZNZUvlYKDGRudb
        K7YA21BC7svzzxU1/PMpG4G+9lGSEFEprjqFRgzEDoezVEvYOLj301Lk5iNTElo9UP9kNkH/yBo48
        i/xXEp5JsywUd2rAXeWqnEeo1pAlVLLgWD3N0CF7Mobp/RFg3cAa9UfAukwk9JtZp9L2pashxhygp
        pesBcnGanCEoaEqLymANJ5463cJaM66L9hP9ZkE/4lHS2k1Ou2FHJigx6i2DVhvwD2DAjmiK6lj15
        QQoRxZzg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pXMrN-00DwVS-BI; Wed, 01 Mar 2023 15:51:09 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: host1x: Don't rely on dma_fence_wait_timeout return value
Date:   Wed,  1 Mar 2023 15:51:06 +0200
Message-Id: <20230301135107.999976-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

dma_fence_wait_timeout (along with a host of other jiffies-based
timeouting functions) returns zero both in case of timeout and when
the wait completes during the last jiffy before timeout. As such,
we can't rely on it to distinguish between success and timeout.

To prevent confusing callers by returning -EAGAIN before the timeout
period has elapsed, check if the fence got signaled again after
the wait.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/syncpt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index 2d2007760eac..f63d14a57a1d 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -248,7 +248,13 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
 	if (value)
 		*value = host1x_syncpt_load(sp);
 
-	if (wait_err == 0)
+	/*
+	 * Don't rely on dma_fence_wait_timeout return value,
+	 * since it returns zero both on timeout and if the
+	 * wait completed with 0 jiffies left.
+	 */
+	host1x_hw_syncpt_load(sp->host, sp);
+	if (wait_err == 0 && !host1x_syncpt_is_expired(sp, thresh))
 		return -EAGAIN;
 	else if (wait_err < 0)
 		return wait_err;
-- 
2.39.2

