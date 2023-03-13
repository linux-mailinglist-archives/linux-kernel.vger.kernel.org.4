Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409CE6B8043
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCMSUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCMSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA66F7B138
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E168B811D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9875C433EF;
        Mon, 13 Mar 2023 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731562;
        bh=vmNYyZuBjNC28emx6QSi+865CiSetjJlXNcihbd0beA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikHdYFEQqwEi9oY+0kPGXadhIhvc0SampZiat3JC6S6yAcBtkt0PPn7tP2699ttEu
         0hSKEnVNlvL66+NtSCGEwIb8mJ2Cj2yylQ91p4VioMyEmuSs7ucoAq85wwpU092b3a
         7/NyBS5QL5uHzhGG2ERnWS8FS8fxkYzjnwTER4WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/12] driver core: device: make device_destroy() take a const class *
Date:   Mon, 13 Mar 2023 19:18:40 +0100
Message-Id: <20230313181843.1207845-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=gregkh@linuxfoundation.org; h=from:subject; bh=vmNYyZuBjNC28emx6QSi+865CiSetjJlXNcihbd0beA=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mcy5BtP4JE//vr1HfI2P/5bkK1qPnTveeJV/Z7dpm V3+58GPjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIswvD/KC+rpO/E5tvvV2n vjot3OopV87/mwzzbPe9z/yntfL3IsmTziWt4lw2SgeOAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_destroy() does not modify the struct class passed into it, so
mark it as const to enforce this rule.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    | 2 +-
 include/linux/device.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 57076837b33e..f3b7040ef9b6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4383,7 +4383,7 @@ EXPORT_SYMBOL_GPL(device_create_with_groups);
  * This call unregisters and cleans up a device that was created with a
  * call to device_create().
  */
-void device_destroy(struct class *class, dev_t devt)
+void device_destroy(const struct class *class, dev_t devt)
 {
 	struct device *dev;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 0f128520f6e5..c0c02a00fe87 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1019,7 +1019,7 @@ __printf(6, 7) struct device *
 device_create_with_groups(struct class *cls, struct device *parent, dev_t devt,
 			  void *drvdata, const struct attribute_group **groups,
 			  const char *fmt, ...);
-void device_destroy(struct class *cls, dev_t devt);
+void device_destroy(const struct class *cls, dev_t devt);
 
 int __must_check device_add_groups(struct device *dev,
 				   const struct attribute_group **groups);
-- 
2.39.2

