Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A46DB9D9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjDHJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FADFC140;
        Sat,  8 Apr 2023 02:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E437A611AE;
        Sat,  8 Apr 2023 09:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF76C433EF;
        Sat,  8 Apr 2023 09:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680946308;
        bh=StJNO4de7jBrcTpA+nFUKFtj9EXHG30Gz3JlLFkKPyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PvBUwzjtr76bPsYzGahl89tM4xiOgWiJXfh9UzZ+4N7PztOaqcneGsB3hIiXXjYuY
         ztxTG3rnLZ0czLhLHpRRWp5d6Ft6rmCMChvY1BFlmdAy8vNH+4HlsRW4lhzohKuGnX
         6R8tUUv7xoU7ZoqJkFY9jD+yKzmqZLE9wX8p6pX4ah4F0pq+O4rYev5ljECAO2Ow5j
         +bO2tTbUhnWMG5SON7cqNixhaCI4g+Ms467R1HsMWRVwb9Oey8t/4hKhLWc/TmUgiF
         LgHR+f73Ka7wblqquHjE8jO0QuadqCzycqlpGVJeVRSfFSg8YEok3SE488hW6rrWmg
         UgDbFK0tf3egA==
Date:   Sat, 8 Apr 2023 10:47:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andriy.shevchenko@linux.intel.com, trix@redhat.com,
        lars@metafoo.de, nathan@kernel.org, ndesaulniers@google.com,
        u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hslester96@gmail.com
Subject: Re: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from
 device tree
Message-ID: <20230408104703.758cb5c0@jic23-huawei>
In-Reply-To: <20230404011455.339454-1-bmasney@redhat.com>
References: <20230404011455.339454-1-bmasney@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Apr 2023 21:14:55 -0400
Brian Masney <bmasney@redhat.com> wrote:

> tsl2772_read_prox_diodes() will correctly parse the properties from
> device tree to determine which proximity diode(s) to read from, however
> it didn't actually set this value on the struct tsl2772_settings. Let's
> go ahead and fix that.
> 
> Reported-by: Tom Rix <trix@redhat.com>
> Link: https://lore.kernel.org/lkml/20230327120823.1369700-1-trix@redhat.com/
> Fixes: 94cd1113aaa0 ("iio: tsl2772: add support for reading proximity led settings from device tree")
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

thanks,

Jonathan

> ---
>  drivers/iio/light/tsl2772.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index ad50baa0202c..e823c145f679 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -601,6 +601,7 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
>  			return -EINVAL;
>  		}
>  	}
> +	chip->settings.prox_diode = prox_diode_mask;
>  
>  	return 0;
>  }

