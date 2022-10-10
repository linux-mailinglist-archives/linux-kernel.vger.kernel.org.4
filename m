Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559695FA0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJJPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF61863F19;
        Mon, 10 Oct 2022 08:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8541A60F5E;
        Mon, 10 Oct 2022 15:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B6FC433D7;
        Mon, 10 Oct 2022 15:06:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WdldBTLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665414384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/cGOeCsidGmGiZ98DVF3Ta98rQRXE0YgnqKqi0mssQ=;
        b=WdldBTLpA+rEApH5WA9tf36Hzezz6L/S61/QOnUnaZye2OC8euwQFFIFduPA4qHcj89EtS
        ZckhCfAU4w5rX6PVyZVpxemHJ0uliGXUobYUxofMpuPPrp9G9dZJBY/tu3VId3UxCJNlg/
        A1w42QeozC5SmPuwWYnfBe9rvdagFp0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89a9ed2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 15:06:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hw_random: bcm2835: use hwrng_msleep() instead of cpu_relax()
Date:   Mon, 10 Oct 2022 09:06:07 -0600
Message-Id: <20221010150607.720600-1-Jason@zx2c4.com>
In-Reply-To: <Y0QjkjU4bsOHWFOd@sirena.org.uk>
References: <Y0QjkjU4bsOHWFOd@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than busy looping, yield back to the scheduler and sleep for a
bit in the event that there's no data. This should hopefully prevent the
stalls that Mark reported:

<6>[    3.362859] Freeing initrd memory: 16196K
<3>[   23.160131] rcu: INFO: rcu_sched self-detected stall on CPU
<3>[   23.166057] rcu:  0-....: (2099 ticks this GP) idle=03b4/1/0x40000002 softirq=28/28 fqs=1050
<4>[   23.174895]       (t=2101 jiffies g=-1147 q=2353 ncpus=4)
<4>[   23.180203] CPU: 0 PID: 49 Comm: hwrng Not tainted 6.0.0 #1
<4>[   23.186125] Hardware name: BCM2835
<4>[   23.189837] PC is at bcm2835_rng_read+0x30/0x6c
<4>[   23.194709] LR is at hwrng_fillfn+0x71/0xf4
<4>[   23.199218] pc : [<c07ccdc8>]    lr : [<c07cb841>]    psr: 40000033
<4>[   23.205840] sp : f093df70  ip : 00000000  fp : 00000000
<4>[   23.211404] r10: c3c7e800  r9 : 00000000  r8 : c17e6b20
<4>[   23.216968] r7 : c17e6b64  r6 : c18b0a74  r5 : c07ccd99  r4 : c3f171c0
<4>[   23.223855] r3 : 000fffff  r2 : 00000040  r1 : c3c7e800  r0 : c3f171c0
<4>[   23.230743] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
<4>[   23.238426] Control: 50c5387d  Table: 0020406a  DAC: 00000051
<4>[   23.244519] CPU: 0 PID: 49 Comm: hwrng Not tainted 6.0.0 #1

Link: https://lore.kernel.org/all/Y0QJLauamRnCDUef@sirena.org.uk/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
I haven't tested this. Somebody with access to that kernel CI infra that
triggered this will need to test.

 drivers/char/hw_random/bcm2835-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index e7dd457e9b22..e98fcac578d6 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -71,7 +71,7 @@ static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
 	while ((rng_readl(priv, RNG_STATUS) >> 24) == 0) {
 		if (!wait)
 			return 0;
-		cpu_relax();
+		hwrng_msleep(rng, 1000);
 	}
 
 	num_words = rng_readl(priv, RNG_STATUS) >> 24;
-- 
2.37.3

