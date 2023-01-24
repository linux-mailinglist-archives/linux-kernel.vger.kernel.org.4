Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E367A031
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjAXRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjAXRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D24670B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674581437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFq/mNBnI/BqcjC2peFCYxWVr3CPoW0svWlbdoxg4JQ=;
        b=hygyXt+OjGOzwDveKGXiV9lFOqImcwgi2utsYpJhlTdq9ezUjtySfYepQy5EpTTSG4vibB
        GI1JLbe0s2meyCeBZakDLbgVtnc6cT5M+grQ/TqQ+xIwsWL2FBv9KCEC+8nYZeAClvr1bT
        FPplrkDYGwmaKkjh85qcOTPW8/vtyG8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-599-O5F0WwH6N-KDGXWTc0hH4Q-1; Tue, 24 Jan 2023 12:30:36 -0500
X-MC-Unique: O5F0WwH6N-KDGXWTc0hH4Q-1
Received: by mail-vs1-f71.google.com with SMTP id e23-20020a056102225700b003dcd3cab619so2346263vsb.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFq/mNBnI/BqcjC2peFCYxWVr3CPoW0svWlbdoxg4JQ=;
        b=WW95zP7GY5wqCcp8V3v7BtCT9B2zyOptwSqqhWJxLgMGt/R8+jmmI5g0KAord0LA+4
         PDqH73TMHQ3gjcNrRpLCQHsv4cfSleQOcAlXOX/mj6fbNQPAmHKWMRDcm/ZgegtoKRW1
         xAF+hPxN7SQJrMtBUL9m7Zi6bfe2cDkLxBGLZdOSxvywpYoVymRMa+fjML5E20Z/KPhy
         9ZP8yppxC+I0xsSDE9RKHoHM7Ez5fIbwVujAWipSz/keh5lMtJ2VE8FXOZD9RlIuVsMy
         N2QuTXSyo8fLkN0hM45EI8tbfLex3vjOmrVERJ74AraaItTVsWsJoPrfy/vuWIazvB+K
         1C4w==
X-Gm-Message-State: AFqh2kpxvU49/8CRNBsB+k5UbJZ5hxrHGwLcBWG2lsRGAigw6GMFlfK+
        5WiKXjQJhUc4clxLP3xLpsWBj6SHjgpsNXmqFiXu6IgC3Esr3sSyysVh/0oUmJCZrp0V4SBvmvL
        4JYzxy2u7eSYuJowRvJ4UTOZ2
X-Received: by 2002:a05:6102:3d86:b0:3b1:4999:1729 with SMTP id h6-20020a0561023d8600b003b149991729mr18463159vsv.32.1674581435821;
        Tue, 24 Jan 2023 09:30:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsyS/lviwCEpx4hKAW3VXvWWIWezeP2/jZ5CCZZkaNf6ca5wcGThV91c0/XonyDxlB64+l5aw==
X-Received: by 2002:a05:6102:3d86:b0:3b1:4999:1729 with SMTP id h6-20020a0561023d8600b003b149991729mr18463141vsv.32.1674581435542;
        Tue, 24 Jan 2023 09:30:35 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id s133-20020a37a98b000000b00706afbdeb01sm1799074qke.8.2023.01.24.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:30:34 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:30:32 -0500
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
Subject: Re: [PATCH v7 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y9AVuF63y9UjEYcj@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-4-usama.anjum@collabora.com>
 <Y8hyqhgx41/ET7bC@x1n>
 <31b71791-66b0-c2d8-81da-e17eff5ffbe8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31b71791-66b0-c2d8-81da-e17eff5ffbe8@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:18:13PM +0500, Muhammad Usama Anjum wrote:
> >> +	if (IS_GET_OP(p) && p->max_pages && (p->found_pages == p->max_pages))
> >> +		return -ENOSPC;
> > 
> > This is the function to test "whether the walker should walk the vma
> > specified".  This check should IIUC be meaningless because found_pages
> > doesn't boost during vma switching, while OTOH your pmd walker fn should do
> > proper check when increasing found_pages and return -ENOSPC properly when
> > the same condition met.  That should be enough, IMHO.
> This check is needed in case we want to abort the walk at once. We return
> negative value from here which aborts the walk. Returning negative value
> from pmd_entry doesn't abort the walk. So this check is needed in the
> test_walk.

Why?  What I see locally is (walk_pmd_range):

		if (ops->pmd_entry)
			err = ops->pmd_entry(pmd, addr, next, walk);
		if (err)
			break;

Thanks,

-- 
Peter Xu

