Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E135B365E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIIL3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIIL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6095B13A052
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662722938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SasvhSvsF8LRZn/BC37PTfJFjK4JwrXoE1DtDBs5qJE=;
        b=Xl+q680GfKavNW23viaSop0v4EVvcWpjpVYOm5Q9L8ODg0abTsKzKNMm2QRrN6vjNNccQg
        UNArpXgv+l+NO9ZurbTDWPkY2VdEf0YlXWqeyNHdRMKFZ7UNTzr8RxavJmAdfk+fFzQImw
        qo4z+sl1oj7OtG+8g4Hw3+XoSR220G4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-28lyun8VORm8ZVi9XGCSzw-1; Fri, 09 Sep 2022 07:28:56 -0400
X-MC-Unique: 28lyun8VORm8ZVi9XGCSzw-1
Received: by mail-wr1-f71.google.com with SMTP id h2-20020adfa4c2000000b00228db7822cbso276557wrb.19
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=SasvhSvsF8LRZn/BC37PTfJFjK4JwrXoE1DtDBs5qJE=;
        b=aZwXpiuQkuFY+5Og0oZ/OjWNFHYi/erKNo7I0PoPQPKpRqtziSVWfsF3QSoa/K7GRf
         hbwBxLG98kvU+NwT5+26zCPhtjry1bCgLds4MLbgnjelXL3pkaFH3dfJCiRM3AdYzo3b
         QROqRlPBBXHkQT1aKqpytQ01IvsASehrPAxGZG1Dku2AfryyCJ0fN2Sn4Gx/2TWRB30g
         fkhKZQF9eMqRp5/Ils4SoyUuKcB9FpI7c9RU24/ysDGZ4vkXJhvk793KoVI5AibCIDzD
         ROgQb3apuVvAGhZeV1nxbl/Jmq0xw3Zcve0LcEIsF++NNy4pxmfly7NdBKxNgBNLe7mQ
         AOvQ==
X-Gm-Message-State: ACgBeo0CPx6XAlo4yzee9oc/Mc2yv4ftDAYlSLRGi7gKj1262k7sqhSB
        N8qcnqR6xMLCGwTo3c7vyhK/iniDz5Yi2tKYXvjepqPYqEeIQjP4fjDuG86UiwezvW4yntCNo4F
        FgQCwoxLUwR1fOVIQGtJLvJmj
X-Received: by 2002:a5d:6581:0:b0:228:e143:ddd7 with SMTP id q1-20020a5d6581000000b00228e143ddd7mr7704453wru.329.1662722935827;
        Fri, 09 Sep 2022 04:28:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+GVIZJsogN8g2DQ972mWraqbf9/Bobl5Kgm79b3QnjHam0io1+c3nVbusvey9AdDy3KQuog==
X-Received: by 2002:a5d:6581:0:b0:228:e143:ddd7 with SMTP id q1-20020a5d6581000000b00228e143ddd7mr7704443wru.329.1662722935568;
        Fri, 09 Sep 2022 04:28:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b00229d55994e0sm277293wrp.59.2022.09.09.04.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:28:54 -0700 (PDT)
Message-ID: <2378a08b-d3ab-1a99-eb16-f51ac4358a3e@redhat.com>
Date:   Fri, 9 Sep 2022 13:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 07/16] mm: remove obsolete pgdat_is_empty()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-8-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-8-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 11:24, Miaohe Lin wrote:
> There's no caller. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/mmzone.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6950179a20a2..ab17a0e6f26f 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1247,11 +1247,6 @@ static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
>   	return pgdat->node_start_pfn + pgdat->node_spanned_pages;
>   }
>   
> -static inline bool pgdat_is_empty(pg_data_t *pgdat)
> -{
> -	return !pgdat->node_start_pfn && !pgdat->node_spanned_pages;
> -}
> -
>   #include <linux/memory_hotplug.h>
>   
>   void build_all_zonelists(pg_data_t *pgdat);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

