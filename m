Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8EE750BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjGLPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGLPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2015E74
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884D761853
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A58C433D9;
        Wed, 12 Jul 2023 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174454;
        bh=6hu2QLAnatQP5UFKHqQxLipPsz8mKS6yWJMOvqrfh4E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oi9YDlwcTqrVxqhOw1EZZr9PArfNBsj2F7xdvu0hNxBS+lAeoSYV+yVW2SkbjXuJ9
         ZJnTmXOAJffEds4stKmwQUKBJJcyNs70h0BlapfpbgY5pD1AJjN1xDNQXr1Kku+9+m
         auOKDvO9TbLw9TkKvY5TzgBK7NBJrZWU9zIZG7DFZkfIMpxm8Zzy/3UcucoiDBHo5X
         5qNcGoh4zLdrErmwDnPVA+H/DYbdaG6VwkSiyrQToE9d/5aGcI7LcpplpauC2PZS+i
         nq2szRaVXz/UQU53cI4Vffdjg8b+M8Srm+/DE6dFL+kh5iwQ8jT3uyTTzczc/W+mBM
         s+gJJSuSDsjuw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:01 +0200
Subject: [PATCH net-next v3 01/11] net: phy: get rid of redundant is_c45
 information
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-1-9eb37edf7be0@kernel.org>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_device_create() will be called with is_c45 and c45_ids. If c45_ids
are set, is_c45 is (usually) true. Change the only caller which do
things differently, then drop the is_c45 check in phy_device_create().

This is a preparation patch to replace the is_c45 boolean with an enum
which will indicate how the PHY is accessed (by c22, c45 or
c45-over-c22).

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/phy/phy_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0c2014accba7..226d5507c865 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -689,7 +689,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	 * driver will get bored and give up as soon as it finds that
 	 * there's no driver _already_ loaded.
 	 */
-	if (is_c45 && c45_ids) {
+	if (c45_ids) {
 		const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
 		int i;
 
@@ -970,7 +970,8 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 						 true, &c45_ids);
 	}
 
-	return phy_device_create(bus, addr, phy_id, is_c45, &c45_ids);
+	return phy_device_create(bus, addr, phy_id, is_c45,
+				 !is_c45 ? NULL : &c45_ids);
 }
 EXPORT_SYMBOL(get_phy_device);
 

-- 
2.39.2

