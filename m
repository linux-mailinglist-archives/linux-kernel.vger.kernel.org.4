Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C8682B09
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjAaLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjAaLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8A470A1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675162786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bK0hY7jWQjhFw5K0U5dRPmjS4u6L95GMLvGFqwCWeps=;
        b=W6+njMID067xOZwyViz89utZldNI9af6Ch8WehwuWXybfQgNg81L4QVg9pQjEgL4GtlsOx
        DX66I6QXYI+i5jcOZ26g0g+GdCzgbFsPtMxo3W4tV6RtF7cG6dWmCVkVfi0qlVSXmPlO8u
        qk+qTlaV8Q2sISWPiWBv/LkE2EL5kOk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-lL8OXA-8NniIvC6dg_PTlg-1; Tue, 31 Jan 2023 05:59:42 -0500
X-MC-Unique: lL8OXA-8NniIvC6dg_PTlg-1
Received: by mail-wr1-f71.google.com with SMTP id r1-20020adfa141000000b002be28fd4a7bso2402479wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bK0hY7jWQjhFw5K0U5dRPmjS4u6L95GMLvGFqwCWeps=;
        b=BolYG/vP9vrnMvEHyOcjclPfl9DZVZmw2Z4fbfqNWg/2MYlpHqN2NKHi3IM+HKKPmd
         E53t5pf1SifqPbvLatlSnez5IIc/V9y1OscoKvgKwiBWQcBrlnNIaXnNwD65/AyxluvN
         985UQTjjVe8Bj23lMguQq/vILR1pBgNv0rL+0JUTFG5PhGp7J48hn7GRkbiQ1Frb0Ax2
         uGYd7Ida6/CAdhe41czhBJlToIAqnRDkMAiE3KxY/nKj48BIRdSLL1RzqOR5kDEJrNxL
         MtZ/SHE8THPOC9opWIxZDsKorB4Fc8XfsZHubti4VshIaK1koayWJTiycOWhPgfT5Upq
         lbDA==
X-Gm-Message-State: AO0yUKUijjj+L38SFaj2ysrMsdGhoQgvIr76edh9cy0Jf+XzjcyAmeZ/
        KH0ZhT+gya8+gYIxjYdT+2mb030i5jC0nIfHyLTKMYT4/7qo7qaKyRjuz1W1wrJ7ZQJ8iy8z9CA
        OMS/gis5Oghk+vUVfMVVkpqTy
X-Received: by 2002:a5d:5181:0:b0:2bf:b92b:8a78 with SMTP id k1-20020a5d5181000000b002bfb92b8a78mr19716859wrv.23.1675162781365;
        Tue, 31 Jan 2023 02:59:41 -0800 (PST)
X-Google-Smtp-Source: AK7set8DGpVSZWFcxWxQzzKd2hwFYf7lwSaCZ2AyoxEoOEo3a1/URRT8kvwULuQ6IWx0K5zx+ogBEg==
X-Received: by 2002:a5d:5181:0:b0:2bf:b92b:8a78 with SMTP id k1-20020a5d5181000000b002bfb92b8a78mr19716838wrv.23.1675162781009;
        Tue, 31 Jan 2023 02:59:41 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm14159375wro.8.2023.01.31.02.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 02:59:40 -0800 (PST)
Message-ID: <8c152d25-5909-71f9-3946-cba9254525ef@redhat.com>
Date:   Tue, 31 Jan 2023 11:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable v4 1/6] mm: add folio_estimated_sharers()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230130201833.27042-1-vishal.moola@gmail.com>
 <20230130201833.27042-2-vishal.moola@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230130201833.27042-2-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 30.01.23 21:18, Vishal Moola (Oracle) wrote:
> folio_estimated_sharers() takes in a folio and returns the precise
> number of times the first subpage of the folio is mapped.
> 
> This function aims to provide an estimate for the number of sharers of a
> folio. This is necessary for folio conversions where we care
> about the number of processes that share a folio, but don't necessarily
> want to check every single page within that folio.
> 
> This is in contrast to folio_mapcount() which calculates the total
> number of the times a folio and all its subpages are mapped.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   include/linux/mm.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27b34f7730e7..c91bf9cdb3d0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1905,6 +1905,24 @@ static inline size_t folio_size(struct folio *folio)
>   	return PAGE_SIZE << folio_order(folio);
>   }
>   
> +/**
> + * folio_estimated_sharers - Estimate the number of sharers of a folio.
> + * @folio: The folio.
> + *
> + * folio_estimated_sharers() aims to serve as a function to efficiently
> + * estimate the number of processes sharing a folio. This is done by
> + * looking at the precise mapcount of the first subpage in the folio, and
> + * assuming the other subpages are the same. This may not be true for large
> + * folios. If you want exact mapcounts for exact calculations, look at
> + * page_mapcount() or folio_total_mapcount().
> + *
> + * Return: The estimated number of processes sharing a folio.
> + */
> +static inline int folio_estimated_sharers(struct folio *folio)
> +{
> +	return page_mapcount(folio_page(folio, 0));
> +}
> +
>   #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
>   static inline int arch_make_page_accessible(struct page *page)
>   {


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

