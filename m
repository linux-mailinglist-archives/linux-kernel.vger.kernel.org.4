Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA34742AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjF2Q7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjF2Q7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26063598
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688057936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swdMiA1r9t+az8w+QR1JvmbiMrBSFzQ6KVm/MzBCuOU=;
        b=To0i02Dcdfq1x9gMZ9vi5PPNCp0/cA9kvECpJBZt0P+0nSmls0KNiWcyteQmSs0x2+QJZh
        xa0OqY5vVRHVkCxMj7o9r2Q2NcWMoGx7XCSOROorPf8lWZ0Yl4axysRR65R2JhREEPi849
        jivFk9JN962exm2PBRv8UKr+FpinfFI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-37UTdkj3OuKsJ5KuC9sLJw-1; Thu, 29 Jun 2023 12:58:54 -0400
X-MC-Unique: 37UTdkj3OuKsJ5KuC9sLJw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e664d2f8so9702226d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057933; x=1690649933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swdMiA1r9t+az8w+QR1JvmbiMrBSFzQ6KVm/MzBCuOU=;
        b=PPd1ShyBjaMeZyz0KLWrlkc66Wbo0r/4lhM7b17KmQUhub/dYyZ0oMHL4rl2yXp6WT
         LXxH0gFTuLH4AHZkv318KzYp6QBat32omUB9pw0f6r5k64Hng7oGm3PL0ykYTY3W2CnL
         78o8SgtlKF7IXmzHRqObJkgoCxbs48YImxmRuEQaLWqWWhDplQhVLmC8pv7wlA1mM3rP
         wHr0B3iVNlHGhl3/X9I1T3g0StUh2s4sDNj3Er/KVn02HIu33pSxqEIMgJmQs5db+Y6G
         4CJZ1ABNaOXiWGnSioVjvVDbAD533jGtuKDAjaq6LSjVXS9SC8EXRYvgaJX/EetVJrWR
         RsuA==
X-Gm-Message-State: ABy/qLbbcsNymL8IjYKGjMkt2Wzi2GzwenawE79tSAuwE6x1igcOJSyS
        bNjlEAhx6pWTsesqrP+ZdQMy7JiXxc4qQEFUaJsFsCSg112DNOKSEl4yQaGDX9KCaIN3stle4+R
        Pf2F3MLMJefA/Xqvv5kg0PC8p
X-Received: by 2002:a05:6214:4110:b0:635:e0dd:db42 with SMTP id kc16-20020a056214411000b00635e0dddb42mr216411qvb.27.1688057933215;
        Thu, 29 Jun 2023 09:58:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZh6c5lPlscLNAkoheXBIabQY3I2vBrGKgWcc7orFQAecMaAR78/iF4k9GfBYMHfhVZAMJ9g==
X-Received: by 2002:a05:6214:4110:b0:635:e0dd:db42 with SMTP id kc16-20020a056214411000b00635e0dddb42mr216401qvb.27.1688057932994;
        Thu, 29 Jun 2023 09:58:52 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y11-20020ad457cb000000b00631eb444e6esm7108198qvx.51.2023.06.29.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:58:52 -0700 (PDT)
Date:   Thu, 29 Jun 2023 09:58:51 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Florian Bezdeka <florian@bezdeka.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo L590 devices
Message-ID: <qaghyyi3wd6sfppfkbf2d6spsnfafalseeznyjf5bgdj5nikdy@mz4t52hjkuus>
References: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:11:01PM +0200, Florian Bezdeka wrote:
> The Lenovo L590 suffers from an irq storm issue like the T490, T490s
> and P360 Tiny, so add an entry for it to tpm_tis_dmi_table and force
> polling.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2214069#c0
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Florian Bezdeka <florian@bezdeka.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7db3593941ea..2771abb5628f 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -138,6 +138,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
>  		},
>  	},
> +	{
> +		.callback = tpm_tis_disable_irq,
> +		.ident = "ThinkPad L590",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> +		},
> +	},
>  	{
>  		.callback = tpm_tis_disable_irq,
>  		.ident = "UPX-TGL",
> 
> ---
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> change-id: 20230620-flo-lenovo-l590-tpm-fix-4aeb6aa25667
> 
> Best regards,
> -- 
> Florian Bezdeka <florian@bezdeka.de>
> 

