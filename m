Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B26767FF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAUSPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUSPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:15:31 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D92B627
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:15:30 -0800 (PST)
Date:   Sat, 21 Jan 2023 18:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674324928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSLV8t+mHMg9bRk9e6jbKy2QqL7MoxPyHgIADPLc1gw=;
        b=oBvdKsRBk/KCPvMNqQzp8o87W6yFujl67ZzxL8++ppyZmPdtkHvA2GFp99B8TDvnTVdeQh
        pWJyS0yCDMpYHvIhdVFpXa6IkFr0EtYQtAtWmeVisBYHjdhKdersuNwplMQo49DHGaQyYa
        dU2lu1ZuNy6fwOjs8GaspLV05q18rQQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v7 7/7] KVM: arm64: Normalize cache configuration
Message-ID: <Y8wru2IrgHtBIofM@google.com>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
 <20230112023852.42012-8-akihiko.odaki@daynix.com>
 <Y8meCFkrVXurXlTk@google.com>
 <86k01gm6ys.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86k01gm6ys.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Sat, Jan 21, 2023 at 12:02:03PM +0000, Marc Zyngier wrote:
> On Thu, 19 Jan 2023 19:46:16 +0000, Oliver Upton <oliver.upton@linux.dev> wrote:
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 459e6d358dab..b6228f7d1d8d 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -148,17 +148,19 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
> >  
> >  static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
> >  {
> > -	u8 line_size = FIELD_GET(CCSIDR_EL1_LineSize, val);
> > +	u8 line_size = SYS_FIELD_GET(CCSIDR_EL1, LineSize, val);
> > +	u32 cur = get_ccsidr(vcpu, csselr);
> > +	u8 min_line_size = SYS_FIELD_GET(CCSIDR_EL1, LineSize, cur);
> >  	u32 *ccsidr = vcpu->arch.ccsidr;
> >  	u32 i;
> >  
> > -	if ((val & CCSIDR_EL1_RES0) || line_size < get_min_cache_line_size(csselr))
> > +	if (cur == val)
> > +		return 0;
> > +
> > +	if ((val & CCSIDR_EL1_RES0) || line_size < min_line_size)
> >  		return -EINVAL;
> 
> This doesn't look right. You're comparing the value userspace is
> trying to set for a given level with the value that is already set for
> that level, and forbid the cache line size to be smaller. It works if
> no value has been set yet (you fallback to something derived from
> CTR_EL0), but this fails if userspace does multiple writes.

Good catch, I tried to skip over the unit/field conversions by doing this
but it has the consequence of not working as expected for multiple writes.

> The original check is against CTR_EL0, which makes absolute sense
> because we want to check across the whole hierarchy. It is just that
> the original code has two bugs:
> 
> - It fails to convert the CCSIDR_EL1.LineSize value to a number of
>   words (the missing +4). Admire how the architecture is actively
>   designed to be hostile to SW by providing two different formats for
>   the cache line size, none of which is in... bytes.
> 
> - It passes the full CSSELR value to get_min_cache_line_size(), while
>   this function wants a bool... Yes, there are times where you'd want
>   a stronger type system (did anyone say Rust? ;-)

Hey now, if you say it enough times people are going to start getting
ideas ;-P

> I propose that we fold something like the patch below in instead
> (tested with get-reg-list).

Agreed, I've backed out my diff and applied yours. Pushed (with force!)
to my repo now, PTAL.

--
Thanks,
Oliver
