Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FBB69E9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBUWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBUWNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3416E3C17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677017574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZexKVQu5aJySrpsPPoew7Lpnukgn8mCz3/T+aftBm0=;
        b=f+irx0S/KoPjhcVP1H4myfELGDxfZm9gKf0/bOkHQyJSFfAPVzJ6Aqh4Y4XAbnu+fDZjbo
        8GV2C0LPmrKmJKIswjmebf7A4SQsZzyNH17AN9av9mnflHj+WL0h4r1613AfVpEyfYG1OA
        RAWfIcCU5gMakiYyiFXwJ5bGYiOw5E0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-HSkFaOIwN5Odh1yyT-hN7g-1; Tue, 21 Feb 2023 17:12:53 -0500
X-MC-Unique: HSkFaOIwN5Odh1yyT-hN7g-1
Received: by mail-qv1-f71.google.com with SMTP id y6-20020ad457c6000000b00535261af1b1so2854015qvx.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677017572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZexKVQu5aJySrpsPPoew7Lpnukgn8mCz3/T+aftBm0=;
        b=vrwKyOg46gyXT8O1xeR1K85jTHph2Im34DHbI+C+oluRBAG/rzsUSi9En2tcDM/LhP
         6fSdDuglCAWDKDCWm5G0jYsjJq0HHIPk/7rUGiTOUgx+MX/jGeZh3f0XD1xCdH0qYKRD
         ZfA1AcX6Jo7vK2PUqJk3E7T7/yOTCfLOrPvqF9fTDZ99HIEIdJECBfVE+b6ks25f8Sy9
         baJBP9rTTw4bYdRXDkqQ3x+F9CrXbnUbeFWmpljZo1b2AfpPLtPAAeICFDR1xrL5T7of
         pQDvc5HNyZXLqa7zubTxZZSisCvIU94Wwwuod4bCUQyt+HYBC91MAiNrWSEVD2GfKHdg
         YkSg==
X-Gm-Message-State: AO0yUKUwpZOXCWZRkLKyQjGpn7Zl7Igai0eex81i+uHH231mh/DzWyl0
        WhxYA3+h2mlvcaAyShucVtpK+edLo7MRBKxxxrjC7aSxYvZg8vuWTMh5gRgnVv2vPM7bbl3MKA/
        FmCshrgciuDv2co3MPANijaHP
X-Received: by 2002:a0c:f0c1:0:b0:56e:89b9:9a92 with SMTP id d1-20020a0cf0c1000000b0056e89b99a92mr8445847qvl.0.1677017572659;
        Tue, 21 Feb 2023 14:12:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+cWTyFaUW6lHd1SJda/j8WwZf1yokHo8OQ4oqkcLZJxZgkC0T5JaGehHlVhQMcsl5N6DnZgg==
X-Received: by 2002:a0c:f0c1:0:b0:56e:89b9:9a92 with SMTP id d1-20020a0cf0c1000000b0056e89b99a92mr8445817qvl.0.1677017572339;
        Tue, 21 Feb 2023 14:12:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j64-20020a37b943000000b007422fd3009esm992940qkf.20.2023.02.21.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:12:51 -0800 (PST)
Date:   Tue, 21 Feb 2023 17:12:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y/VB4pSCoJMQQn5o@x1n>
References: <20230217085439.2826375-1-stevensd@google.com>
 <20230217085439.2826375-3-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230217085439.2826375-3-stevensd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 05:54:38PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Make sure that collapse_file respects any userfaultfds registered with
> MODE_MISSING. If userspace has any such userfaultfds registered, then
> for any page which it knows to be missing, it may expect a
> UFFD_EVENT_PAGEFAULT. This means collapse_file needs to be careful when
> collapsing a shmem range would result in replacing an empty page with a
> THP, to avoid breaking userfaultfd.
> 
> Synchronization when checking for userfaultfds in collapse_file is
> tricky because the mmap locks can't be used to prevent races with the
> registration of new userfaultfds. Instead, we provide synchronization by
> ensuring that userspace cannot observe the fact that pages are missing
> before we check for userfaultfds. Although this allows registration of a
> userfaultfd to race with collapse_file, it ensures that userspace cannot
> observe any pages transition from missing to present after such a race
> occurs. This makes such a race indistinguishable to the collapse
> occurring immediately before the userfaultfd registration.
> 
> The first step to provide this synchronization is to stop filling gaps
> during the loop iterating over the target range, since the page cache
> lock can be dropped during that loop. The second step is to fill the
> gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> time, to avoid races with accesses to the page cache that only take the
> RCU read lock.
> 
> The fact that we don't fill holes during the initial iteration means
> that collapse_file now has to handle faults occurring during the
> collapse. This is done by re-validating the number of missing pages
> after acquiring the page cache lock for the final time.
> 
> This fix is targeted at khugepaged, but the change also applies to
> MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> return EBUSY if there are any missing pages (instead of succeeding on
> shmem and returning EINVAL on anonymous memory). There is also now a
> window during MADV_COLLAPSE where a fault on a missing page will cause
> the syscall to fail with EAGAIN.
> 
> The fact that intermediate page cache state can no longer be observed
> before the rollback of a failed collapse is also technically a
> userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> is exceedingly unlikely that anything relies on being able to observe
> that transient state.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>

It'll be great to have another eye looking, but... AFAICT this works for
us.  Thanks David, this is better than what I suggested.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

