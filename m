Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21876614E3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjAHMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjAHMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:02:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD3FCEA;
        Sun,  8 Jan 2023 04:02:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99155B8085C;
        Sun,  8 Jan 2023 12:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C13C433D2;
        Sun,  8 Jan 2023 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673179332;
        bh=SGxjXK9k/w/LOoqXLxQr0dPDFa8dALCIhSRUWIRumeA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sah0DuQT7VF2ToVJVCTF+wuUx3Sw4e+e5aoUR9Q/se+HFwyaVrdJUok9k5sUBgdiB
         eIXzqGZxG8XhimoHrjeheKLEfhIbAVzGt65LELmSrvBpBUwpjJbRH6FjK6g/8YjQQS
         MqKSaLaIJ4+5HylohTbg6BZOKi60+jCacXw6N/p3FiwaKh7FUZyckRQ2MhF3tOY9Um
         6S5JisluBQ92vC95caqpOvqefMMxpNyT1cw/vwVqEHPPx59eoz9AZcQMLRmoEq2BFS
         FUuIGUPT+ASDqR5FPWnoiW9lCOaFjAvbGhAlsPwxJTYmWmtY9yVnlh2fu7ikqAvbUB
         1IVLx22x0D/ag==
Date:   Sun, 8 Jan 2023 12:15:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-iio@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix build when
 CONFIG_IIO_TRIGGERED_BUFFER=m
Message-ID: <20230108121540.461f4c0c@jic23-huawei>
In-Reply-To: <20230103130348.1733467-1-vladimir.oltean@nxp.com>
References: <20230103130348.1733467-1-vladimir.oltean@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Tue,  3 Jan 2023 15:03:48 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> The following kernel linkage error:
> 
> st_lsm6dsx_core.o: in function `st_lsm6dsx_sw_buffers_setup':
> st_lsm6dsx_core.c:2578: undefined reference to `devm_iio_triggered_buffer_setup_ext'
> 
> is caused by the fact that the object owning devm_iio_triggered_buffer_setup_ext()
> (drivers/iio/buffer/industrialio-triggered-buffer.o) is allowed to be
> built as module when its user (drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c)
> is built-in.
> 
> The st_lsm6dsx driver already has a "select IIO_BUFFER", so add another
> select for IIO_TRIGGERED_BUFFER, to make that option follow what is set
> for the st_lsm6dsx driver. This is similar to what other iio drivers do.
> 
> Fixes: 2cfb2180c3e8 ("iio: imu: st_lsm6dsx: introduce sw trigger support")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index f6660847fb58..8c16cdacf2f2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -4,6 +4,7 @@ config IIO_ST_LSM6DSX
>  	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
>  	depends on (I2C || SPI || I3C)
>  	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	select IIO_KFIFO_BUF
>  	select IIO_ST_LSM6DSX_I2C if (I2C)
>  	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)

