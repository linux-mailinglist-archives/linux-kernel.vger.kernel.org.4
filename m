Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DB7641DAA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 16:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLDPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 10:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLDPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:36:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE1A120AD;
        Sun,  4 Dec 2022 07:36:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97FAFB8069A;
        Sun,  4 Dec 2022 15:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA343C433D6;
        Sun,  4 Dec 2022 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670168180;
        bh=O1qz95Pb9I33OjCFKXFJFaZ1swHQCaILsdIKSNUsTXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AcdaVFn+XsCZU68UuyVbj1DApCZlidCw051GrEbvZJkN96yChqqMbapkEWDWHcNnq
         3lE0zYNmltqurZCfKQ+LLS5wCk/5jqCxiIa2UdBbkjrqeGmh6hN/BSGKEbboRQCYXV
         7UKc9mrT6Klha7FKcr9BR7EjnkRZs3uRsGN6RYgBOd6txTUFJyZxKk85jXH5TAcO2X
         Cya/98xgxMlwbaONATZu2plgZ4b0ZXUAUqRieVPqlmaYtRgfvxl4yKdzbahb3ulQme
         P4nZODS2GeM5vI8h+qcm7vojQFPdbl5x1+XW/Q1xiPG7t1Tj/jho5hIgu+2Sth3rTe
         57xG8XyCUKAbA==
Date:   Sun, 4 Dec 2022 15:49:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <ye.xingchen@zte.com.cn>
Cc:     <jbhayana@google.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] iio: common: scmi_iio: use sysfs_emit() to instead of 
  scnprintf()
Message-ID: <20221204154906.163c9c02@jic23-huawei>
In-Reply-To: <202212011156314630626@zte.com.cn>
References: <202212011156314630626@zte.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 1 Dec 2022 11:56:31 +0800 (CST)
<ye.xingchen@zte.com.cn> wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Applied. Cc'd scmi people as well just in case they are interested.


> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index d92f7f651f7b..0c2caf3570db 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -400,12 +400,12 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
>  			rem = do_div(resolution,
>  				     int_pow(10, abs(exponent))
>  				     );
> -			len = scnprintf(buf, PAGE_SIZE,
> +			len = sysfs_emit(buf,
>  					"[%lld %llu.%llu %lld]\n", min_range,
>  					resolution, rem, max_range);
>  		} else {
>  			resolution = resolution * int_pow(10, exponent);
> -			len = scnprintf(buf, PAGE_SIZE, "[%lld %llu %lld]\n",
> +			len = sysfs_emit(buf, "[%lld %llu %lld]\n",
>  					min_range, resolution, max_range);
>  		}
>  	}

