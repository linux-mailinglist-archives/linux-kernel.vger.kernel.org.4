Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B4681753
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjA3RLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjA3RLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:11:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A930402D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB30611F0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB732C4339B;
        Mon, 30 Jan 2023 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675098664;
        bh=uPrZO2VVFrmuQntAv0HtD/x/u3arHKR1TJC+0KNfpe8=;
        h=From:To:Cc:Subject:Date:From;
        b=BGosTPqDXNPivlWS6lv6r22K/bJNkQaeDtCEnu5r29biygyn1kFkl6hAr9idKn2JG
         b0YlfYTTeT1H6gE6YQMeTTjo2mfqjYzOdzVvw6lNYQTP3iQLfTQRia4nnEH+kE6IGq
         kFNvXMo0f34e7ICwvgETsnG5nSWkr9TlCirUYa5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] driver core: soc: remove layering violation for the soc_bus
Date:   Mon, 30 Jan 2023 18:10:59 +0100
Message-Id: <20230130171059.1784057-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=gregkh@linuxfoundation.org; h=from:subject; bh=uPrZO2VVFrmuQntAv0HtD/x/u3arHKR1TJC+0KNfpe8=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnXfynWLODJCyy6dexTdiLHc+tEnqiGqzk6zHb7fhupKNyv nevQEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABPhm8owv579VpOKb66af2S4yFy5Al ON7xN0GRZccvy/4OD5zIgQq/o01S8KN6X6rtoCAA==
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

The soc_bus code pokes around in the internal bus structures assuming
that it "knows" if a field is not set that it has not been registered
yet.  That isn't a safe assumption, so just remove the layering
violation entirely and keep track if the bus has been registered or not
ourselves.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/soc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 22130b5f789d..0fb1d4ab9d8a 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -30,6 +30,7 @@ struct soc_device {
 static struct bus_type soc_bus_type = {
 	.name  = "soc",
 };
+static bool soc_bus_registered;
 
 static DEVICE_ATTR(machine,		0444, soc_info_show,  NULL);
 static DEVICE_ATTR(family,		0444, soc_info_show,  NULL);
@@ -117,7 +118,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 	const struct attribute_group **soc_attr_groups;
 	int ret;
 
-	if (!soc_bus_type.p) {
+	if (!soc_bus_registered) {
 		if (early_soc_dev_attr)
 			return ERR_PTR(-EBUSY);
 		early_soc_dev_attr = soc_dev_attr;
@@ -183,6 +184,7 @@ static int __init soc_bus_register(void)
 	ret = bus_register(&soc_bus_type);
 	if (ret)
 		return ret;
+	soc_bus_registered = true;
 
 	if (early_soc_dev_attr)
 		return PTR_ERR(soc_device_register(early_soc_dev_attr));
-- 
2.39.1

