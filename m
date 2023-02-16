Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97114699500
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBPM5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBDD3B858
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676552176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0brO8VK06ZnIcshoHVvytI1fhIpz6iPLFoXabkZbK1Y=;
        b=hwwdyHcZsebtKDs7I9jLlFB315caVPD1Uc4RvNeQoxG5AgZ3ec6hO7Bsz6u0UNemtNzfFL
        ucy8IHdZRggpsdj8qdF9gFtSojDsJYdOubkIdzkB0Wij9COsbDfhh0dRSKLmnc6o+z4ZdU
        0AySlsP9A4zXVcftVcfNGo9S3CfNHg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-Dh76mL1NPr6cqhjfsMiJVg-1; Thu, 16 Feb 2023 07:56:15 -0500
X-MC-Unique: Dh76mL1NPr6cqhjfsMiJVg-1
Received: by mail-wm1-f69.google.com with SMTP id bg9-20020a05600c3c8900b003e1e7d3db06so1084374wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0brO8VK06ZnIcshoHVvytI1fhIpz6iPLFoXabkZbK1Y=;
        b=LuTnvJJuAk0H9ItvLU9i1nREvoxs0VUgXFadSMQyHfYrTXKV6pKDX0sqmRr/L1uxp6
         5DjDX+a6XnfEnvkAiOBzbucNC7ZGc2d6FaO034BImtmJrY0XxkIHDkkGF/n9/3eo/bRy
         exspKxQisZEyYy91Y0AeuoKdvmAlOpRWjSoQCkpLOIK0NlyaFjQIi93Uyty0i5FIrvhT
         LfNmLwdrvt3EExhEwvhIFgbdKeXsqLdtxQ/HFfvcvA0/tzS80nA0hJ2yUvDnt6WhwiOg
         cngG1iFw37yaSKDTn0GYll8eIPzuIej+5vg4LxQU/sEuOXoa8rzuDd2PBa07XWJWSYUD
         KzYw==
X-Gm-Message-State: AO0yUKXtes3PWZ1ppasSHj9n4CQTGEBsnLx2htTpKMoa+Yat72XZIZ57
        1eKj4+/zSRDuacEOS6ePU7qRIUiJPeYkI5CB9QgozwBqSWFTI+NGsWW0mi2SlKzdKUdGXWeItGm
        NKcNGbsZfKCHBp/Pfb5aNVRxe
X-Received: by 2002:a5d:4382:0:b0:2c5:5da4:a3b1 with SMTP id i2-20020a5d4382000000b002c55da4a3b1mr5067815wrq.69.1676552174377;
        Thu, 16 Feb 2023 04:56:14 -0800 (PST)
X-Google-Smtp-Source: AK7set8ga4/l/6qx8d8pgKP4FREWjdTFn59p9XK8gw6tuQF/ZAJU23f5WU3594HK3YmofYUfawVPeA==
X-Received: by 2002:a5d:4382:0:b0:2c5:5da4:a3b1 with SMTP id i2-20020a5d4382000000b002c55da4a3b1mr5067803wrq.69.1676552173996;
        Thu, 16 Feb 2023 04:56:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d530e000000b002c553e061fdsm1373550wrv.112.2023.02.16.04.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 04:56:13 -0800 (PST)
Message-ID: <30bc98f3-2048-1b2e-88b5-4e54dff8e0fa@redhat.com>
Date:   Thu, 16 Feb 2023 13:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] sh: initialize max_mapnr
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
References: <20230214140729.1649961-1-rppt@kernel.org>
 <20230214140729.1649961-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230214140729.1649961-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 15:07, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> sh never initializes max_mapnr which is used by the generic
> implementation of pfn_valid().
> 
> Initialize max_mapnr with set_max_mapnr() in sh::paging_init().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: e5080a967785 ("mm, arch: add generic implementation of pfn_valid() for FLATMEM")
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/sh/mm/init.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 506784702430..bf1b54055316 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -301,6 +301,7 @@ void __init paging_init(void)
>   	 */
>   	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
>   	min_low_pfn = __MEMORY_START >> PAGE_SHIFT;
> +	set_max_mapnr(max_low_pfn - min_low_pfn);
>   
>   	nodes_clear(node_online_map);
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

