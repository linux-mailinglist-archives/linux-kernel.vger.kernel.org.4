Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF2668AB01
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjBDPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjBDPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C3227AB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675525598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6iJIruggPm7ZW79w49UxTokI6ilWzp8XnYfnsm2RHI=;
        b=BJZ1idlbUDOJ1+sMt2ZnPBmzsr2iCXRg+TcMjmP4XtvtAasph7UKJKM4zdom6lF2sT/WQ/
        337CWaAX4v6sp+aLfSYsQ5iomyztcA6EsYrEST1uwYJFTj5pphp+me9psD6eXbbZnbWcy4
        qhcyD3N5lYzp7D0ybZy4QYUtSJLogVA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-TJstNrn_P3u3KFb8kARpgA-1; Sat, 04 Feb 2023 10:46:36 -0500
X-MC-Unique: TJstNrn_P3u3KFb8kARpgA-1
Received: by mail-il1-f198.google.com with SMTP id b4-20020a92c564000000b00313942dcd86so3367279ilj.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 07:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6iJIruggPm7ZW79w49UxTokI6ilWzp8XnYfnsm2RHI=;
        b=TJNIlOY3n/YeGS5ibpU35sbYHWS4NU8fafS6xmI5fVJB2nir4/pqWrHxiPjRW51B3V
         HTJRTIsi3uDfWn4b953cKAgtp9nWIaGLqnePLMoX2/aEB9YMXEkbqFo9w3q04JZaQm87
         qQ5iw90VxoYHHQLkDKBD20prz0h16OCjQOMh/X3O0whiIRyGupuYyCbssufJdFQGno5M
         OvpgAbQNb1ndvBMQ5qcYrqoixQpYjLRCwp7GlfJo5OvLiyENXtHH+QXplntQIcOq1IdH
         zKRJFJn61LZDNCGL4eodV4NXQRRmD9docaBQLhyw3dSY4Q8m65JDuW/mckNwqltezDch
         HmRQ==
X-Gm-Message-State: AO0yUKXdv61D6ookMNtFnOH5j0sO4QRtpCLRbiCslF6KaEGjnl1UK3wP
        5GEYLBSetUvC7Sx61P+JuVNOcqfMi6Xl08AdCO5PytyzsguMZTisKb9ljHiX/DPPvccH7Wm3k/d
        lMyg5dsUJYmkenGAzjG8BLjsa
X-Received: by 2002:a05:6e02:b4b:b0:310:dc99:a878 with SMTP id f11-20020a056e020b4b00b00310dc99a878mr12922640ilu.32.1675525596110;
        Sat, 04 Feb 2023 07:46:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/FHnRnxzLZzqXg3+drbEWQhVstxJOHvElmO6bFnf1mvDBt7pIAGixCTJHQNAffTy4L8sB79Q==
X-Received: by 2002:a05:6e02:b4b:b0:310:dc99:a878 with SMTP id f11-20020a056e020b4b00b00310dc99a878mr12922620ilu.32.1675525595862;
        Sat, 04 Feb 2023 07:46:35 -0800 (PST)
Received: from [192.168.0.241] (192-0-145-146.cpe.teksavvy.com. [192.0.145.146])
        by smtp.gmail.com with ESMTPSA id n46-20020a02716e000000b003a5d8834734sm1881199jaf.45.2023.02.04.07.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 07:46:34 -0800 (PST)
Message-ID: <38bb7dd4-7b22-8905-8dc8-403125c921da@redhat.com>
Date:   Sat, 4 Feb 2023 10:46:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] uapi: add missing ip/ipv6 header dependencies for
 linux/stddef.h
Content-Language: en-US
To:     "Herton R. Krzesinski" <herton@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, liuhangbin@gmail.com,
        pabeni@redhat.com, gnault@redhat.com, jstancek@redhat.com,
        prarit@redhat.com, torez@redhat.com, dzickus@redhat.com,
        dhoward@redhat.com, kuba@kernel.org
References: <20230203160448.1314205-1-herton@redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
In-Reply-To: <20230203160448.1314205-1-herton@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 11:04, Herton R. Krzesinski wrote:
> Since commit 58e0be1ef6118 ("net: use struct_group to copy ip/ipv6
> header addresses"), ip and ipv6 headers started to use the __struct_group
> definition, which is defined at include/uapi/linux/stddef.h. However,
> linux/stddef.h isn't explicitly included in include/uapi/linux/{ip,ipv6}.h,
> which breaks build of xskxceiver bpf selftest if you install the uapi
> headers in the system:
> 
> $ make V=1 xskxceiver -C tools/testing/selftests/bpf
> ...
> make: Entering directory '(...)/tools/testing/selftests/bpf'
> gcc -g -O0 -rdynamic -Wall -Werror (...)
> In file included from xskxceiver.c:79:
> /usr/include/linux/ip.h:103:9: error: expected specifier-qualifier-list before ‘__struct_group’
>   103 |         __struct_group(/* no tag */, addrs, /* no attrs */,
>       |         ^~~~~~~~~~~~~~
> ...
> 
> Include the missing <linux/stddef.h> dependency in ip.h and do the
> same for the ipv6.h header.
> 
> Fixes: 58e0be1ef611 ("net: use struct_group to copy ip/ipv6 header addresses")
> Signed-off-by: Herton R. Krzesinski <herton@redhat.com>

LGTM, if you used it you should #include-it.

Tested with x86_64 defconfig at 0136d86b78522bbd5755f8194c97a987f0586ba5.

Tested building glibc with the new UAPI headers, and that works too.

Reviewed-by: Carlos O'Donell <carlos@redhat.com>
Tested-by: Carlos O'Donell <carlos@redhat.com>

> ---
>  include/uapi/linux/ip.h   | 1 +
>  include/uapi/linux/ipv6.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
> index 874a92349bf5..283dec7e3645 100644
> --- a/include/uapi/linux/ip.h
> +++ b/include/uapi/linux/ip.h
> @@ -18,6 +18,7 @@
>  #ifndef _UAPI_LINUX_IP_H
>  #define _UAPI_LINUX_IP_H
>  #include <linux/types.h>
> +#include <linux/stddef.h>

OK. Includes stddef.h because of __struct_group use by struct iphdr.

>  #include <asm/byteorder.h>
>  
>  #define IPTOS_TOS_MASK		0x1E
> diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
> index 81f4243bebb1..53326dfc59ec 100644
> --- a/include/uapi/linux/ipv6.h
> +++ b/include/uapi/linux/ipv6.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/libc-compat.h>
>  #include <linux/types.h>
> +#include <linux/stddef.h>

OK. Includes stddef.h because of __struct_group use by struct ipv6hdr.

>  #include <linux/in6.h>
>  #include <asm/byteorder.h>
>  

-- 
Cheers,
Carlos.

