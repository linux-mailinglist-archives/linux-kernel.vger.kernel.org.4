Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01064809F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLIKGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLIKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:05:59 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A5196;
        Fri,  9 Dec 2022 02:05:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 4AFAE186418E;
        Fri,  9 Dec 2022 13:05:54 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VxhB5KV63KKr; Fri,  9 Dec 2022 13:05:54 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 00DC318643B4;
        Fri,  9 Dec 2022 13:05:53 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ldQXrwzzovs9; Fri,  9 Dec 2022 13:05:53 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 65908186418E;
        Fri,  9 Dec 2022 13:05:53 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH v3] MIPS: BCM63xx: Add check for NULL for clk in clk_enable
Date:   Fri,  9 Dec 2022 13:05:50 +0300
Message-Id: <20221209100550.30470-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check clk for NULL before calling clk_enable_unlocked where clk
is dereferenced. There is such check in other implementations
of clk_enable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx=
 family of SOCs.")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
v2: Fix errors reported by kernel test robot <lkp@intel.com>.
v3: Merge several patches into single one.
 arch/mips/bcm63xx/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 6e6756e8fa0a..86a6e2590866 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -361,6 +361,8 @@ static struct clk clk_periph =3D {
  */
 int clk_enable(struct clk *clk)
 {
+	if (!clk)
+		return 0;
 	mutex_lock(&clocks_mutex);
 	clk_enable_unlocked(clk);
 	mutex_unlock(&clocks_mutex);
--=20
2.30.2

