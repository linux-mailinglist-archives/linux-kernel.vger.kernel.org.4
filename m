Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61870B812
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjEVIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjEVIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95050A0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684745553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPeE6tUQHjzc91RgBdRzEGVCAOWxBtl44bgg1/KBy7s=;
        b=KIDt74Z3/fh9W7N7chj2O9RK868VrzocbP4JUYGRbnsBRXb1rRol1pGrKU81Kz3cyQEU9F
        qkfDrVdD8AgX1Odks0yQbEXJaqubK3u0ti+T9fg8lc12aK4IujXY545hPihvbyeQoY3jXi
        See1BFiUhcc0K84ZUCWKT3MQ6HL4m/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-kfxxGqf6Pra1BGYoTgRRgA-1; Mon, 22 May 2023 04:52:32 -0400
X-MC-Unique: kfxxGqf6Pra1BGYoTgRRgA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f4f2f5098bso32640785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745551; x=1687337551;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPeE6tUQHjzc91RgBdRzEGVCAOWxBtl44bgg1/KBy7s=;
        b=kJpcVC+xYVMRhZg9berW5wLONBT0eJvzOGBWES7ovJ4VZ096CDgMEjOuNk/C/Emo2V
         9ouWdlv7tq+6YkO1Y2PuC05G7LV9ewCVu6kbgpHVDsj9IcOG7WNljkjvUFoA7DdBhEP4
         11t+IQ48YqOUuZokFAAv3ppULEeWobdBkh3WRvZYnTs7EXwvSuhR7joPSqcAMRPp+UQP
         LU35rdByESzEFAbVBvp+fvBT4Qwtv1CwDdMNsFNOM3G65zgF2kOFY9jONPJA+CLc6IeL
         kBCQAtfHMH37MAN0ckYbQ1wzflqZldhYsw2LDsVYTmgsojsuj5wk3TnmyVUe6sdnBztq
         ZxSg==
X-Gm-Message-State: AC+VfDwO6UNg1kU/4NieiwjytDaKznYm93I7SxJirazsvMct0Ygdfl3u
        FM85/zV4XS7p0P7vJKjGF5BVdMRievtzSz+9AQhr7/eVVYTogUmVABYhKr6odylDY0JLzWW50LD
        nSF7w7N5RvmEJSglAu9v8LY2t
X-Received: by 2002:a7b:c04c:0:b0:3f4:9bee:b9c with SMTP id u12-20020a7bc04c000000b003f49bee0b9cmr6593940wmc.18.1684745550977;
        Mon, 22 May 2023 01:52:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7EcneEskXT4qQ/O1QZ3bDxhumqqD9OP/xqSTy9nholH3ENkuqJSxjHrcTc1cXYcYPX/2MeIA==
X-Received: by 2002:a7b:c04c:0:b0:3f4:9bee:b9c with SMTP id u12-20020a7bc04c000000b003f49bee0b9cmr6593923wmc.18.1684745550642;
        Mon, 22 May 2023 01:52:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id f9-20020a1cc909000000b003f180d5b145sm7567762wmb.40.2023.05.22.01.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:52:30 -0700 (PDT)
Message-ID: <695a9b93-0dd5-d4c2-90a9-e33675d855ce@redhat.com>
Date:   Mon, 22 May 2023 10:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] kselftest: vm: Fix tabs/spaces inconsistency in
 the mdwe test
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-2-revest@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230517150321.2890206-2-revest@chromium.org>
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

On 17.05.23 17:03, Florent Revest wrote:
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>   tools/testing/selftests/mm/mdwe_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index bc91bef5d254..d0954c657feb 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -49,19 +49,19 @@ FIXTURE_VARIANT(mdwe)
>   
>   FIXTURE_VARIANT_ADD(mdwe, stock)
>   {
> -        .enabled = false,
> +	.enabled = false,
>   	.forked = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(mdwe, enabled)
>   {
> -        .enabled = true,
> +	.enabled = true,
>   	.forked = false,
>   };
>   
>   FIXTURE_VARIANT_ADD(mdwe, forked)
>   {
> -        .enabled = true,
> +	.enabled = true,
>   	.forked = true,
>   };
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

