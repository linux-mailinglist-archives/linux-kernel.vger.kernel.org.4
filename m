Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4F688915
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjBBVfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBBVfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:35:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72047841AC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675373685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eW5nnN/Ib32jdUWa/RWBvIQi/iNU6+BNj/uI00opUo8=;
        b=XwJ1IuLaUNovUuKKauNCH3bGfBNMT9XFaZ87jJUrmWplhB8wrR2jY+2p3nMxp4Hh19K71L
        iHggtyexIrgBghGUIKXVSRApEP+jzCPFhcJVXsrmUn/hjeuXKiSE0enKW8zTtEmpGXbq5l
        vwktJVK+oEjDbGW13ObGpEagCTi4YPo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-H3U45Vu_PtmaYqlphD-qDg-1; Thu, 02 Feb 2023 16:34:43 -0500
X-MC-Unique: H3U45Vu_PtmaYqlphD-qDg-1
Received: by mail-ej1-f70.google.com with SMTP id ud13-20020a170907c60d00b0088d773d11d6so2360878ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW5nnN/Ib32jdUWa/RWBvIQi/iNU6+BNj/uI00opUo8=;
        b=JrPzCnhHNAijoi8uEfKQ33vF9xlumVAEbMeF/dHz5EB+M3PRiaZ055ttSXxsowG6au
         7FEUbLyX9yCJiGhgTqK1zlED8OAP1iH2dNlb0VQ81qFlOvYF+xF+oFSwaH/ADkvyA6Qe
         uPt3hrGFhpd9CaWJ/8a/lGSMJoC63YJ8C1X1LQBFF+Ru7DpOxbw0dCKrOVogM0Kwux9x
         Uoc9uxchsXqKqTLRwyOgm4hzwivnELbQZfK4NranKgtFDlMvhahEbOe3GRkWiwpMm2us
         J9xwqnIrON3EKfBSneb+rSCEq1a3ttPEBWKsyCbOQX1hTKued1FBMLfmwuPd47QqUnR4
         fPcA==
X-Gm-Message-State: AO0yUKVa4Z8R15Zxt+D/DTKJTbQvOBACJH/fNp8TNrSeF3qDp6h3hj1L
        MsRBNBO4D+SLFtkXZhQKOjDGn7W289y8sUX4/LK7E/h7d4BzUH8uHOtVZzCqqrbYvygzSLNMaZ4
        HS6HsIHrps3yICDp/axx2KOG0
X-Received: by 2002:a17:907:7211:b0:88d:ba89:184f with SMTP id dr17-20020a170907721100b0088dba89184fmr3931590ejc.32.1675373682498;
        Thu, 02 Feb 2023 13:34:42 -0800 (PST)
X-Google-Smtp-Source: AK7set/MueIrH2ulLtKu+jzCEAXRz6gYQ9ydSfs2I9fl85KH/t4CrjinYYkdksZb8pqi5m1jIbJsvw==
X-Received: by 2002:a17:907:7211:b0:88d:ba89:184f with SMTP id dr17-20020a170907721100b0088dba89184fmr3931584ejc.32.1675373682314;
        Thu, 02 Feb 2023 13:34:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709064e1900b0088550a1ce6esm324922eju.222.2023.02.02.13.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 13:34:41 -0800 (PST)
Message-ID: <2b11d9f4-f32b-7214-3181-a49a8d190f0a@redhat.com>
Date:   Thu, 2 Feb 2023 22:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: atomisp: add I2C dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230202210312.544277-1-arnd@kernel.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230202210312.544277-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2/2/23 22:02, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_I2C, atomisp fails to build because of a missing
> function declaration:
> 
> drivers/staging/media/atomisp/pci/atomisp_v4l2.c: In function 'atomisp_subdev_probe':
> drivers/staging/media/atomisp/pci/atomisp_v4l2.c:960:21: error: implicit declaration of function 'i2c_get_adapter'; did you mean 'i2c_get_adapdata'? [-Werror=implicit-function-declaration]
>   960 |                     i2c_get_adapter(subdevs->v4l2_subdev.i2c_adapter_id);
>       |                     ^~~~~~~~~~~~~~~
>       |                     i2c_get_adapdata
> 
> Ideally the driver should just move away from calling i2c_get_adapter
> as explained in a comment near the call. For now, just use a Kconfig
> dependency. Apparently configurations with I2C disabled are rare in
> practice as well as in randconfig builds because a lot of other
> drivers 'select' the subsystem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Actually the i2c_get_adapter() call is gone in the atomisp pull-req
which I send to Mauro for 6.3, it is removed by this patch.

https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/commit/?h=media-atomisp-6.3-1&id=4f205ce7a915ffa4ae0fb24f48714604d39baa29

So adding the I2C dependency is no longer necessary.

Regards,

Hans






> ---
>  drivers/staging/media/atomisp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
> index c9bff98e5309..8b0de0b5b4a3 100644
> --- a/drivers/staging/media/atomisp/Kconfig
> +++ b/drivers/staging/media/atomisp/Kconfig
> @@ -13,6 +13,7 @@ config VIDEO_ATOMISP
>  	tristate "Intel Atom Image Signal Processor Driver"
>  	depends on VIDEO_DEV && INTEL_ATOMISP
>  	depends on PMIC_OPREGION
> +	depends on I2C
>  	select IOSF_MBI
>  	select VIDEOBUF2_VMALLOC
>  	select VIDEO_V4L2_SUBDEV_API

