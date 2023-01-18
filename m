Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE990671E10
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjARNgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjARNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:36:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B35AA4D;
        Wed, 18 Jan 2023 05:05:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674047129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZaIjrzhvVg9jpiqi2HTixsDbSaXaIdATroe2BmK7u8=;
        b=Eq700/picnYdhBtQy1p726vv/TLVIwnpnWNT+krWpkyrEoJ0lMc1UxOB7mAX5X2tLjShtu
        of4UG5nvdBZG30dD2CtrWRfc8jggFE5RJk0Pfe/FmY7ALaN03fzKkv6nAmb6RiI8Z2Lxo3
        ewAbdlN/HpLQrekdqqDde3n7j504IFfGJzMj/x25nMNE+qTG997KUtEKcKcWxyt078VBRT
        6u3Uhm/bTDrIE4j38avwZCLOm6968BZ6+hsAN00vtN08pMimx8SbAqT25rk4sZN0pjxD85
        OLGFaW46nNwFnCZzjKzdsQ+NiQwhWpGYCMOmEXAHUefTRH3hC1ifZYwm+C3nrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674047129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZaIjrzhvVg9jpiqi2HTixsDbSaXaIdATroe2BmK7u8=;
        b=v0dQgim9ekA7YGFRhrRSgwJtx1R+dmhRXTihTnGp0SDMuGAWpQOy6mtYyQ9PfV/h2SZmyE
        eLReQIWvKXg1LCDw==
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 06/19] irqdomain: Drop revmap mutex
In-Reply-To: <Y8e6Us0Qgt0p5S4R@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-7-johan+linaro@kernel.org> <871qnslut3.ffs@tglx>
 <Y8e6Us0Qgt0p5S4R@hovoldconsulting.com>
Date:   Wed, 18 Jan 2023 14:05:29 +0100
Message-ID: <87r0vshu1y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18 2023 at 10:22, Johan Hovold wrote:
> On Tue, Jan 17, 2023 at 10:23:20PM +0100, Thomas Gleixner wrote:
>> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
>> > The global irq_domain_mutex is now held in all paths that update the
>> > revmap structures so there is no longer any need for the revmap mutex.
>> 
>> This can also go after the 3rd race fix, but ...
>> 
>> >  static void irq_domain_clear_mapping(struct irq_domain *domain,
>> >  				     irq_hw_number_t hwirq)
>> >  {
>> > +	lockdep_assert_held(&irq_domain_mutex);
>> 
>> these lockdep asserts want to be part of the [dis]association race
>> fixes. They are completely unrelated to the removal of the revmap_mutex.
>
> No, they are very much related to the removal of the revmap_mutex. These
> functions deal with the revmap structures which before this patch were
> clearly only modified with the revmap_mutex held.
>
> The lockdep assert is here to guarantee that my claim that all current
> (and future) paths that end up modifying these structures do so under
> the irq_domain_mutex instead.
>
>> Your race fixes change the locking and you want to ensure that all
>> callers comply right there, no?
>
> I want to make sure that all callers of these function comply, yes.
> That's why the asserts belong in this patch.

You can do this in a two step approach.

    1) Add the new locking and ensure that the lock is held when
       the functions are called

    2) Safely remove the revmap_mutex because you already established
       that revmap is protected by some other means

Thanks,

        tglx
