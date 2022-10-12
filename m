Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAD5FC91F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJLQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJLQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:22:31 -0400
X-Greylist: delayed 632 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 09:22:20 PDT
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [IPv6:2a00:1ed0:2:0:1:5bef:c8ee:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12CFDED21;
        Wed, 12 Oct 2022 09:22:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smtp.cesky-hosting.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
        s=rampa2-202208; t=1665591114;
        bh=Kxemadi69pFkVKEwR5Ct+aURnZswpdi+grRKg9XSUXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAJz+2sz2IMgY6tsPsXGxVq5bdbCyOqe0lEq1PgQ5u3JnITtPyURer2dO+loY7E5x
         ES28+H560S8Lw3Yr6erJ9FdbqY8sQckLpc2YuRtsT+J911nqp+ERQ3aFJPGDP/oXg7
         4jvGrefQ1rnZSwsi6lJYW4AC8ZIQsdPeVv2huIXYWEEL8SOV6M67z+9dm5QpgePIUZ
         6/uzYAvHawwfnfHHQmMEFbrDKJFnem3we8VmIab58vwiJL46zo0WjDDbprT6IdSQ8y
         jWjub3fTeVjqu6L2U/u49zsdHpy1qBqP9VmtcTcvrt6cbQEiVT/B3ztfQgLX+yyu/M
         9D3XpiQJPxiqw==
X-Thin-Conversation: conversation
Received: from localhost.localdomain (unknown [5.181.92.50])
        (Authenticated sender: tomas.marek@elrest.cz)
        by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 81D451498;
        Wed, 12 Oct 2022 18:11:54 +0200 (CEST)
From:   Tomas Marek <tomas.marek@elrest.cz>
To:     mpm@selenic.com, herbert@gondor.apana.org.au
Cc:     mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, oleg.karfich@wago.com,
        Tomas Marek <tomas.marek@elrest.cz>
Subject: [PATCH 1/2] hwrng: stm32 - fix number of returned bytes on read
Date:   Wed, 12 Oct 2022 18:09:23 +0200
Message-Id: <20221012160924.12226-2-tomas.marek@elrest.cz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221012160924.12226-1-tomas.marek@elrest.cz>
References: <20221012160924.12226-1-tomas.marek@elrest.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stm32_rng_read() function uses `retval` variable as a counter of
generated random bytes. However, the same variable is used to store
a result of the polling function in case the driver is waiting until
the TRNG is ready. The TRNG generates random numbers by 16B. One
loop read 4B. So, the function calls the polling every 16B, i.e.
every 4th loop. The `retval` counter is reset on poll call and only
number of bytes read after the last poll call is returned to the
caller. The remaining sampled random bytes (for example 48 out of
64 in case 64 bytes are read) are not used.

Use different variable to store the polling function result and
do not overwrite `retval` counter.

Cc: Oleg Karfich <oleg.karfich@wago.com>
Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
---
 drivers/char/hw_random/stm32-rng.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index bc22178f83e8..8eaacefd498b 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -49,11 +49,13 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 		/* Manage timeout which is based on timer and take */
 		/* care of initial delay time when enabling rng	*/
 		if (!sr && wait) {
-			retval = readl_relaxed_poll_timeout_atomic(priv->base
+			int ret;
+
+			ret = readl_relaxed_poll_timeout_atomic(priv->base
 								   + RNG_SR,
 								   sr, sr,
 								   10, 50000);
-			if (retval)
+			if (ret)
 				dev_err((struct device *)priv->rng.priv,
 					"%s: timeout %x!\n", __func__, sr);
 		}
-- 
2.17.1

