Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9F6A4D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjB0VTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjB0VTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C435A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677532710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHSRojRxVE6zC17aax0uBR9kKGNj5ie6daOM2pf7ZMM=;
        b=ISsZgOv7FRIXML+kiVaUzKGXeMONSCBGelARTDJ8rsQRR5DEiQdm1Id0DujP0OC+5zT3od
        4226WAoA4n1RGY4LnB+8EfHRk/fZiZsRxaOg40/gWsDTbywVLNmNgGeRDNxcMwbPSXAPBL
        nxT1BJ52D26GlHDEYBhOcpRANiYDu4U=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-muyHQfAEMxCUpB_zRWgGGA-1; Mon, 27 Feb 2023 16:18:29 -0500
X-MC-Unique: muyHQfAEMxCUpB_zRWgGGA-1
Received: by mail-io1-f69.google.com with SMTP id h84-20020a6bb757000000b007404263f2faso4820901iof.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHSRojRxVE6zC17aax0uBR9kKGNj5ie6daOM2pf7ZMM=;
        b=7OSHZOBb4Om9/9XBp/lFsgikQSnkdB+oKT0k/ISi/9byK1kCDqePKRbsYuTz+tusm9
         FzJLQ8TdL+YdPJRyKm/RRKqM9iE4cWBaCDHSpvMmMsA0TTvmUWsmZbR+plLkrmEIYy1E
         X9PiRTpd7jDMORYaS7McKAY6anWUGZNx9s2SsSaLtaCnczRh7WMGJBzAmssILIRAmt32
         Xa5ux5Fth0QM6xiUBFlfWmCc1H0Gitdt1MYbQHuTy1+EThAL3xpqxLjfZrNEIzAv0vgm
         Cst6xyxRyvdzd4PJYfvEbrd3xek399m2c7xG5dsweTkURl7mF1spGtWlkF55uSpQr6dL
         D1wQ==
X-Gm-Message-State: AO0yUKUkQ4u3GyRlWy6nvWXEZJadW6IJczB5/2MnRaKZVNQLCMVmHadW
        zkL+3Pb0jh4y7PQpel6xvAPnLEb1EGUrU9dXOBXIH1TSSL6CuSDDqJLFifl+1vSwgsn0QTAIgEf
        zptz0Ps3PMADhjTHsszXUY3IH
X-Received: by 2002:a05:6e02:1a0c:b0:316:ef1e:5e1f with SMTP id s12-20020a056e021a0c00b00316ef1e5e1fmr688404ild.1.1677532708512;
        Mon, 27 Feb 2023 13:18:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/84o635Z+vKrcRkh21erP0lfLznxR99YMjOmgvY/p96dgESRiSUUmj+XE/9aVJEr7p0zVQmg==
X-Received: by 2002:a05:6e02:1a0c:b0:316:ef1e:5e1f with SMTP id s12-20020a056e021a0c00b00316ef1e5e1fmr688396ild.1.1677532708247;
        Mon, 27 Feb 2023 13:18:28 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id i24-20020a02b698000000b003a484df1652sm2296207jam.55.2023.02.27.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:18:27 -0800 (PST)
Date:   Mon, 27 Feb 2023 16:18:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
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
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y/0eIUIh81jK9w2i@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
 <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
 <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 05:11:11PM +0000, Nadav Amit wrote:
> From my experience with UFFD, proper ordering of events  is crucial, although it
> is not always done well. Therefore, we should aim for improvement, not
> regression. I believe that utilizing the pagemap-based mechanism for WP'ing
> might be a step in the wrong direction. I think that it would have been better
> to emit a 'UFFD_FEATURE_WP_ASYNC' WP-log (and ordered) with UFFD #PF and
> events. The 'UFFD_FEATURE_WP_ASYNC'-log may not need to wake waiters on the
> file descriptor unless the log is full.

Yes this is an interesting question to think about..

Keeping the data in the pgtable has one good thing that it doesn't need any
complexity on maintaining the log, and no possibility of "log full".

If there's possible "log full" then the next question is whether we should
let the worker wait the monitor if the monitor is not fast enough to
collect those data.  It adds some slight dependency on the two threads, I
think it can make the tracking harder or impossible in latency sensitive
workloads.

The other thing is we can also make the log "never gonna full" by making it
a bitmap covering any registered ranges, but I don't either know whether
it'll be worth it for the effort.

Thanks,

-- 
Peter Xu

