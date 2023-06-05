Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C727224CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjFELjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjFELje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9121A1A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685965117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nw6c3Frym7PEsE78EAla72qbR0TE8qr6R9Rp/jfKLzY=;
        b=c3KCDTA2x1/0uawrkpqtcSTPcNEpw8/R8gs9uTdC2Ia8khwdFXe1DsB+oOtNhuP48Ti78L
        mpA27sLC6hiSFaZ/p4oDwOh7YtQJtk6pO9FPPK5WZN6Bki08eO+PMxUwPDhwVr1oMIv8Sr
        CA7auRZ7su/duDubpbEnziB27EbXPvg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-pZ3Mf9e4Ol6ZZKR9bTLWQA-1; Mon, 05 Jun 2023 07:38:36 -0400
X-MC-Unique: pZ3Mf9e4Ol6ZZKR9bTLWQA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6fa88a86bso25887875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965115; x=1688557115;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nw6c3Frym7PEsE78EAla72qbR0TE8qr6R9Rp/jfKLzY=;
        b=JcDXXYtmFk/gYPz1W3qOc2dcmlSUGbib04LcOGtR4lpWbo264Tjui7IoadohpbwnTy
         q9xYpQWp+RLxe/8u1y/guVugHUAJ2btdjRb6lgwybfMpj5Xk1RHktmub1gnwbogjqeck
         +2B/hEpnfShbpp4H09VTsQYkGlR/F3wTh5UeBfjdJ6LWMb7wH/88BatqSpu0saY/poB/
         KuVawpV4u5ff4HWcMcTI7U4bmC3S46eX8THyGeRNfSbF4bwUkWm0aLENaSaloCNi9tsc
         67Z0F8zJHMwv4SVsdeeqeJmE10XjSvvxag3+6kk8lIKRV5THvsfxobOuevKVnWUN3n7o
         CoxQ==
X-Gm-Message-State: AC+VfDy8B8pEjHTtJiAy8kHtkGCPd/1Lnxhzd5vxZmcxWO7s0HgqGgWO
        yWLpdXINFFIg9J6PqIn1ZCkYHavB3B41I45E6rurC50VwYAzvtoNKLW8YGVDwVGFSoeihWO6CfT
        Hf7MKjAksXovlfGDJYi0u+kf7
X-Received: by 2002:a05:600c:294b:b0:3f2:549b:3ef2 with SMTP id n11-20020a05600c294b00b003f2549b3ef2mr7114539wmd.17.1685965115490;
        Mon, 05 Jun 2023 04:38:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kvL4JlLeuJgsapJ+Y6U3lmqfa/03WInR1fTsMNi3NgkfaVjGeDxgrx8WocL5SlrBLyA73Ng==
X-Received: by 2002:a05:600c:294b:b0:3f2:549b:3ef2 with SMTP id n11-20020a05600c294b00b003f2549b3ef2mr7114527wmd.17.1685965115287;
        Mon, 05 Jun 2023 04:38:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b003f1978bbcd6sm24406738wmo.3.2023.06.05.04.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:38:34 -0700 (PDT)
Message-ID: <c9ff1306-9918-5ca5-6578-9a05a164de26@redhat.com>
Date:   Mon, 5 Jun 2023 13:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 11/11] Documentation: kselftest: "make headers" is a
 prerequisite
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-12-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603021558.95299-12-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.23 04:15, John Hubbard wrote:
> As per a discussion with Muhammad Usama Anjum [1], the following is how
> one is supposed to build selftests:
> 
>      make headers && make -C tools/testing/selftests/mm
> 
> However, that's not yet documented anywhere. So add it to
> Documentation/dev-tools/kselftest.rst .
> 
> [1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   Documentation/dev-tools/kselftest.rst | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 12b575b76b20..6e35d042199c 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -36,6 +36,7 @@ Running the selftests (hotplug tests are run in limited mode)
>   
>   To build the tests::
>   
> +  $ make headers
>     $ make -C tools/testing/selftests
>   
>   To run the tests::

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

