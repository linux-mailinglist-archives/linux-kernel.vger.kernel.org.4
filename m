Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05844665A43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjAKLcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjAKLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF879FC0;
        Wed, 11 Jan 2023 03:31:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EBF9B81BAE;
        Wed, 11 Jan 2023 11:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6F0C433F0;
        Wed, 11 Jan 2023 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436664;
        bh=AOHTskiEf/EAugFIosirnt3UqsWGT4GZR/BBhCBjd6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNXb2t3AesSrXPfTX4HewBgBh8EPSOATBcb2MUmFQIbs8yr2M+Lodwmqhp0aCUE9M
         to9ZBuow1oYvIXdyBP89Tl8CqHOv1wJDSSsBEcSLSlaN0Oo5eY9jArYHEUT7w4g+Nn
         YiWabd8mE8Y6WOPQ6F86VAed1zHzcNfH4RbcEvNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 03/16] platform/surface: aggregator: move to_ssam_device() to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:05 +0100
Message-Id: <20230111113018.459199-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=gregkh@linuxfoundation.org; h=from:subject; bh=AOHTskiEf/EAugFIosirnt3UqsWGT4GZR/BBhCBjd6w=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75h6fqF/OaWkev969+0via23dxdl/Vl0+b+bYP4HPlVP5 pda9jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIewTDgi6X/YxP9ovXmdzTTg2/+s 2IJfhXN8OChfos7xNWBgpHVCbn+fq+kDVycpcGAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core is changing to pass some pointers as const, so move
to_ssam_device() to use container_of_const() to handle this change.
to_ssam_device() now properly keeps the const-ness of the pointer passed
into it, while as before it could be lost.

Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/surface_aggregator/device.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 46c45d1b6368..24151a0e2c96 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -229,10 +229,7 @@ static inline bool is_ssam_device(struct device *d)
  * Return: Returns a pointer to the &struct ssam_device wrapping the given
  * device @d.
  */
-static inline struct ssam_device *to_ssam_device(struct device *d)
-{
-	return container_of(d, struct ssam_device, dev);
-}
+#define to_ssam_device(d)	container_of_const(d, struct ssam_device, dev)
 
 /**
  * to_ssam_device_driver() - Casts the given device driver to a SSAM client
-- 
2.39.0

