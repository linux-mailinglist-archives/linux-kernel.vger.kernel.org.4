Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2556873C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjBBDZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBDZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:25:49 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474784FAE7;
        Wed,  1 Feb 2023 19:25:48 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pNQE9-006bCQ-NC; Thu, 02 Feb 2023 11:25:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Feb 2023 11:25:33 +0800
Date:   Thu, 2 Feb 2023 11:25:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH-next] crypto: aspeed: fix type warnings
Message-ID: <Y9stLeguRuQVpbiD@gondor.apana.org.au>
References: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
 <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
 <TY2PR06MB321395387369059BC9F9722E80D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR06MB321395387369059BC9F9722E80D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:23:29AM +0000, Neal Liu wrote:
>
> I cannot tell which way is better. Do you prefer to keep the iomem marker?

The whole point of iomem is to prevent you from directly
dereferencing that memory.  So casting it away to remove the
warning simply defeats its purpose.

If you're worried about the overhead of readb perhaps you can
look into readb_relaxed after considering the effects of the
barriers.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
