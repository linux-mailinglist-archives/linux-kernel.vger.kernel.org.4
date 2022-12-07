Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C827C645C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiLGO3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiLGO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:28:44 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227EA56EC0;
        Wed,  7 Dec 2022 06:28:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 7390018643B9;
        Wed,  7 Dec 2022 17:28:32 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cMC_BiZcTg-y; Wed,  7 Dec 2022 17:28:32 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 2722D18643BE;
        Wed,  7 Dec 2022 17:28:32 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IfQygreVYS-r; Wed,  7 Dec 2022 17:28:32 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 8132D18643B9;
        Wed,  7 Dec 2022 17:28:31 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] MIPS: BCM63xx: Add check for NULL for clk in clk_enable
Date:   Wed,  7 Dec 2022 17:28:24 +0300
Message-Id: <20221207142824.8706-2-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221207142824.8706-1-abelova@astralinux.ru>
References: <20221207142824.8706-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors from previous version of patch fixed.
Check clk for NULL before calling clk_enable_unlocked where clk
is dereferenced. There is such check in other implementations
of clk_enable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx=
 family of SOCs.")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 arch/mips/bcm63xx/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 401140cf36d9..cf303d6e6693 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -362,7 +362,7 @@ static struct clk clk_periph =3D {
 int clk_enable(struct clk *clk)
 {
 	if (!clk)
-		return;
+		return 0;
=20
 	mutex_lock(&clocks_mutex);
 	clk_enable_unlocked(clk);
--=20
2.30.2

