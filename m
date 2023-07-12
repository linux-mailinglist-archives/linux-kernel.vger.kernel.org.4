Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7305C750D43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjGLP5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjGLP5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D45FB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689177408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wAt6+osSS3pbKJmTQKGnYWBFtRN0+JfWHJloeeie9A=;
        b=C0mPa90YR+PJmX300kkkqwzAFG1p5KRIo/EGIJQ4E5A54kXbHuI8isiXH8wGyIq8YWcDtK
        XpPFL3Fi1WyTy9T8ZflV7GRHR2Vm3ceYM7sFxE//4W5VgaJX/acA6/wPYngiCuc/7lKuBK
        OaL/lcMRDPm2C1GcV1ormOJhVRAX3t4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-dXCg6gGFMkugsDZ5z1-N8g-1; Wed, 12 Jul 2023 11:56:41 -0400
X-MC-Unique: dXCg6gGFMkugsDZ5z1-N8g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso48190105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177400; x=1691769400;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wAt6+osSS3pbKJmTQKGnYWBFtRN0+JfWHJloeeie9A=;
        b=eq0WPXkvxB0+zlUF0gQzu5ey612o+6HvYXmUmLmC10Fc8vxltDunK2B2F7W66npr9V
         AdOPA8vBvBrFTeyZnXp1neSRXj5CRoTCsDcBlgAt/KS5dBNirgT0OVfcTI7jwK7SO/+l
         aUrW47sjnMR7DsMmTBGqmgcoX+QXIpKbhXW5bnMZjEUEf40pLfW3Ft1/uzTACbEPLHZf
         nNs4NuuA+A1mxvx53drByMVZ9BGWobNcP4A+nGG/vz3EdLRGgxRwYoMcD8ONoldp7FDd
         FnvE6SniMdI7w6bYMAX47ZAvBpG0e/eOacfeHmgEqgdP+FAr0Q4zQlEUbxQehpYox7oO
         z8MQ==
X-Gm-Message-State: ABy/qLZyzLpcQfGQA0dps7OA3ph2KOrqpJM0HL1kFVrcte0s8EzbFthL
        H1d73G/3VDCN7lj0YDNO+1/IIlwwK82eqNm8D2YE+5BKYO2GuYFHUnvHO80vgAUXcOJpv54d1v6
        IrZ8p2Tut7OaShfJBGpJ8UUY2rGZnD9K9
X-Received: by 2002:a7b:c3cf:0:b0:3fa:e92e:7a7b with SMTP id t15-20020a7bc3cf000000b003fae92e7a7bmr18600246wmj.15.1689177400332;
        Wed, 12 Jul 2023 08:56:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfRU8sL8vzkU3hbpJRRH54la4vFD6x92syt0UUJ0rgn29SvPB5zhIOWfKc9DrtOrFuBbOSCQ==
X-Received: by 2002:a7b:c3cf:0:b0:3fa:e92e:7a7b with SMTP id t15-20020a7bc3cf000000b003fae92e7a7bmr18600235wmj.15.1689177399998;
        Wed, 12 Jul 2023 08:56:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3700:3eea:ace6:5bde:4478? (p200300cbc70737003eeaace65bde4478.dip0.t-ipconnect.de. [2003:cb:c707:3700:3eea:ace6:5bde:4478])
        by smtp.gmail.com with ESMTPSA id a23-20020a5d4577000000b0030ae53550f5sm5424569wrc.51.2023.07.12.08.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:56:39 -0700 (PDT)
Message-ID: <fa0d9f73-467b-64b8-91df-b2943f4dc27b@redhat.com>
Date:   Wed, 12 Jul 2023 17:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: remove clear_page_idle()
Content-Language: en-US
To:     Xueshi Hu <xueshi.hu@smartx.com>, akpm@linux-foundation.org,
        mhocko@suse.com, quic_charante@quicinc.com
Cc:     linux-kernel@vger.kernel.org
References: <20230712134959.145373-1-xueshi.hu@smartx.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712134959.145373-1-xueshi.hu@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.23 15:49, Xueshi Hu wrote:
> All callers have now been converted to call folio_clear_idle().
> 
> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
> ---
>   include/linux/page_idle.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
> index 5cb7bd2078ec..d8f344840643 100644
> --- a/include/linux/page_idle.h
> +++ b/include/linux/page_idle.h
> @@ -144,9 +144,4 @@ static inline void set_page_idle(struct page *page)
>   {
>   	folio_set_idle(page_folio(page));
>   }
> -
> -static inline void clear_page_idle(struct page *page)
> -{
> -	folio_clear_idle(page_folio(page));
> -}
>   #endif /* _LINUX_MM_PAGE_IDLE_H */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

