Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7FC6DB0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDGQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDGQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34C4C08;
        Fri,  7 Apr 2023 09:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E78F611A8;
        Fri,  7 Apr 2023 16:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF4FC433D2;
        Fri,  7 Apr 2023 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680885263;
        bh=uFreq4aHevhnTAF6ygcgF7VPCtfXDPHg/Zs6GZ7KnNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GxyFBwlcyzKdC9d/QKzAHy30rocb1MznxnlzsnyMAVD7jRZaH+ttI4b6x67UPLjXC
         3ZvYinB2PWkwzZqjrKi3B5T5XXMvfLQLbgpl0FD1ilz6wX+BBsRO9AZQlVId5Wc4FL
         s8zSH5Q4ovwK1oa3/awLJbiLMMuuDqqyat0m5dOi7cumFBU5HP5awETn3gd9kUMUys
         SyLHbgXuD9EzqHSr2EOPIn3GThJLWY1lCt8gxWW4LTxvjujI/Remxsevk3jJQv6nZ4
         1l7wCaCpp/tU5G4l1ciW7nTWSMMxmkHwmWgnJCedVSOY9O++vWOUlbnHYaSoGAFix4
         iQtAc9OV0BADg==
Date:   Fri, 7 Apr 2023 17:49:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/6] Migrate STX104 to the regmap API
Message-ID: <20230407174841.2ca510f5@jic23-huawei>
In-Reply-To: <cover.1680790580.git.william.gray@linaro.org>
References: <cover.1680790580.git.william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Apr 2023 10:40:09 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

Series applied to the togreg branch of iio.git and pushed out initially as
testing.  If anyone wants to offer tags / remaining comments there will
still be a few days before I push this out in a non rebasing form.

Thanks,

Jonathan


> Changes in v5:
>  - Explicitly check for negative val for IIO_CHAN_INFO_RAW case in
>    stx104_write_raw(); this avoids the explicit case previously used
>  - Use U16_MAX rather than hardcoding unsigned 16-bit maximum value
>  - Improve ADC conversion comment format and use proper SI units format
> Changes in v4:
>  - Fix race conditions in stx104_read_raw() and stx104_write_raw() by
>    utilizing a mutex
>  - Improve indentation in stx104_write_raw() by bailing out early if
>    chan->output is false in for the IIO_CHAN_INFO_RAW case
>  - Remove regmap_config max_register lines as superfluous
>  - Utilize BIT() for gain calculation in stx104_read_raw()
> Changes in v3:
>  - Add STX104_ prefixes to defines to avoid potential name classes
>  - Rename SAME_CHANNEL() to STX104_SINGLE_CHANNEL() to convey intention
>    better
>  - Utilize u8_encode_bits() to define STX104_SOFTWARE_TRIGGER
>  - Adjust to utilize reg_base members in regmap_config structures
>  - Fix off-by-one errors in aio_data_wr_ranges[], aio_data_rd_ranges[],
>    and aio_data_regmap_config max_register
>  - Inline gpio_config initialization to avoid zeroing it at declaration
>  - Add blank lines between register map init blocks for clarity
>  - Utilize regmap_read_poll_timeout() for ADC conversion status poll
> Changes in v2:
>  - Relocate struct stx104_iio for the sake of a clearer patch diff
>  - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
>    u8_get_bits()
> 
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> To make the git history cleaner, precursor patches to use a define
> rather than hardcoded limit and to improve indentation in
> stx104_write_raw(), and a follow-up patch to utilize
> regmap_read_poll_timeout() for polling the ADC conversion status are
> included.
> 
> William Breathitt Gray (6):
>   iio: addac: stx104: Fix race condition for stx104_write_raw()
>   iio: addac: stx104: Fix race condition when converting
>     analog-to-digital
>   iio: addac: stx104: Use define rather than hardcoded limit for write
>     val
>   iio: addac: stx104: Improve indentation in stx104_write_raw()
>   iio: addac: stx104: Migrate to the regmap API
>   iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll
> 
>  drivers/iio/addac/Kconfig  |   2 +
>  drivers/iio/addac/stx104.c | 460 +++++++++++++++++++++----------------
>  2 files changed, 264 insertions(+), 198 deletions(-)
> 
> 
> base-commit: f73df43e957a6fc705a9bd6d143585bdf1b13365

