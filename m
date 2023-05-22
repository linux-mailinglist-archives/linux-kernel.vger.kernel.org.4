Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1D70BBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjEVLfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjEVLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5A2E50
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684755217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4wlCqP/bAFdihLv2wSratormpoOv+1EUJpnr4J9d9g=;
        b=Dibw95oOkL6uX0BTbAafzNVnWsAQNN8QxWZfK9DPjlCf0iDfaG/ee1LoWnOYHA/ky7vecY
        /DnoEClqc44F9IIwe7tN7dUJinJ3S9dHjiMdnKZrA65Lkqc9r9BcYe563t5TnbW7W1DB4R
        Wmg6EKJoaRfPkDHAXYbRcm8V26W2xKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Ehn6mGrcMMK1h9uG_yh0lg-1; Mon, 22 May 2023 07:33:36 -0400
X-MC-Unique: Ehn6mGrcMMK1h9uG_yh0lg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f50aa22cd2so35659045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684755215; x=1687347215;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4wlCqP/bAFdihLv2wSratormpoOv+1EUJpnr4J9d9g=;
        b=fj72Mo7vraZvBbak7FLdOag54i2F3BPyNWz1cqUJnltRFm1+w4CXu8S2pecFyWmHab
         f6FH2CyazoCzrfZ5vycg7o9Pc+Zz4LfAdXWO5/Q5e4/cfJrk0SsyFC6beqfGfntL08SB
         0MacrbBHSBEcuRLI8fvwdOvOzYsddSx/uETSU3yIDkXmF4YcYIvlRE9DemEp0q4IjRx/
         rlkr1pzVqOYdotDvRrFgZgqaH9lsTXZJxuS3NiNcR4z4wDmU96SsZrrnJUHlnvgb582X
         8JIdEXYXh25Qrl0ILzyyARmIse+RTB1oNP793Lo74F9zF4gUnTdXwjOppdcKNRqrCkyD
         ZCbQ==
X-Gm-Message-State: AC+VfDxUxVP/Jn5TQgg3NmSot7nGWLqHXsQEJB8hrmTh8gpmS+HgmwHF
        5q6Yuj8RQfDQJFYljO6ckhqzIUZYX4sQ+/vtt4N8/UN+9KpzHcNoXWLds8p9d9ybODCRptCFWcW
        ij/jx42kROc5ow/a1EjKMPKIQ
X-Received: by 2002:a1c:7911:0:b0:3f6:76e:604b with SMTP id l17-20020a1c7911000000b003f6076e604bmr961856wme.0.1684755215402;
        Mon, 22 May 2023 04:33:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sHQZ1W8KykgGRFIsxmPBxvnMRXc3F2kTr9pYA6l5VFdB/HgxcSkxAmsKOAKZ7xjEsdCyBgQ==
X-Received: by 2002:a1c:7911:0:b0:3f6:76e:604b with SMTP id l17-20020a1c7911000000b003f6076e604bmr961839wme.0.1684755214999;
        Mon, 22 May 2023 04:33:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id c4-20020a7bc004000000b003f42461ac75sm11320613wmb.12.2023.05.22.04.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 04:33:34 -0700 (PDT)
Message-ID: <d7d8d50b-ac3c-56e8-ca3b-5248c8855102@redhat.com>
Date:   Mon, 22 May 2023 13:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mm-unstable 1/4] mm: multi-gen LRU: use macro for bitmap
Content-Language: en-US
To:     "T.J. Alumbaugh" <talumbau@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com
References: <20230522112058.2965866-1-talumbau@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522112058.2965866-1-talumbau@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 13:20, T.J. Alumbaugh wrote:
> Use DECLARE_BITMAP macro when possible.
> 
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>   mm/vmscan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4637f6462e9c..cf18873a36b9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4144,7 +4144,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
>   	unsigned long next;
>   	unsigned long addr;
>   	struct vm_area_struct *vma;
> -	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)];
> +	DECLARE_BITMAP(bitmap, MIN_LRU_BATCH);
>   	unsigned long first = -1;
>   	struct lru_gen_mm_walk *walk = args->private;
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

