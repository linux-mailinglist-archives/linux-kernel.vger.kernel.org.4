Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362B2626AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiKLRfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKLRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:35:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BABBF;
        Sat, 12 Nov 2022 09:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C84360D38;
        Sat, 12 Nov 2022 17:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7373C433C1;
        Sat, 12 Nov 2022 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668274521;
        bh=D5tNslk5Uud0NPANZ1lJaZMeLKEZFr6cIs3ciZ9ZkSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cjv53huAJ6qR1gLFtnPL9cV3tIuIUbBJ1K2zAfKXzGRI54DOK4KPDew2vFvJmO4WL
         ren1ecwFejT5owb31Y3poT0XFA8LsCqYpcicpxKEuc5uQT+QbJ40sHmFtwn3dTNM2V
         +hA6Kq5r6dzqDh6RopI+5OaumFFcPK7KDw2YEFfB4zKryClknqErdZqCFvS0IfHvbV
         VMbqevKZubbAkparzdxE4u11qlNNYp6SPFa4howQjLu7R6JSQVKIyU4y+1/ajLxqG3
         zltmX05iCwaY8QUHULAfhaVd2NswUjm31L5aHLooxjbQ+cj7Y6K89Lc8ISYLEvgP2P
         tccxW8TkEOlMA==
Date:   Sat, 12 Nov 2022 17:47:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
Message-ID: <20221112174736.75d0b926@jic23-huawei>
In-Reply-To: <380ae3c3-14c2-db1a-954c-caf8180746f0@vixtechnology.com>
References: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
        <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com>
        <b6ac2692-3152-dfc4-5388-7986042970f0@vixtechnology.com>
        <CAJCx=g=WaGiBFYJTTjNgzrnW3We0qpuMvyy9iFAVDC8Mkbscsg@mail.gmail.com>
        <20221111111049.0000467f@Huawei.com>
        <380ae3c3-14c2-db1a-954c-caf8180746f0@vixtechnology.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 21:44:48 +0800
Subhajit Ghosh <subhajit.ghosh@vixtechnology.com> wrote:

> > Hmm.  Given that event enables often cover a couple of different things
> > (as done here) it isn't unknown for those to not be as easily covered
> > as you have done.  As such, we have drivers were the ABI allows for
> > enabling one event to end up enabling several others (even though they
> > have separate enable attributes).  It's always been permitted for one
> > IIO attribute write to have an effect on other attributes simply because
> > we can't represent all dependencies.
> > 
> > Now the bigger complexity / surprise here is the return of the either
> > direction in response to enabling either rising or falling. 
> > That is going to rather surprise your average writer of userspace cod This is where the inconsistency was found. When an ALS threshold rising   
> value was given and as soon as it was enabled, interrupts started firing
> in low light conditions as there was some value present in the ALS falling 
> threshold(reset value is not defined in the datasheet for this register), 
> but falling threshold value was neither fed nor enabled!
> 
> > So patch covers what we should definitely have had in the first place.
> > Hence it's a question of risk of someone running code that will be affected
> > by the ABI change.  One of those fingers crossed moments...  
> I understand that breaking existing userspace applications is not the best
> thing to do.

Given the risks around this one, I'm going to apply it to the togreg
branch of iio.git which is lined up for next merge cycle.  That should
in theory provide more time before it hits upstream / gets back ported
to stable releases for people to notice the change.

Hopefully no one will though!

Applied to the togreg branch of iio.git and pushed out initially as testing
to let 0-day poke at it.

Thanks,

Jonathan

> 
> > 
> > Jonathan  
> 
> Thank you for your time and comments.
> 
> Regards,
> Subhajit Ghosh
> 

