Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DAB68ED9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjBHLPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjBHLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7D3669F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0103B81D4C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03748C433D2;
        Wed,  8 Feb 2023 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854880;
        bh=/Jfy0ZR86tMaNpwhqHvCr9+CtBj1NZD8CISYkm9vbio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjBx8BOvdpjGmXL6F0NX0feINLoBbn3tCD3u64ZH7dXqndFZTBFuxV1+ueA6/Jd2J
         PNb1ZUgouvQp9ch0a4LSJ8GwT55BpMvhtaM6X3n7lfA0ZEp379iYqaUWvgvBkeYCBe
         rEN6gCnM+nupIizpTWGjO8LmBkhtbodmgOqTNuQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 09/21] driver core: bus: bus_get_kset() cleanup
Date:   Wed,  8 Feb 2023 12:13:18 +0100
Message-Id: <20230208111330.439504-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=gregkh@linuxfoundation.org; h=from:subject; bh=/Jfy0ZR86tMaNpwhqHvCr9+CtBj1NZD8CISYkm9vbio=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm6+Hhv5XPJBlmHUrzOXrqpDCqsM9Nscvfryj8WL56m0G 0muCO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiXXUMC47eUcp5/fqZyGSVdwevOd 6fMyVR7hvDfN88jmWv5x2RZ7zAqH5eQKao7DlPOwA=
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

Convert the bus_get_kset() function function to use bus_to_subsys() and
not use the back-pointer to the private structure.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index deed62509a62..90627c68d02b 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -956,7 +956,16 @@ void bus_notify(struct device *dev, enum bus_notifier_event value)
 
 struct kset *bus_get_kset(struct bus_type *bus)
 {
-	return &bus->p->subsys;
+	struct subsys_private *sp = bus_to_subsys(bus);
+	struct kset *kset;
+
+	if (!sp)
+		return NULL;
+
+	kset = &sp->subsys;
+	subsys_put(sp);
+
+	return kset;
 }
 EXPORT_SYMBOL_GPL(bus_get_kset);
 
-- 
2.39.1

