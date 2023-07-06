Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D47492DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjGFA7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGFA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:59:20 -0400
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613311722
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:59:18 -0700 (PDT)
Date:   Wed, 5 Jul 2023 20:59:16 -0400
From:   Rich Felker <dalias@libc.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Szabolcs Nagy <nsz@port70.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: Re: [RFC PATCH v2] openrisc: Union fpcsr and oldmask in sigcontext
 to unbreak userspace ABI
Message-ID: <20230706005916.GW20050@brightrain.aerifal.cx>
References: <20230705212646.3618706-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705212646.3618706-1-shorne@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:26:45PM +0100, Stafford Horne wrote:
> With commit 27267655c531 ("openrisc: Support floating point user api") I
> inproperly added an entry to the struct sigcontext which caused an
> unwanted to chagne to the userspace ABI.
> 
> Since oldmask was never used in OpenRISC we now use it's space for the
> floating point fpcsr state.  We do this with a union to restore the ABI
> back to the pre kernel v6.4 ABI and keep API compatibility.
> 
> This does mean if there is some code somewhere that is setting oldmask
> in a userspace sighandler it would end up setting the floating point
> register status, but I think it's unlikely as oldmask was never used
> before.
> 
> Fixes: 27267655c531 ("openrisc: Support floating point user api")
> Reported-by: Szabolcs Nagy <nsz@port70.net>
> Closes: https://lore.kernel.org/openrisc/20230626213840.GA1236108@port70.net/
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Changes since v1:
>  - Rather than revert the change, just use the oldmask slot for fpu state.
> 
>  arch/openrisc/include/uapi/asm/sigcontext.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/include/uapi/asm/sigcontext.h b/arch/openrisc/include/uapi/asm/sigcontext.h
> index ca585e4af6b8..93817d7051aa 100644
> --- a/arch/openrisc/include/uapi/asm/sigcontext.h
> +++ b/arch/openrisc/include/uapi/asm/sigcontext.h
> @@ -28,8 +28,10 @@
>  
>  struct sigcontext {
>  	struct user_regs_struct regs;  /* needs to be first */
> -	struct __or1k_fpu_state fpu;
> -	unsigned long oldmask;
> +	union {
> +		struct __or1k_fpu_state fpu;
> +		unsigned long oldmask;	/* unused */
> +	};
>  };
>  
>  #endif /* __ASM_OPENRISC_SIGCONTEXT_H */
> -- 
> 2.39.1

Correctness/ABI-safety of this patch depends on struct
__or1k_fpu_state being just a single unsigned long and never changing.
Is this something it's possible to commit to? Otherwise, a much better
idea would be making the union contain a struct __or1k_fpu_state *
or some more general pointer type that points to an out-of-band,
expandable data structure past the end of the ucontext_t.

Rich
