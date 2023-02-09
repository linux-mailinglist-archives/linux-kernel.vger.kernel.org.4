Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B364C691152
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBIT1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94810D2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675970805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x9cE6e+W76LeERGPHwI+bdvwZC6nPSTrvaIuldAklW4=;
        b=TSnVYYYBqJsJJs7GqCO/jEG5PNrtTfYqUNtcVydn9pmNae0xN3Y4oU6Z7j6WRwF1TYWHqn
        2ApylfXCOFCGWSebPPpsb51VpmxZj2XHN1Bb1m2K6cx3TRPoIe28JZ1RmLQbesU1aT3xuV
        sJvmSmg3QZ0zBtS6cLlxu1eGa3qWf9M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-Y6loDvJ1NPamADOHg6GrzA-1; Thu, 09 Feb 2023 14:26:44 -0500
X-MC-Unique: Y6loDvJ1NPamADOHg6GrzA-1
Received: by mail-qt1-f198.google.com with SMTP id a24-20020ac87218000000b003bb7c7a82f7so1678703qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9cE6e+W76LeERGPHwI+bdvwZC6nPSTrvaIuldAklW4=;
        b=3omy+9MBQ61afaOC+OdEg+i7kaaYtnly2ffaPxSX/p03nqtOMZL5DGU5/o0RN991T6
         /eXZSc68WRqPQqcP+/BHOg6mOmb+mt1BUO9FzHsHZn5eovCTRjQbEkQI9arwQ4uz6HWa
         5hOlKTzR7w/55h75lnB2I6f6iq+HyQq0p0dOxZs406lnahuFCiQlAHAaRTbnMDtZWCXH
         F8uMmHFCWospBMfRtei4n7Q7Mc0lVYSQ1f35yUqpGr45afK+bTA46FDJ6jFw2VTj7rhR
         fJsTpoxYKyDPqYqaKt+0/T2J4bBT052Ffu5KDW79EWutETfPBmtWBJZDHZ57MOYwxae8
         3xQg==
X-Gm-Message-State: AO0yUKWMWAN8f5twtiE1G1g8B6nEmxUWb7ptgVZ7UR/0vbm3t/OGGu/c
        HPULH6WWq0I7s8a1deH8Lc3U493FZfsEPtxzYIjAXFnipYqaXKg1GNE88Ug3Kw+xkXmEcBVouo0
        l3HflpjqULgdjTIf4YoofUkyb
X-Received: by 2002:a0c:f54e:0:b0:56c:2082:743d with SMTP id p14-20020a0cf54e000000b0056c2082743dmr9228461qvm.5.1675970803829;
        Thu, 09 Feb 2023 11:26:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/Cz68ujEJJEwIYk1OtfltUrAU4LXBdHLuQ9itehZm0vTs8jvdCbtuAw+h5up7Jog7JfvKeyQ==
X-Received: by 2002:a0c:f54e:0:b0:56c:2082:743d with SMTP id p14-20020a0cf54e000000b0056c2082743dmr9228433qvm.5.1675970803495;
        Thu, 09 Feb 2023 11:26:43 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id t66-20020a374645000000b007203bbbbb31sm1994600qka.47.2023.02.09.11.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:26:42 -0800 (PST)
Date:   Thu, 9 Feb 2023 14:26:40 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 5/6] mm/pagemap: add documentation of PAGEMAP_SCAN
 IOCTL
Message-ID: <Y+VI8HfM1k3uPA5t@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-6-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202112915.867409-6-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:29:14PM +0500, Muhammad Usama Anjum wrote:
> Add some explanation and method to use write-protection and written-to
> on memory range.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  Documentation/admin-guide/mm/pagemap.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index 6e2e416af783..1cb2189e9a0d 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -230,3 +230,27 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
>  always 12 at most architectures). Since Linux 3.11 their meaning changes
>  after first clear of soft-dirty bits. Since Linux 4.2 they are used for
>  flags unconditionally.
> +
> +Pagemap Scan IOCTL
> +==================
> +
> +The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get and/or clear
> +the info about page table entries. The following operations are supported in
> +this IOCTL:
> +- Get the information if the pages have been written-to (``PAGE_IS_WRITTEN``),
> +  file mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``) or swapped
> +  (``PAGE_IS_SWAPPED``).
> +- Write-protect the pages (``PAGEMAP_WP_ENGAGE``) to start finding which
> +  pages have been written-to.
> +- Find pages which have been written-to and write protect the pages
> +  (atomic ``PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE``)

Could we extend this section a bit more?  Some points for reference:

  - The new struct you introduced, definitions of each of the fields, and
    generic use cases for each of the field/ops.

  - It'll be nice to list the OPs the new interface supports (GET,
    WP_ENGAGE, GET+WP_ENGAGE).

  - When should people use this rather than the old pagemap interface?
    What's the major problems to solve / what's the major difference?
    (Maybe nice to reference the Windows API too here)

> +
> +To get information about which pages have been written-to and/or write protect
> +the pages, following must be performed first in order:
> + 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
> + 2. The ``UFFD_FEATURE_WP_ASYNC`` feature is set by ``UFFDIO_API`` IOCTL.
> + 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
> +    through ``UFFDIO_REGISTER`` IOCTL.
> +Then the any part of the registered memory or the whole memory region can be
> +write protected using the ``UFFDIO_WRITEPROTECT`` IOCTL or ``PAGEMAP_SCAN``
> +IOCTL.

This part looks good.

Thanks,

-- 
Peter Xu

