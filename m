Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A78655813
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 03:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiLXCcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 21:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiLXCcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 21:32:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF1195A7;
        Fri, 23 Dec 2022 18:32:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso6425818pjh.1;
        Fri, 23 Dec 2022 18:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GX+qyGsc0p9ERUYOo7nTONHwRSdpCqjvBlXCvvUgAiY=;
        b=Ni0nL8trQ/GcyMmugbzLyScoRy8/LWxdgSIxeFWu3XczTjfkr4o4IFUo+12B8PtfI5
         sfwC7FxVPJ2tTBBrdIh69JvgJzZ4iIqbpCX60E1AhA7/Q6z5+YNc0Oet0JKiViGAE5Pc
         o1SlgkNtFe1Uhq9iKQ7mUW1NJyiKqKInyNACdgmvQZMvoOkfIg9JFCkW4+HKYBDdE9dy
         nx3+oaOcSkzwDqvIzyzYKAAZ1pf2Z2+wPCt8C6dZSGi9d3gGdR2yahl9jGPxIqK6JB8O
         sqPXH1UKqQAs1CIN6ojlMOjKqq9i/g3bnKnuLZAiMosbQ9LzZfibwBo0FI7XY9bVJWB1
         9gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX+qyGsc0p9ERUYOo7nTONHwRSdpCqjvBlXCvvUgAiY=;
        b=lspy/oI2a20JQ1oe9CTp/uEwm2rpX5Z5r8eJ1fJR0i2VJ5bS0W7Q0xXbbV6yJFB9im
         i+kH0ka4KAgFbi+JKzPQTIpdBPIZB7qhpLrnmLwG8azkf8j4WsgGPWQbPP60bCdGehix
         xPAD7o76y4yaQYv0CpmLz8SX3pMwPfSvTsRd1jXZzijDWkDlvwOl9xQ+yhKMWdiAEnNB
         Demo512ppKpaioxfJ49YGNihdnu7gu7w0pnge9+j3MlBQhBQA4hjh7zX/WGRIb8E26XI
         4k1d77oGEHtvIFs0zvISPJTkeL9nuVsVUkTrSR8/uODvbn4jfTpuu3BlS40UYLMlgUKm
         98lQ==
X-Gm-Message-State: AFqh2kqwfOtuyUyKyZl5eJapf7fYX9J5cfhGcVPUbLh0TK9411dUNJus
        us6LiJ7cxM9Aj8rWfffkKSTPD0SUr1Y=
X-Google-Smtp-Source: AMrXdXsRW+k6i7keBCvLhs7V77NwMATR/Sab+rClNQuMsRvzfyoRwxtMxUCqt2GADHBNJOyNW/8ogQ==
X-Received: by 2002:a17:902:a708:b0:187:467f:c76c with SMTP id w8-20020a170902a70800b00187467fc76cmr11682112plq.51.1671849121449;
        Fri, 23 Dec 2022 18:32:01 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902c9d200b0018930dbc560sm3008598pld.96.2022.12.23.18.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 18:32:01 -0800 (PST)
Date:   Sat, 24 Dec 2022 15:31:58 +1300
From:   Daniel Beer <dlbeer@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ad_sigma_delta: fix race between IRQ and completion
Message-ID: <20221224023158.GA254443@nyquist.nev>
References: <63a01acb.a70a0220.9a08f.987d@mx.google.com>
 <20221223161659.7652c95c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223161659.7652c95c@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 04:16:59PM +0000, Jonathan Cameron wrote:
> > ad_sigma_delta waits for a conversion which terminates with the firing
> > of a one-shot IRQ handler. In this handler, the interrupt is disabled
> > and a completion is set.
> > 
> > Meanwhile, the thread that initiated the conversion is waiting on the
> > completion to know when the conversion happened. If this wait times out,
> > the conversion is aborted and IRQs are disabled. But the IRQ may fire
> > anyway between the time the completion wait times out and the disabling
> > of interrupts. If this occurs, we get a double-disabled interrupt.
> 
> Ouch and good work tracking it down.  just to check, did you see this
> bug happen in the wild or spotted by code inspection?

Hi Jonathan,

Thanks for reviewing. It was by inspection -- I'd originally thought
about it and fixed in in a similar way in this patch:

    https://lore.kernel.org/all/61dd3e0c.1c69fb81.cea15.8d98@mx.google.com/

But since that's not applied, I thought I'd better put together a
separate fix for the time being.

> Given that timeout generally indicates hardware failure, I'm not sure
> how critical this is to fix.

Probably not very critical. I think you'd have to be pretty unlucky to
encounter it.

> Is this fix sufficient?  If the interrupt is being handled on a different
> CPU to the caller of this function, I think we can still race enough that
> this fails to fix it up.  Might need a spinlock to prevent that.
> 
>   CPU 0                                        CPU 1
> ad_sd_data_rdy_trig_poll()               ad_sd_wait_and_disable()
>                                        
>                                          //wait_for_completion ends
> 					
> Interrupt
>                                           disable_irq()
> 					  if (sigma-delta->irq_dis) !true	
> 					  else
> 						sigma_delta->irq_dis = true
> 
> disable_irq_nosync(irq)
> sigma_delta->irq_dis = true;
> 
> So we still end up with a doubly disabled irq.  Add a spinlock to make the
> disable and the setting of sigma_delta->irq_dis atomic then it should all be fine.                

My understanding is that the suffix-less version of disable_irq would
wait for all running handlers on other CPUs (i.e.
ad_sd_data_rdy_trig_poll) to finish before proceeding, which would
prevent this from happening. Is that not the case?

But now that you mention it, there is another small problem: in the case
where the conversion doesn't time out, the interrupt handler will call
complete() and then perform some operations on the struct
ad_sigma_delta.

This is always ok on a single processor, but if there are multiple CPUs
there is possibly a brief period where both the interrupt handler and
the waiting thread are accessing the ad_sigma_delta struct without
synchronization between them.

Not sure if that's really a problem in practice, but I think an easy way
to rule it out would just be to move the complete() call to the bottom
of the handler and make sure it doesn't touch the structure again after
that.

Cheers,
Daniel

-- 
Daniel Beer <dlbeer@gmail.com> http://dlbeer.co.nz/
PGP: BA6E 0B26 1F89 246C E3F3  C910 1E58 C43A 160A 553B
