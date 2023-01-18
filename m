Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13A672ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjARVvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjARVvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:51:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C7630AF;
        Wed, 18 Jan 2023 13:50:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DCD3F3F824;
        Wed, 18 Jan 2023 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674078656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImXWQyU4WFGAYv86tZ8Xzi8aUY2vgULsXE686tIBgtA=;
        b=aqBu6/y8+eY7NxuH49S2vhQnojNiXzIIFVXUoWwqh4gQTC/EBxdbk9xbSc9VpUYsGxke+H
        I4j/1Fe8CJ4hNNrv+izPi93x0VR2Nr4YmUAE5duvZK3xnDSsqplfZP/lORSvCITsvISo5b
        vI0Nrq88LJgj1V/hOg/QWTM0fuXMkpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674078656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImXWQyU4WFGAYv86tZ8Xzi8aUY2vgULsXE686tIBgtA=;
        b=wshYCj7T4L0m6eOKuX/ezCn2oMy5WSPFrp+Mx2EJgbAw9tG7KVya4xbzPFwcjcUOLPVyRw
        PrWMvVbalNRogDBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id A99192C141;
        Wed, 18 Jan 2023 21:50:56 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     "Erhard F." <erhard_f@mailbox.org>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: Fix of platform build on powerpc due to bad of disaply code
Date:   Wed, 18 Jan 2023 22:50:45 +0100
Message-Id: <20230118215045.5551-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230118211305.42e50a4a@yea>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The commit 2d681d6a23a1 ("of: Make of framebuffer devices unique")
breaks build because of wrong argument to snprintf. That certainly
avoids the runtime error but is not the intended outcome.

Fixes: 2d681d6a23a1 ("of: Make of framebuffer devices unique")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/of/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f2a5d679a324..e9dd7371f27a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -564,10 +564,10 @@ static int __init of_platform_default_populate_init(void)
 		}
 
 		for_each_node_by_type(node, "display") {
-			char *buf[14];
+			char buf[14];
 			if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
 				continue;
-			ret = snprintf(buf, "of-display-%d", display_number++);
+			ret = snprintf(buf, sizeof(buf), "of-display-%d", display_number++);
 			if (ret >= sizeof(buf))
 				continue;
 			of_platform_device_create(node, buf, NULL);
-- 
2.35.3

