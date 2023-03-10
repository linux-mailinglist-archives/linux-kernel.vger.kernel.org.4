Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F26B3D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCJLR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCJLRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:17:38 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D68710A2B8;
        Fri, 10 Mar 2023 03:17:36 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paakY-002Xni-52; Fri, 10 Mar 2023 19:17:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:17:26 +0800
Date:   Fri, 10 Mar 2023 19:17:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: caam - reduce page 0 regs access to minimum
Message-ID: <ZAsRxvI71MvsbNMp@gondor.apana.org.au>
References: <20230302062055.1564514-1-meenakshi.aggarwal@nxp.com>
 <20230302062055.1564514-2-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302062055.1564514-2-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:50:54AM +0530, meenakshi.aggarwal@nxp.com wrote:
> From: Horia GeantA <horia.geanta@nxp.com>
> 
> Use job ring register map, in place of controller register map
> to access page 0 registers, as access to the controller register
> map is not permitted.
> 
> Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/caamalg.c  | 21 +++++-----
>  drivers/crypto/caam/caamhash.c | 10 +++--
>  drivers/crypto/caam/caampkc.c  |  6 +--
>  drivers/crypto/caam/caamrng.c  |  6 +--
>  drivers/crypto/caam/ctrl.c     | 74 +++++++++++++++++++++-------------
>  drivers/crypto/caam/debugfs.c  |  8 ++--
>  drivers/crypto/caam/debugfs.h  |  7 +++-
>  7 files changed, 78 insertions(+), 54 deletions(-)

With these two patches I get:

  CHECK   ../drivers/crypto/caam/ctrl.c
../drivers/crypto/caam/ctrl.c:706:27: warning: cast removes address space '__iomem' of expression
../drivers/crypto/caam/ctrl.c:705:27: warning: cast removes address space '__iomem' of expression
../drivers/crypto/caam/ctrl.c:705:17: warning: incorrect type in assignment (different address spaces)
../drivers/crypto/caam/ctrl.c:705:17:    expected struct caam_perfmon [noderef] __iomem *perfmon
../drivers/crypto/caam/ctrl.c:705:17:    got struct caam_perfmon *
../drivers/crypto/caam/ctrl.c:836:37: warning: incorrect type in argument 2 (different address spaces)
../drivers/crypto/caam/ctrl.c:836:37:    expected struct caam_perfmon *perfmon
../drivers/crypto/caam/ctrl.c:836:37:    got struct caam_perfmon [noderef] __iomem *perfmon
../drivers/crypto/caam/ctrl.c:881:32: warning: cast removes address space '__iomem' of expression
../drivers/crypto/caam/ctrl.c:880:32: warning: cast removes address space '__iomem' of expression
../drivers/crypto/caam/ctrl.c:880:22: warning: incorrect type in assignment (different address spaces)
../drivers/crypto/caam/ctrl.c:880:22:    expected struct version_regs [noderef] __iomem *vreg
../drivers/crypto/caam/ctrl.c:880:22:    got struct version_regs *
../drivers/crypto/caam/ctrl.c:450: warning: Function parameter or member 'perfmon' not described in 'caam_get_era'
../drivers/crypto/caam/ctrl.c:450: warning: Excess function parameter 'ctrl' description in 'caam_get_era'

Please always make sure your code compiles cleanly with C=1 W=1.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
