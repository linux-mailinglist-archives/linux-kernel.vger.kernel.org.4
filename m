Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269306E9B75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjDTSTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDTSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:19:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558AE2736;
        Thu, 20 Apr 2023 11:19:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a667067275so12572855ad.1;
        Thu, 20 Apr 2023 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682014779; x=1684606779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7m896v0zwclnMzE5M32YGgcorfSqd9qtXANPeD/BFc=;
        b=EKZvXX4qyof85ohLLAM5XOERZrpcAuvSepl8jPQj89JQnPoSBqtiUH4jqb7JZM7fZD
         0civ84sZ/NmZG1iKoJVlVTw2vqfKIEV8sawSg7c86w27iZSS9qrOQRrja9a9oke80Blx
         MqdNhUJMGCU/MvsriLgCm5AUPugCkmxFsysaRm6EdWRcAa/g47WF9nc5ykOYMvKw6vY9
         wyAlCnn5PoHo5lqOnf+8AagDwFN+zC7dn3Fxc9rU6OzN5zc9tsOSQvQqIHgahjZxfCrm
         2r9C2gA3NILtzH/0+J3VtL41AsFOvi551NgCuX63BF1Bz6KQJ7L9RiLNMJnGajFRYpch
         9l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014779; x=1684606779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7m896v0zwclnMzE5M32YGgcorfSqd9qtXANPeD/BFc=;
        b=CJKcfIaqAZierY2wyY2tHzTeyKaFgQHcPSUi7y2Xipigb/u//JGY+olakKJiCDKSq3
         X+073CczelAfabxfSok94OTjyJYCN57Wj+kLK+gJuANp8JpuKXRuNsXJb0MR/2WOnhNk
         k52sHGfsAGHXCZy6+vK4Xw9A0bcPNXb98nQDxWY7S0dFH6Yz9oNMSBKHLuyEYjD8WRYP
         AQgIqHO2Ti7wjdNH1iuexKxXebgBj7AHiXsuaWhDFgdX64kC3RP1DRSlFF1uRzhrO4+p
         mhemNwQrNYN4IjrGOn+QekFtwC9DnoXuJ6RiZwfV7bcUcRJ2QB+zBKVH+wf2otxXFOP8
         KPOQ==
X-Gm-Message-State: AAQBX9d5tppCOdu4COV4SziW4San/TXqSX1728VDOg00x6SDZpzIIEIt
        Quhkfcb+40XgqJFr4w2jpKK8Esb/z4I=
X-Google-Smtp-Source: AKy350YbizgwIxj66WbsohtGqdUE092BhFj/u0NcCBirM0AovG5ih/cigIPbpby5y4HLhgcFKqJvDg==
X-Received: by 2002:a17:903:244f:b0:1a8:16d2:a867 with SMTP id l15-20020a170903244f00b001a816d2a867mr3002668pls.62.1682014778706;
        Thu, 20 Apr 2023 11:19:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902b48b00b001a63ba28053sm1453017plr.68.2023.04.20.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:19:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Apr 2023 11:19:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?utf-8?B?VG9tw6HFoQ==?= Pecka <tomas.pecka@cesnet.cz>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH 1/1] hwmon: (pmbus/fsp-3y) Fix functionality bitmask in
 FSP-3Y YM-2151E
Message-ID: <1eb61572-591b-44ac-8415-7f18875202f7@roeck-us.net>
References: <20230420171939.212040-1-tomas.pecka@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230420171939.212040-1-tomas.pecka@cesnet.cz>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 07:19:39PM +0200, Tomáš Pecka wrote:
> The bit flags in pmbus_driver_info functionality for YM-2151E chip were
> joined with a comma operator instead of a bitwise OR. This means that
> the last constant PMBUS_HAVE_IIN was not OR-ed with the other
> PM_BUS_HAVE_* constants for this page but it initialized the next element
> of the func array (which was not accessed from anywhere because of the
> number of pages).
> 
> However, there is no need for setting PMBUS_HAVE_IIN in the 5Vsb page
> because this command does not seem to be paged. Obviously, the device
> only has one IIN sensor, so it doesn't make sense to query it again from
> the second page.
> 
> Fixes: 1734b4135a62 ("hwmon: Add driver for fsp-3y PSUs and PDUs")
> Co-developed-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>

FWIW, adding both Co-developed-by: and Signed-off-by: tags doesn't
make sense since Signed-off-by: implies Co-developed-by:.
I'll drop the first tag.

> Signed-off-by: Tomáš Pecka <tomas.pecka@cesnet.cz>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/fsp-3y.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
> index aec294cc72d1..c7469d2cdedc 100644
> --- a/drivers/hwmon/pmbus/fsp-3y.c
> +++ b/drivers/hwmon/pmbus/fsp-3y.c
> @@ -180,7 +180,6 @@ static struct pmbus_driver_info fsp3y_info[] = {
>  			PMBUS_HAVE_FAN12,
>  		.func[YM2151_PAGE_5VSB_LOG] =
>  			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
> -			PMBUS_HAVE_IIN,
>  		.read_word_data = fsp3y_read_word_data,
>  		.read_byte_data = fsp3y_read_byte_data,
>  	},
