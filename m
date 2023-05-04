Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720956F6E97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjEDPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEDPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44581997
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683212683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKpeHZVSxx8CJs7gUO4c0bM4YS+xQ3y47FDdrxUz/84=;
        b=bKzBxSW0KsXYqxiZGF4W60ZIOFdzrBH0VNmKpSSeUQeDfxOoBVHEVSSH8BwPmr3cAnNF7d
        7wTmdJFUcQRMqB7rbDRdPMWpNaD222Za+wajVQWsumfnH0q04eu1CPOU9H57FO5v55OkrC
        /+oAKxSVtoKVK1zLW//0nXM9kj0zbr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-q6bI7LrIPRyywliqQVQhaQ-1; Thu, 04 May 2023 11:04:40 -0400
X-MC-Unique: q6bI7LrIPRyywliqQVQhaQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30641258c9eso228895f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212678; x=1685804678;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKpeHZVSxx8CJs7gUO4c0bM4YS+xQ3y47FDdrxUz/84=;
        b=RYx2Kj0o2FG9ooRKtLCzuzKD5HLlQ7ATx1h2PXHIsC26fOhdWk1YWisFedMF1LUvBu
         G2pxaZ6giGkD0gC4coMSxPSDezqCw83Ewl/a8EXNXRPLpgJWhnIErQOcar7o03Zr5EiK
         EDV4Wxdk8thVoTqZJRR2qaooyJK0f+nn3ZUzEtYw0n9R6W6nreLoiCpc+GfUl+TYzfr4
         Mn+l076B9QKMmDS77yvAL2I+lfX7NGQWJQh1ItLlPQTnEOuEvm7H+yZ2w+G6xIEqHBSo
         YuJJs5azC0/POHtFAiJhDGt2bWtFPHd9ATJC2YCV2UnQ7Vy8ry8kbjjOeluDgTHS1QwS
         0X7w==
X-Gm-Message-State: AC+VfDxJ5rosbLNdOp70vNFMcL5lWx9PuUDMIoY3Q+bDCwGgPQWG4SVD
        Z0geTgCSGTy/MquYyb3ks/KSXAY/rSeUfjfKcALyZwi+LsCh7GbLPKV5d7gyXd7Ck+ArWSPlZsM
        WAzRf5VRpc5r+3xJb1S6h6ZR5
X-Received: by 2002:adf:fe0f:0:b0:2f8:e190:e719 with SMTP id n15-20020adffe0f000000b002f8e190e719mr3103313wrr.65.1683212677669;
        Thu, 04 May 2023 08:04:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rxT0rJtp8bOBHaHErNHhzE0fosUbvHA3tSGtLLdRYz110diw12mrtbe5YpgvE/16tzPAhoQ==
X-Received: by 2002:adf:fe0f:0:b0:2f8:e190:e719 with SMTP id n15-20020adffe0f000000b002f8e190e719mr3103257wrr.65.1683212676920;
        Thu, 04 May 2023 08:04:36 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d680c000000b0030630120e56sm10437110wru.57.2023.05.04.08.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:04:36 -0700 (PDT)
Message-ID: <e4c92510-9756-d9a1-0055-4cd64a0c76d9@redhat.com>
Date:   Thu, 4 May 2023 17:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <cover.1683067198.git.lstoakes@gmail.com>
 <a690186fc37e1ea92556a7dbd0887fe201fcc709.1683067198.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
In-Reply-To: <a690186fc37e1ea92556a7dbd0887fe201fcc709.1683067198.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> +static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)
> +{
> +	struct address_space *mapping;
> +	unsigned long mapping_flags;
> +
> +	/*
> +	 * If we aren't pinning then no problematic write can occur. A long term
> +	 * pin is the most egregious case so this is the one we disallow.
> +	 */
> +	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=
> +	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
> +		return true;
> +
> +	/* The folio is pinned, so we can safely access folio fields. */
> +
> +	/* Neither of these should be possible, but check to be sure. */

You can easily have anon pages that are at the swapcache at this point 
(especially, because this function is called before our unsharing 
checks), the comment is misleading.

And there is nothing wrong about pinning an anon page that's still in 
the swapcache. The following folio_test_anon() check will allow them.

The check made sense in page_mapping(), but here it's not required.

I do agree regarding folio_test_slab(), though. Should we WARN in case 
we would have one?

if (WARN_ON_ONCE(folio_test_slab(folio)))
	return false;

> +	if (unlikely(folio_test_slab(folio) || folio_test_swapcache(folio)))
> +		return false;
> +
> +	/* hugetlb mappings do not require dirty-tracking. */
> +	if (folio_test_hugetlb(folio))
> +		return true;
> +
> +	/*
> +	 * GUP-fast disables IRQs. When IRQS are disabled, RCU grace periods
> +	 * cannot proceed, which means no actions performed under RCU can
> +	 * proceed either.
> +	 *
> +	 * inodes and thus their mappings are freed under RCU, which means the
> +	 * mapping cannot be freed beneath us and thus we can safely dereference
> +	 * it.
> +	 */
> +	lockdep_assert_irqs_disabled();
> +
> +	/*
> +	 * However, there may be operations which _alter_ the mapping, so ensure
> +	 * we read it once and only once.
> +	 */
> +	mapping = READ_ONCE(folio->mapping);
> +
> +	/*
> +	 * The mapping may have been truncated, in any case we cannot determine
> +	 * if this mapping is safe - fall back to slow path to determine how to
> +	 * proceed.
> +	 */
> +	if (!mapping)
> +		return false;
> +
> +	/* Anonymous folios are fine, other non-file backed cases are not. */
> +	mapping_flags = (unsigned long)mapping & PAGE_MAPPING_FLAGS;
> +	if (mapping_flags)
> +		return mapping_flags == PAGE_MAPPING_ANON;

KSM pages are also (shared) anonymous folios, and that check would fail 
-- which is ok (the following unsharing checks rejects long-term pinning 
them), but a bit inconstent with your comment and folio_test_anon().

It would be more consistent (with your comment and also the 
folio_test_anon implementation) to have here:

	return mapping_flags & PAGE_MAPPING_ANON;

> +
> +	/*
> +	 * At this point, we know the mapping is non-null and points to an
> +	 * address_space object. The only remaining whitelisted file system is
> +	 * shmem.
> +	 */
> +	return shmem_mapping(mapping);
> +}
> +

In general, LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

