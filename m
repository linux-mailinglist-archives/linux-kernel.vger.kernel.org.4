Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0E70920B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjESIuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjESIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:49:58 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7A2E5A;
        Fri, 19 May 2023 01:49:56 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pzvo6-00AnvM-Df; Fri, 19 May 2023 16:49:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 May 2023 16:49:50 +0800
Date:   Fri, 19 May 2023 16:49:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Alice Guo <alice.guo@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] caam: imx: fix the built-in caam driver cannot match
 soc_id
Message-ID: <ZGc4LqAp4gvsS7qv@gondor.apana.org.au>
References: <20230512151033.1327643-1-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512151033.1327643-1-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:40:33PM +0530, Pankaj Gupta wrote:
> Since, CAAM driver is probed before soc_device_attribute done as part of:
> - drivers/soc/imx/soc-imx8m.c   (for i.MX8M)
> - drivers/firmware/imx/ele_mu.c (EdgeLock Enclave kernel driver, for i.MX8ULP)
> 
> It is needed to return -EPROBE_DEFER, after calling soc_device_match() in
> drivers/crypto/caam/ctrl.c.
> 
> soc_device_match returns NULL for:
> - i.MX8M
> - i.MX8ULP,
> can be considered that the SoC device has not been probed yet.
> Hence, it returns -EPROBE_DEFER directly.
> 
> caam: imx: change to use of_match_node in run_descriptor_deco0
> 
> Providing imx8m_machine_match to match:
> - i.MX8M{Q,M,N,P},
> - i.MX8ULP,
> so as to start using of_match_node, to simplify the code.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
