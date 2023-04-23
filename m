Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39036EBEBC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDWKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDWKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BDE1A4;
        Sun, 23 Apr 2023 03:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B6C860EB6;
        Sun, 23 Apr 2023 10:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF39C433D2;
        Sun, 23 Apr 2023 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682247127;
        bh=PNBBXsNrnkRVgwOgOoEWcaOi6+BMrRyuUIjbtkDc4Bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I8JccwcxE/4aFg0SCoB2AulOisOyp6PHOVmQrSsfZ4BHJZq2pGjHsvjZaqMtAiXLM
         mBfc/b8M+iN5o1SK8ebEkwfF9XQVr3Oaj2Jg9arxXZNmAnVvT+KeO6jNFTWVMXZOD7
         X5mgFU6eD0/Ec8d+nvTeJrL8R/M7rdi5gJ4cH8GGitpBewxs04WryGBJWRzbLSgKhg
         jL3+lJY3Y6VaduJoDbxYl1Yd02qrwb2T4JZjxYJ3Y+ViJd+PyCBHbIarG4xe/AqPrl
         +4KGh5zwfQeKHImKlMLe1IMPsXjl3AUu1x4d4C2VDwx7LCJtWS0ENbBbb6rXOs2Cdv
         ZqUCYl2+ecKpQ==
Date:   Sun, 23 Apr 2023 12:07:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] iio: light: al3320a: Handle ACPI device CALS0001
Message-ID: <20230423120744.568f107d@jic23-huawei>
In-Reply-To: <20230420182314.53796-1-mail@mariushoch.de>
References: <20230420182314.53796-1-mail@mariushoch.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 20:23:14 +0200
Marius Hoch <mail@mariushoch.de> wrote:

> This sensor can be found as CALS0001 on the Lenovo Yoga
> Tablet 2 series.
> 
> Tested on a Lenovo Yoga Tablet 2 1051-F.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

I made a small tweak.  This driver includes of.h to get
the ID table, which is less than ideal anyway.  Now you've added
a second table, I've switched that for mod_devicetable.h which is
the include that should have been used in the first place.

Applied with that and a not in the patch description to the togreg
branch of iio.git which is initially pushed out as testing for 0-day to
see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/light/al3320a.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 9ff28bbf34bb..ffcb65cbc125 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -247,11 +247,18 @@ static const struct of_device_id al3320a_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, al3320a_of_match);
>  
> +static const struct acpi_device_id al3320a_acpi_match[] = {
> +	{"CALS0001"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
> +
>  static struct i2c_driver al3320a_driver = {
>  	.driver = {
>  		.name = AL3320A_DRV_NAME,
>  		.of_match_table = al3320a_of_match,
>  		.pm = pm_sleep_ptr(&al3320a_pm_ops),
> +		.acpi_match_table = al3320a_acpi_match,
>  	},
>  	.probe_new	= al3320a_probe,
>  	.id_table	= al3320a_id,
> 
> base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f

