Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E2A616E89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKBUX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F645195;
        Wed,  2 Nov 2022 13:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C988F61BB6;
        Wed,  2 Nov 2022 20:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31530C433C1;
        Wed,  2 Nov 2022 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667420634;
        bh=SoPxowNL2wQMY8yb7AJeEyGxnbtrkZim847pUvBQbwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfjPqEtYXiCdkBLiD6Mb9K3XA51IVPUzGRUTvms6p8otl6PuFvxWJt1eNfolnsfMh
         8dOIiVYrNAvWUbc0eNesbhfxuTxND9PyOfr87g31Ntyy1O1D+CTiL0Ie98zFKhuL6L
         pQ6P5NPg9O9EYdY94YsL2yXqg36H/b9HAt0cdMS0OgSSvy64YmI0vtfYhObAcu3zvz
         dNfsvy2LS2sTnLtx58wwVQmNFpMeTJG42JD4GtztqHso9Ufxk1sH8tTONFs9g9eRjR
         Xm+yRgTchmBGh4Sk8fbw4WKFDXV+G1cCqTlkngWQBtrxjrVSY5vsGgYa9I9w0HKA3v
         fRU/uLjxEBNqQ==
Date:   Wed, 2 Nov 2022 13:23:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        David Lechner <david@lechnology.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] counter: Adjust final parameter type in function and
 signal callbacks
Message-ID: <Y2LR13xrrauVmeXP@dev-arch.thelio-3990X>
References: <20221102172217.2860740-1-nathan@kernel.org>
 <202211021216.FF49E84C69@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211021216.FF49E84C69@keescook>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:21:23PM -0700, Kees Cook wrote:
> On Wed, Nov 02, 2022 at 10:22:14AM -0700, Nathan Chancellor wrote:
> > The ->signal_u32_read(), ->count_u32_read(), and ->count_u32_write()
> > callbacks in 'struct counter_comp' expect the final parameter to have a
> > type of 'u32' or 'u32 *' but the ops functions that are being assigned
> > to those callbacks have an enumerated type as the final parameter. While
> > these are compatible from an ABI perspective, they will fail the
> > aforementioned CFI checks.
> > 
> > Adjust the type of the final parameter in the ->signal_read(),
> > ->function_read(), and ->function_write() callbacks in 'struct
> > counter_ops' and their implementations to match the prototypes in
> > 'struct counter_comp' to clear up these warnings and CFI failures.
> 
> I don't understand these changes. Where do 'struct counter_comp'
> and 'struct counter_ops' get confused? I can only find matching
> ops/assignments/calls, so I must be missing something. This looks like
> a loss of CFI granularity instead of having wrappers added if there is
> an enum/u32 conversion needed somewhere.

Right, I am not the biggest fan of this change myself and it is entirely
possible that I am misreading the warnings from the commit message but I
do not see how

        comp_node.comp.signal_u32_read = counter->ops->signal_read;

and

        comp_node.comp.count_u32_read = counter->ops->function_read;

in counter_add_watch(),

        comp.signal_u32_read = counter->ops->signal_read;

in counter_signal_attrs_create(), and

        comp.count_u32_read = counter->ops->function_read;
        comp.count_u32_write = counter->ops->function_write;

in counter_count_attrs_create() are currently safe under kCFI, since the
final parameter type of the prototypes in 'struct counter_ops' does not
match the final parameter type of the prototypes in 'struct
counter_comp'. I would expect the indirect calls in counter_get_data()
and counter_comp_u32_show() to fail currently.

I briefly looked at making the 'struct counter_comp' callbacks match the
'struct counter_ops' ones but the COUNTER_COMP macros in
include/linux/counter.h made it seem like these callbacks might be used
by implementations that might use different enumerated types as the
final parameter. I can look a little closer to see if we can make
everything match.

I am not sure how wrappers would work here, I can take a look into how
feasible that is.

Cheers,
Nathan
