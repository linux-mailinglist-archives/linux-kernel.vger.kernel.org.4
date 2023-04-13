Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5120B6E08D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDMIWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDMIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:22:19 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDDE5FD4;
        Thu, 13 Apr 2023 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DdPYvmnlhKSi2/t2MM9rvNpqpdHa3YjdMYZD1FWaIEs=; b=gqJizhtTRdr8hkff58lekZDHZf
        7w+fg8oyG3h96eTYQeDG4opBNJQ2hLaadNwAQv7PgeTg+xB2dnVoO+KBOKQ2gDguV2khSTVbX1Xx9
        fGcQNIcgPeYxO1zMibGgSEFXs/ZTDdSEJJU0PGtAYZJXLIdu5JM62PRaYcy4vXiuzSW332e07moCZ
        FjMLgDPw2949+DMOSzL0dYDuYezRyfMP/NB6FBbhHPrpB09lqjy5D+MyIk2GNS7WpncNHQE+Vj8x/
        FVObCbWTq9uu2E0de0vmsYatPIfMV2SZoYXFy05AHCRJUlU3m0xxo455eA3YTH8v7kPCIAiTloO1X
        xkalSz4A==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pmsDc-008oPu-AT; Thu, 13 Apr 2023 11:22:12 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Dan Carpenter <error27@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpu: host1x: Return error when context device not attached to IOMMU
Date:   Thu, 13 Apr 2023 11:22:02 +0300
Message-Id: <20230413082202.114721-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413082202.114721-1-cyndis@kapsi.fi>
References: <20230413082202.114721-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

If a context device was not attached to IOMMU, we kept the old
success err value causing context devices to be unregistered but
success to be returned. This would mean that things would go on
but with context isolation disabled.

To decide on an explicit behavior, let's return an error code
here instead. If someone wants to go without IOMMU on a platform
modern enough to support context isolation, they can remove the
context devices from device tree.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/context.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index 9ad89d22c0ca..c45c4d4e6c1a 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -79,6 +79,14 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 		    !device_iommu_mapped(&ctx->dev)) {
 			dev_err(host1x->dev, "Context device %d has no IOMMU!\n", i);
 			device_unregister(&ctx->dev);
+
+			/*
+			 * This means that if IOMMU is disabled but context devices
+			 * are defined in the device tree, Host1x will fail to probe.
+			 * That's probably OK in this time and age.
+			 */
+			err = -EINVAL;
+
 			goto unreg_devices;
 		}
 	}
-- 
2.39.2

