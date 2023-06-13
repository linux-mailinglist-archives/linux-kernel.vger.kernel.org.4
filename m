Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8535F72EB74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbjFMTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjFMTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:02:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3DE5;
        Tue, 13 Jun 2023 12:02:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f62b552751so7318482e87.3;
        Tue, 13 Jun 2023 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686682923; x=1689274923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk4xTe07/GeNMrAZFNQY+BzkTYH3If3cldLHtOxjDjg=;
        b=hnBQKQlz7SSBYWxjCWexy5F+WSYk+2Tqo0P3qW0WiyBfFLsPhA7shj1ApaTEocai0/
         phin901w7E53BQMDS9I3j4x87Ix2P25wPdwNYxcrdnT7AO606nYuTpFdiirpAgcSuCln
         sa2RlU9qK4vCofv3vsHSR4CkZKA9PQhp8BVPRGLGH5eK5152LZNW3z3qmuYRfC2f4YU4
         wAbSbqq31G9WE+pXZBZ2csmB8Ms1v4J0DIGUm1Esa+4AidpOpvM+ydMwOu+a1ntfs70d
         +b08gtKZirLVVu8Gw8ne9gyp8u70q0VcNOzcMbCwFUIfTDbudreWyfKozRl20TPjab/I
         /VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686682923; x=1689274923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk4xTe07/GeNMrAZFNQY+BzkTYH3If3cldLHtOxjDjg=;
        b=UdkspsKAqsnMN0EmPulXVrF4hPN5ZIkt6yhUSELavkUQaMKQ/baBMU0YaQYtK54MSQ
         hviBdMxMQX1MGE6sHU+gtXvI6IjInKRjpwCUIToI41M7sV+vtU9vf45x3jvJp3BLbDuU
         OCdJfmPC4Ft+kzV8SxciE125gXXrAtDAxveNRlRmod/n0WlSSuBP6ZJrHREJhhXqD2x2
         eUweWsCPLWamXWalsVkftGFrBVTbJ8Dv21bJgQ3AyTITUC8e7kaF7O1uPzjdA42XtnTj
         vGGV8YD5GdWlaOBqWcpnpiki89Mj5rukeaGZcaEkh80pwhoM0AN4IVcZBcQESaV3E52S
         X6wA==
X-Gm-Message-State: AC+VfDyIe7lLkcn9neDag5oU77am+OWLoTlTQDe8mVETLDvXstIbnekK
        rQV4RSwaIk2ES2GRxEfsGTo=
X-Google-Smtp-Source: ACHHUZ454yzSsHJTRyUrKRIQsvsXLypKDPWH6elEZzFQjXx1TGgnzhqQCL5NmUlhY3sV9DBuS6yIJA==
X-Received: by 2002:ac2:4982:0:b0:4f6:2e4f:19c6 with SMTP id f2-20020ac24982000000b004f62e4f19c6mr6339639lfl.53.1686682923262;
        Tue, 13 Jun 2023 12:02:03 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id q4-20020ac24a64000000b004f2532cfbc1sm1870281lfp.81.2023.06.13.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:02:02 -0700 (PDT)
Date:   Tue, 13 Jun 2023 22:02:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Abe Kohandel <abe.kohandel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] spi: dw: Replace incorrect spi_get_chipselect with set
Message-ID: <20230613190200.ifuwxstc77tbeopo@mobilestation>
References: <20230613162103.569812-1-abe.kohandel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613162103.569812-1-abe.kohandel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:21:03AM -0700, Abe Kohandel wrote:
> Commit 445164e8c136 ("spi: dw: Replace spi->chip_select references with
> function calls") replaced direct access to spi.chip_select with
> spi_*_chipselect calls but incorrectly replaced a set instance with a
> get instance, replace the incorrect instance.
> 
> Fixes: 445164e8c136 ("spi: dw: Replace spi->chip_select references with function calls")
> Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Indeed! Thanks for fixing this.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/spi/spi-dw-mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index a699ce496cc5..a963bc96c223 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -292,7 +292,7 @@ static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
>  	 */
>  	spi_set_chipselect(spi, 0, 0);
>  	dw_spi_set_cs(spi, enable);
> -	spi_get_chipselect(spi, cs);
> +	spi_set_chipselect(spi, 0, cs);
>  }
>  
>  static int dw_spi_elba_init(struct platform_device *pdev,
> -- 
> 2.40.1
> 
