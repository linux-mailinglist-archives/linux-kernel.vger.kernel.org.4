Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39E6BFBCA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCRRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCRRPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:15:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CBA558A;
        Sat, 18 Mar 2023 10:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 832FDB803F5;
        Sat, 18 Mar 2023 17:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F9FC433EF;
        Sat, 18 Mar 2023 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679159688;
        bh=CQpkawQkGuAV8PfhgbbB2HU74NKtyCwPubkAloZHHYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dz4HF5Hx9TT7waxUaZNhzhHHpWM5oLTkgvGftUuZ6aTvSwWGnmqsIpXRJS2KvSprg
         vAy0lgAzbNfltOcK/g4IzS4GWt6WhIvWSIvqKZEPGL6APixbGRYp0pQ0ZfFdHJFFaF
         mQZCUSxPLtRizIVlLKGN0XiFQPvzIr0YUMWw93YzpXdgJQza5MAORovic4qR6ebLQS
         lDBfmbiJ8ZPp/w6Jd2DSsL0GfmJYatoZWj3nS6VyzG/7D1iHQ4JELOPNDiv+LB6bAB
         eRObvbBHhnNsa67+DRGP5S1RUQQ42zK5YlS3OXsYpI2M+QQ/gvhnxlptriVij6K97M
         YJ99eu2/dy4qQ==
Date:   Sat, 18 Mar 2023 17:29:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230318172941.36e41a79@jic23-huawei>
In-Reply-To: <b4bf8587-d3cd-ff88-0276-7e394c110757@gmail.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
        <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
        <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
        <e507c171-bebc-84f6-c326-ff129b42fb7f@gmail.com>
        <ZA8kTx4exvGwUfNn@smile.fi.intel.com>
        <b4bf8587-d3cd-ff88-0276-7e394c110757@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >   
> >>>> +		kfree(gts->avail_all_scales_table);  
> > 
> > ...
> >   
> >>>> +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);  
> >>>
> >>> sizeof(type) is error prone in comparison to sizeof(*var).  
> >>
> >> Yes and no. In majority of cases where we see sizeof(*var) - the *var is no
> >> longer a pointer as having pointers to pointers is not _that_ common. When
> >> we see sizeof(type *) - we instantly know it is a size of a pointer and not
> >> a size of some other type.
> >>
> >> So yes, while having sizeof(*var) makes us tolerant to errors caused by
> >> variable type changes - it makes us prone to human reader errors. Also, if
> >> someone changes type of *var from pointer to some other type - then he/she
> >> is likely to in any case need to revise the array alloactions too.
> >>
> >> While I in general agree with you that the sizeof(variable) is better than
> >> sizeof(type) - I see that in cases like this the sizeof(type *) is clearer.  
> > 
> > Still get a fundamental disagreement on this. I would insist, but I'm not
> > a maintainer, so you are lucky :-) if Jonathan will not force you to follow
> > my way.  
> 
> In a code you are maintaining it is good to have it in your way as 
> you're responsible for it. This is also why I insist on having things in 
> a way I can read best for a code I plan to maintain - unless the 
> subsystem maintainers see it hard to maintain for them. So, let's see if 
> Jonathan has strong opinions on this one :)

This is one where I strongly prefer sizeof(*per_time_gains)
because it's easier to review.  I don't care so much if it's easier to
modify as reality is these rarely get modified.

I often just 'fix' these up whilst applying.

Jonathan
