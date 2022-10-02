Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C755F233D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJBMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJBMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:55:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38552655D;
        Sun,  2 Oct 2022 05:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA7F0B80D33;
        Sun,  2 Oct 2022 12:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BD7C433C1;
        Sun,  2 Oct 2022 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664715296;
        bh=mfHKMtXZfHvWDjYAzhBW3GrdyW5sJh9RiHPmj6UhT9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cjf9dEWkuu79zI40Yj6RO3hQmyp4SXI/K9R2dEv6z+0T/C/0dFG/22373Dy7DT94q
         rWb752S6zyySDZDyglRJBc1oegHOtVwL3KfaR6QfpJHOqapYY2QCff6a4kFW9Sk6i6
         kvyLu+l/J8qM7LEL25SQPA2CLYJj7Zo+L37Ebfiw9gACJVa1Dc9fn/6mAsW1bjvKZK
         34YmkhAbzlUsfD3yN83bL9NYvsww5Pv5o0cfz4jrk2ju+2VHWz/zEA1HUwOiUHXRm+
         e8Ttx5MET+PTxyQ80Ikyi91fS+0c7GEPRoYluaYFyBr0MBpXZemyWr0vC+xWiUQIJb
         rWtBYVPfaN5Ng==
Date:   Sun, 2 Oct 2022 13:55:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio: adc: mcp3911: return proper error code on failure
 to allocate trigger
Message-ID: <20221002135512.7cf08a9f@jic23-huawei>
In-Reply-To: <20220927092537.94663-1-marcus.folkesson@gmail.com>
References: <20220927092537.94663-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 27 Sep 2022 11:25:37 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> smatch warnings:
> drivers/iio/adc/mcp3911.c:441 mcp3911_probe() warn: passing zero to 'PTR_ERR'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied, with addition of fixes tag to the fixes-togreg branch of iio.git.
Slightly messy at this point in the cycle, but I can't push this out until
Linus takes Greg's char-misc-next pull request as otherwise linux-next will
get the content of Greg's tree via mine an potentially make a mess.

Should only matter for a few days though then I'll push my fixes-togreg branch
out (which I've moved to being based on char-misc-next to allow me to apply
a few patches for things only recently introduced).

Jonathan

> ---
>  drivers/iio/adc/mcp3911.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 0d768006eabb..e55db02c534f 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -554,7 +554,7 @@ static int mcp3911_probe(struct spi_device *spi)
>  				indio_dev->name,
>  				iio_device_id(indio_dev));
>  		if (!adc->trig)
> -			return PTR_ERR(adc->trig);
> +			return -ENOMEM;
>  
>  		adc->trig->ops = &mcp3911_trigger_ops;
>  		iio_trigger_set_drvdata(adc->trig, adc);

