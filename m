Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E765695B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBNH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjBNH6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:58:51 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893C5273
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676361511; bh=lqRBs/V02eF++gqEHyUnn/ngpNeiPg4yTOPnCTWDevw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=WeXQm0T7tjMh4Dh6XLnNCxB/IctCRXiDBo3xeuKz73ZALHDk35nt2s6HLbEec5ux5
         8Kpfvs4e4UB5QtIhx4ri2Kg4Uf2qx4HvT8xzSXtBvUceh4ZGk6Jois3VNENFSr5fkG
         M23fbUNRW/rXtXQE5EeLu8EXz/RJrPXUVd/awt0I=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 14 Feb 2023 08:58:31 +0100 (CET)
X-EA-Auth: 2iR67mCyPRdq436HyyW20MhiHCxLYSlVzFD2WrbDwBNY+f6n+4IUcYy4ktVSOejB+WCSa/bRKtwDIMXbYfikP4GU+7NM2Kq0
Date:   Tue, 14 Feb 2023 13:28:20 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: change (struct pi433_tx_cfg)->bit_rate
 to be a u32
Message-ID: <Y+s/HP+v7lx2SKRj@ubun2204.myguest.virtualbox.org>
References: <Y+srSuTdGmzmXG1I@jacob-Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+srSuTdGmzmXG1I@jacob-Ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 05:33:46PM +1100, Jacob Bai wrote:
> Based on the TODO file and datasheet of pi433, the maximum bit rate for
> transmitter is 300kbps when modulation been set to FSK. Hence, the size
> should be u32 rather than u16.

Hi Jacob,
This change was already discussed recently. Please check the following link and
all the responses to this thread:

https://lore.kernel.org/all/Y9h42l%2F8EcPqn63x@combine-ThinkPad-S1-Yoga/

Thanks,
./drv

> 
> Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
> ---
>  drivers/staging/pi433/Documentation/pi433.txt | 3 ++-
>  drivers/staging/pi433/pi433_if.h              | 2 +-
>  drivers/staging/pi433/rf69.c                  | 4 ++--
>  drivers/staging/pi433/rf69.h                  | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
> index 4a0d34b4ad37..b34d8e9f6d53 100644
> --- a/drivers/staging/pi433/Documentation/pi433.txt
> +++ b/drivers/staging/pi433/Documentation/pi433.txt
> @@ -78,7 +78,8 @@ rf params:
>  		Allowed values: 433050000...434790000
>  	bit_rate
>  		bit rate used for transmission.
> -		Allowed values: #####
> +		Allowed values when FSK: 1200...300000
> +		Allowed values when OOK: 1200...32768
>  	dev_frequency
>  		frequency deviation in case of FSK.
>  		Allowed values: 600...500000
> diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> index 25ee0b77a32c..1f8ffaf02d99 100644
> --- a/drivers/staging/pi433/pi433_if.h
> +++ b/drivers/staging/pi433/pi433_if.h
> @@ -51,7 +51,7 @@ enum option_on_off {
>  #define PI433_TX_CFG_IOCTL_NR	0
>  struct pi433_tx_cfg {
>  	__u32			frequency;
> -	__u16			bit_rate;
> +	__u32			bit_rate;
>  	__u32			dev_frequency;
>  	enum modulation		modulation;
>  	enum mod_shaping	mod_shaping;
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> index 8c7fab6a46bb..0b90ca004dd6 100644
> --- a/drivers/staging/pi433/rf69.c
> +++ b/drivers/staging/pi433/rf69.c
> @@ -185,7 +185,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
>  	}
>  }
>  
> -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
> +int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate)
>  {
>  	int retval;
>  	u32 bit_rate_reg;
> @@ -201,7 +201,7 @@ int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
>  	}
>  
>  	// check input value
> -	if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
> +	if (bit_rate < 1200 || bit_rate > 300000 || (mod == OOK && bit_rate > 32768)) {
>  		dev_dbg(&spi->dev, "setBitRate: illegal input param\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
> index 78fa0b8bab8b..46a1fb2d5329 100644
> --- a/drivers/staging/pi433/rf69.h
> +++ b/drivers/staging/pi433/rf69.h
> @@ -24,7 +24,7 @@ int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
>  int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
>  int rf69_set_modulation_shaping(struct spi_device *spi,
>  				enum mod_shaping mod_shaping);
> -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
> +int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate);
>  int rf69_set_deviation(struct spi_device *spi, u32 deviation);
>  int rf69_set_frequency(struct spi_device *spi, u32 frequency);
>  int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
> -- 
> 2.34.1
> 
> 


