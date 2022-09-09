Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071A95B367B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIILhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIILh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CE1135D52
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmn7xPeaGEOUt1FeZIgwphGHIp83y3fKQu5eVjeuDCc=;
        b=M0NwyFIFgs4m41QlVF/AZX2Fq/UgppPmy/fk0QSNM1WosT7bg93ZdJT7X8sjxpmmH4r+0f
        pNZvSlSeLgK01gmKGsXz6upI6bIcz81c9hCJaGdPTccdpcABLCxucsnY92gN8AbPLddCfH
        WWxv/ftQmRTJyLEnMT1x2Z3plBG6TJQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-OkH5NflfMCaqWowuxs-cmw-1; Fri, 09 Sep 2022 07:37:26 -0400
X-MC-Unique: OkH5NflfMCaqWowuxs-cmw-1
Received: by mail-wm1-f71.google.com with SMTP id i129-20020a1c3b87000000b003b33e6160bdso1013914wma.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=rmn7xPeaGEOUt1FeZIgwphGHIp83y3fKQu5eVjeuDCc=;
        b=fSGT7MXPDO2ZzjNenaiOIA+5MA/XgM06pEZ2wdDz9U/SoYj1PsBZZBFXqHHWQ+y/FH
         4tdz2eVEd5a5vM7Ql+P6BolRMDDVxUJZn/Ze8iVLSFWFc1VqKAdF85o8t+JhLtX0nQJb
         OA21VHc0lWDzVBQssEHAWxCeM/nJIx85wvbFN9a5HLeo3nUSQUmrMGUDjrvu1XgD+BVh
         impcKddRNpORoxTxogudhvYxAbBiIPCTA7EvUhSsv3kdSMThoHm/Juatzj4BMUeTUgCr
         G8MhLl7k/3UzTuRYMkl9oWCze56IiGPA8YM7jbfd1KGZ8ngG3OEuaez309NppDHthrmk
         CQJw==
X-Gm-Message-State: ACgBeo13lVmF9DAnHfIw3+pTQ3Wz+M4yi6QFZsn6rioIEkNVDfTe6SAX
        CchcXYwUMxTYFuxgUUQoUdoBCMWFP+5AMJVwq2VoSmv9DjcT/KvoT79flm/Bc62Nl/AYxxjrUHk
        TZ7MplWM3h6njgg0kNsN3CkEO
X-Received: by 2002:adf:fb46:0:b0:228:6443:c934 with SMTP id c6-20020adffb46000000b002286443c934mr8122917wrs.431.1662723445230;
        Fri, 09 Sep 2022 04:37:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7yHVrKh63b9uyZ7+DQ+CvKaM7ehysVEY8HPVVovIGOLYxSqT/RanvllDyoK5CcnfFkPoz0vw==
X-Received: by 2002:adf:fb46:0:b0:228:6443:c934 with SMTP id c6-20020adffb46000000b002286443c934mr8122905wrs.431.1662723444925;
        Fri, 09 Sep 2022 04:37:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d468c000000b00228c375d81bsm324083wrq.2.2022.09.09.04.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:37:24 -0700 (PDT)
Message-ID: <b2181a4c-229f-8da6-d66a-9ccf6bab0821@redhat.com>
Date:   Fri, 9 Sep 2022 13:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 15/16] mm/page_alloc: remove obsolete
 gfpflags_normal_context()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-16-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-16-linmiaohe@huawei.com>
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
> Since commit dacb5d8875cc ("tcp: fix page frag corruption on page
> fault"), there's no caller of gfpflags_normal_context(). Remove it
> as this helper is strictly tied to the sk page frag usage and there
> won't be other user in the future.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/gfp.h | 23 -----------------------
>   1 file changed, 23 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index ea6cb9399152..ef4aea3b356e 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -36,29 +36,6 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>   	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
>   }
>   
> -/**
> - * gfpflags_normal_context - is gfp_flags a normal sleepable context?
> - * @gfp_flags: gfp_flags to test
> - *
> - * Test whether @gfp_flags indicates that the allocation is from the
> - * %current context and allowed to sleep.
> - *
> - * An allocation being allowed to block doesn't mean it owns the %current
> - * context.  When direct reclaim path tries to allocate memory, the
> - * allocation context is nested inside whatever %current was doing at the
> - * time of the original allocation.  The nested allocation may be allowed
> - * to block but modifying anything %current owns can corrupt the outer
> - * context's expectations.
> - *
> - * %true result from this function indicates that the allocation context
> - * can sleep and use anything that's associated with %current.
> - */
> -static inline bool gfpflags_normal_context(const gfp_t gfp_flags)
> -{
> -	return (gfp_flags & (__GFP_DIRECT_RECLAIM | __GFP_MEMALLOC)) ==
> -		__GFP_DIRECT_RECLAIM;
> -}
> -
>   #ifdef CONFIG_HIGHMEM
>   #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
>   #else

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

