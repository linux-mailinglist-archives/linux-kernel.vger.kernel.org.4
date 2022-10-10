Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3F5F9D69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiJJLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiJJLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEF74F66B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665400567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAnZYCx+crWb7x49Ic4rELwDm5XffixZvlKcyuXXQ4Y=;
        b=GF4k4kIU1NHvQPgPar2P4nkPo6AHoe51qHuBxjq3SaaMCqFlM89wCHdTQOEV7cCWKBrWQy
        O3Rv/tvw0X3dQOz6IJziIE1s9lHzKATviO1ddQOM77yNqGHvRgScIKECzvd0nDrQQ4UN9w
        8cALmKEqJtUE3CrY35GAxAfCGWTnKJA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-WWxRRlBcOD6bK5QMq6Au9A-1; Mon, 10 Oct 2022 07:16:06 -0400
X-MC-Unique: WWxRRlBcOD6bK5QMq6Au9A-1
Received: by mail-wm1-f70.google.com with SMTP id q14-20020a7bce8e000000b003c6b7debf22so398215wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAnZYCx+crWb7x49Ic4rELwDm5XffixZvlKcyuXXQ4Y=;
        b=ZDfHWMytlGVOo5VrJRrkOpIEmqmU8WF5/Fe2AH6AX+drjvI6gKhiMnCVB+m9YGUNT7
         itKr9DofN9m/1rS32cCMeRWI6aIImimTiXks21CNh+hBO7MuPQyuAhO4h71s9odf/Gj9
         2eNRZUH/SRVsjJaO74GJmWblKUU/8QdL49XVoV8KhyJsyY/dUgrqQg7WYZaeIUdU2Nig
         hn8hVI6dpFtpoNFcU1Tgjds+IQOXGyNIjYU9B478rFgMsM2YcL6RYXkbhp1K5KtToI7L
         ypW/Q9U3bj+K8XgD+tDe6cpoMxQeOSHFnXyMkgk2yl0pkr5hCZN2Ni0eLZ/qQBGV7GfB
         onpQ==
X-Gm-Message-State: ACrzQf3LtgQwrX75l/IDIwHKA6KLAq5qrd1po56hI5lPtuUzsc3FyMcE
        nMJgkMLG0tp6rQpujuVoyF+xdxY8UyGECOKUVKhEAGkDKcxLM2z66Tbfmj+Cve8NlZ3AuGHqEVe
        /7e4tLvtPFn3xKywKCqK+w83K
X-Received: by 2002:a5d:65c4:0:b0:22c:dbdd:7177 with SMTP id e4-20020a5d65c4000000b0022cdbdd7177mr10711824wrw.470.1665400564962;
        Mon, 10 Oct 2022 04:16:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4otAEdTe/UjaWjkb49+axzaI+LAv0GYApqsg/Kk3ETzL985evO+gl2SP6SjjSQgGLyYl2Dlw==
X-Received: by 2002:a5d:65c4:0:b0:22c:dbdd:7177 with SMTP id e4-20020a5d65c4000000b0022cdbdd7177mr10711808wrw.470.1665400564697;
        Mon, 10 Oct 2022 04:16:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:e600:3a4a:f000:b085:4839? (p200300cbc704e6003a4af000b0854839.dip0.t-ipconnect.de. [2003:cb:c704:e600:3a4a:f000:b085:4839])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003b3365b38f9sm9628042wms.10.2022.10.10.04.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:16:04 -0700 (PDT)
Message-ID: <b44eee1a-0d61-f5bb-7b0c-a01f13a0b297@redhat.com>
Date:   Mon, 10 Oct 2022 13:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/5] memblock tests: add range tests for
 memblock_alloc_exact_nid_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1664753534.git.remckee0@gmail.com>
 <c73a6fd7fc3fa4529a6e444b9602d9c63ded91fd.1664753534.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c73a6fd7fc3fa4529a6e444b9602d9c63ded91fd.1664753534.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.22 01:41, Rebecca Mckeever wrote:
> Add tests for memblock_alloc_exact_nid_raw() that are very similar to
> the range tests for memblock_alloc_try_nid_raw().
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/Makefile               |    2 +-
>   tools/testing/memblock/main.c                 |    2 +
>   .../memblock/tests/alloc_exact_nid_api.c      | 1208 +++++++++++++++++
>   .../memblock/tests/alloc_exact_nid_api.h      |    9 +
>   4 files changed, 1220 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
>   create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h
> 
> diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
> index 246f7ac8489b..2310ac4d080e 100644
> --- a/tools/testing/memblock/Makefile
> +++ b/tools/testing/memblock/Makefile
> @@ -7,7 +7,7 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
>   LDFLAGS += -fsanitize=address -fsanitize=undefined
>   TARGETS = main
>   TEST_OFILES = tests/alloc_nid_api.o tests/alloc_helpers_api.o tests/alloc_api.o \
> -		  tests/basic_api.o tests/common.o
> +		  tests/basic_api.o tests/common.o tests/alloc_exact_nid_api.o
>   DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
>   OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
>   EXTR_SRC = ../../../mm/memblock.c
> diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
> index 4ca1024342b1..278f9dec5008 100644
> --- a/tools/testing/memblock/main.c
> +++ b/tools/testing/memblock/main.c
> @@ -3,6 +3,7 @@
>   #include "tests/alloc_api.h"
>   #include "tests/alloc_helpers_api.h"
>   #include "tests/alloc_nid_api.h"
> +#include "tests/alloc_exact_nid_api.h"
>   #include "tests/common.h"
>   
>   int main(int argc, char **argv)
> @@ -12,6 +13,7 @@ int main(int argc, char **argv)
>   	memblock_alloc_checks();
>   	memblock_alloc_helpers_checks();
>   	memblock_alloc_nid_checks();
> +	memblock_alloc_exact_nid_checks();
>   
>   	return 0;
>   }


memblock_alloc_exact_nid_raw(NUMA_NO_NODE) behaves exactly the way 
memblock_alloc_try_nid_raw(NUMA_NO_NODE) behaves -- which is essentially 
memblock_alloc_raw().

So do we really need a separate set of tests for these?

-- 
Thanks,

David / dhildenb

