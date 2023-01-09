Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65976662C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbjAIRHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAIRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:06:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467F7BE06;
        Mon,  9 Jan 2023 09:06:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD0D76121D;
        Mon,  9 Jan 2023 17:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D1CC433F0;
        Mon,  9 Jan 2023 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673283968;
        bh=vEV9IS5lr6A/EE9wxrV5D9TaFzycOxX4Uu56ZOeL6M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtyaDBeUOkqQUzw6fSk49pLzNL0bz4DaGhE5rtpO3DuaDAfvTnHk+ydPYVIewSWdZ
         YhKx2ZCyexae5uxi0ZhHyjaWXGdg+Sg6XrXMDKPP7AjnZnKmK2i6FcDdSxzZ6xeyPB
         MtdcA6neLy77LFUwkJFbQqR84amGc01eNorg9kcNVmdfGVvXq6e128rkV7/4jAeSz/
         tv1QYsBqpU6JNyPI/ePkEbE508hWUxyKyQUL3mZx7QwUO2hgvEFnevjf3Zd1i/DvBC
         WYFZ1dUkQxan5/ffs2AeNLAgbF7W3sOK/4wQk/vZupkTwxZpdSS4Ur1KhU2YWWGT0X
         p3KxsaY1JZHiQ==
Date:   Mon, 9 Jan 2023 17:06:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] leds: is31fl319x: Wrap mutex_destroy() for
 devm_add_action_or_rest()
Message-ID: <Y7xJexzNrs4c7WP/@google.com>
References: <20221228093238.82713-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228093238.82713-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022, Andy Shevchenko wrote:

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

I fixed-up the wording above a little.

> Fix both issues by switching to devm_add_action_or_reset() and adding a
> wrapper for mutex_destroy() call.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e1af5c815586 ("leds: is31fl319x: Fix devm vs. non-devm ordering")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
> 
> v2: added tag (Vincent), Cc'ed to Lee
> 
>  drivers/leds/leds-is31fl319x.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
