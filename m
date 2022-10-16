Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B29760016E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJPQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJPQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5036BCB;
        Sun, 16 Oct 2022 09:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB8060C35;
        Sun, 16 Oct 2022 16:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE971C433C1;
        Sun, 16 Oct 2022 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938230;
        bh=37IDBlT9h1wZixGYlQIPgLNHS+XN/qSb58yicxbhiF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XOfgOlSkHm3yqHMExfFnWyNVyDWRQS7ccWubWQ0qdXzEhMVXpNLVxdXfDcg7kVTHW
         9HRMICv+7mSuEUCeQUn5ZliKPJzw3gBfT/hlw7bqQBPJsUO8LmkoO3xDpQFUkswakx
         G4Je9R+XnoY+rXjQfSDUOdAIT2trZDwc4MBPAO8hJFQWipiYgRnH94ZuQ7fBwtGW4d
         Q6AsSJDiQai0UAaqlipJmPmKhs4eXq1YeCmnEW/wRY9DWSlJq9+FX8t2OuCehPZgTJ
         7VMFWLpjGn8D0JpWt8LwEFpqYgpubcscalUadg+nP690DJfJwbaWDxfw6EwlSf32A/
         fvRkFXePmJvzA==
Date:   Sun, 16 Oct 2022 17:37:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: iio_utils: fix digit calculation
Message-ID: <20221016173732.1c28ab90@jic23-huawei>
In-Reply-To: <Y0f+tKCz+ZAIoroQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi>
References: <Y0f+tKCz+ZAIoroQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 15:04:04 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The iio_utils uses a digit calculation in order to know length of the
> file name containing a buffer number. The digit calculation does not
> work for number 0.
> 
> This leads to allocation of one character too small buffer for the
> file-name when file name contains value '0'. (Eg. buffer0).
> 
> Fix digit calculation by returning one digit to be present for number
> '0'.
> 
> Fixes: 096f9b862e60 ("tools:iio:iio_utils: implement digit calculation")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
hi Matti

Makes sense.

Applied to the fixes-togreg branch of iio.git and marked for stable.


Thanks,

Jonathan

> ---
>  tools/iio/iio_utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index aadee6d34c74..8d35893b2fa8 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -547,6 +547,10 @@ static int calc_digits(int num)
>  {
>  	int count = 0;
>  
> +	/* It takes a digit to represent zero */
> +	if (!num)
> +		return 1;
> +
>  	while (num != 0) {
>  		num /= 10;
>  		count++;
> 
> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f

