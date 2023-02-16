Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91C0698ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBPIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBPIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:37:33 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545134C3B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:37:32 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:4605:3635:9491:c6bc])
        by albert.telenet-ops.be with bizsmtp
        id MkdU2900V3wKl5506kdUJU; Thu, 16 Feb 2023 09:37:29 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pSZlK-0099qN-1G;
        Thu, 16 Feb 2023 09:37:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pSZlg-005Dq1-Nw;
        Thu, 16 Feb 2023 09:37:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Martin Liu <liumartin@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: reserved_mem: Use proper binary prefix
Date:   Thu, 16 Feb 2023 09:37:25 +0100
Message-Id: <20230216083725.1244817-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printed reserved memory information uses the non-standard "K"
prefix, while all other printed values use proper binary prefixes.
Fix this by using "Ki" instead.

While at it, drop the superfluous spaces inside the parentheses, to
reduce printed line length.

Fixes: aeb9267eb6b1df99 ("of: reserved-mem: print out reserved-mem details during boot")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
K = Kelvin
k = kilo
Ki = kibi
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 27de0d32145939e3..948efa9f99e3bc90 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -290,7 +290,7 @@ void __init fdt_init_reserved_mem(void)
 				bool reusable =
 					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
 
-				pr_info("%pa..%pa ( %lu KB ) %s %s %s\n",
+				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
 					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
 					nomap ? "nomap" : "map",
 					reusable ? "reusable" : "non-reusable",
-- 
2.34.1

