Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A670CE35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjEVWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjEVWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544CEF4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684795535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FtagtMPCZhdjQLxkhVALS9CtFRmmMprPy30yXuFW40=;
        b=FDpoKfNcJ1vEOLdNCMNT+HOjmTggwvdf31V1l+SyZnsCaM0u5EzXq4gxMefxtKo45KLj0S
        Eowkb0P8wEs5wAaaQ9lGhPoGxbu896MvfkjmE1PVSyFj/SnQEGW1nOriyR6O4voZkvvN7D
        Od2eH8Ve5rZ/K3KWPedKCxRaRpoWLCI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-G6TMdm6qMZuPux9q7KCXfA-1; Mon, 22 May 2023 18:45:33 -0400
X-MC-Unique: G6TMdm6qMZuPux9q7KCXfA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f6b5bb0b60so6553281cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684795533; x=1687387533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FtagtMPCZhdjQLxkhVALS9CtFRmmMprPy30yXuFW40=;
        b=cFkXMuvt+zodOcvXP8uadhVZl7GZ635poWEmjbgVAjWbNlU6SYi6QUquZ0rNPP92Jg
         MGKHNn17GRw2NhW+Bc6IxdMyjawJBsuo3guGpzW0N7YX59KJ5t1HEWKFpfHNbT7zL4Tz
         veYEaGwoyOXghV+i/GYoBCgGLVp49aYdT4gLmaie2bw5O8+XKORKQkUF3r+lL0m8Gtsb
         0qvd/5l3VG9DO14kkTgFo4uLT3Uv51MmvvPFO8jXzRmy8R4ncZbkaddxW1VfVRdcx2io
         U4zEzAlSfrMIk+I4YU4hNaoS294c7JEwJ/s5O6dzX6pz4uM+oA7REHyVuByA6kbuvS4r
         ualQ==
X-Gm-Message-State: AC+VfDxG+sE9oh6+1IihPb5+NWPui/Fscq0ETNPLv8UG9kJ4PPdWEl5x
        LBuDK6YgTg3VH2uDNpzOsdI1tsPn5Pnm3m3HrwyYGV/R0a0c+XvWMxbUu/wXjyaPB7vlt2AvRVm
        K6RSWLyF0z1zOyVrhXEC2sTDv
X-Received: by 2002:ac8:5bcc:0:b0:3f4:dc79:1a6e with SMTP id b12-20020ac85bcc000000b003f4dc791a6emr18815223qtb.19.1684795533414;
        Mon, 22 May 2023 15:45:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QoB9ZN08YxUWKinY5Qg4xARLp2kT9AyL+I8LQV/JUP1TiW3Tb0GizkkcYu8GU+rMO3Zid1w==
X-Received: by 2002:ac8:5bcc:0:b0:3f4:dc79:1a6e with SMTP id b12-20020ac85bcc000000b003f4dc791a6emr18815203qtb.19.1684795533194;
        Mon, 22 May 2023 15:45:33 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c14-20020ac84e0e000000b003ef13aa5b0bsm2413063qtw.82.2023.05.22.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:45:32 -0700 (PDT)
Date:   Mon, 22 May 2023 15:45:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peter.ujfalusi@linux.intel.com, peterz@infradead.org,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH 2/2] tpm, tpm_tis: reuse code in disable_interrupts()
Message-ID: <sjuno2nngrloge53ypxgn36ptbuwr2m3wouxt3nwmatux27pyb@vi5hadhrljgt>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <20230522143105.8617-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522143105.8617-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:31:05PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Avoid code redundancy by shifting part of the code in disable_interrupts()
> into a subfunction and reusing this function in tpm_tis_handle_irq_storm().
> Make sure that in the subfunction the INT_ENABLE register is written with a
> claimed locality even if the caller did not claim it before.
> 
> In the shifted code get rid of the variable "rc" by initializing the
> interrupt mask to zero at variable declaration.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis_core.c | 36 ++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 458ebf8c2f16..8f4f2cb5520f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -468,25 +468,32 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	return rc;
>  }
>  
> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	u32 intmask = 0;
> +
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> +
> +	tpm_tis_request_locality(chip, 0);
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	tpm_tis_relinquish_locality(chip, 0);
> +
> +	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +}
> +
>  static void disable_interrupts(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	u32 intmask;
> -	int rc;
>  
>  	if (priv->irq == 0)
>  		return;
>  
> -	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> -		intmask = 0;
> -
> -	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> -	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	__tpm_tis_disable_interrupts(chip);
>  
>  	devm_free_irq(chip->dev.parent, priv->irq, chip);
>  	priv->irq = 0;
> -	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>  }
>  
>  /*
> @@ -755,20 +762,11 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>  static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int intmask = 0;
>  
>  	dev_err(&chip->dev, HW_ERR
>  		"TPM interrupt storm detected, polling instead\n");
>  
> -	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -
> -	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> -
> -	tpm_tis_request_locality(chip, 0);
> -	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> -	tpm_tis_relinquish_locality(chip, 0);
> -
> -	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +	__tpm_tis_disable_interrupts(chip);
>  
>  	/*
>  	 * We must not call devm_free_irq() from within the interrupt handler,
> -- 
> 2.40.1
> 

