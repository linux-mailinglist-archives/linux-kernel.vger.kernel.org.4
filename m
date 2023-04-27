Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305C6F0BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbjD0S2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbjD0S2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDB44BF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682620077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+CX4GL4gGpxnXf/hJ5GWtmKz7MYbRhiiF9QJ1pFsSM=;
        b=N88+kLHAIM79eS+q/xb+Hwgxt5IWlQ1T7qeA0qgzBeRjx8HT3w5bJo9GtYY3kpHvQkXVJQ
        3LlSh9/sVCncsokccSB61oVXOx1qx4MQOnorriaFv9kKEdKT9U4IMtrIX9uLc1vEPt3sOC
        YdKVGtV+qGk+3z3OlMlPzR63n6Vt850=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-6Md7NY57MYOOg3tgNAX_OA-1; Thu, 27 Apr 2023 14:27:56 -0400
X-MC-Unique: 6Md7NY57MYOOg3tgNAX_OA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-751319bd93cso492554485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620075; x=1685212075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+CX4GL4gGpxnXf/hJ5GWtmKz7MYbRhiiF9QJ1pFsSM=;
        b=F/MAtvQWOhqHOYCGWXlWu8bsRQSZWEA4Y5HVDrzvwgcTG0zBm1cUIct+Uwanl0UyCj
         yVXJR28TcwGTzDBYmmP20TZCS0jfhE3wd9cHNACISrXrTQzBq4UA9Xk86rcMWB7owzF4
         5zxnabKoH30fhZNkOWi/pu0O7NRbOufflsHG8fA7OCbeM/m2R1xcUYwvb4JrcWMqyWFO
         ddsDmdSbMs0rcoP4ohwbQ1MbMaR5dtkg/vFqkzJggEMv81Zil5zy6EdMorORJboVG2RC
         yiHpd4SQubjerqavuYxaWxXy7ENwVVdkpB7rqmzaGyGyg2P879qcCkd6T6leVRosOD0I
         lQYA==
X-Gm-Message-State: AC+VfDyecCpgMUeziKFFRlKyF1TMGLjftZYt6V1HWoBA+0DZyxJzhg3L
        2MsDVSZWro3rRKIP79y9JvcuZqa0jbKRi2CHbmLS/zg6XR9deyAy+pP4HzAhphBbU+OYEs9zRuw
        GpOdKquIqGZSN95nT1117ruY1
X-Received: by 2002:a05:6214:2aa3:b0:5ef:6103:1475 with SMTP id js3-20020a0562142aa300b005ef61031475mr11387352qvb.20.1682620075762;
        Thu, 27 Apr 2023 11:27:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vITNttbiX9o2HcGScMwOU1JSe1VuR1YaYTjTVSHMXZNPeaKjyjfa3hzA7JN/b3DzJWeMzfA==
X-Received: by 2002:a05:6214:2aa3:b0:5ef:6103:1475 with SMTP id js3-20020a0562142aa300b005ef61031475mr11387327qvb.20.1682620075431;
        Thu, 27 Apr 2023 11:27:55 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id k25-20020a0c9719000000b005ef529dc39esm4016014qvd.108.2023.04.27.11.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:27:55 -0700 (PDT)
Date:   Thu, 27 Apr 2023 11:27:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: Prevent hwrng from activating during resume
Message-ID: <3r4dorqzh7nrcsqmsedmt47iimqrh52dfzgrmkjduqglhwufkt@3svji6cfdsug>
References: <20230426172928.3963287-1-jarkko@kernel.org>
 <20230426172928.3963287-3-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426172928.3963287-3-jarkko@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 08:29:28PM +0300, Jarkko Sakkinen wrote:
> Set TPM_CHIP_FLAG_SUSPENDED in tpm_pm_suspend() and reset in
> tpm_pm_resume(). While the flag is set, tpm_hwrng() gives back zero bytes.
> This prevents hwrng from racing during resume.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6e592a065d51 ("tpm: Move Linux RNG connection to hwrng")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/char/tpm/tpm-chip.c      |  4 ++++
>  drivers/char/tpm/tpm-interface.c | 10 ++++++++++
>  include/linux/tpm.h              | 13 +++++++------
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 6fdfa65a00c3..6f5ee27aeda1 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -572,6 +572,10 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
>  	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
>  
> +	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> +	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
> +		return 0;
> +
>  	return tpm_get_random(chip, data, max);
>  }
>  
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 7e513b771832..0f941cb32eb1 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -412,6 +412,8 @@ int tpm_pm_suspend(struct device *dev)
>  	}
>  
>  suspended:
> +	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> +
>  	if (rc)
>  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
>  	return 0;
> @@ -429,6 +431,14 @@ int tpm_pm_resume(struct device *dev)
>  	if (chip == NULL)
>  		return -ENODEV;
>  
> +	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
> +
> +	/*
> +	 * Guarantee that SUSPENDED is written last, so that hwrng does not
> +	 * activate before the chip has been fully resumed.
> +	 */
> +	wmb();
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_pm_resume);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4dc97b9f65fb..d7073dc45444 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -274,13 +274,14 @@ enum tpm2_cc_attrs {
>  #define TPM_VID_ATML     0x1114
>  
>  enum tpm_chip_flags {
> -	TPM_CHIP_FLAG_TPM2		= BIT(1),
> -	TPM_CHIP_FLAG_IRQ		= BIT(2),
> -	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
> -	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
> -	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
> +	TPM_CHIP_FLAG_SUSPENDED			= BIT(0),
> +	TPM_CHIP_FLAG_TPM2			= BIT(1),
> +	TPM_CHIP_FLAG_IRQ			= BIT(2),
> +	TPM_CHIP_FLAG_VIRTUAL			= BIT(3),
> +	TPM_CHIP_FLAG_HAVE_TIMEOUTS		= BIT(4),
> +	TPM_CHIP_FLAG_ALWAYS_POWERED		= BIT(5),
>  	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
> -	TPM_CHIP_FLAG_FIRMWARE_UPGRADE	= BIT(7),
> +	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
>  };
>  
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> -- 
> 2.39.2
> 

