Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C4734357
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjFQTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E581A10C3;
        Sat, 17 Jun 2023 12:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FCB860A0F;
        Sat, 17 Jun 2023 19:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5618BC433C8;
        Sat, 17 Jun 2023 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687030518;
        bh=FvYQ5VVD1QZWWP0pvu0JZMqsgqYDUfVAeeiYeEmkoTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uSUmNyQXmFk2aNwd1m3dx0sheEKiAsuUq/tac1f5YNkc4H0mhwtj9UjbNgkkc54wR
         H1ifkwuYMELtwhL8KBHUvmYvtLiP4Bzw7xLn3+5VlcUcRt5b4jf5qa5RUPFjWaKE8K
         yMaMqDKarpMhj5af1NS4l4m0ZA28/lzKT/piWQp9qIcOB/PPV2WQz6Ap7dhWKLlzZa
         Rkxk72nKSrgX4EVaPd1uTO5CWF77/vxKCdPUvOdfKYrj+7JeDso6GYWVOvfwSpakci
         tEkTlbpoEdImF+GyIS5YxylpS53G4H3mWoy3Qv28OuSJRJfXGhb/dcJyktp64YGSVd
         ewuYOM0FOZ6JQ==
Date:   Sat, 17 Jun 2023 20:35:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: bu27008: Fix intensity data type
Message-ID: <20230617203514.60436177@jic23-huawei>
In-Reply-To: <240a7ca5fc1b76da20d81f930d00f31a54b1fdf8.1686648422.git.mazziesaccount@gmail.com>
References: <cover.1686648422.git.mazziesaccount@gmail.com>
        <240a7ca5fc1b76da20d81f930d00f31a54b1fdf8.1686648422.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Tue, 13 Jun 2023 12:35:12 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The intensity data from bu27008 is unsigned. The type of the scan data
> was incorrectly marked as signed resulting large intensity values to be
> interpreted as negative ones.
> 
> Fix the scan data type.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied series to the fixes-togreg branch of iio.git (which now includes
this as it's upstream in char-misc-next)  Added fixes tags where needed given
the ids are now stable

Thanks,
Jonathan

> 
> ---
> Fixes tag not added because AFACS the bu27008 is not yet in any releases.
> ---
>  drivers/iio/light/rohm-bu27008.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> index 80eb14ea8193..b50bf8973d9a 100644
> --- a/drivers/iio/light/rohm-bu27008.c
> +++ b/drivers/iio/light/rohm-bu27008.c
> @@ -190,7 +190,7 @@ static const struct iio_itime_sel_mul bu27008_itimes[] = {
>  	.address = BU27008_REG_##data##_LO,					\
>  	.scan_index = BU27008_##color,						\
>  	.scan_type = {								\
> -		.sign = 's',							\
> +		.sign = 'u',							\
>  		.realbits = 16,							\
>  		.storagebits = 16,						\
>  		.endianness = IIO_LE,						\

