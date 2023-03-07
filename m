Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018C6AD881
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCGHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCGHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:51:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A38617E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597D660BA5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCAFC433D2;
        Tue,  7 Mar 2023 07:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678175466;
        bh=EHSYx70OmALyZKpquN+PuVafSdwvNOxA/K6t/OhikYc=;
        h=From:To:Cc:Subject:Date:From;
        b=UblaqUjBSJTigui6gYHI0abjrdRdNd+6Z5lqtsDVEGLLcpxlsA+DsYJdUDIS2K1Iq
         3JIZM0/fMJD/sBqSIak29ZfcNiyIfR015QGdld9OpjXH25PVsoO+WHftd/IIiij0Il
         XV+3gaLsIzthKAO5ruSDUxe+awjTXwMw0Pa1ym6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] driver core: class: fix block class problem when removing CONFIG_SYSFS_DEPRECATED*
Date:   Tue,  7 Mar 2023 08:51:02 +0100
Message-Id: <20230307075102.3537-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=gregkh@linuxfoundation.org; h=from:subject; bh=EHSYx70OmALyZKpquN+PuVafSdwvNOxA/K6t/OhikYc=; b=owGbwMvMwCRo6H6F97bub03G02pJDClsb55cy83cf63rgKLz4b/Suif5TcMetSdFpR1dVFH8cdLi DaelOmJYGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiZtwMC/ZVLJn1dp8av73ylPY/Hl +cPxbPF2GYsT//YduL/QK6yQbSs+4EPGvgcNIEAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In removing the CONFIG_SYSFS_DEPRECATED and CONFIG_SYSFS_DEPRECATED_V2
config options, I messed up in the __class_register() function and got
the logic incorrect.  Fix this all up by just removing the special case
of a block device class logic in this function, as that is what is
intended.

In testing, this solves the boot problem on my systems, hopefully on
others as well.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED and CONFIG_SYSFS_DEPRECATED_V2")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index fb8f2a1e1c19..5983eead8391 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -178,13 +178,7 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 	if (!cls->dev_kobj)
 		cls->dev_kobj = sysfs_dev_char_kobj;
 
-#if defined(CONFIG_BLOCK)
-	/* let the block class directory show up in the root of sysfs */
-	if (cls != &block_class)
-		cp->subsys.kobj.kset = class_kset;
-#else
 	cp->subsys.kobj.kset = class_kset;
-#endif
 	cp->subsys.kobj.ktype = &class_ktype;
 	cp->class = cls;
 	cls->p = cp;
-- 
2.39.2

