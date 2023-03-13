Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB6D6B80BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCMSck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCMScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24884F6C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8511F61465
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DEAC433D2;
        Mon, 13 Mar 2023 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732248;
        bh=XOt986J4P1SQsjKxI3G691EIKx8QyqtjbVGtFAmvj24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wifLC8SvUOVTXRkE2sazX5gOlQwZKubUUINw5E59fDDwyHo6YWaKKTDr+o/iQ0Yv+
         y5Ky/4JEL7u4QSKsf1uaC1ABb9A3ud6QeLQU7OmK8kHI4kriupcyR9zNqmxluCpY5H
         tL3cY2TnPPuNqkMXdAVAtjwcrEay3o+R/7MolWOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 28/36] driver core: make the bus_type in struct device_driver constant
Date:   Mon, 13 Mar 2023 19:29:10 +0100
Message-Id: <20230313182918.1312597-28-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=gregkh@linuxfoundation.org; h=from:subject; bh=XOt986J4P1SQsjKxI3G691EIKx8QyqtjbVGtFAmvj24=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82dVsb5yWXN3845t6n23hxESxrAv+2Y6Vqm+T523e2 HX1hHFIRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExE/DvDgoOa7Jr/3y7ssZdz dlqwv2DDHiWh2wwLNpipTHS8q85SmFS26oG8uac8t0gKAA==
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

The pointer to struct bus_type in struct device_driver should only be
pointing to something that can never change now that the driver core has
fixed up the previously writable fields.  So mark it as a constant
pointer to enforce this and move forward with the goal of moving
bus_type into read-only memory.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index ceb0e477c2c8..0f22a6f46f8c 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -95,7 +95,7 @@ enum probe_type {
  */
 struct device_driver {
 	const char		*name;
-	struct bus_type		*bus;
+	const struct bus_type	*bus;
 
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
-- 
2.39.2

