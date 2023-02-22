Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8869FA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjBVRr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBVRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:47:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA2366B0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:47:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E64CB815CF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB580C433D2;
        Wed, 22 Feb 2023 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677088040;
        bh=9I7KWoSq6/peLkMkNptPqDdgYxCmYBYm3Szm50B41jA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hwnSWLm4zNHhA4NWmCQbvJvyi4NswIDoXr9WL1al+NEP3yIQKxjxuGmADuOAjV3dl
         5oIWV3Zd690KwaIMk3PPQ0QZBnzerI83M2NrwPW7B14SBJWhjmZkp3dyBWxLWAHsHk
         qPdCKG0AWJWdP/ObaDBCiX4zoJjEDjdp+Ez8R2I/l1hRIBv/LrY4L1jIlT9ifZcsxO
         7JEm5fN+7zbRpI8UiNprdg6YX/ekIk3obpq6YnyTK7BAjyogrDkE2XyYAympFOYFM/
         1WHrji1GinAghmbzzR+fnoGlKHxYOk0cDbPVIMQjLnTnMLrDGK3h3rVLUkRxY33TSL
         OF+ve6zQTG7gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 968D95C09C7; Wed, 22 Feb 2023 09:47:19 -0800 (PST)
Date:   Wed, 22 Feb 2023 09:47:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/powerpc/include/asm/barrier.h: redefine rmb and
 wmb to  lwsync
Message-ID: <20230222174719.GA1400185@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 02:33:44PM +0530, Kautuk Consul wrote:
> A link from ibm.com states:
> "Ensures that all instructions preceding the call to __lwsync
>  complete before any subsequent store instructions can be executed
>  on the processor that executed the function. Also, it ensures that
>  all load instructions preceding the call to __lwsync complete before
>  any subsequent load instructions can be executed on the processor
>  that executed the function. This allows you to synchronize between
>  multiple processors with minimal performance impact, as __lwsync
>  does not wait for confirmation from each processor."
> 
> Thats why smp_rmb() and smp_wmb() are defined to lwsync.
> But this same understanding applies to parallel pipeline
> execution on each PowerPC processor.
> So, use the lwsync instruction for rmb() and wmb() on the PPC
> architectures that support it.
> 
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/barrier.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index b95b666f0374..e088dacc0ee8 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -36,8 +36,15 @@
>   * heavy-weight sync, so smp_wmb() can be a lighter-weight eieio.
>   */
>  #define __mb()   __asm__ __volatile__ ("sync" : : : "memory")
> +
> +/* The sub-arch has lwsync. */
> +#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
> +#define __rmb() __asm__ __volatile__ ("lwsync" : : : "memory")
> +#define __wmb() __asm__ __volatile__ ("lwsync" : : : "memory")

Hmmm...

Does the lwsync instruction now order both cached and uncached accesses?
Or have there been changes so that smp_rmb() and smp_wmb() get this
definition, while rmb() and wmb() still get the sync instruction?
(Not seeing this, but I could easily be missing something.)

							Thanx, Paul

> +#else
>  #define __rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define __wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> +#endif
>  
>  /* The sub-arch has lwsync */
>  #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
> -- 
> 2.31.1
> 
