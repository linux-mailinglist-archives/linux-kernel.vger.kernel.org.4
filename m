Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140597018EC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjEMSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbjEMSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A255FC6;
        Sat, 13 May 2023 11:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A824E61C36;
        Sat, 13 May 2023 18:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9867AC433D2;
        Sat, 13 May 2023 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000992;
        bh=6EasBiyNb7kJmINIASaWWSJeit3QY9hOpg97FKodcw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WKNrnbwad4HicJmPpsnGOK6lGrhm6nPLQZolI54DMFfiG6CJlHCgvRqMHyVtRf1I8
         t3UKqkAVAd4Ry7HD6xpgVHLYYDQQbwqt0gyvU7VqvLfZch+FpA19N2BV/uSJXCbyZx
         3Gud647ONclYXzW7+y3i1Fwhf1Il/8lroJqQ+YZCL+sM/AUixeogiW9mCgYGK7EsF3
         NtyTtK/TzuTj9k7ho1gT0oBeSe4yYu9AcHqEnoprwqlCBajPlNWDkpQIC0aeiCwY26
         qPI2lUwX8bc7IrHAmzy71G2INnxQSGO8y2ZmiFaBGbBZZ6RNdA69UZYG1zJts7gYpq
         M91FBwfdOZPQg==
Date:   Sat, 13 May 2023 19:19:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: build ad5758 driver when AD5758 is selected
Message-ID: <20230513191912.41276f94@jic23-huawei>
In-Reply-To: <20230508040208.12033-1-lukas.bulwahn@gmail.com>
References: <20230508040208.12033-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 May 2023 06:02:08 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 28d1a7ac2a0d ("iio: dac: Add AD5758 support") adds the config AD5758
> and the corresponding driver ad5758.c. In the Makefile, the ad5758 driver
> is however included when AD5755 is selected, not when AD5758 is selected.
> 
> Probably, this was simply a mistake that happened by copy-and-paste and
> forgetting to adjust the actual line. Surprisingly, no one has ever noticed
> that this driver is actually only included when AD5755 is selected and that
> the config AD5758 has actually no effect on the build.
> 
> Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

oops. That's been there a while so good spot!

Applied to the fixes-togreg branch of iio.git and marked for stable inclusion

Thanks,

Jonathan


> ---
>  drivers/iio/dac/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 6c74fea21736..addd97a78838 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -17,7 +17,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>  obj-$(CONFIG_AD5592R) += ad5592r.o
>  obj-$(CONFIG_AD5593R) += ad5593r.o
>  obj-$(CONFIG_AD5755) += ad5755.o
> -obj-$(CONFIG_AD5755) += ad5758.o
> +obj-$(CONFIG_AD5758) += ad5758.o
>  obj-$(CONFIG_AD5761) += ad5761.o
>  obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5766) += ad5766.o

