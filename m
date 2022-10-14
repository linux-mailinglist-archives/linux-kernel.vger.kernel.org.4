Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5627B5FECE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJNLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJNLGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:06:53 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F01C3E43;
        Fri, 14 Oct 2022 04:06:50 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ojIWF-00EgYJ-Ny; Fri, 14 Oct 2022 22:06:24 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Oct 2022 19:06:23 +0800
Date:   Fri, 14 Oct 2022 19:06:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw_random: bcm2835: use hwrng_msleep() instead of
 cpu_relax()
Message-ID: <Y0lCr9f0fekMgASN@gondor.apana.org.au>
References: <Y0QjkjU4bsOHWFOd@sirena.org.uk>
 <20221010150607.720600-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010150607.720600-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> 
>  drivers/char/hw_random/bcm2835-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
