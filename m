Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C256285B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiKNQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiKNQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F265F9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668444090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAPMcB4adDD3VD3fOe3xKGmraughThs1U7zivtVzWBA=;
        b=DqVV6s1Z5CUxC9/rX7nOMo8RzTROelQCHTQ1Xm1qp0JfdiAMUDCwCyNS5ys6x/wRTm8J/e
        jtoU4DaF6lsRkbsx+Yjaw42aFxaWj9YKwMxVoXyklYjNmwbKp3osNzWFKDsQFeU2Z9DnW4
        oKHbXzH72tcvC2dshGT+bvYnBljQdDA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-67-uqG5vlnOOU-n-iyQo74Wmw-1; Mon, 14 Nov 2022 11:41:28 -0500
X-MC-Unique: uqG5vlnOOU-n-iyQo74Wmw-1
Received: by mail-wm1-f72.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso9180164wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAPMcB4adDD3VD3fOe3xKGmraughThs1U7zivtVzWBA=;
        b=p4R9qgIfK0ww7iU9q3AKOG2uS+zWguxZe6Evg+Mj+4XaEZ/NzPFdeqwjnR0PCDPMqU
         j/CmRWUeZak+4JqQ9crY5h4aSFWoEPdymfyzlnYfNCxLlUnpQYb2EJ1L5fDTYps3Icq1
         xr5Vi966zsZmeWjFVIfVzK3ewLpSBp1AiVE1uAYlANeGmhC4//q0xdrDHX3p2wLpwueB
         +8DQxgiRVnFkDiUqh6xh3zcQ8h5LkbmHeUO1LvBruUcVTZ/BtlZ6ueXUP73jjVb+aihI
         rMPa0KQw3r6pSnZ+LP+vnEqRBRaRFUFwwEQZq9RtcYbeJfnFRMtm0PlBAvuX9J/Sl9MB
         oLmA==
X-Gm-Message-State: ANoB5pk793aUHz11cSqDJ5BEW/VG6BC0wYIR3M0if8yMv/8rwkPX6OFE
        aeXhT0hbIMLEfkFB9AZzheIDgkHyI5cQGCud5VRILMzRo3BLg1iEQncNPDIUA69r4XexMbGrgEt
        c0fGvAlLWP0ilpbLF3HpDmGLD
X-Received: by 2002:adf:f90f:0:b0:236:5c6c:1e06 with SMTP id b15-20020adff90f000000b002365c6c1e06mr7755387wrr.156.1668444087619;
        Mon, 14 Nov 2022 08:41:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5f2l6f8RIGeBcBzU8xGAv66L/uhIhhSQt+HlQvWjp6Cbrwetta8fu53+oCpSsrch9tHIZNSA==
X-Received: by 2002:adf:f90f:0:b0:236:5c6c:1e06 with SMTP id b15-20020adff90f000000b002365c6c1e06mr7755374wrr.156.1668444087256;
        Mon, 14 Nov 2022 08:41:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:d881:1fd5:bc95:5e2d? (p200300cbc703d300d8811fd5bc955e2d.dip0.t-ipconnect.de. [2003:cb:c703:d300:d881:1fd5:bc95:5e2d])
        by smtp.gmail.com with ESMTPSA id n10-20020adff08a000000b002368f6b56desm11905661wro.18.2022.11.14.08.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:41:26 -0800 (PST)
Message-ID: <b3fb40a1-f748-7c3f-8920-1f7a4a49cada@redhat.com>
Date:   Mon, 14 Nov 2022 17:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mm: mmap: fix documentation for vma_mas_szero
Content-Language: en-US
To:     Ian Cowan <ian@linux.cowan.aero>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221114003349.41235-1-ian@linux.cowan.aero>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221114003349.41235-1-ian@linux.cowan.aero>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 14.11.22 01:33, Ian Cowan wrote:
> When the struct_mm input, mm, was changed to a struct ma_state, mas, the
> documentation for the function was never updated. This updates that
> documentation reference.
> 
> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> ---
>   mm/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bf2122af94e7..7ffd562c57a0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -456,7 +456,7 @@ void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
>    * vma_mas_szero() - Set a given range to zero.  Used when modifying a
>    * vm_area_struct start or end.
>    *
> - * @mm: The struct_mm
> + * @mas: The maple tree ma_state
>    * @start: The start address to zero
>    * @end: The end address to zero.
>    */

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

