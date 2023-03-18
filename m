Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304AA6BFB3D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCRPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCRPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9B425BAE;
        Sat, 18 Mar 2023 08:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB34860EAE;
        Sat, 18 Mar 2023 15:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3436C433EF;
        Sat, 18 Mar 2023 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679153641;
        bh=Kt8CaawG0MpSdZ26UOh9SvS3bT30FK58COF6HsU3+Jk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JuzGuPUZ2yaltpUX++JHiZdYu//rZwH2Pw2DoLxBWoyo3+RRfHWgHJ1IE+Q3qJN00
         dw4/q2c3q+qAcWQwXcQQQ8eRCe+I9GBqjdtPg2RTBnf+vh2UN3DcG3WQR4CeX/FMwo
         7IEuj/soJSkM5ho/gJtvtyhSd0tlR3q26dJjJGvwlYbrz7jS82NXJYioZYdn2INUWg
         HJ5Bcp4mJXRqRArLC3h1kotAkOsIaVC6V6JgF/kSdQ92LSvHZjxL+9x6Nw/2kTkqqV
         UGLMAPKPbH+6QGeOOub3vpaCylvwqrk7wItsfGKND3uwYm5bam1y9o3j5e9/SQh332
         5EsK8kUL9z2cg==
Date:   Sat, 18 Mar 2023 15:48:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kasumov Ruslan <xhxgldhlpfy@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>
Subject: Re: [PATCH v2] iio: adc: qcom-pm8xxx-xoadc: Remove useless
 condition in pm8xxx_xoadc_parse_channel()
Message-ID: <20230318154853.0c91e055@jic23-huawei>
In-Reply-To: <20230315135114.22684-1-xhxgldhlpfy@gmail.com>
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
        <20230315135114.22684-1-xhxgldhlpfy@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 16:51:14 +0300
Kasumov Ruslan <xhxgldhlpfy@gmail.com> wrote:

> The left side of the loop condition never becomes false.
> hwchan cannot be NULL, because it points to elements of the
> hw_channels array that takes one of 4 predefined values:
> pm8018_xoadc_channels, pm8038_xoadc_channels,
> pm8058_xoadc_channels, pm8921_xoadc_channels.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>

We could file this under the category of (overly) paranoid checking that
he variant structure has the hw_channels set, but given there are only 4 instances
of that it is (as you have done) easy to check.

So fair enough to drop this check.

Applied.

Thanks,

Jonathan

> ---
> v2: Removed "Fixes" tag as Andi Shyti <andi.shyti@kernel.org> suggested.
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
>  		if (hwchan->pre_scale_mux == pre_scale_mux &&
>  		    hwchan->amux_channel == amux_channel)
>  			break;

