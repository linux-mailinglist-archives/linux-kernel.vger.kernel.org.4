Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E566D1910
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjCaHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCaHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:53:12 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342A1B350
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:52:38 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id evsc290061C8whw06vsc8a; Fri, 31 Mar 2023 09:52:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pi9Y6-00FTC1-I1;
        Fri, 31 Mar 2023 09:52:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pi9Yp-008Ra3-Sh;
        Fri, 31 Mar 2023 09:52:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] of: address: Fix documented return value of of_pci_range_to_resource()
Date:   Fri, 31 Mar 2023 09:52:29 +0200
Message-Id: <bcdaa9332e9c6dfa27af68d79fda121eac2975dc.1680248888.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680248888.git.geert+renesas@glider.be>
References: <cover.1680248888.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_pci_range_to_resource() returns a negative instead of a positive
error code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/address.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 6312b10885e85864..bd965d104c83a1ac 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -216,7 +216,7 @@ EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
  * @res:	pointer to a valid resource that will be updated to
  *              reflect the values contained in the range.
  *
- * Returns EINVAL if the range cannot be converted to resource.
+ * Returns -EINVAL if the range cannot be converted to resource.
  *
  * Note that if the range is an IO range, the resource will be converted
  * using pci_address_to_pio() which can fail if it is called too early or
-- 
2.34.1

