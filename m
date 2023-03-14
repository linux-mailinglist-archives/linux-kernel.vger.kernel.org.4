Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3672E6BA0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCNUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:42:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEDF1B2F8;
        Tue, 14 Mar 2023 13:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1305B81903;
        Tue, 14 Mar 2023 20:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF28C433EF;
        Tue, 14 Mar 2023 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678826551;
        bh=3F8VJYaSb8vhtJbEMBhDsBJmQehPisrUw1hBFyo1xBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPwtHhGOxpFeiFu6PFlu8voRzvh7S77cxk4eSgqif6VNIlqDb1TnRXyYuhNJtWL7e
         lC0wyV0S7JW2JIGEhXAS+YxDyCGbxUYPMaKuPncBi+aXwS8G2O2boKus0R4N/CN9NZ
         dqYIkKozqSjraU9x8MH6d9F7gw4I/nv/HKY4j5I5J/B1DzmOZ/s0dRqq09xB1rns0m
         AA1xxpZy0OEPliAsC8ViZAK1jvA8l/EFpcIza9AtmoTGuCJVP9HeQ8f5vOalQMl/df
         eL/TD917cGGg+cfKVyk5k6o/JGRVty7oGFA3wayMRZkDX/vlhjkp3MouchapFy+D9r
         rPZ+ze/7Jl+1w==
Date:   Tue, 14 Mar 2023 21:42:28 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Kasumov Ruslan <xhxgldhlpfy@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>
Subject: Re: [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in
 pm8xxx_xoadc_parse_channel()
Message-ID: <20230314204228.m3rbmobsv2lyknhm@intel.intel>
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:37:09PM +0300, Kasumov Ruslan wrote:
> The left side of the loop condition never becomes false.
> hwchan cannot be NULL, because it points to elements of the
> hw_channels array that takes one of 4 predefined values:
> pm8018_xoadc_channels, pm8038_xoadc_channels,
> pm8058_xoadc_channels, pm8921_xoadc_channels.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC")

It wasn't broken before, it wasn't causing any harm. It's not a
fix, it's a cleanup. Please, remove remove the "Fixes:" tag.

> Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index eb424496ee1d..64a3aeb6261c 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -758,7 +758,7 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
>  	/* Find the right channel setting */
>  	chid = 0;
>  	hwchan = &hw_channels[0];
> -	while (hwchan && hwchan->datasheet_name) {
> +	while (hwchan->datasheet_name) {

With the fixes tag removed:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

>  		if (hwchan->pre_scale_mux == pre_scale_mux &&
>  		    hwchan->amux_channel == amux_channel)
>  			break;
> -- 
> 2.34.1
> 
