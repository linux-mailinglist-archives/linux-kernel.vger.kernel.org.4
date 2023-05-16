Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B058704B25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjEPKxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjEPKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75EF1FE6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684234338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNW1JTsp2+TJANbu5HHxgt8Gjvq1fykbhirooX/h10s=;
        b=d4GdjEcnOguLIhzVNUYuiq7G/ol80tnCD0fLVaNZOPxKlUI/fScTa5vbAcYVJhV/Xi6tjB
        ETkAzrTaYjM8G0QDmt9ZY2apoMQCB3agy9GXGeSQ812Q+qU/I+Yi2OZO4SwqxknFJTxsFE
        kD1gkl2hMBCQ94RYfS06O0kvgUQdKsw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-Ik3tA53xNbOzhWwQmJhGhQ-1; Tue, 16 May 2023 06:52:17 -0400
X-MC-Unique: Ik3tA53xNbOzhWwQmJhGhQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42867b47dso55664255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684234336; x=1686826336;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNW1JTsp2+TJANbu5HHxgt8Gjvq1fykbhirooX/h10s=;
        b=NkXS1GNePI6MkOrKINfP85mmgTPgpqut5INxzstA436/acGGenH/wUgji+oZqhTBR7
         5+z6npcTYitSeD0Xij3Hg7Png7QRmFPEnx1UsIJcyo7ZjhDg00NIAFZs13PGn7SzixqD
         BEq1UpLBpYNHV9fkrjCRfOrE55UZQWdaUJW4kW68W5Dm5FSm/I/t+DCEuNas+XbQhA0D
         RwCdjD++6qb4D3erYfkoCNtEEB7ayiiuwvkilYwQG92h0wrqkH459UvzCozWvyOiSzgt
         qJF8oIMIptyYHv23tk2I0f06LkLUNtBlCA1RSY9Uu856YdP1EoLgutl6celforyIH2ye
         pTeQ==
X-Gm-Message-State: AC+VfDywKP3V6sMYz3EAvEow3DzqDUY0ByV93BKzAtVIpu2iC+o6zj7Z
        8i92Of698mnEHq9Jx79N2huh7StGtKzceQov2ChgXep7L1WoiS26FDBAmZak9All96maeRClcTU
        WeQsgp2NyX35WPch0GDsSArdmCig8i3sZ
X-Received: by 2002:a05:600c:21c2:b0:3f5:b51:12c0 with SMTP id x2-20020a05600c21c200b003f50b5112c0mr4190052wmj.12.1684234336427;
        Tue, 16 May 2023 03:52:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ411ax2ykjjiu2vkOAsMFB0UarxZmseD9PwixRDnspgDaNLVg/LUhk10UNMtZRjflnMCr4dVg==
X-Received: by 2002:a05:600c:21c2:b0:3f5:b51:12c0 with SMTP id x2-20020a05600c21c200b003f50b5112c0mr4190038wmj.12.1684234336025;
        Tue, 16 May 2023 03:52:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id b4-20020adfde04000000b0030632833e74sm2195140wrm.11.2023.05.16.03.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:52:15 -0700 (PDT)
Message-ID: <d0d149bd-669a-94fa-e0b7-1205bae79281@redhat.com>
Date:   Tue, 16 May 2023 12:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/secretmem: make it on by default
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230515083400.3563974-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230515083400.3563974-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.23 10:34, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Following the discussion about direct map fragmentaion at LSF/MM [1], it
> appears that direct map fragmentation has a negligible effect on kernel
> data accesses. Since the only reason that warranted secretmem to be
> disabled by default was concern about performance regression caused by
> the direct map fragmentation, it makes perfect sense to lift this
> restriction and make secretmem enabled.
> 
> secretmem obeys RLIMIT_MEMBLOCK and as such it is not expected to cause
> large fragmentation of the direct map or meaningfull increase in page
> tables allocated during split of the large mappings in the direct map.
> 
> The secretmem.enable parameter is retained to allow system
> administrators to disable secretmem at boot.
> 
> Switch the default setting of secretem.enable parameter to 1.
> 
> Link: https://lwn.net/Articles/931406/ [1]
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   mm/secretmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 0b502625cd30..974b32ba8b9d 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -35,7 +35,7 @@
>   #define SECRETMEM_MODE_MASK	(0x0)
>   #define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
>   
> -static bool secretmem_enable __ro_after_init;
> +static bool secretmem_enable __ro_after_init = 1;
>   module_param_named(enable, secretmem_enable, bool, 0400);
>   MODULE_PARM_DESC(secretmem_enable,
>   		 "Enable secretmem and memfd_secret(2) system call");

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

