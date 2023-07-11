Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41474EB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGKJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjGKJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DCB91
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689068656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vCRTvkn5ZH82riXGsCDdYpG1boSEt6dLfoCx9K6sPw=;
        b=EROn+Pod54b50qE+NoOtZwUX2pCd2JmqmiWBtTMuQX/j8ueJyM/KUWJEZYEcvJETwGJ/o9
        wQWuivuX9n/9srpg6H9xdIquVLV4tOZGbsjW0H9VP8vqSbZyYTmwSN+OODWbAe1C37IWes
        FljOeP1t3TesaL+4CWMobABdDODe4BY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-N7Usya3fN5eQg0Gpih1yQw-1; Tue, 11 Jul 2023 05:44:11 -0400
X-MC-Unique: N7Usya3fN5eQg0Gpih1yQw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-992e684089aso318023466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068647; x=1691660647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vCRTvkn5ZH82riXGsCDdYpG1boSEt6dLfoCx9K6sPw=;
        b=OnKjXN5e8HNF+ODx6UKc8ukjMA3GgPh1SkRW10kVDfA/xQCczP0zJfp5O5ZwsZbQXp
         S9imkviZOpACPk3NBra02C0Jqj7C06b5rEfkS0KSuoJmuDA64WH5cBfXWrS0s8msj6aK
         t2Q15DvMbpgt68gYBuh4ar64A1512YZGXf/2gdW4xVqozQ9kcaUhc0z+miLy9GdvQUjp
         OCD5WQlvwhQxVjF2pTenporoOCvxWRR6f0jXSADCE4rgWild7U355Fja9W1XTGEI5vVm
         Qs+fZXvx3tkRIvyoiVrlpcVGNNBvY/9S8frH8dGR1E9YXz7yV5UfLlQnlTsBuVkbQXiz
         0wOA==
X-Gm-Message-State: ABy/qLY48sRBD6n/c0GsEdy6kQotpvs6rlBVZrbXCwkuCRUR7vr1vZzr
        prkNx/UEhUR/ADEQBjWvrHL4d1obrgdgFoiL3GsdC0E8pSdwRCYCkwZRvtIFV+8FJF2qL2VO/IO
        /0Jh9DFdTzbFyyCGNrzkdF9Gt
X-Received: by 2002:a17:906:4ad2:b0:988:a986:b11c with SMTP id u18-20020a1709064ad200b00988a986b11cmr13936700ejt.29.1689068647556;
        Tue, 11 Jul 2023 02:44:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHetqx7htc1mmoAuyViXDXDIXvhQ3Mn8NXqdjkDdtzjYr7mDuO0xLjRYit8bbVWHcG1AyfWDA==
X-Received: by 2002:a17:906:4ad2:b0:988:a986:b11c with SMTP id u18-20020a1709064ad200b00988a986b11cmr13936690ejt.29.1689068647369;
        Tue, 11 Jul 2023 02:44:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z26-20020a1709064e1a00b009937dbabbd5sm908730eju.220.2023.07.11.02.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:44:06 -0700 (PDT)
Message-ID: <d9c9d8d0-3b1f-8f8e-5fbf-84448c3a20e5@redhat.com>
Date:   Tue, 11 Jul 2023 11:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] platform/x86: int3472/discrete: set variable
 skl_int3472_regulator_second_sensor storage-class-specifier to static
Content-Language: en-US, nl
To:     Tom Rix <trix@redhat.com>, djrscally@gmail.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230702134419.3438361-1-trix@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230702134419.3438361-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/2/23 15:44, Tom Rix wrote:
> smatch reports
> drivers/platform/x86/intel/int3472/clk_and_regulator.c:263:28: warning: symbol
>   'skl_int3472_regulator_second_sensor' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/platform/x86/intel/int3472/clk_and_regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> index 61aeca804ba2..ef4b3141efcd 100644
> --- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> +++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> @@ -260,7 +260,7 @@ static_assert(ARRAY_SIZE(skl_int3472_regulator_map_supplies) ==
>   * This DMI table contains the name of the second sensor. This is used to add
>   * entries for the second sensor to the supply_map.
>   */
> -const struct dmi_system_id skl_int3472_regulator_second_sensor[] = {
> +static const struct dmi_system_id skl_int3472_regulator_second_sensor[] = {
>  	{
>  		/* Lenovo Miix 510-12IKB */
>  		.matches = {


Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




