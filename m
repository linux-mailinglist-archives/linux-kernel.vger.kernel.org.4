Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432766527CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLTUWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiLTUVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:21:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339841EED1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C060D61572
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C9C433EF;
        Tue, 20 Dec 2022 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671567674;
        bh=tHGz5rErrLmMZswKrJCJRdthAcEj2+aPBGfougwOjec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G34FYUrtRYg9MSVFa2eP9SoW49WUoAfMSA93CucR6zljg7QDsS84SO1TNSTUIzVH/
         IjhHz74cSFBc29V5/aeYy6VOJ5UiraLLtZOmeXgA0cFiAMnWW3wb8U5jL2EldZOLyM
         r4CZLbRhS/wfbmfXQe3CzlAPoNdvTWkakIloSgLeBPAYw5AHMIEhuD/BiGn5wm/EP1
         /OPHUgnF8nsLLkyM93hRTz3uTGfjrT8FCmp9yzAafKpnRzKm2Ku2J+mFF/xw9q+wso
         rKAzUNgg9fv/fky3GLR7872JeJPYKj3BZJqHOLbIzhNgynQQgo/nm2YUiXQyqNFfAy
         +0RJ9t8vIqfYg==
Received: by pali.im (Postfix)
        id B11D7963; Tue, 20 Dec 2022 21:21:11 +0100 (CET)
Date:   Tue, 20 Dec 2022 21:21:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] powerpc/epapr: Don't use wrteei on non booke
Message-ID: <20221220202111.jpxsyviplco6sbsm@pali>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
 <b29c7f1727433b003eae050e44072741c8ac223b.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29c7f1727433b003eae050e44072741c8ac223b.1671475543.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2022 19:46:00 Christophe Leroy wrote:
> wrteei is only for booke. Use the standard mfmsr/ori/mtmsr
> when non booke.
> 
> Reported-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Not sure this is needed at all, the commit that introduced the code says it is for e500, but there's no such limitation in Kconfig. Maybe we should limit all the file to CONFIG_PPC_E500

This ePAPR code is according to ePAPR v1.1. So it does not have to be
e500 specific. But is there anything else in this category?

> ---
>  arch/powerpc/kernel/epapr_hcalls.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
> index 69a912550577..033116e465d0 100644
> --- a/arch/powerpc/kernel/epapr_hcalls.S
> +++ b/arch/powerpc/kernel/epapr_hcalls.S
> @@ -21,7 +21,13 @@ _GLOBAL(epapr_ev_idle)
>  	ori	r4, r4,_TLF_NAPPING	/* so when we take an exception */
>  	PPC_STL	r4, TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
>  
> +#ifdef CONFIG_BOOKE_OR_40x
>  	wrteei	1
> +#else
> +	mfmsr	r4
> +	ori	r4, r4, MSR_EE
> +	mtmsr	r4
> +#endif
>  
>  idle_loop:
>  	LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
> -- 
> 2.38.1
> 
