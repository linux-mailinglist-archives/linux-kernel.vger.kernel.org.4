Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97C3621786
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiKHO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiKHO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:57:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9CF21AC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20DF7B81B08
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4607C433D7;
        Tue,  8 Nov 2022 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667919423;
        bh=8/7+dZAfZ4oLmH8C5GDxy0YK9sTb0CaI2LgkvYa7ypQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRp4TDwm4I6QtzjpO11Izbisr1RkIA9BCxRVOMSVPsbk18zDUBJ9ttSLeJHbIfbf9
         L1eSjllGAic8am5jy6YYT56gFXtkN/46a3IxdvLgU+ksVStZxfofSJGjQZJhKgwEhL
         bNXDRi1yAal0PXnhf4o4WEKMXE8FWJ40A6j5W05XrVQEr/VWtQFbMVinKMYgQIHaDL
         8URElVjmbBaraVEzwEaDDdN5RBwKKjb/aWjNI/B4B6AztrPlxCQzfFv1glqW3oBTiW
         RhXlSkPTse1RWcr9pHvmDc8i92xJQr1Q2q4rb2LSKHXdfaDRANkdCDJGhOQeVmiqa+
         /3iQgOV061IJA==
Date:   Tue, 8 Nov 2022 14:56:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Subject: Re: [PATCH v2] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <20221108145656.GA23059@willie-the-truck>
References: <20221107172400.1851434-1-ardb@kernel.org>
 <Y2pqlmlro/aICn+u@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pqlmlro/aICn+u@FVFF77S0Q05N.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:41:26PM +0000, Mark Rutland wrote:
> On Mon, Nov 07, 2022 at 06:24:00PM +0100, Ard Biesheuvel wrote:
> > diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> > index 8b02d310838f9240..3032a82ea51a19f7 100644
> > --- a/arch/arm64/kernel/suspend.c
> > +++ b/arch/arm64/kernel/suspend.c
> > @@ -60,6 +60,8 @@ void notrace __cpu_suspend_exit(void)
> >  	 * PSTATE was not saved over suspend/resume, re-enable any detected
> >  	 * features that might not have been set correctly.
> >  	 */
> > +	if (cpu_has_dit())
> > +		set_pstate_dit(1);
> 
> As above, I'd prefer if we either renamed cpu_has_dit() to cpus_have_dit(), or
> just open-coded this as:
> 
> 	if (cpus_have_const_cap(ARM64_HAS_DIT))
> 		set_pstate_dit(1);
> 
> With either of those options:
> 
>   Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> I assume Will might fix that up when applying.

Yup, I'll take care of that.

Will
