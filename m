Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15BB71363E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjE0TkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0TkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 15:40:16 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE7D9
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 12:40:14 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2zlqqt6LYzb8g2zlqqY7Te; Sat, 27 May 2023 21:40:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685216412;
        bh=VKthlyn9E+U4rCBy7ij6kRftfxuaXpwhoHRrC4eHBog=;
        h=From:To:Cc:Subject:Date;
        b=mG4kTaBcbdVgJxb642fw9xT4sANB4RsAO2haUtUX9fe7eNV41iuffXUFBlfXvzRCa
         xm5NRBMB1GSBRPb0Kb6/cY2F/Ikzq99aceXqkcXapTgNDYe5awbRfSTnYi3BRMtJ+u
         7XXWgSEo+20gE6IjEEIEAJ7tjBM8EWA+AQrD2uGJ9o9iBSr0mN/cssERJj15ZgwBiB
         WWZNRBYsoYGlEarqTmPGoCmdocT5A6ohz/htXTajhFihPOvw7XoSZZmU7IFZ1ZHr8y
         y1fDYxAo0fnLkBX5B1ctnql9gHDL2Cy+rrplV+XFhX4UpwN3Q9N/1NWzuXs+fYc0q+
         cNnm/rZj5BovA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 May 2023 21:40:12 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH net-next] liquidio: Use vzalloc()
Date:   Sat, 27 May 2023 21:40:08 +0200
Message-Id: <93b010824d9d92376e8d49b9eb396a0fa0c0ac80.1685216322.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc() instead of hand writing it with vmalloc()+memset().
This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 4 +---
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 9ed3d1ab2ca5..285d3825cad3 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -719,12 +719,10 @@ static int cn23xx_setup_pf_mbox(struct octeon_device *oct)
 	for (i = 0; i < oct->sriov_info.max_vfs; i++) {
 		q_no = i * oct->sriov_info.rings_per_vf;
 
-		mbox = vmalloc(sizeof(*mbox));
+		mbox = vzalloc(sizeof(*mbox));
 		if (!mbox)
 			goto free_mbox;
 
-		memset(mbox, 0, sizeof(struct octeon_mbox));
-
 		spin_lock_init(&mbox->lock);
 
 		mbox->oct_dev = oct;
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
index fda49404968c..b3bd2767d3dd 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -279,12 +279,10 @@ static int cn23xx_setup_vf_mbox(struct octeon_device *oct)
 {
 	struct octeon_mbox *mbox = NULL;
 
-	mbox = vmalloc(sizeof(*mbox));
+	mbox = vzalloc(sizeof(*mbox));
 	if (!mbox)
 		return 1;
 
-	memset(mbox, 0, sizeof(struct octeon_mbox));
-
 	spin_lock_init(&mbox->lock);
 
 	mbox->oct_dev = oct;
-- 
2.34.1

