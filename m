Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6C631224
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 02:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiKTBkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 20:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKTBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 20:40:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB0B94AD;
        Sat, 19 Nov 2022 17:40:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A402060BCB;
        Sun, 20 Nov 2022 01:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F92EC433D6;
        Sun, 20 Nov 2022 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668908406;
        bh=mB2/5SFy2jr4OJagL4mr8wczTaB3RfCbSmiQnv5noa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5nq+us05sEucQ4RJRBz5n6pXnWIBxZo6AvKSt7WtLvvmxC2q8kgGEci49G0FEKMT
         R0cptdirpgBxNX303fr0yMWEkWQw4j1e42S21cywB1YXa9hGiDHaS65lvGeJX6KjMs
         Jyq30v5N2jWc2hmdwGXwQnoIiFRX9YR8dY8OyiGoMIg1Xm0QI32iXwilgwpTvLFGP3
         tnmHb+371mqvMfXx0zl9lDXExjGT7NV9sorUk3JCI1ISrRMggtGpY22Dsu7t0VeaCl
         vVOdQTp5OmwjeP1qjPYYIbl7HnMJT89KpssX5Q7Z8du7uEPNmvxbjwIl9jzh7weVMf
         sstirvDV/4+1w==
Date:   Sat, 19 Nov 2022 17:40:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v5 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <Y3mFdMVowWj+VaXx@sol.localdomain>
References: <20221119120929.2963813-1-Jason@zx2c4.com>
 <20221119120929.2963813-2-Jason@zx2c4.com>
 <Y3k+/hSL5rIIkBhK@sol.localdomain>
 <Y3ltyzxIPwniRNW5@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ltyzxIPwniRNW5@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 12:59:07AM +0100, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Sat, Nov 19, 2022 at 12:39:26PM -0800, Eric Biggers wrote:
> > On Sat, Nov 19, 2022 at 01:09:27PM +0100, Jason A. Donenfeld wrote:
> > > +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned long __user *, num,
> > > +		unsigned long __user *, size_per_each, unsigned int, flags)
> > > +{
> > > +	unsigned long alloc_size;
> > > +	unsigned long num_states;
> > > +	unsigned long pages_addr;
> > > +	int ret;
> > > +
> > > +	if (flags)
> > > +		return -EINVAL;
> > > +
> > > +	if (get_user(num_states, num))
> > > +		return -EFAULT;
> > > +
> > > +	alloc_size = size_mul(num_states, sizeof(struct vgetrandom_state));
> > > +	if (alloc_size == SIZE_MAX)
> > > +		return -EOVERFLOW;
> > > +	alloc_size = roundup(alloc_size, PAGE_SIZE);
> > 
> > Small detail: the roundup to PAGE_SIZE can make alloc_size overflow to 0.
> > 
> > Also, 'roundup(alloc_size, PAGE_SIZE)' could be 'PAGE_ALIGN(alloc_size)'.
> 
> Good catch, thanks. So perhaps this?
> 
>         alloc_size = size_mul(num_states, sizeof(struct vgetrandom_state));
>         if (alloc_size > SIZE_MAX - PAGE_SIZE + 1)
>                 return -EOVERFLOW;
>         alloc_size = PAGE_ALIGN(alloc_size);
> 
> Does that look right?

Yes.  Maybe use 'SIZE_MAX & PAGE_MASK'?

Another alternative is the following:

	if (num_states >
	    (SIZE_MAX & PAGE_MASK) / sizeof(struct vgetrandom_state))
		return -EOVERFLOW;
	alloc_size = PAGE_ALIGN(num_states * sizeof(struct vgetrandom_state));

- Eric
