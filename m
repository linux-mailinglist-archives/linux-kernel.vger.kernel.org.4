Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D080A6A5EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjB1S3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1S3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:29:16 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1EE3344B;
        Tue, 28 Feb 2023 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ECH1deKx+z2SM1iXhh3cdnB9YsWa9ZMdhAGEfXckaJk=; b=k9SBVVXa9t2tvPvU/Arvj2qbzU
        hil9SInUdqiUiy4MqEmRuKnvY36d9MSNu1+KFcJYV/+lDWevfE0s/mMTZXrRgTStVYUAnmdoSvvKg
        73f+kqqwZSPo1V6mCczxehP6p5wvIMWhhONKtsDz16iGQ95BmppodQzU7eWPkwwPj4KxXfF5eFeF0
        1lg52gCdHycdvwLGcm+Yi5Wh1gg1IOTN2G3VnAeOj7pVLHETPt2QmQ8BpGMxmUL3gsYJ6N87xLHmP
        RLIHUheupaDUPWOe7xqa1LecCnAf9C4C2SEoR7tz+/R33ATXzDotHmriHZVD5T0jmFRj3vqau4ZIf
        HU+7Xt+g==;
Received: from [2001:4d48:ad59:1403::17ca] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pX4ik-008oSf-Us; Tue, 28 Feb 2023 18:29:03 +0000
Date:   Tue, 28 Feb 2023 18:28:58 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Antoine Tenart <atenart@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] crypto: inside-secure - Cleanup ring IRQ workqueues
 on load failure
Message-ID: <7b3dbe21c21e547252ed6d292cf0be1fede9d487.1677608527.git.noodles@earth.li>
References: <Y/fkOF31BTQVocSe@sevai.o362.us>
 <cover.1677608527.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677608527.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A failure loading the safexcel driver results in the following warning
on boot, because the IRQ affinity has not been correctly cleaned up.
Ensure we clean up the affinity and workqueues on a failure to load the
driver.

crypto-safexcel: probe of f2800000.crypto failed with error -2
------------[ cut here ]------------
WARNING: CPU: 1 PID: 232 at kernel/irq/manage.c:1913 free_irq+0x300/0x340
Modules linked in: hwmon mdio_i2c crypto_safexcel(+) md5 sha256_generic libsha256 authenc libdes omap_rng rng_core nft_masq nft_nat nft_chain_nat nf_nat nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink fuse autofs4
CPU: 1 PID: 232 Comm: systemd-udevd Tainted: G        W          6.1.6-00002-g9d4898824677 #3
Hardware name: MikroTik RB5009 (DT)
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : free_irq+0x300/0x340
lr : free_irq+0x2e0/0x340
sp : ffff800008fa3890
x29: ffff800008fa3890 x28: 0000000000000000 x27: 0000000000000000
x26: ffff8000008e6dc0 x25: ffff000009034cac x24: ffff000009034d50
x23: 0000000000000000 x22: 000000000000004a x21: ffff0000093e0d80
x20: ffff000009034c00 x19: ffff00000615fc00 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 000075f5c1584c5e
x14: 0000000000000017 x13: 0000000000000000 x12: 0000000000000040
x11: ffff000000579b60 x10: ffff000000579b62 x9 : ffff800008bbe370
x8 : ffff000000579dd0 x7 : 0000000000000000 x6 : ffff000000579e18
x5 : ffff000000579da8 x4 : ffff800008ca0000 x3 : ffff800008ca0188
x2 : 0000000013033204 x1 : ffff000009034c00 x0 : ffff8000087eadf0
Call trace:
 free_irq+0x300/0x340
 devm_irq_release+0x14/0x20
 devres_release_all+0xa0/0x100
 device_unbind_cleanup+0x14/0x60
 really_probe+0x198/0x2d4
 __driver_probe_device+0x74/0xdc
 driver_probe_device+0x3c/0x110
 __driver_attach+0x8c/0x190
 bus_for_each_dev+0x6c/0xc0
 driver_attach+0x20/0x30
 bus_add_driver+0x148/0x1fc
 driver_register+0x74/0x120
 __platform_driver_register+0x24/0x30
 safexcel_init+0x48/0x1000 [crypto_safexcel]
 do_one_initcall+0x4c/0x1b0
 do_init_module+0x44/0x1cc
 load_module+0x1724/0x1be4
 __do_sys_finit_module+0xbc/0x110
 __arm64_sys_finit_module+0x1c/0x24
 invoke_syscall+0x44/0x110
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x20/0x80
 el0_svc+0x14/0x4c
 el0t_64_sync_handler+0xb0/0xb4
 el0t_64_sync+0x148/0x14c
---[ end trace 0000000000000000 ]---

Fixes: 1b44c5a60c13 ("inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Jonathan McDowell <noodles@earth.li>
Cc: stable@vger.kernel.org
---
v2:
 - Expand error clean up to cover ring initialisation failures
---
 drivers/crypto/inside-secure/safexcel.c | 37 ++++++++++++++++++-------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 5e10ab24be3b..9ff02b5abc4a 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1628,19 +1628,23 @@ static int safexcel_probe_generic(void *pdev,
 						     &priv->ring[i].rdr);
 		if (ret) {
 			dev_err(dev, "Failed to initialize rings\n");
-			return ret;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].rdr_req = devm_kcalloc(dev,
 			EIP197_DEFAULT_RING_SIZE,
 			sizeof(*priv->ring[i].rdr_req),
 			GFP_KERNEL);
-		if (!priv->ring[i].rdr_req)
-			return -ENOMEM;
+		if (!priv->ring[i].rdr_req) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq = devm_kzalloc(dev, sizeof(*ring_irq), GFP_KERNEL);
-		if (!ring_irq)
-			return -ENOMEM;
+		if (!ring_irq) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq->priv = priv;
 		ring_irq->ring = i;
@@ -1654,7 +1658,8 @@ static int safexcel_probe_generic(void *pdev,
 						ring_irq);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get IRQ ID for ring %d\n", i);
-			return irq;
+			ret = irq;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].irq = irq;
@@ -1666,8 +1671,10 @@ static int safexcel_probe_generic(void *pdev,
 		snprintf(wq_name, 9, "wq_ring%d", i);
 		priv->ring[i].workqueue =
 			create_singlethread_workqueue(wq_name);
-		if (!priv->ring[i].workqueue)
-			return -ENOMEM;
+		if (!priv->ring[i].workqueue) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		priv->ring[i].requests = 0;
 		priv->ring[i].busy = false;
@@ -1684,16 +1691,26 @@ static int safexcel_probe_generic(void *pdev,
 	ret = safexcel_hw_init(priv);
 	if (ret) {
 		dev_err(dev, "HW init failed (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	ret = safexcel_register_algorithms(priv);
 	if (ret) {
 		dev_err(dev, "Failed to register algorithms (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	return 0;
+
+err_cleanup_rings:
+	for (i = 0; i < priv->config.rings; i++) {
+		if (priv->ring[i].irq)
+			irq_set_affinity_hint(priv->ring[i].irq, NULL);
+		if (priv->ring[i].workqueue)
+			destroy_workqueue(priv->ring[i].workqueue);
+	}
+
+	return ret;
 }
 
 static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
-- 
2.39.2

