Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B706672BE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFLKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFLKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3A1734
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686563788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7erq9mCXu6YfPjb1swyfCVbQPxq89IutQ/4dZgRd0RM=;
        b=V0ATC0kXn4FriecrDCvWf5Yz8puSCqVylTrmi9gX9HfMlTRmWuin6VA6KQa9XW0P3fYsHr
        d2Y3+kkx77prWVYX5YvFtPFsVr/+JFzC6K9JFuMFbSbbbgTZH58U4E843jdOps4x7CTnhi
        E53B8uklWyixn7Xnvt/K6g9fIAoFJkM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-5EvZIs7FMfeIX1pGHLi-dg-1; Mon, 12 Jun 2023 05:56:24 -0400
X-MC-Unique: 5EvZIs7FMfeIX1pGHLi-dg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4ec817fb123so2671362e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563782; x=1689155782;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7erq9mCXu6YfPjb1swyfCVbQPxq89IutQ/4dZgRd0RM=;
        b=T5fV00Msd07BEr7TIfo3Y5WJp5dmlTTc9c9lxzGyVJnclS/Wuk/fn+fL/lVk93ifjS
         A7e7yHRMicKe6UT7T5Yaz9hceDhXZ4VqXgstSArl8/mF/dRXsfiao7bxL+d3HCwLkumP
         9VTE56+x1O4nMLFdzSmswymZkpQchP9SZeBwa4ER5USYrCP6Z5P6O9J9drTfFPN5a9p+
         HFZtUkHwFK5tBImHlIHF+/9/BYFu+U4YF5LmEsUYDCL5RtU7hV12rdsZLEt1CfMDgP4v
         IievhyAI/bwVIBnkkk7ekFOFflTA2vWbrktoLtiJ3ZKXeI/SekUqjPbfTpQOiElBF0Nk
         SG2A==
X-Gm-Message-State: AC+VfDwfyJ4oX+zEC7bSjWY1EqyS93WrEUiWqe+/o1nSeMAlEd9zuVu5
        f0zUxpH33yIZXRxaYBFVGBa4XZoHwweOTRyqHxFxjERJilLgckhS/RlVKYoY9SmIo5JyJWiJk68
        NzjizLgEf7FYqdyAFJ5PvMM1w
X-Received: by 2002:a19:4f4c:0:b0:4f3:b222:1eed with SMTP id a12-20020a194f4c000000b004f3b2221eedmr3525799lfk.2.1686563782588;
        Mon, 12 Jun 2023 02:56:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4U7pGmP/JxxfD47wW6q0zz8WCn++HEA7IpRLWH5Pgnbq09E9OG/AArBNmozy2NqofxEpwZXA==
X-Received: by 2002:a19:4f4c:0:b0:4f3:b222:1eed with SMTP id a12-20020a194f4c000000b004f3b2221eedmr3525779lfk.2.1686563782187;
        Mon, 12 Jun 2023 02:56:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f8140763c7sm5747410wml.30.2023.06.12.02.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:56:21 -0700 (PDT)
Message-ID: <c287f70c-7eab-8835-de9f-f68db4e54510@redhat.com>
Date:   Mon, 12 Jun 2023 11:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] selftests: mm: remove wrong kernel header inclusion
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Stefan Roesch <shr@devkernel.io>
Cc:     kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612095347.996335-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230612095347.996335-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.23 11:53, Muhammad Usama Anjum wrote:
> It is wrong to include unprocessed user header files directly. They are
> processed to "<source_tree>/usr/include" by running "make headers" and
> they are included in selftests by kselftest makefiles automatically with
> help of KHDR_INCLUDES variable. These headers should always bulilt
> first before building kselftests.
> 
> Fixes: 07115fcc15b4 ("selftests/mm: add new selftests for KSM")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 95acb099315e..e6cd60ca9e48 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -29,7 +29,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>   # LDLIBS.
>   MAKEFLAGS += --no-builtin-rules
>   
> -CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>   LDLIBS = -lrt -lpthread
>   
>   TEST_GEN_PROGS = cow

Still compiles after "make headers", so

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

