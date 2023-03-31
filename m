Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD96D26C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCaRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC31EA12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680284224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TW3eRYhY8krxuQYRljIfEDzKI7IC0lmrJ5k4rfM21Xg=;
        b=MTae3yG+kFwK9uNFyoOofc8NYLhsY0d4c5NZsMhjcJ5fi0pcetRp00GC2dm/bQyBZGnCYQ
        qMxL58LVARUOKKcewjiTRAuF/M0QrsE/vXGP98TQZtvzpzHdZBJaoLNKSAlUKVm1MjWlCF
        KmUXAWaSly0sluNIufFuLk3FEpKrAQQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-XFKyX_fTPVGvdLGfRK6BYg-1; Fri, 31 Mar 2023 13:36:58 -0400
X-MC-Unique: XFKyX_fTPVGvdLGfRK6BYg-1
Received: by mail-ed1-f71.google.com with SMTP id k30-20020a50ce5e000000b00500544ebfb1so32710875edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TW3eRYhY8krxuQYRljIfEDzKI7IC0lmrJ5k4rfM21Xg=;
        b=0smlwctM3F6RngLjILG/3cOlVqIteZ+4nG4wouM3X/DME87+BshKvnyRS9yZOOIdYn
         k6SRdG+XJE/WHANIDAmPGQwju9dndRGbjJY4sAscBqmZyfzipun/wiRoP5lnhQUbFu5e
         B1JGjuSYZjuwLJh5v+HGWVQF069mZ0LrVUm9FoZCNpQOuaCdWTI0STIoKxfWN9DePsJb
         QYR+KlDzt1cHQ6db/ajHDucFRVcF+FwBtkkHd4ElQZPsb+G6YimXy9Z5pVI/ZqX34pYW
         421UwJNHhMTnpaI2exE7nD7ods7jT5pgCP1Hdhs1+q73I9+GuzvTbVdOM2FI5vHTed3h
         9yIQ==
X-Gm-Message-State: AAQBX9cu4RCJDUXhs67ZOMsOeYWm26hAI+/bXtMO/L+BQwd+VuY8OqrI
        N0O1XIWql2lg4MWA6RYGNG8DZjRYUMuH7yEvXjxN/rfnxn5RPLl1Q3zFPS/jMbcjJIZyt7TGvsS
        sy105Z1AOmexH17D5uBA7JCKH2EiOjTCM
X-Received: by 2002:a17:907:31c9:b0:8e1:12b6:a8fc with SMTP id xf9-20020a17090731c900b008e112b6a8fcmr35359825ejb.4.1680284217413;
        Fri, 31 Mar 2023 10:36:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350aLVFsaDSdzCWqC92WwjhMyQo3uQWkmyog3iTj2B/nfN3+H43nOF4AhDPjhQ1C+MvaERqwQkg==
X-Received: by 2002:a17:907:31c9:b0:8e1:12b6:a8fc with SMTP id xf9-20020a17090731c900b008e112b6a8fcmr35359813ejb.4.1680284217188;
        Fri, 31 Mar 2023 10:36:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009318ad4a583sm1172870ejb.210.2023.03.31.10.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 10:36:56 -0700 (PDT)
Message-ID: <15c8a804-6e73-706a-d6de-fa9d84e9a0d4@redhat.com>
Date:   Fri, 31 Mar 2023 19:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] asus-nb-wmi: Add quirk_asus_tablet_mode to other ROG
 Flow X13 models
Content-Language: en-US, nl
To:     weiliang1503 <weiliang1503@gmail.com>, corentin.chary@gmail.com
Cc:     markgross@kernel.org, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330114943.15057-1-weiliang1503@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230330114943.15057-1-weiliang1503@gmail.com>
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

On 3/30/23 13:49, weiliang1503 wrote:
> Make quirk_asus_tablet_mode apply on other ROG Flow X13 devices,
> which only affects the GV301Q model before.
> 
> Signed-off-by: weiliang1503 <weiliang1503@gmail.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/asus-nb-wmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index cb15acdf1..e2c9a68d1 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -464,7 +464,8 @@ static const struct dmi_system_id asus_quirks[] = {
>  		.ident = "ASUS ROG FLOW X13",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
> +			/* Match GV301** */
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GV301"),
>  		},
>  		.driver_data = &quirk_asus_tablet_mode,
>  	},

