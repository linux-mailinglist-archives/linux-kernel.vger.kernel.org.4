Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0739E74B187
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGGNLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGGNL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25A1FE9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t1O9zb5GHKVELS5klWqCpQjcxJWJEqyoSLzfvfMUZe4=;
        b=cTm1fbBHdtnLhcbGYhOVJzsKdTck8QSCVl3zmmGT+AIKbejtSjvixN/b9dA4KDJuBE56CN
        Q05ki7LrgmA38a4ygiJof4qnZNmw1L2Iar0LMwHWEUifUNhH085OsOT3GpUtY+Apa+sdHc
        LRut0gZEnhyfirFVSAuMfvFGrunpNLM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-dwTXcIFWNEquJ2x97cQEiw-1; Fri, 07 Jul 2023 09:10:44 -0400
X-MC-Unique: dwTXcIFWNEquJ2x97cQEiw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63656624620so4001386d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735444; x=1691327444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1O9zb5GHKVELS5klWqCpQjcxJWJEqyoSLzfvfMUZe4=;
        b=XPgY8ozwjlH+g00VrPEJhoQFcCCaetc1m3eYQMkxm83KGriYroA4ChzykM4gTHIfG7
         Bdaewn/EuAxc+2QrZIqTliTrfQZc2gOQzzEcL3Akrzco3L/A0EKzk/COdaOf0QUIaYqo
         XpDnpt2mWTbB+JwqOtNimke8G+apbkFCZjs33cosA9bmF/l4DGFNt+5fzWq9SgkxFn+g
         8v7Wa8cmSpwJ37zEvJX2/TA2aacEw1L3viAL4M/sIebQ1pw8yuB12DpG17Nt8ZRzS1cD
         RI4qDHrVwcefJLlLhrLUK/1Xe5kUOUxN2YdjAm5p19noT3pobDg1GFrjeSdm9Xlowx0p
         vi7Q==
X-Gm-Message-State: ABy/qLamj8CvO8VY0vazOsfGtE2kFXRr6yZeFmYOuOP8D2b/qvwzrXV9
        pnGSupQ0OTDtiwcckkYNB5jZptDEdi3zf0HvDU1NfRGCVBMTSWM29phqxW8ncA6cUawMRDJUN+L
        BLTVNMDXg7DUqh1v7YUZCN9mM
X-Received: by 2002:a05:6214:b65:b0:634:cdae:9941 with SMTP id ey5-20020a0562140b6500b00634cdae9941mr5244166qvb.0.1688735444331;
        Fri, 07 Jul 2023 06:10:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcMXIEnO4pEK4x9rJYrWIuHjnwN+qpj3mBxRaYTRfLT3AgJiKgGQJyC0v2TXCl9WOzVHERgw==
X-Received: by 2002:a05:6214:b65:b0:634:cdae:9941 with SMTP id ey5-20020a0562140b6500b00634cdae9941mr5244120qvb.0.1688735443971;
        Fri, 07 Jul 2023 06:10:43 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p8-20020a0ce188000000b0063757aea986sm2066436qvl.28.2023.07.07.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:10:43 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:10:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/8] mm: make PTE_MARKER_SWAPIN_ERROR more general
Message-ID: <ZKgOxIeKN0wEmkih@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706225037.1164380-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:50:29PM -0700, Axel Rasmussen wrote:
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 886f06066622..59e954586e2a 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -660,7 +660,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  				free_swap_and_cache(entry);
>  				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  			} else if (is_hwpoison_entry(entry) ||
> -				   is_swapin_error_entry(entry)) {
> +				   is_error_swp_entry(entry)) {

is_error_swp_entry() made me think whether we should call this marker as
ERROR at all - it's too generic, is_error_swp_entry() can be easily read as
"this swap entry is not legal".  Can we come up with a less generic one?

PTE_MARKER_PAGE_POISONED / PTE_MARKER_POISONED / PTE_MARKER_PAGE_ERR / ...?

We do use poisoned only in real bad physical pages before, but I think we
can still keep using it when applying it to a pte.  I think it's fine to
call a pte poisoned if it's not legal to access, just like a poisoned page.

>  				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  			}
>  			continue;

The code change across the whole patch look good to me otherwise, thanks.

-- 
Peter Xu

