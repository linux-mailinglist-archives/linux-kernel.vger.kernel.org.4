Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13B96C7A33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjCXIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCXIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1E10E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679647632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5G+nkVZbFhorfyx9g7JFxAkGXU0+uL9r+IJmU+EGZDc=;
        b=Zt0sVtOJhQ7q1F0Xf1zHUr7BWM5hfHztyzve/hQ9HtVIED2SqswHMFxqkPPnEzWzNt69fB
        EqfOhgyjkDBM93jyzJsEE0MbTlUtkDwyN/OkP5RWWOiGymZG8gbWfe4v8fUU/9fW10MTNW
        g11DZAwZSQQeoqJZITigf1RsUjDEZOI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-L1Z6kcDeNLOx9bVUQs8IlA-1; Fri, 24 Mar 2023 04:47:10 -0400
X-MC-Unique: L1Z6kcDeNLOx9bVUQs8IlA-1
Received: by mail-ed1-f72.google.com with SMTP id t14-20020a056402240e00b004fb36e6d670so2193055eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679647629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5G+nkVZbFhorfyx9g7JFxAkGXU0+uL9r+IJmU+EGZDc=;
        b=1koLhAn8LgS5l86r3bQjcPPojGqVqU9liy/RwfGBFZvHfWly7YAwwQaQdrsyOf9p3k
         +SeujE+nw1MjUemL8DJGS2mQ9sKhdEwpi5eolzKttuuPetHI30ZBlq2Rnxqhk7mHkPBC
         xEmGM8IEE2xm7cYaDpHUFDRxzJmiGLAd7l68tB6aSbBJ/0sZLQx/OH0uqWkEDGqSim1Q
         WXvd9VWhDysC3hhPGc9LUESVt4Qs9Y+tc9lodZovnIkKm9V40numBzJUQr9eD5V3xTe1
         B537jHqj43HE+fk8fSSiklivTt5koY20SEOe8Bdh1EyjWqXGQy1Z2rrsjfamxkIChJv4
         mJ3Q==
X-Gm-Message-State: AAQBX9fVN6Pqf/ZsmfhZFt4OMUgzGx7B/I1r6gz3Hu1p7NOf+7lyQdkm
        xQ6ZyueMHHlCWyVoGC6qoXDG9LGB5LBmzqPqlLJEjK2qX4/HshiQAwq4uY5oIha6eLsVhgdwuWd
        rjIiRnn3OofqDEMkfQA2gweyN
X-Received: by 2002:a17:907:7f25:b0:931:f57a:4bcd with SMTP id qf37-20020a1709077f2500b00931f57a4bcdmr2154505ejc.77.1679647629507;
        Fri, 24 Mar 2023 01:47:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y5sorhIXa/1/3XlRrgSYRtI0MI1TLm5EQbwDS3hG646GTEMQT+qf958aIcY2hlb7VtfCu0Kw==
X-Received: by 2002:a17:907:7f25:b0:931:f57a:4bcd with SMTP id qf37-20020a1709077f2500b00931f57a4bcdmr2154493ejc.77.1679647629265;
        Fri, 24 Mar 2023 01:47:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906278800b0093dc6944b8bsm981148ejc.208.2023.03.24.01.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 01:47:08 -0700 (PDT)
Message-ID: <f2eef1b0-5ab5-0ccf-7721-520c3b708007@redhat.com>
Date:   Fri, 24 Mar 2023 09:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: rtl8723bs: remove hal_btcoex_SetChipType()
Content-Language: en-US, nl
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230324084334.12183-1-straube.linux@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230324084334.12183-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/24/23 09:43, Michael Straube wrote:
> Remove the function hal_btcoex_SetChipType() as it does nothing and
> produces the following gcc warning when compiling with W=1.
> 
> drivers/staging/rtl8723bs/hal/hal_btcoex.c:1182:30: warning: variable 'pHalData' set but not used [-Wunused-but-set-variable]
>  1182 |         struct hal_com_data *pHalData;
>       |                              ^~~~~~~~
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/staging/rtl8723bs/hal/hal_btcoex.c        | 8 --------
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
>  drivers/staging/rtl8723bs/include/hal_btcoex.h    | 1 -
>  3 files changed, 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> index e36f8c369a04..e26b789b9cdd 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> @@ -1177,14 +1177,6 @@ bool hal_btcoex_IsBtDisabled(struct adapter *padapter)
>  		return false;
>  }
>  
> -void hal_btcoex_SetChipType(struct adapter *padapter, u8 chipType)
> -{
> -	struct hal_com_data *pHalData;
> -
> -
> -	pHalData = GET_HAL_DATA(padapter);
> -}
> -
>  void hal_btcoex_SetPgAntNum(struct adapter *padapter, u8 antNum)
>  {
>  	struct hal_com_data *pHalData;
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index 0fcae6871108..c3c1b49674d3 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -2304,7 +2304,6 @@ void Hal_EfuseParseBTCoexistInfo_8723B(
>  	}
>  
>  	hal_btcoex_SetBTCoexist(padapter, pHalData->EEPROMBluetoothCoexist);
> -	hal_btcoex_SetChipType(padapter, pHalData->EEPROMBluetoothType);
>  	hal_btcoex_SetPgAntNum(padapter, pHalData->EEPROMBluetoothAntNum == Ant_x2 ? 2 : 1);
>  	if (pHalData->EEPROMBluetoothAntNum == Ant_x1)
>  		hal_btcoex_SetSingleAntPath(padapter, pHalData->ant_path);
> diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
> index fb167642da01..525cce3574fe 100644
> --- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
> +++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
> @@ -23,7 +23,6 @@ struct bt_coexist {
>  void hal_btcoex_SetBTCoexist(struct adapter *padapter, u8 bBtExist);
>  bool hal_btcoex_IsBtExist(struct adapter *padapter);
>  bool hal_btcoex_IsBtDisabled(struct adapter *);
> -void hal_btcoex_SetChipType(struct adapter *padapter, u8 chipType);
>  void hal_btcoex_SetPgAntNum(struct adapter *padapter, u8 antNum);
>  void hal_btcoex_SetSingleAntPath(struct adapter *padapter, u8 singleAntPath);
>  

