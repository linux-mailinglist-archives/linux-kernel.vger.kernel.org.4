Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC265C5D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbjACSMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjACSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:12:53 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B7313D46
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:12:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 334C941F72;
        Tue,  3 Jan 2023 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672769569; bh=IEPZKLrGrNh2iBWa1yrt4pvbZvClcUgd83VdzZjTM/c=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=DTClBDKCJ88tVQClc0uAEZlXElGHb/J7JAd6fRPWt/Iu3+7gWZ4PxHmJiKYvJU7Fn
         pAiwzAb+1J7f7Q4gMPCUXsR1P3tLtKJ3ktQrPpXtn/q+KAI7CFKPM3rGaosDVzvTZP
         xOsviaYrC/iH7GS5s6522oxqx+EVuIwRY3ow0KLpdwIPkChH/uBZcdfnL8Tee7WnxV
         VzvJy9tXCw5sPfKBNFFQ6HlTUhvnPn0j8SfQpdBbZDdFqc1/mC/y557XC5FMeb5smJ
         kLjx9jCFFKOn4Fekf8qz2mUnwetMLZMImGsK8iUiKb2yONqyHn+LAJgu0BIpPe5oC6
         CqXj6wBw3f8dQ==
Message-ID: <5333ed0e-010c-178a-beb2-e8a4338f2d43@marcan.st>
Date:   Wed, 4 Jan 2023 03:12:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 0/5] Fix a whole host of nvmem registration/cleanup
 issues
In-Reply-To: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 01.58, Russell King (Oracle) wrote:
> Hi,
> 
> This series fixes a whole host of nvmem registration/error cleanup
> issues that have been identified by both Hector and myself. It is a
> substantial rework of my original patch fixing the first problem.
> 
> The first most obvious problem is the race between nvmem registration
> and use, which leads to sporadic failures of drivers to probe at boot
> time.
> 
> While fixing this, it has been noticed that a recent fix to check the
> return value of dev_set_name() introduced a new bug where wp_gpio was
> not being put in that newly introduced error path.
> 
> Then there's a fix for a previous fix which itself purports to fix
> another bug, but results in the allocated ID being leaked. Fix for a
> fix for a fix is not good!
> 
> Then there's an error in the docbook documentation for wp_gpio (it's
> listed as wp-gpio instead) but as nothing seems to set wp_gpio, we
> might as well get rid of it - which also solves the issue that we
> call gpiod_put() on this whether we own it or not.
> 
> Lastly, there's a fix for yet another spurious white-space in this
> code, one of what seems to be a long history of past white-space
> fixes.
> 
> These patches have been individually build-tested in the order of
> posting, but not run-time tested except for the entire series.
> 
>  drivers/nvmem/core.c           | 51 ++++++++++++++++++------------------------
>  include/linux/nvmem-provider.h |  2 --
>  2 files changed, 22 insertions(+), 31 deletions(-)
> 

Uhh. The series itself looks fine as far as fixing the problems, but I
fail to see how this is any better than my attempt as far as backporting
or commit atomicity goes. Patch #4 fixes the newer gpio leak bug *and*
half fixes the race condition bug, then patch #5 completes the race
condition fix but now depends on #4, meaning you're left with exactly
the same backporting mess since now you can't apply #5 to older kernels
and #4 only to newer ones. Splitting the commits like this buys you nothing.

I thought we were doing minimal backportable fixes to solve this, but
your commit message for #4 literally says "While a minimal fix for this
would be to add the gpiod_put() call, we can do better if we split
device_register() [...]"... and then that whole "let's do better" part
is what breaks the backportability again.

And then of course if you *do* manage to queue at least #4 to be
backported to a newer subset of stable trees, #3 certainly isn't going
to get backported itself (since it's just removing dead code, not
eligible for stable since it fixes no actual bugs), but then you're left
with the same
broken-on-paper-except-nobody-uses-it-anyway-so-it-doesn't-matter
situation my v2 left us in for those stable kernels.

That said, thanks for identifying that nobody uses the functionality I
supposedly regressed (in a tiny corner case code path where it was
already broken anyway) in my v2, and therefore I didn't actually regress
anything in practice and strictly fixed real bugs.

- Hector
