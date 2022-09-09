Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E54B5B3691
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIILlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIILld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7215A820
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8m4RqaV+L7PjYgd4q6CvYkN7poUl5+DQqxJTHjxeEs=;
        b=EUXP/bTVQx6IR4nMQsPM/LHbz4SNFHq0fiUpQdp8DmM2Qhzq9Ah0DDiD5kplyjuTaa5wUH
        StGDQFeqb0OC2OE8+ujhbcbekppcN1Ry12CoXmttdr5BwmgfM72dJ6TCmJHLgXg2qK/85Y
        RPSGLDip+u+/x8MjPkqaL/qS/OT8JQM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-dWsGwnb3Mw2BVo8CVxNnVg-1; Fri, 09 Sep 2022 07:41:29 -0400
X-MC-Unique: dWsGwnb3Mw2BVo8CVxNnVg-1
Received: by mail-wm1-f69.google.com with SMTP id v128-20020a1cac86000000b003b33fab37e8so733112wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M8m4RqaV+L7PjYgd4q6CvYkN7poUl5+DQqxJTHjxeEs=;
        b=ykHOvg4h35xFB1CrcK0U0AooOvvZTKOyLSQ2B1aKu0vWckjGN7t6mbsg3FyHyePXKb
         3EmjVAESz3vLmJ9YBm4cykxSEgoRlqbf+gkW4i3eoPwBJePw696XN869e1cl8zbPLh3f
         +i5uvl3BrWiLz0wVokJNW0cE57xJ8UqEmeEfG6K+Dog587DEf07hsuimNBSooMW8+RaR
         YVpvcOwGp5PGiN2Nu/Wn2T4TizOIBNpVWHhQ9cUenkCqQf8yYOwC49iUcRjFqTeTRuPG
         zsOC9AuB4Wea69DGS5JDYoNGLAJKjUC/Oc4k5gWSWIsrytttbgrBrzAhPqIHFWjU+7KM
         BQGg==
X-Gm-Message-State: ACgBeo23PnuIMfcPQpCY48BUzwhVd8kScFFb/HLvHpDxmZgu3guQ5gaK
        /AzL7U5G3r30drzhRb0SgWF7EvtFqON9B+AXJ3LsqLX/ZZmaU102mb5/3TMB+uaaHygjrlWHb4r
        JTNl08ePe5b3wCotqI9kBKU5J
X-Received: by 2002:a05:600c:1552:b0:3a8:4523:d16 with SMTP id f18-20020a05600c155200b003a845230d16mr5144680wmg.200.1662723688106;
        Fri, 09 Sep 2022 04:41:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6D0OWtKFY9E+O9vhBGqmrlOCmpkAqx5UZk5i7PfdubsvBswpnlbG93P0Gct9xrBqincvnZ6A==
X-Received: by 2002:a05:600c:1552:b0:3a8:4523:d16 with SMTP id f18-20020a05600c155200b003a845230d16mr5144667wmg.200.1662723687858;
        Fri, 09 Sep 2022 04:41:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003a62052053csm658225wmq.18.2022.09.09.04.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:41:27 -0700 (PDT)
Message-ID: <63cbc594-14cb-b5c3-485b-5c784315b04b@redhat.com>
Date:   Fri, 9 Sep 2022 13:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1662698159.git.remckee0@gmail.com>
 <5ac0e2f8d6b6cb985e2d6f308edeec2b699ecbea.1662698159.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5ac0e2f8d6b6cb985e2d6f308edeec2b699ecbea.1662698159.git.remckee0@gmail.com>
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

On 09.09.22 06:46, Rebecca Mckeever wrote:
> Add function setup_numa_memblock() for setting up a memory layout with
> multiple NUMA nodes in a previously allocated dummy physical memory.
> This function can be used in place of setup_memblock() in tests that need
> to simulate a NUMA system.
> 
> setup_numa_memblock():
> - allows for setting up a memory layout by specifying the fraction of
>    MEM_SIZE in each node
> 
> Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> 16 NUMA nodes.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   .../testing/memblock/scripts/Makefile.include |  2 +-
>   tools/testing/memblock/tests/common.c         | 31 +++++++++++++++++++
>   tools/testing/memblock/tests/common.h         |  4 ++-
>   3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> index aa6d82d56a23..998281723590 100644
> --- a/tools/testing/memblock/scripts/Makefile.include
> +++ b/tools/testing/memblock/scripts/Makefile.include
> @@ -3,7 +3,7 @@
>   
>   # Simulate CONFIG_NUMA=y
>   ifeq ($(NUMA), 1)
> -	CFLAGS += -D CONFIG_NUMA
> +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
>   endif
>   
>   # Use 32 bit physical addresses.
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index eec6901081af..9d9ad7df298b 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -9,6 +9,7 @@
>   #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>   #define PREFIXES_MAX				15
>   #define DELIM					": "
> +#define BASIS					10000
>   
>   static struct test_memory memory_block;
>   static const char __maybe_unused *prefixes[PREFIXES_MAX];
> @@ -72,6 +73,36 @@ void setup_memblock(void)
>   	fill_memblock();
>   }
>   
> +/**
> + * setup_numa_memblock:
> + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> + * dummy physical memory.
> + * @node_fracs: an array representing the fraction of MEM_SIZE contained in
> + *              each node in basis point units (one hundredth of 1% or 1/10000).
> + *              For example, if node 0 should contain 1/8 of MEM_SIZE,
> + *              node_fracs[0] = 1250.
> + *
> + * The nids will be set to 0 through NUMA_NODES - 1.
> + */
> +void setup_numa_memblock(const int node_fracs[])

If you make it an unsigned int ...

> +{
> +	phys_addr_t base;
> +	int flags;
> +
> +	reset_memblock_regions();
> +	base = (phys_addr_t)memory_block.base;
> +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> +
> +	for (int i = 0; i < NUMA_NODES; i++) {
> +		assert(node_fracs[i] <= BASIS && node_fracs[i] > 0);

You can drop the latter assertion.

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

