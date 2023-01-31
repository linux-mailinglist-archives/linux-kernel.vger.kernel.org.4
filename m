Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3521682BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjAaLoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjAaLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:44:29 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E32D6C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:44:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 507744206F;
        Tue, 31 Jan 2023 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1675165466; bh=fHTaiebiYMY0WOf6cP/yLgX3gp64foO7cBbwtcWg7o4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fQa2UDdYklyv9VVqThGIQeIhBt4YUmrzOlegINjuOcYPvfAePm+21I9HzPrOP90GG
         ZGFAyVVjWYTOjxSwBDsWzeWooct97LazgCSFkhuU37f8QFrxk3mjj55jm10ob+5gyy
         AJ2S/VPldcCw94KcUNug49Zd6I+SoGUtxPC0xzZST27ILkCU7TQDwxOzh9QI2sei0g
         50UNkGdifBoqbSHUrU+fp6/hbbVSpv56psqLlqgSP+WZpzhNGla4dhilwAy0Dvvs62
         YycZt9q3/dcPB5DSxOU8mcDP2hKneckgDjm293JsWWzxYZgUaUfIZZAShlIOEw/Rb3
         TSGlER57JU87g==
Message-ID: <5ab06fc7-275a-fa70-f4a1-de7f1b365fee@marcan.st>
Date:   Tue, 31 Jan 2023 20:44:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] soc: apple: rtkit: Export non-devm init/free functions
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230121074135.8629-1-lina@asahilina.net>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230121074135.8629-1-lina@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 16.41, Asahi Lina wrote:
> While we normally encourage devm usage by drivers, some consumers (and
> in particular the upcoming Rust abstractions) might want to manually
> manage memory. Export the raw functions to make this possible.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  drivers/soc/apple/rtkit.c       | 15 ++++++++++-----
>  include/linux/soc/apple/rtkit.h | 19 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 

Thanks, applied to asahi-soc/soc!

> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index fa3cda831d2b..bb33f3cd4efd 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -686,7 +686,7 @@ static int apple_rtkit_request_mbox_chan(struct apple_rtkit *rtk)
>  	return mbox_start_channel(rtk->mbox_chan);
>  }
>  
> -static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
> +struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
>  					    const char *mbox_name, int mbox_idx,
>  					    const struct apple_rtkit_ops *ops)
>  {

FYI: This hunk didn't apply cleanly on the upstream tree due to a
context difference in apple_rtkit_request_mbox_chan (I think you based
this on some other change), but it was easy enough to fix.

- Hector
