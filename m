Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0747E6AE68A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCGQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCGQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:09 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684384F57
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=JtgpuSK8MmevXI
        itz6mQVyFwa8KVkr2/FF+DSt6FhcE=; b=tyKU84erH9mXtS96aLIMQKmyVSd9L3
        ZS1PHqinNMVw4uzLZioEtVQewxGVlp1FYSsHs+bLNjI8rdqUhOF7bCoZiTMhNvN9
        JSyLEQ7lm3IwtF6a+KvacNjqBY/D0XS7XVvgQcjo1ktaJnGqkujpq3oi0H34OJxL
        V3Q7L7KzZf5Q8=
Received: (qmail 751874 invoked from network); 7 Mar 2023 17:31:02 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:02 +0100
X-UD-Smtp-Session: l3s3148p1@DE3z71H2QI0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] iommu/ipmmu-vmsa: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:29 +0100
Message-Id: <20230307163041.3815-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 drivers/iommu/ipmmu-vmsa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..ba42001a6f57 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -697,7 +697,6 @@ static const struct soc_device_attribute soc_needs_opt_in[] = {
 
 static const struct soc_device_attribute soc_denylist[] = {
 	{ .soc_id = "r8a774a1", },
-	{ .soc_id = "r8a7795", .revision = "ES1.*" },
 	{ .soc_id = "r8a7795", .revision = "ES2.*" },
 	{ .soc_id = "r8a7796", },
 	{ /* sentinel */ }
-- 
2.35.1

