Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E15FA136
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJJPhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJJPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88771BC5;
        Mon, 10 Oct 2022 08:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED6C660F69;
        Mon, 10 Oct 2022 15:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293DBC433C1;
        Mon, 10 Oct 2022 15:37:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ppcXTPB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665416231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBj5n8AeywXS5nBd6mMPaCC8APWIC2bqj8ZV7OMzNDI=;
        b=ppcXTPB+D/rSVYbNWHtYjGfYdaN+yA7n5mGjk25di8AVpcNxtQSABFIFG1CpPPJbIXU4tl
        MU+fr/ns+9f2eNYvubOh9Row2wL/0AnrM39wFla0zzfBjmFiuA0Ana3LVk18Wnb/uyRa25
        jck+BzVaDZYmAgC6aK77KsFdlzNReII=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3616f1ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 15:37:11 +0000 (UTC)
Date:   Mon, 10 Oct 2022 09:37:07 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw_random: bcm2835: use hwrng_msleep() instead of
 cpu_relax()
Message-ID: <Y0Q8I6YXsBNLBiix@zx2c4.com>
References: <Y0QjkjU4bsOHWFOd@sirena.org.uk>
 <20221010150607.720600-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221010150607.720600-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 09:06:07AM -0600, Jason A. Donenfeld wrote:
> Rather than busy looping, yield back to the scheduler and sleep for a
> bit in the event that there's no data. This should hopefully prevent the
> stalls that Mark reported:
> 
> <6>[    3.362859] Freeing initrd memory: 16196K
> <3>[   23.160131] rcu: INFO: rcu_sched self-detected stall on CPU
> <3>[   23.166057] rcu:  0-....: (2099 ticks this GP) idle=03b4/1/0x40000002 softirq=28/28 fqs=1050
> <4>[   23.174895]       (t=2101 jiffies g=-1147 q=2353 ncpus=4)
> <4>[   23.180203] CPU: 0 PID: 49 Comm: hwrng Not tainted 6.0.0 #1
> <4>[   23.186125] Hardware name: BCM2835
> <4>[   23.189837] PC is at bcm2835_rng_read+0x30/0x6c
> <4>[   23.194709] LR is at hwrng_fillfn+0x71/0xf4
> <4>[   23.199218] pc : [<c07ccdc8>]    lr : [<c07cb841>]    psr: 40000033
> <4>[   23.205840] sp : f093df70  ip : 00000000  fp : 00000000
> <4>[   23.211404] r10: c3c7e800  r9 : 00000000  r8 : c17e6b20
> <4>[   23.216968] r7 : c17e6b64  r6 : c18b0a74  r5 : c07ccd99  r4 : c3f171c0
> <4>[   23.223855] r3 : 000fffff  r2 : 00000040  r1 : c3c7e800  r0 : c3f171c0
> <4>[   23.230743] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
> <4>[   23.238426] Control: 50c5387d  Table: 0020406a  DAC: 00000051
> <4>[   23.244519] CPU: 0 PID: 49 Comm: hwrng Not tainted 6.0.0 #1
> 
> Link: https://lore.kernel.org/all/Y0QJLauamRnCDUef@sirena.org.uk/
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> I haven't tested this. Somebody with access to that kernel CI infra that
> triggered this will need to test.

So I succeeded at testing this, sort of. I was able to reproduce the
hang on a CONFIG_PREEMPT=n kernel with this diff:

diff --git a/drivers/net/wireguard/main.c b/drivers/net/wireguard/main.c
index ee4da9ab8013..19e1186f0db0 100644
--- a/drivers/net/wireguard/main.c
+++ b/drivers/net/wireguard/main.c
@@ -15,12 +15,29 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/genetlink.h>
+#include <linux/hw_random.h>
 #include <net/rtnetlink.h>

+static int derp_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	if (wait) {
+		for (;;)
+			cpu_relax();
+	}
+	return 0;
+}
+
+static struct hwrng derp_ops = {
+	.name = "flurpderp",
+	.read = derp_rng_read,
+};
+
 static int __init wg_mod_init(void)
 {
 	int ret;

+	hwrng_register(&derp_ops);
+
 	ret = wg_allowedips_slab_init();
 	if (ret < 0)
 		goto err_allowedips;


Next, I changed the cpu_relax() into hwrng_msleep(), as this patch does:

diff --git a/drivers/net/wireguard/main.c b/drivers/net/wireguard/main.c
index ee4da9ab8013..19e1186f0db0 100644
--- a/drivers/net/wireguard/main.c
+++ b/drivers/net/wireguard/main.c
@@ -15,12 +15,29 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/genetlink.h>
+#include <linux/hw_random.h>
 #include <net/rtnetlink.h>

+static int derp_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	if (wait) {
+		for (;;)
+			hwrng_msleep(rng, 1000);
+	}
+	return 0;
+}
+
+static struct hwrng derp_ops = {
+	.name = "flurpderp",
+	.read = derp_rng_read,
+};
+
 static int __init wg_mod_init(void)
 {
 	int ret;

+	hwrng_register(&derp_ops);
+
 	ret = wg_allowedips_slab_init();
 	if (ret < 0)
 		goto err_allowedips;

And then the problem went away.

So I think this patch is a good one.

Jason
