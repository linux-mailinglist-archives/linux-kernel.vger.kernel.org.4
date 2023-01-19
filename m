Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFD673E36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjASQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjASQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:06:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3618A717;
        Thu, 19 Jan 2023 08:05:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34CA961CB8;
        Thu, 19 Jan 2023 16:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E54EC433D2;
        Thu, 19 Jan 2023 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674144332;
        bh=UdfkIT4pkagNyMSdRnF01LnSFEp9DSwK99agBJfkJ78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKB6KRE98zltc/kjjU9D98v+Ga5C+RcDjgnAyuUqxVss90GnWTp3OygslYnxDAnvJ
         Utb4vpw4cmaO/J3u/a/x5Y+SOSbOknURjXhr7gUw8PEqDtay1JSXvI4LlEQF0BsFnG
         KIXD/YnSIn7/ZBYmOMfI8slzvsgwD5FMzk58u53oLnxJf+kCH+CcEIjCaWLGFhQF0s
         nKsX6FIq/gbH1UFNqcNEDCS7H1Z08+gwauzoGjktQKuITxiG4U69jjBP8Q3IX5W/Bo
         dSqpnzRFWzvtJAUenHEc1wNUxTTChgu7XuP8FkP0JNejS0w9J8fQlvU8OZbv2l8fb9
         SmJXl34zvgGKw==
Date:   Thu, 19 Jan 2023 16:05:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Subject: Re: [resent, PATCH v2 1/1] leds: is31fl319x: Wrap mutex_destroy()
 for devm_add_action_or_rest()
Message-ID: <Y8lqRjeM9I/rRrvv@google.com>
References: <20230103131553.34124-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103131553.34124-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023, Andy Shevchenko wrote:

> Clang complains that devm_add_action() takes a parameter with a wrong type:
> 
> warning: cast from 'void (*)(struct mutex *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
>     err = devm_add_action(dev, (void (*)(void *))mutex_destroy, &is31->lock);
>                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1 warning generated.
> 
> It appears that the commit e1af5c815586 ("leds: is31fl319x: Fix devm vs.
> non-devm ordering") missed two things:
> - while mention devm_add_action_or_reset() the actual change got
>   devm_add_action() call by unknown reason
> - strictly speaking the parameter is not compatible by type
> 
> Fix both issues by switching to devm_add_action_or_reset() and adding a
> wrapper for mutex_destroy() call.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e1af5c815586 ("leds: is31fl319x: Fix devm vs. non-devm ordering")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
> 
> v2 resent: resent as v2
> v2: added tag (Vincent), Cc'ed to Lee                                                                            
> 
>  drivers/leds/leds-is31fl319x.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Not sure what the differences were, but looks like I already applied v1.

-- 
Lee Jones [李琼斯]
