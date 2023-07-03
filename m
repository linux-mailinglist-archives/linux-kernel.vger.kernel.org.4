Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10069745551
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGCGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGCGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB96BC;
        Sun,  2 Jul 2023 23:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EB660DB5;
        Mon,  3 Jul 2023 06:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EA1C433C8;
        Mon,  3 Jul 2023 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688364933;
        bh=2mre+NpxhnM/j2ilzhpVesXfPxbXoHN0rR5zLU6NZP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vIzuonFHs7xO4B7zjPZ0guaugCZQyYPqQVubQIX1L76rEdEAhNfnPcuHjsngyVl22
         3MVwlvlMwobNJmv+UNpysJH5eQi7a9sHKgYWdWnSHr6nvbgvKw5kcKTh0IAaLQ8+Gd
         DF3jPE3JksekXGCKStEQ6iZ4J6lLq1DJucmhoKwP6TnhNtc/vbJrJ8fNF7wwtJfFZ/
         JHNwwk93WjQiCwOd2Z8dbnjNk56mJBrucwJElqDkdlKPPH+kxab/m932woGNGuFiW3
         SQuxcz7WjXS9vdyIxhAcFwivDcnQnyJhSKZMZaqOznqFYFiq9LUtbHbztxQdyEB9q/
         lGKAmuYxhqVxA==
Date:   Mon, 3 Jul 2023 08:15:25 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Antti Palosaari <crope@iki.fi>, Sergey Kozlov <serjk@netup.ru>,
        Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 2/4] lib/math/int_log: Use ARRAY_SIZE(logtable) where
 makes sense
Message-ID: <20230703081525.0fb45fde@sal.lan>
In-Reply-To: <20230619172019.21457-3-andriy.shevchenko@linux.intel.com>
References: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
        <20230619172019.21457-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 19 Jun 2023 20:20:17 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:

> Use ARRAY_SIZE(logtable) where makes sense.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  lib/math/int_log.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/math/int_log.c b/lib/math/int_log.c
> index 322df25a22d6..ea98fc0b3fe2 100644
> --- a/lib/math/int_log.c
> +++ b/lib/math/int_log.c
> @@ -91,7 +91,7 @@ unsigned int intlog2(u32 value)
>  	 *	so we would use the entry 0x18
>  	 */
>  	significand = value << (31 - msb);
> -	logentry = (significand >> 23) & 0xff;
> +	logentry = (significand >> 23) % ARRAY_SIZE(logtable);
>  
>  	/**
>  	 *	last step we do is interpolation because of the
> @@ -109,7 +109,7 @@ unsigned int intlog2(u32 value)
>  	 *	logtable_next is 256
>  	 */
>  	interpolation = ((significand & 0x7fffff) *
> -			((logtable[(logentry + 1) & 0xff] -
> +			((logtable[(logentry + 1) % ARRAY_SIZE(logtable)] -
>  			  logtable[logentry]) & 0xffff)) >> 15;
>  
>  	/* now we return the result */
