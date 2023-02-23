Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032FE6A12E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBWWms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBWWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:42:46 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6CB5505F;
        Thu, 23 Feb 2023 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
        Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=QycZbkJqi7Zscv1obsdF2TfLt0izpxXbF1U4b6Hoalo=; b=d
        H4uqJBfXzhk7hCGKwFhZzlQu3sajuD+/B6NvA0Tqxt98X7x6N/+CmF5DZpdiAyCymK5N94BbsDj7T
        kNrS/5ReRp0bYQuO4eeWtOdCtgl2/bu3YCnMLxUn44MyNX84Ejtn96Jwb1vUHATLQdOvxDAoWxycW
        KCoqRZ3F7888Pf3xXmXyTSb0t4+NFb/xQthSB3HTq3LBUnaKuBRVaaB5VVgvIzxmC+kBZxd4XI6s2
        IpgAozJ2DDhtZIK9jMopvgMqKIiWjBd/TdsXJvnucgsFw74aFdSrYcJlsTsxNKgNCWqTdQ82p86xJ
        iwAdEutrHlNPB9+OuHBiuYuzX1pu8IItQ==;
Received: from [2001:4d48:ad59:1403::17ca] (helo=sevai.o362.us)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pVJnx-0047rz-S4; Thu, 23 Feb 2023 22:11:09 +0000
Date:   Thu, 23 Feb 2023 22:11:05 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Antoine Tenart <atenart@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] crypto: inside-secure: Cleanup ring IRQ workqueues on
 load failure
Message-ID: <Y/fkbMft2oN8EGag@sevai.o362.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Signed-off-by: Jonathan McDowell <noodles@earth.li>
Cc: stable@vger.kernel.org
---
 drivers/crypto/inside-secure/safexcel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 5e10ab24be3b..c7263d84a2e9 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1684,16 +1684,24 @@ static int safexcel_probe_generic(void *pdev,
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
+		irq_set_affinity_hint(priv->ring[i].irq, NULL);
+		destroy_workqueue(priv->ring[i].workqueue);
+	}
+
+	return ret;
 }
 
 static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
-- 
2.39.1

