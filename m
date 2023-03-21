Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709E6C3A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCUT0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B818168
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679426731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85m7idf7+4iCJskalXeMQ1A6vtydsiefpfGzk6u9aGk=;
        b=Pz1UiyaKRNzSVCFGehzWkD8GveHgtAPF+bHhZCMMIh1N5j+U4wpPlJt2/XL1sX6eTZlz2G
        C7J3nEsiAV7djWxoYGpHhVWz7SrMERcTAfCUR+flRNA9dAqNZn3tRZ5cckEuL3kjL0KEDY
        8qJ4BfsqjdvoYO5hiv9xnd/Hz8hNVtI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-AL7MW4jDNdKdOP8NmxHLdg-1; Tue, 21 Mar 2023 15:25:29 -0400
X-MC-Unique: AL7MW4jDNdKdOP8NmxHLdg-1
Received: by mail-qk1-f200.google.com with SMTP id x80-20020a376353000000b0074681bc7f42so3522883qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85m7idf7+4iCJskalXeMQ1A6vtydsiefpfGzk6u9aGk=;
        b=akYOsQQOH3rfUd8fCC5/nZOc/1J9iSXI5If+K3u9rNir/IjMp+dN7QJ2zCLrSk2uOG
         bJfa1PyyoK4Q8aYzlOJVazv1HZ3TqGBPi38qdKy8/az+qRRujXeMdyFnExXvikXNoa8W
         azfbntTmLUOFfF35xzEr8hyw6M5uwwqLNk8YJ/iM8mQ1ifUL27sKInIotnmaaep49KQ8
         jAbnNNZBUH9y8VDRbIkadvWvIQrpu1RXXVFllxZngB9VDoiP2zJkbxYtKsc4Pjm8VXfK
         jxJ7JRLXObEYiXaDCfAjH79N+ZgRUBqOc/kQnDl1YgLKJd7To3qE6DuKNS652034enrO
         TlgA==
X-Gm-Message-State: AO0yUKU6XL8Np9lbqtydXAlcZ2bBy+Ey6bmgO5i3MEJcXDuCMPW1gpO7
        in/9d4xqyykIcqEde4qye1XyKLPYyv6Uyy8yvoDFnOADMjwjy1TURkEpKNpxnpG8U0qeqTEP5fc
        YeW37j69UghPBW6OlMZDKjYz0
X-Received: by 2002:a05:622a:1ba6:b0:3c0:40c3:b8fd with SMTP id bp38-20020a05622a1ba600b003c040c3b8fdmr6057132qtb.6.1679426729258;
        Tue, 21 Mar 2023 12:25:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set+9iqNdU6v9wQzdMs3AczgBSXHN3PRvEEclpNBfmVrHlftA95NuuUy9gB8wfKiTRndykR9lzQ==
X-Received: by 2002:a05:622a:1ba6:b0:3c0:40c3:b8fd with SMTP id bp38-20020a05622a1ba600b003c040c3b8fdmr6057082qtb.6.1679426728928;
        Tue, 21 Mar 2023 12:25:28 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 77-20020a370650000000b007458c5a807csm9774944qkg.83.2023.03.21.12.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:25:28 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:25:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 1/7] userfaultfd: Add UFFD WP Async support
Message-ID: <ZBoEpkq66ZxHFr8A@x1n>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-2-usama.anjum@collabora.com>
 <ZBNr4nohj/Tw4Zhw@x1n>
 <1b78ee32-003d-5645-c223-619b66d41733@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b78ee32-003d-5645-c223-619b66d41733@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Muhammad,

On Tue, Mar 21, 2023 at 05:21:15PM +0500, Muhammad Usama Anjum wrote:
> Thank you so much for the patch. I've tested hugetlb mem. This patch is
> working fine for hugetlb shmem:
> *shmid = shmget(2, size, SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
> mem = shmat(*shmid, 0, 0);
> 
> I've found slight issue with hugetlb mem which has been mmaped:
> mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
> 	   MAP_ANONYMOUS | MAP_HUGETLB | MAP_PRIVATE, -1, 0);
> The issue is that even after witting to this memory, the wp flag is still
> present there and memory doesn't appear to be dirty when it should have
> been dirty. The temporary fix is to write to memory and write protect the
> memory one extra time.

I looked into this today and found it's an existing bug that can trigger
with sync mode too.. as long as protection applied to unpopulated hugetlb
private mappings, then write to it.

I've sent a fix for it here and have you copied:

https://lore.kernel.org/linux-mm/20230321191840.1897940-1-peterx@redhat.com/T/#u

Please have a look and see whether it also fixes your issue.

PS: recently I added a warning in commit c2da319c2e2789 and that can indeed
capture this one when verifying using pagemap.  I'd guess your dmesg should
also contain something dumped.

Thanks,

-- 
Peter Xu

