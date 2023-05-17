Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D38706315
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjEQIjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjEQIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7C1FE3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684312653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97ToGLKuvaj7XmcoRhe/olZuS/lpM05KUIrSj3Fc5mA=;
        b=b2Y3aEMMXVPFM0+5F4IGiXF+aTHqjQCvSaZRUJcPFwuXgll9JbYP+1isgf2GYqjEkF3yHn
        Hgyp2wMTOY/35T2ta+6+EzT4fTQPRf2oUwCIt5jmDuhqTWiZKGCDfu+M7Y7tcvsTuBQesV
        zX7vrqws7KGTNVLG6jiMWPRvyjBfgcU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Q8LwkPWeMnOq35EliVzNCg-1; Wed, 17 May 2023 04:37:31 -0400
X-MC-Unique: Q8LwkPWeMnOq35EliVzNCg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f518f2900eso3502855e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312651; x=1686904651;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97ToGLKuvaj7XmcoRhe/olZuS/lpM05KUIrSj3Fc5mA=;
        b=gW4yBKzwcl2xH/9pbm0FkYr+EtUzfbpQoQBHz4ViL0yyP1y5kiymszbtEB4w9cNXcC
         dqq0Poqna7VoJVuqlntm+kys5mXHSFzA6UUp72/UJ1iw0x9z17nORxUV9ZWprxnaen75
         hNZ/rIjU0Uw+TyFO7MsIDb/uDmP5MdHQSLkDjDFx3/jAujsrkcfcVkM/Uli3wdqIhelv
         1hWN/xZZ/02qydsa/i8Ndt56VlokrLPImiXQLkWy86yqXiSISEzWfa7GNKRgxvJmXvJH
         PgL/nmuvoHDRR389MGaafVklvT9k8Rw8kCuGRltCnevDG+U6XByMoJercxp42poudQ7l
         hlHQ==
X-Gm-Message-State: AC+VfDxgP9lZFDw5kYumlafioZ7Ql+5b1IPkQ5JQ+GLx0k4LQyEojagm
        xAq4L04toXrZAlNFrS7u/AYxxH7ThCVbTHZbp0PG1y/cJ/lwSDq493aGZVP2/4bAbqVUquNy3px
        jw6QJUa4VWVRSZZYlYe9f/vI5
X-Received: by 2002:a05:6000:548:b0:306:4162:ebbe with SMTP id b8-20020a056000054800b003064162ebbemr27840934wrf.49.1684312650868;
        Wed, 17 May 2023 01:37:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61oQtI8NSfdfqGeBSv749qPFZlbpUYgWlIACvEuF6nv468SUUYxofca3rAKZHN/GQIfcueNw==
X-Received: by 2002:a05:6000:548:b0:306:4162:ebbe with SMTP id b8-20020a056000054800b003064162ebbemr27840916wrf.49.1684312650566;
        Wed, 17 May 2023 01:37:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id r14-20020adfe68e000000b00307d58b3da9sm2030355wrm.25.2023.05.17.01.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:37:30 -0700 (PDT)
Message-ID: <12b29199-4469-d970-579a-46a60e6e8236@redhat.com>
Date:   Wed, 17 May 2023 10:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] mm: Call arch_swap_restore() from unuse_pte()
Content-Language: en-US
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>
References: <20230517022115.3033604-1-pcc@google.com>
 <20230517022115.3033604-3-pcc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230517022115.3033604-3-pcc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.23 04:21, Peter Collingbourne wrote:
> We would like to move away from requiring architectures to restore
> metadata from swap in the set_pte_at() implementation, as this is not only
> error-prone but adds complexity to the arch-specific code. This requires
> us to call arch_swap_restore() before calling swap_free() whenever pages
> are restored from swap. We are currently doing so everywhere except in
> unuse_pte(); do so there as well.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I68276653e612d64cde271ce1b5a99ae05d6bbc4f
> ---
>   mm/swapfile.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 274bbf797480..e9843fadecd6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1794,6 +1794,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>   		goto setpte;
>   	}
>   
> +	/*
> +	 * Some architectures may have to restore extra metadata to the page
> +	 * when reading from swap. This metadata may be indexed by swap entry
> +	 * so this must be called before swap_free().
> +	 */
> +	arch_swap_restore(entry, page_folio(page));
> +
>   	/* See do_swap_page() */
>   	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>   	BUG_ON(PageAnon(page) && PageAnonExclusive(page));

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

