Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1036380DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 23:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKXWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 17:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 17:20:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13F4EC28;
        Thu, 24 Nov 2022 14:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 743FA62268;
        Thu, 24 Nov 2022 22:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A604C433B5;
        Thu, 24 Nov 2022 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669328420;
        bh=XH4bQAQgI4eseVSTFvlZqCEPFCpPt/Y+lqbzeKYOX/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C18BI9AaVGnv9hcWoLeKvBfykg0tURljrRA9kdalMSWJ4A4V7N2qtX2OLbCRI3Hk3
         2H+g3iUbiPsu09WN59DcAgXM2jUJs2gr+pQtxuWjpKGEKVAtfCVQI9yYz5u6jptIsc
         aHfZSF3adyEUf/d3L1my194gi5WIL6NjsdY4Pc3DpGbbf2JO4NFiSL+mCPA06mnQgX
         raKLVur2feyLf8zVc/uKQ1aoM+zSI8zVAkHi8/GqN3ZAfP29tTBap1iQtskLEvm8+L
         684yMjb6Oy3Hn0efq+vNVYNeTux0MXoCcrRUVWVguuuQ3Yul7MBQKVl38ZqYXyUFmP
         NLVvnle7IuAew==
Date:   Thu, 24 Nov 2022 22:20:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 2/4] Documentation: RISC-V: Allow patches for
 non-standard behavior
Message-ID: <Y3/uIOxnm3pNHLEJ@spud>
References: <20221013045619.18906-1-palmer@rivosinc.com>
 <20221013045619.18906-3-palmer@rivosinc.com>
 <alpine.DEB.2.21.999.2211181027590.4480@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.2211181027590.4480@utopia.booyaka.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Paul,
I thought you'd got an answer but noticed today you'd not so...

On Fri, Nov 18, 2022 at 10:49:18AM +0000, Paul Walmsley wrote:
> Hi, 
> 
> On Wed, 12 Oct 2022, Palmer Dabbelt wrote:
> 
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> > 
> > The patch acceptance policy forbids accepting support for non-standard
> > behavior.  This policy was written in order to both steer implementers
> > towards the standards and to avoid coupling the upstream kernel too
> > tightly to vendor-specific features.  Those were good goals, but in
> > practice the policy just isn't working: every RISC-V system we have
> > needs vendor-specific behavior in the kernel and we end up taking that
> > support which violates the policy.  That's confusing for contributors,
> > which is the main reason we have a written policy in the first place.
> > 
> > So let's just start taking code for vendor-defined behavior.
> 
> I think I understand the motivation behind this patch: to align the stated 
> patch acceptance policy with the actual maintenance practice for 
> arch/riscv.  Along those lines, how about the following tweaks, based on 
> your original patch?
> 
> Probably the most significant proposed change from what you wrote is to 
> temporarily drop the section about accepting patches for hardware that 
> doesn't yet exist.
> I know arch/x86 does this,

IIRC it was x86 that was cited as the example at LPC...

> but my recollection is that 
> the maintainers there started doing that after the key x86 hardware 
> manufacturers established a track record of consistently releasing 
> mass-market hardware that implemented what they promised.

> Not sure we're at that point with RISC-V yet.

... and you're probably not wrong there either.

> We'll get there at some point, but maybe 
> we can add that clause back in once that happens?

> 
> From: Paul Walmsley <paul.walmsley@sifive.com>
> Date: Fri, 18 Nov 2022 02:16:17 -0600
> Subject: [PATCH] Documentation: RISC-V: Allow patches for widely available
>  hardware
> 
> This patch, based on an earlier patch from Palmer, updates the patch
> acceptance policy to note that the maintainers may also accept patches
> for RISC-V hardware that contains features that may not be strictly
> RISC-V-compliant, but which is widely available.  The intention here
> is to align the stated policy with the de-facto upstream Linux policy.

NGL, this commit message is kinda confusing. If this version is used
instead of Palmer's, then any mention of the earlier patch should be
dropped IMO. In fact, his original commit message should apply here too,
no?

> Link: https://lore.kernel.org/linux-riscv/20221013045619.18906-3-palmer@rivosinc.com/  # Palmer's original patch
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  Documentation/riscv/patch-acceptance.rst | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
> index 5da6f9b273d6..2e3f9ecdd977 100644
> --- a/Documentation/riscv/patch-acceptance.rst
> +++ b/Documentation/riscv/patch-acceptance.rst
> @@ -29,7 +29,12 @@ their own custom extensions.  These custom extensions aren't required
>  to go through any review or ratification process by the RISC-V
>  Foundation.  To avoid the maintenance complexity and potential
>  performance impact of adding kernel code for implementor-specific
> +RISC-V extensions, we'll only consider patches for extensions that
> +either:
> +
> +- Have been officially frozen or ratified by the RISC-V Foundation, or
> +- Have been implemented in hardware that is widely available, per standard
> +  Linux practice
> +
> +(Implementors, may, of course, maintain their own Linux kernel
> +trees containing code for any custom extensions that they wish.)

I have no preference for whichever version, but I think some of the
people at LPC did want to be able to add support for stuff that was not
publicly available who may have one ;)

Folded into the original, I guess this one also is:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Certainly less headache potential this way,
Conor.

