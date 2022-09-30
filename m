Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE55F049E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiI3GOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiI3GOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:14:24 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F40139402;
        Thu, 29 Sep 2022 23:14:23 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oe9Hd-00A54M-Ue; Fri, 30 Sep 2022 16:14:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Sep 2022 14:14:01 +0800
Date:   Fri, 30 Sep 2022 14:14:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] crypto: marvell/octeontx - prevent integer overflows
Message-ID: <YzaJKX686KiMteCe@gondor.apana.org.au>
References: <YygPh/RTMxucazLl@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YygPh/RTMxucazLl@kili>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:43:19AM +0300, Dan Carpenter wrote:
> The "code_length" value comes from the firmware file.  If your firmware
> is untrusted realistically there is probably very little you can do to
> protect yourself.  Still we try to limit the damage as much as possible.
> Also Smatch marks any data read from the filesystem as untrusted and
> prints warnings if it not capped correctly.
> 
> The "code_length * 2" can overflow.  The round_up(ucode_size, 16) +
> sizeof() expression can overflow too.  Prevent these overflows.
> 
> Fixes: d9110b0b01ff ("crypto: marvell - add support for OCTEON TX CPT engine")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: In the first commit, I accidentally added some unnecessary checks.
>     Those were only drafts and I sent them uninitentionally.  Sorry!
> 
>  .../crypto/marvell/octeontx/otx_cptpf_ucode.c  | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
