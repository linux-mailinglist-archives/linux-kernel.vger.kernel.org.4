Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456767370B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjFTPkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjFTPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC101B0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687275565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGk8vxk8AnrtqTq0AdHw6yZETcVNiHfrmKvc9/TW2Kc=;
        b=XEFhKkhYS3wSifK1mUVXTD5cMf5Pvz5uNn/7C73xvaq7pg7OE975P5c3AmzMwuqrzYWs3l
        IViyLc8oW1kUv1lRyn8NMZsF1e/VWMzZFbF3zFZTJ9blsDviY8Sj4gHlqfaWTuyO13waKT
        il+alnFDu3L34x0LhZG4CZSpfh9LjLs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-T55EizStNimSJ8OC0BI0aA-1; Tue, 20 Jun 2023 11:39:18 -0400
X-MC-Unique: T55EizStNimSJ8OC0BI0aA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a341efd9aso379705666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275550; x=1689867550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGk8vxk8AnrtqTq0AdHw6yZETcVNiHfrmKvc9/TW2Kc=;
        b=Mn58ik2B/fyp8+D7xnYxf8wLC5WshupoafoZnZZayMp/5MfcHIwk4lHH6/5nyK0bt1
         /E5UOm+vHWf4dBK5sb/wWB9opjwxzl1YSLkZqi5JMlui8LeRylTyxYiyqbfHHaDGuB8G
         N/aSmLj5ZwRGv/cvx4MCTfB4GmzB6SlOlA4BoMjaThCTZYnRjJEq7rVw7IJgGzIreiMI
         xlwLpYFj+/YHloIvZvyC5+8sCqkJxuXeEoDREVD94hRMpe2u+oVy4qj0nEzRA0EjTtfO
         S1DAdR6PrXGiXHSWp1KJ4zk0cjLFw9e16FWLmn4NWJEN8qR9nb3JewfvxYSGD9uPqYlX
         C1rw==
X-Gm-Message-State: AC+VfDzcki9tXAsQoH6QJ9KrGc7zTmwvSBnMEC02/corjdnKW85P4GQY
        ubMNXNJTToqg+rkJvBfuf5batsTodKnYZHGD3wMS24X5j5azhkI2ukyUYJX/SqqhIffA7Os+EOs
        QjUsLW6wElFnYFAZW+oWNKNxu
X-Received: by 2002:a17:907:6d97:b0:988:9621:d85d with SMTP id sb23-20020a1709076d9700b009889621d85dmr5816270ejc.46.1687275549925;
        Tue, 20 Jun 2023 08:39:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/+6bx2nXw+tGTUrage9rV9LxeLUps7RJhscUo+U2JKiODKGpWLPGHrkdkJ7HpOW144704Rw==
X-Received: by 2002:a17:907:6d97:b0:988:9621:d85d with SMTP id sb23-20020a1709076d9700b009889621d85dmr5816260ejc.46.1687275549676;
        Tue, 20 Jun 2023 08:39:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709064a8900b00985767bb5f9sm1588123eju.70.2023.06.20.08.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:39:09 -0700 (PDT)
Message-ID: <fa67a1b8-ad4e-0ee3-b629-be0e80898c7c@redhat.com>
Date:   Tue, 20 Jun 2023 17:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo L590 devices
To:     Florian Bezdeka <florian@bezdeka.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/20/23 13:11, Florian Bezdeka wrote:
> The Lenovo L590 suffers from an irq storm issue like the T490, T490s
> and P360 Tiny, so add an entry for it to tpm_tis_dmi_table and force
> polling.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2214069#c0
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Florian Bezdeka <florian@bezdeka.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


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

