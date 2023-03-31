Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF86D1DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjCaKOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjCaKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:13:15 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8CF24AC1;
        Fri, 31 Mar 2023 03:07:48 -0700 (PDT)
Received: from legion.. ([172.16.0.254])
        (user=lidaxian@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32V9tmlN007322-32V9tmlO007322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Mar 2023 17:56:17 +0800
From:   Li Yang <lidaxian@hust.edu.cn>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Li Yang <lidaxian@hust.edu.cn>, Dan Carpenter <error27@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: renesas: renesas-soc: release 'chipid' from ioremap()
Date:   Fri, 31 Mar 2023 17:55:44 +0800
Message-Id: <20230331095545.31823-1-lidaxian@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lidaxian@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

drivers/soc/renesas/renesas-soc.c:536 renesas_soc_init() warn:
'chipid' from ioremap() not released on lines: 475.

If soc_dev_atrr allocation is failed, function renesas_soc_init()
will return without releasing 'chipid' from ioremap().

Fix this by adding function iounmap().

Fixes: cb5508e47e60 ("soc: renesas: Add support for reading product revision for RZ/G2L family")
Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
---
 drivers/soc/renesas/renesas-soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 468ebce1ea88..51191d1a6dd1 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -471,8 +471,11 @@ static int __init renesas_soc_init(void)
 	}
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
+	if (!soc_dev_attr) {
+		if (chipid)
+			iounmap(chipid);
 		return -ENOMEM;
+	}
 
 	np = of_find_node_by_path("/");
 	of_property_read_string(np, "model", &soc_dev_attr->machine);
-- 
2.34.1

