Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA36B80B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCMSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjCMSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1437B83167
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A71B66148D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB015C433A7;
        Mon, 13 Mar 2023 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732241;
        bh=NAMwfV4LXKVlZrKLBvSDA4tAh1lT6Itj7zD+l/JKnWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPhUcsIYC0CBVQx6E5sTK60w0TGLRcnknw6rpxTZjtKL58R4FXiivBQEoxTD0dwWS
         HIGntxEUZnQ2+tFWsSTh5iImWobLwbsRddj2U/adllkrJbxbdBnqiJ59Ja8zO2iw7V
         PC3Kit6WubZXiU8GM6ItIXro5jfe0KR3VLcccdN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 25/36] driver core: bus: constify bus_rescan_devices()
Date:   Mon, 13 Mar 2023 19:29:07 +0100
Message-Id: <20230313182918.1312597-25-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=gregkh@linuxfoundation.org; h=from:subject; bh=NAMwfV4LXKVlZrKLBvSDA4tAh1lT6Itj7zD+l/JKnWg=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82VU7N/1N411lfehfvLB4krVL/0SrH2edJirY79zee cQnzk6tI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbCfIphntbh/s/9rqX1Hese MsW4u2qvalnswTCH7/x8PY/CYPllotcN51dPO+CQaJgKAA==
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

The bus_rescan_devices() function was missed in the previous change of
the bus_for_each* constant pointer changes, so fix it up now to take a
const * to struct bus_type.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 2 +-
 include/linux/device/bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f739a2a79e59..ced61fad390e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -769,7 +769,7 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
  * attached and rescan it against existing drivers to see if it matches
  * any by calling device_attach() for the unbound devices.
  */
-int bus_rescan_devices(struct bus_type *bus)
+int bus_rescan_devices(const struct bus_type *bus)
 {
 	return bus_for_each_dev(bus, NULL, NULL, bus_rescan_devices_helper);
 }
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index c30c4748c170..b517b82d4723 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -114,7 +114,7 @@ extern int __must_check bus_register(const struct bus_type *bus);
 
 extern void bus_unregister(const struct bus_type *bus);
 
-extern int __must_check bus_rescan_devices(struct bus_type *bus);
+extern int __must_check bus_rescan_devices(const struct bus_type *bus);
 
 struct bus_attribute {
 	struct attribute	attr;
-- 
2.39.2

