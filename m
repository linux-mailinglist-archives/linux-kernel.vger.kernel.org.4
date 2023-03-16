Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581606BCFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCPMvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6588CB07C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678971015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPdjSzj6jsV5topoFHb/CW9wwLlrUfcPQ2AkSEnDD0g=;
        b=Njpa0f+uzTSrl1di/fkYZrIVe8ZF0aJyON13x2B3YuCrDwl2pO0QlY8QQwDDoCcDBHMXU/
        rPis6Jx5ZtXi+BOyMJyvvLaIw4YD/FhcHzto2IM0K5NNdjfps+J+hycrhkOUG71Zpx69gD
        MPoWQ3cHHThaYdB+ONsAv8yr7tm43mQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-cxcNbvhEO9-3T66mGm3b3Q-1; Thu, 16 Mar 2023 08:50:12 -0400
X-MC-Unique: cxcNbvhEO9-3T66mGm3b3Q-1
Received: by mail-ed1-f71.google.com with SMTP id e18-20020a056402191200b004fa702d64b3so2904596edz.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678971012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPdjSzj6jsV5topoFHb/CW9wwLlrUfcPQ2AkSEnDD0g=;
        b=PmPmcdvBB4yg7sLWaqDe3UMpX92jGri9BXIEtDQmC/4J1GGgbta6O59bfeHavS+Yv/
         KInlMeWbWzTR+rQK9e+gyQ9Dcodx5KICZUmBkAjv5r7WVIYad8kV8tWoZqfb5M/3ST3/
         hQF3DynDT09Ijq6FfSJ+1bzzIAeZSKEk1+QgBSo+p/a6HlEk8Al69nQ/dkXSoXYtmVld
         2MFBb+YA7BlsntUImEZBgavVp0TdxpR2IJzwXcO9tH0M/3H+ShSjUP0Fk0FTv/Nq/O+W
         ChmHr0wdLbdjWkELcMlnte58ZGGmW3qKIzDON5srdY2/yrK0EVRruim+nk0sM8zx1o9a
         MFcw==
X-Gm-Message-State: AO0yUKXegpIa9rqwXlr7P+JnVBKWM/4h6zNKK+4upVG9mpwmkNS/Afh8
        D5q6n5j1FcYqKzHjo+ByHBo9JZCUHaIJq34bld+LzDMKgvS4uIfPzc8cN8CkjH1nqq40PR54l6Q
        +5bngdoEzRjff3UqWWI2eBiyB
X-Received: by 2002:a17:907:2130:b0:930:f1b4:c033 with SMTP id qo16-20020a170907213000b00930f1b4c033mr1066575ejb.11.1678971011922;
        Thu, 16 Mar 2023 05:50:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set++DOjx83OQ0JfoGdfQG9v8lmgkiW061sRJeYdjos2LTGanTGZWCP0iNKnh4yf+Lz3jt0zw6A==
X-Received: by 2002:a17:907:2130:b0:930:f1b4:c033 with SMTP id qo16-20020a170907213000b00930f1b4c033mr1066562ejb.11.1678971011661;
        Thu, 16 Mar 2023 05:50:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d7-20020a50f687000000b004fe9386b259sm3293507edn.41.2023.03.16.05.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 05:50:11 -0700 (PDT)
Message-ID: <63814b1b-1297-da4d-79fe-8f2e58e30482@redhat.com>
Date:   Thu, 16 Mar 2023 13:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] platform: olpc: mark SPI related data as maybe unused
Content-Language: en-US, nl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Mattia Dongili <malattia@linux.it>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 3/12/23 14:26, Krzysztof Kozlowski wrote:
> The driver can be compile tested as built-in making certain data unused:
> 
>   drivers/platform/olpc/olpc-xo175-ec.c:737:35: error: ‘olpc_xo175_ec_id_table’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/platform/olpc/olpc-xo175-ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
> index 4823bd2819f6..04573495ef5a 100644
> --- a/drivers/platform/olpc/olpc-xo175-ec.c
> +++ b/drivers/platform/olpc/olpc-xo175-ec.c
> @@ -734,7 +734,7 @@ static const struct of_device_id olpc_xo175_ec_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, olpc_xo175_ec_of_match);
>  
> -static const struct spi_device_id olpc_xo175_ec_id_table[] = {
> +static const struct spi_device_id olpc_xo175_ec_id_table[] __maybe_unused = {
>  	{ "xo1.75-ec", 0 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, olpc_xo175_ec_id_table);

The whole presence of the olpc_xo175_ec_id_table[] seems to make little sense.

This should be referenced by:

static struct spi_driver olpc_xo175_ec_spi_driver = {

Like this:

        .probe          = olpc_xo175_ec_probe,
        .remove         = olpc_xo175_ec_remove,
+       .id_table       = olpc_xo175_ec_id_table,

Otherwise those ids cannot be used to load the driver the non DT/of way. Since the driver assumingly does actually bind already this means that it is only used the DT/of way and it seems to me that the whole olpc_xo175_ec_id_table[] can be removed entirely.

Exposing modaliases for a non supported way of binding the driver does not really seem useful ?

Patches 2/3 and 3/3 do make sense, I'll merge those soonish.

Regards,

Hans






