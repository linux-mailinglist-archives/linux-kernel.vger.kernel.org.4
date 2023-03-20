Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64456C0DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCTJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCTJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2BBCC3D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679305837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ss6kVDpqjW5IIsm4uryKZ88uo+KrVDW16y6KeLjlJYk=;
        b=O1fHbx/GjsUCJUp+j9dcYDc93nGWZOgTyTpyAe0g1+GDPUwco63wFTE56NjEjq/kTCroBW
        4k2YlBJTTKzKzrmi9OAuKYTjjG9dZSouZIgdDWLOTEZOkZxpd/oC4VvE0+e6Ukc+O6eypl
        kEvfyOX2VApiEx+HpmM+4Y4gYBUqNNA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-C90FDM1jOwy67oiHx5ZoPg-1; Mon, 20 Mar 2023 05:50:36 -0400
X-MC-Unique: C90FDM1jOwy67oiHx5ZoPg-1
Received: by mail-ed1-f71.google.com with SMTP id er23-20020a056402449700b004fed949f808so16739525edb.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679305835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss6kVDpqjW5IIsm4uryKZ88uo+KrVDW16y6KeLjlJYk=;
        b=YKrRGkahHMgfDNggLwIM5Ry/BdHbVnvgUmh7ROAEloE7m6vKBCpl3G3NtB8MABfHKA
         7xY/9BtIgEXrjvXO13nFonH+axTksPIWPCEpaUEcw2WUG4yNl9HVKE+48GGeG4LiIDX2
         1V9hrb5wasIgvY9EHDjRuJyBjmgLkNYmwKh0G8K8+1m5bw0+NkppWVp4TsmnsoRR10zG
         pDpWOX0WQQkl/P5PXBvYx0p18jlMXvrvxq9BCGdGiYxANjn/Jn8GGj/PVKdwn3oT9jKT
         I1WBmCZfhvneSq//eGTyxTbbH2B2VUtXmc8oygaA703TtwBhp+o6XqimmG2TmV7PNzur
         0q/A==
X-Gm-Message-State: AO0yUKUt6oR1Arf76/nWCacu3nkx4Y/03Z/HaAC0tdwJ83P3hjdNjUdK
        rsqxIEN+9ZjpasskTVSE/FnrErxU75YFICxdqFHN9s67HS4htYYA0xF31iU9TkNQBDC+LTZXatt
        4sgrshflBQiRBYI0P11DCxffZ
X-Received: by 2002:a17:906:fe4c:b0:92f:22b1:57f9 with SMTP id wz12-20020a170906fe4c00b0092f22b157f9mr9854311ejb.2.1679305835064;
        Mon, 20 Mar 2023 02:50:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set/47JPtGexk0TSuJX1KiZr+LwW7LBb1OTu2U07PVmduBtikRfn1f3Orewm9RB9+y1JlZkjZQQ==
X-Received: by 2002:a17:906:fe4c:b0:92f:22b1:57f9 with SMTP id wz12-20020a170906fe4c00b0092f22b157f9mr9854299ejb.2.1679305834816;
        Mon, 20 Mar 2023 02:50:34 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906169a00b009200601ea12sm4127757ejd.208.2023.03.20.02.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:50:34 -0700 (PDT)
Message-ID: <9b8bc631-435d-7c4d-d605-be10092242c8@redhat.com>
Date:   Mon, 20 Mar 2023 10:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] staging: rtl8723bs: use inline functions for
 dvobj_to_dev
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, namcaov@gmail.com,
        straube.linux@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
References: <20230319201134.253839-1-eng.mennamahmoud.mm@gmail.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230319201134.253839-1-eng.mennamahmoud.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/19/23 21:11, Menna Mahmoud wrote:
> Convert `dvobj_to_dev` macro into a static inline function.
> it is not great to have macro that use `container_of` macro,
> because from looking at the definition one cannot tell
> what type it applies to.
> 
> One can get the same benefit from an efficiency point of view
> by making an inline function.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> change in v2:
> 	edit commit message.


Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/staging/rtl8723bs/include/drv_types.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> index 82159e1c7f9b..ea6bb44c5e1d 100644
> --- a/drivers/staging/rtl8723bs/include/drv_types.h
> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> @@ -305,7 +305,11 @@ struct sdio_data intf_data;
>  };
>  
>  #define dvobj_to_pwrctl(dvobj) (&(dvobj->pwrctl_priv))
> -#define pwrctl_to_dvobj(pwrctl) container_of(pwrctl, struct dvobj_priv, pwrctl_priv)
> +
> +static inline struct dvobj_priv *pwrctl_to_dvobj(struct pwrctrl_priv *pwrctl_priv)
> +{
> +	return container_of(pwrctl_priv, struct dvobj_priv, pwrctl_priv);
> +}
>  
>  static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
>  {

