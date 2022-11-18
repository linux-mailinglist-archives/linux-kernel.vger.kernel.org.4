Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC36F62F6D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbiKROKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKROKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:10:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777711160
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC7C3B8240C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35637C433C1;
        Fri, 18 Nov 2022 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668780597;
        bh=YlqOyLJmIJmPUAIiq8dJcBPhanVtu3o0KNlHKw+/3bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGLEFppErUJSp8zXdsG5EEFU9xNMZm/+sI72TaPWUdMOj+KBpAlL0FJMvOm7YRzx7
         tz/4jw+/O0g1qohJ2QSNCehqag+Xjzks8GC5MbOulByYnzvH+7RluaH5aph1eiX3QH
         TPHNYNSRMmYEMf8LV3rEKka+1ExVA2x5L2tDbkQ//ZNr6WroguvqZSt/pT2mVHKa/2
         n0zkrAbi3QAUg1dNcLn6E4zzWGaFQnjy7V1zIGUikMOub7IffqL3gEktHWYx5rK+TF
         Bxm8U7rQRmoFg9HDv8Vbk7JWwIjGt7qSjXW3crWtQ1idvSbzup8wHOg4/7JBW3vpbf
         MSOpGDpudMaIA==
Date:   Fri, 18 Nov 2022 14:09:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 4/4] ftrace: arm64: move from REGS to ARGS
Message-ID: <20221118140951.GE4046@willie-the-truck>
References: <20221103170520.931305-1-mark.rutland@arm.com>
 <20221103170520.931305-5-mark.rutland@arm.com>
 <20221115112701.GB32523@willie-the-truck>
 <Y3YRqvfYOP+RBk8r@FVFF77S0Q05N>
 <20221118123149.GB3697@willie-the-truck>
 <Y3ePYOxwPbSzxhoZ@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ePYOxwPbSzxhoZ@FVFF77S0Q05N.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:57:52PM +0000, Mark Rutland wrote:
> On Fri, Nov 18, 2022 at 12:31:50PM +0000, Will Deacon wrote:
> > On Thu, Nov 17, 2022 at 10:52:15AM +0000, Mark Rutland wrote:
> > > On Tue, Nov 15, 2022 at 11:27:03AM +0000, Will Deacon wrote:
> > > > On Thu, Nov 03, 2022 at 05:05:20PM +0000, Mark Rutland wrote:
> > > > > +static __always_inline unsigned long
> > > > > +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> > > > > +{
> > > > > +	if (n < 8)
> > > > > +		return fregs->regs[n];
> > > > 
> > > > Where does this '8' come from?
> > > 
> > > Because in AAPCS64 the arguments are in x0 to x7, as mentioned in the commit
> > > message:
> > > 
> > > | Per AAPCS64, all function call argument and return values are held in
> > > | the following GPRs:
> > > | 
> > > | * X0 - X7 : parameter / result registers
> > > | * X8      : indirect result location register
> > > | * SP      : stack pointer (AKA SP)
> > > 
> > > The 'indirect result location register' would be used when returning large
> > > structures, and isn't a function argument as such.
> > 
> > Ah gotcha, I was mainly wondering about the role of x8 in 'struct
> > ftrace_regs', but now I see that the FETCH_OP_REG might want to get at that.
> 
> Ah, I see. Should I just add the bits above from the commit message into a
> comment block above the definition of struct ftrace_regs ?

Nah, it's ok, mainly just me learning what this is doing and I've queued it
locally now.

Will
