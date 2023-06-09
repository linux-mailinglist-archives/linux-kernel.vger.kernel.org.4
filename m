Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31F72941A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbjFIJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbjFIJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:04:51 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7562198C;
        Fri,  9 Jun 2023 02:04:27 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q7Y2Y-000vwE-78; Fri, 09 Jun 2023 17:04:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Jun 2023 17:04:14 +0800
Date:   Fri, 9 Jun 2023 17:04:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 2/2] crypto: starfive - Add RSA algo support
Message-ID: <ZILrDjVRdt/pyjvL@gondor.apana.org.au>
References: <20230602025551.874280-1-jiajie.ho@starfivetech.com>
 <20230602025551.874280-3-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602025551.874280-3-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:55:51AM +0800, Jia Jie Ho wrote:
>
> +static inline void starfive_pka_irq_mask_clear(struct starfive_cryp_ctx *ctx)
> +{
> +	struct starfive_cryp_dev *cryp = ctx->cryp;
> +	u32 stat;
> +
> +	reinit_completion(&cryp->pka_done);
> +
> +	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
> +	stat &= ~STARFIVE_IE_MASK_PKA_DONE;
> +	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
> +}

Shouldn't the order of reinit_completion and the register write
be reversed? Otherwise what's to stop a spurious interrupt from
completing pka_done prematurely?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
