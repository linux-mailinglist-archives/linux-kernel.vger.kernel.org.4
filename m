Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244B363FFB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 06:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiLBFFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 00:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLBFFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 00:05:30 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A30CFE40;
        Thu,  1 Dec 2022 21:05:28 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p0yEe-00371q-Db; Fri, 02 Dec 2022 13:05:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 13:05:16 +0800
Date:   Fri, 2 Dec 2022 13:05:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] crypto/caam: Avoid GCC constprop bug warning
Message-ID: <Y4mHjKXnF/4Pfw5I@gondor.apana.org.au>
References: <20221202010410.gonna.444-kees@kernel.org>
 <Y4loCFGhxecG6Ta0@gondor.apana.org.au>
 <202212011928.97A43D01@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212011928.97A43D01@keescook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 07:30:22PM -0800, Kees Cook wrote:
>
> Getting rid of the if doesn't solve the warning. I can switch it to just
> "if (data)", though. That keeps GCC happy.

OK I misread the thread.

Anyhow, it appears that this warning only occurs due to a debug
printk in caam.  So how about something like this?

diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index 62ce6421bb3f..b49c995e1cc6 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -163,7 +163,7 @@ static inline void append_data(u32 * const desc, const void *data, int len)
 {
 	u32 *offset = desc_end(desc);
 
-	if (len) /* avoid sparse warning: memcpy with byte count of 0 */
+	if (!IS_ENABLED(CONFIG_CRYPTO_DEV_FSL_CAAM_DEBUG) || data)
 		memcpy(offset, data, len);
 
 	(*desc) = cpu_to_caam32(caam32_to_cpu(*desc) +

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
