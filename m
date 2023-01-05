Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B847965F475
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjAETaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjAET3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:29:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD056DF0B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672946574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADW1K4PuhFmDUthAnWNZLxX9smSORrKhgThxl96aaHM=;
        b=RVQ8BzL8WFiVfQvdJzNF118wu9XzSD8DtgzNzzMSH6MGeexwSjCVkDwnKEayiA3LurQ45q
        oP2JUw2dotvO3B2StrvsEJnI+jE9Nt/ED3PXN6kSBJtuGNBlXqwQVSRyQ6QWoqb5I42/Ag
        59jJ7dSqxdA+PNlT0AMcCwHkBtFKXF0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-TQiLpZ97Mz63R68oqcD32Q-1; Thu, 05 Jan 2023 14:22:53 -0500
X-MC-Unique: TQiLpZ97Mz63R68oqcD32Q-1
Received: by mail-qk1-f199.google.com with SMTP id f13-20020a05620a408d00b006fc740f837eso25936617qko.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADW1K4PuhFmDUthAnWNZLxX9smSORrKhgThxl96aaHM=;
        b=BTUaNHOinhdjIB66SChKf0vUEEZ0GGjBebhzgVnd/yOsfBfoEr4LiueofD7BnpJUBW
         5sK4DUUJL373GaPUOIlvzIjJNf0I6tlq17fgDDnQRGhmJ2WcW5ra/aBcPpnp/t2SLt+r
         sHeef1C4ATLxyJLRsnPdD4bsGBmpAy5WLGcM6+I9ttDug3+C/kpo5Q8+ZH2MI5T8iHTS
         m0bHT+18HwEyPzST6MaiAC+4Coci8t6zmDTy51eeoJSsNASUNZ53ln2271DpK9WU0Hjx
         wm5BGixeddlOy+O2vSpMhkpjv4GjNJ2P2bvPn0I9vUiTJqQN5OJ4f4SFJFwr4/H8OyTJ
         RvOw==
X-Gm-Message-State: AFqh2koIl7yCLJE/x9YXDW+E0VNqyAK9vI1t1jPpR4uM79UVI6M6KMaK
        T3AeebzrHVMJgdbJunofTFUrAUiTnOcSZkefyo6cogWPnSPH0cye9hYps4E/oRS5I+guXklz02R
        eHrYeAoapcWJi62sKQgpA6yFN
X-Received: by 2002:ac8:7c81:0:b0:3a8:11d6:2d0d with SMTP id y1-20020ac87c81000000b003a811d62d0dmr72093652qtv.43.1672946572436;
        Thu, 05 Jan 2023 11:22:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsM2kmIU2DF0AgxYxehxHQzuVMOGJNoeeqcpmHVgrPJwS2pHkY2LK4czHY0M2F7U0Ty7ZCcaw==
X-Received: by 2002:ac8:7c81:0:b0:3a8:11d6:2d0d with SMTP id y1-20020ac87c81000000b003a811d62d0dmr72093634qtv.43.1672946572234;
        Thu, 05 Jan 2023 11:22:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id n23-20020ac86757000000b003a826e25bc4sm21893373qtp.64.2023.01.05.11.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 11:22:51 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:22:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/mprotect: Use long for page accountings and retval
Message-ID: <Y7cjir3+MpT8XqJT@x1n>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-3-peterx@redhat.com>
 <aabd4bb8-560b-10b0-9837-b656e1a0a9e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aabd4bb8-560b-10b0-9837-b656e1a0a9e1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:44:16AM +0100, David Hildenbrand wrote:
> I'm wondering if we should just return the number of changed pages via a
> separate pointer and later using an int for returning errors -- when
> touching this interface already.
> 
> Only who's actually interested in the number of pages would pass a pointer
> to an unsigned long (NUMA).
> 
> And code that expects that there never ever are failures (mprotect, NUMA)
> could simply check for WARN_ON_ONCE(ret).
> 
> I assume you evaluated that option as well, what was your conclusion?

Since a single long can cover both things as retval, it's better to keep it
simple?  Thanks,

-- 
Peter Xu

