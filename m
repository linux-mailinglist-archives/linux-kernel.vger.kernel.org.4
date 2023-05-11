Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B76FFB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbjEKUoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjEKUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:44:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094321FF1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:44:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24deb9c5ffcso6265877a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683837857; x=1686429857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hjCuhDdEpisTNEgIUNHt8mdh/WtukpJUPhW4o+llao=;
        b=DzptXMJESoyD2cU6GH7BV0t5a3uv+1D7VfT2KoLoczknojYd0DwBwVxS/eWthAieQQ
         hV1IvRE2P4Fo+45Tc06HCzsKRKcBdBRbE9sDTxNaVwX+sHDzhbrX2ZsEP+59QYUraARQ
         Z98FmW9d2rssrFBBPfl2ZwTGpqjUzEtzVky1JG8FP0C4B7rYWWjr9ZfoFhX/8WV7mMdU
         PWMN18rWFyfJlRhZUKGMf9JG0UHkX6nLqhJAtF24wd1F/pnpvAYsoHa/RlGBVfwMs9Ui
         ZdCgj69aBqIPQtNzj6lG5OJRQYs5I3N+NuDeukeFspYIRrC8kGuRZeedGFwD0KiZzEK7
         Avbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683837857; x=1686429857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hjCuhDdEpisTNEgIUNHt8mdh/WtukpJUPhW4o+llao=;
        b=gI1nAzxlB3414V1YMhUzKQpbNrvJYB5NeDdK5lXBfw1jqIqwPOMj5uCMfME935J2XD
         cnm8ShEbTKbZFx5URPVXAeWkaNzq3kGhzpfbk34XNQx6tZvy2NuohugRCA0pxPm0RyZz
         NJIdJLbfi1hfKfB6+bq4x1D+ChdEim8wz8WWus2x5SGsKsCD1vA4rC3LDdKgrab/a7gk
         MALVpQgV/1uf9I5WEiin9gp7PDG2TjeizfzRKkvVcNmQDpkoqx8pb6YzmpGHFwq7sPEU
         H8t47ZZLQEsf8tLeDgITsxu1uiZIbIbeHhdEYLq5nsubehbRQOMLdKTKBUNgh1cjizBk
         5SPw==
X-Gm-Message-State: AC+VfDyS1YOqYaLiSCgI50go1F5y6T1Xhs2PoSuU+1yX+6hl7H3QEiqc
        jIVqNqKZMMIE0X1jSJq/QCA=
X-Google-Smtp-Source: ACHHUZ5hQnUC2s8ywUsFomsmvpvRU6S4XCPDUAhd7Tb1dugMgzmlRcrqmf/Hr3jtex/qu9nuGVhixA==
X-Received: by 2002:a17:90a:db07:b0:250:a4f5:fb34 with SMTP id g7-20020a17090adb0700b00250a4f5fb34mr11969525pjv.2.1683837857291;
        Thu, 11 May 2023 13:44:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090a760e00b0024e134a2408sm18906917pjk.14.2023.05.11.13.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:44:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 May 2023 13:44:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <38162cf3-44e8-4774-b60b-539075369699@roeck-us.net>
References: <20230511174650.279452-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511174650.279452-1-krzysztof.kozlowski@linaro.org>
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

On Thu, May 11, 2023 at 07:46:50PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> Changes since v1:
> 1. Correct whitespace (Christoph)
> 2. Add tag
> ---
>  drivers/nvme/host/hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 9e6e56c20ec9..6aa153f3178a 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -185,7 +185,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
>  	return 0;
>  }
>  
> -static const struct hwmon_channel_info *nvme_hwmon_info[] = {
> +static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
> -- 
> 2.34.1
> 
