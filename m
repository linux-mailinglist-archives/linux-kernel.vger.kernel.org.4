Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D990663EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjAJLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjAJLD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4913CCC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673348560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTWV3iMaD81pwfEJZyicf42Tlx7DhOJiIaHvcmnaLWs=;
        b=YKvAp6dAtp+wGprWsgX3XDeW9NXOu++ZIYXsF7qSz04CfjmUQ08i13Ram7OAIsIyRHA7DD
        ZW0EVqd81cbdf0bIYhUzUyA1A2ClZeU6ho6Rwc4a3vk0ZiBvEmi2nPiyB986HeVJ9xmbFB
        dBePuteX8dqSN5cT6ErkWYQ9hzJDhqc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-wv8lx56zMXq7E4usi00cVA-1; Tue, 10 Jan 2023 06:02:39 -0500
X-MC-Unique: wv8lx56zMXq7E4usi00cVA-1
Received: by mail-ed1-f72.google.com with SMTP id v8-20020a056402348800b0048db0688c80so7350782edc.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTWV3iMaD81pwfEJZyicf42Tlx7DhOJiIaHvcmnaLWs=;
        b=jQJAYC8cGIL4jiunPgWuRDRk8TA3aFp6U4nLrloBq6TE0HaqVKh20l6MQXVsS4p3pe
         +rXtPH4ksOgKL93+tPWDpyRzGcAZgXwrsH9nPEfSjEB6VrF1zO4N6kdTeTS4A31JmNr6
         m/3xnTqRQag3DkKMyXVH93/JbpKpfj3ElsankldhK8gKNpmsl42e/xrhLZkjUuqxsaZD
         sVJ6BIM/4snBxZLSsOlMxrk3nT+jVPLylwjM5wrSiXFR2bjncVBf6sS7VN/v/7/uy5/i
         MKTcEL1qREzf28W/q1hsBzfY9hR8TOONABD9WIR2fbC1AJEgYZ5y16e4JbPSDWYqRxsv
         Owwg==
X-Gm-Message-State: AFqh2ko7rnvnbye3mGPZUoXdBEayqn+VdnEQnooZ/3qtHzEcvUL6MgIC
        dDN5+Nn046bW7TvfE2JVywEi24VlDHcEusIXfrFHY3xYqk5akGJr/06zO2RJ5qALaceG5Kih5fH
        6CcIw9lm4+ouT+Q6HzPAT6CVS
X-Received: by 2002:a17:906:1410:b0:7bb:7d69:da90 with SMTP id p16-20020a170906141000b007bb7d69da90mr54055976ejc.31.1673348558235;
        Tue, 10 Jan 2023 03:02:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvzRd5VbzqlkNxSrrkP817SlZx0vErAVSGXRAmaSrLX9FRNypwoAhZuApyAsPCWEz5B2tK2Cw==
X-Received: by 2002:a17:906:1410:b0:7bb:7d69:da90 with SMTP id p16-20020a170906141000b007bb7d69da90mr54055959ejc.31.1673348558066;
        Tue, 10 Jan 2023 03:02:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e15-20020a056402104f00b004918b6b5e30sm4712397edu.15.2023.01.10.03.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 03:02:37 -0800 (PST)
Message-ID: <39c80c05-3fac-6513-c941-7ae91959c88e@redhat.com>
Date:   Tue, 10 Jan 2023 12:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: atomisp: fix videobuf2 Kconfig depenendency
Content-Language: en-US, nl
To:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Andy Shevchenko <andy@kernel.org>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230104082212.3770415-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230104082212.3770415-1-arnd@kernel.org>
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

On 1/4/23 09:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The recent conversion missed the Kconfig bit, so it can now
> end up in a link error on randconfig builds:
> 
> ld.lld: error: undefined symbol: vb2_vmalloc_memops
>>>> referenced by atomisp_fops.c
>>>>               drivers/staging/media/atomisp/pci/atomisp_fops.o:(atomisp_open) in archive vmlinux.a
> 
> Fixes: cb48ae89be3b ("media: atomisp: Convert to videobuf2")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Mauro, can you pick this up and send it to Linus as a 6.1 fix?

Regards,

Hans





> ---
>  drivers/staging/media/atomisp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
> index 2c8d7fdcc5f7..c9bff98e5309 100644
> --- a/drivers/staging/media/atomisp/Kconfig
> +++ b/drivers/staging/media/atomisp/Kconfig
> @@ -14,7 +14,7 @@ config VIDEO_ATOMISP
>  	depends on VIDEO_DEV && INTEL_ATOMISP
>  	depends on PMIC_OPREGION
>  	select IOSF_MBI
> -	select VIDEOBUF_VMALLOC
> +	select VIDEOBUF2_VMALLOC
>  	select VIDEO_V4L2_SUBDEV_API
>  	help
>  	  Say Y here if your platform supports Intel Atom SoC

