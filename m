Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F66133A2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiJaK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiJaK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349822FE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667212100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hIeJVnchaNxDIQLVeOkkO5U18ich1B9OkG0LgN+vzo=;
        b=i3lDS4IFRGMDaMUQu93N7YeMqN0tWMRsudw1EErSJMFtkVcgT9W6MRnXVrRiDSoT1xIlUi
        giyE3mxHZgXuG1puv2kpcOY1ffB7FvR8+4Sn63QecD8qtNJyl/UzhFeoNQSTDN40fomOmL
        ld04RkN5f9qpWlnxHhtjsoyqXdNw4Vk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-tqpsWtyNOjeqCgfOgcNdAA-1; Mon, 31 Oct 2022 06:28:18 -0400
X-MC-Unique: tqpsWtyNOjeqCgfOgcNdAA-1
Received: by mail-wr1-f69.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso2898305wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hIeJVnchaNxDIQLVeOkkO5U18ich1B9OkG0LgN+vzo=;
        b=L+Fpgoxe5vTmPgdTYQSDZUwbjLgxDjdwD8jD707OasJwJDTm31/7L7CLdaP+0AwA8a
         1FaIUutH+EUCyHhxagqvpDYM9rRdH/ALFf4ivknsMu3HvDLchSur/gdwEtgIuj2pIUrO
         lKjBCb2bgKRQMXzDLoV53FQaR0FiF+km27WtiVjYiiCHCw3gUzs9INc9UDs914T4A1Fc
         yw9+xQ6jc9PeN6kwMvazJ04ZjLTTlYOGnHXn12rLOvxEqOd3Yhgz/2wl9htuOFJvCWGz
         4kk12ZA8dWtjSowDWrVYAg7qcuRTaGoxCOxAg7dRKoO6qGb2x+qGniUKlmIbvI2LNyxT
         lbLQ==
X-Gm-Message-State: ACrzQf1Cmw462ng/lL+4JbSD7RzB2utK0c0rBOLVAvukQwMdZcMav95W
        ajKVpGjbmbnAzyiEUlc6+50zP4EHJCyfgD1iM5SDUS1OW7SaoI91gUtl7diPOB4SSyxhCwTzTsF
        n1Xj4BKc6HfBJQ+LqIvPsaYhy
X-Received: by 2002:adf:dd12:0:b0:236:6ef7:dacf with SMTP id a18-20020adfdd12000000b002366ef7dacfmr7421293wrm.204.1667212097621;
        Mon, 31 Oct 2022 03:28:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ydPFfgWp2fYwXo04xgnbDjn+PJoF9QYc3RViQ0SveCErN/DxpTH63zs/QvfNCPP/X+35XUA==
X-Received: by 2002:adf:dd12:0:b0:236:6ef7:dacf with SMTP id a18-20020adfdd12000000b002366ef7dacfmr7421277wrm.204.1667212097269;
        Mon, 31 Oct 2022 03:28:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d? (p200300cbc705b300ab9a1f1fddaf3b1d.dip0.t-ipconnect.de. [2003:cb:c705:b300:ab9a:1f1f:ddaf:3b1d])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d6192000000b00228692033dcsm6652894wru.91.2022.10.31.03.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 03:28:16 -0700 (PDT)
Message-ID: <b60e55de-46b7-3eeb-4ad1-914d8cc5f25b@redhat.com>
Date:   Mon, 31 Oct 2022 11:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1666203642.git.remckee0@gmail.com>
 <d5481026b5b75e919e6497968453e86ab79b77d0.1666203643.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/5] memblock tests: introduce range tests for
 memblock_alloc_exact_nid_raw
In-Reply-To: <d5481026b5b75e919e6497968453e86ab79b77d0.1666203643.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.22 20:34, Rebecca Mckeever wrote:
> Add TEST_F_EXACT flag, which specifies that tests should run
> memblock_alloc_exact_nid_raw(). Introduce range tests for
> memblock_alloc_exact_nid_raw() by using the TEST_F_EXACT flag to run the
> range tests in alloc_nid_api.c, since memblock_alloc_exact_nid_raw() and
> memblock_alloc_try_nid_raw() behave the same way when nid = NUMA_NO_NODE.
> 
> Rename tests and other functions in alloc_nid_api.c by removing "_try".
> Since the test names will be displayed in verbose output, they need to
> be general enough to refer to any of the memblock functions that the
> tests may run.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

[...]

> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 2c2d60f4e3e3..df8e7e038cab 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -18,18 +18,27 @@ static const unsigned int node_fractions[] = {
>   	 625, /* 1/16 */
>   };
>   
> -static inline const char * const get_memblock_alloc_try_nid_name(int flags)
> +static inline const char * const get_memblock_alloc_nid_name(int flags)
>   {
> +	if (flags & TEST_F_EXACT)
> +		return "memblock_alloc_exact_nid_raw";
>   	if (flags & TEST_F_RAW)
>   		return "memblock_alloc_try_nid_raw";
>   	return "memblock_alloc_try_nid";
>   }
>   
> -static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
> -					       phys_addr_t align,
> -					       phys_addr_t min_addr,
> -					       phys_addr_t max_addr, int nid)
> +static inline void *run_memblock_alloc_nid(phys_addr_t size,
> +					   phys_addr_t align,
> +					   phys_addr_t min_addr,
> +					   phys_addr_t max_addr, int nid)
>   {

I think we want to assert here that TEST_F_EXACT without TEST_F_RAW is 
not set --- because there is no API to support it.

Apart from that

Acked-by: David Hildenbrand <david@redhat.com>


Thanks!

-- 
Thanks,

David / dhildenb

