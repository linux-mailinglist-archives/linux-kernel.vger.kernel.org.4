Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03737611E15
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ1XZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1XZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C11114D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666999468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRyNGp9vBF4GSRr09z30VvDe1naMezW0SypBh95qjuw=;
        b=cF8qylGnTTjOKG8iRmv8ZopDux5cJfOdhJyCDpvZuemjbRn7GZACpkbCwzUeRhcRrNlR5Q
        S8QMCQhiX04CLDqLev1lZYxOJbpXkdkv6NhHVvYm+uZHwLNxRamYheeuy1+bJaYyRbCv/U
        8JMFpLmnqKQuRoLggjK4FEHa04tf3Dw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-izWfKLZpNXeW91PiQm61JQ-1; Fri, 28 Oct 2022 19:24:21 -0400
X-MC-Unique: izWfKLZpNXeW91PiQm61JQ-1
Received: by mail-qv1-f70.google.com with SMTP id x2-20020a0cff22000000b004bb07bf7557so3695896qvt.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRyNGp9vBF4GSRr09z30VvDe1naMezW0SypBh95qjuw=;
        b=nSOI2qaXwlLCR+dmSePcNLoGA+wo/gP9BnmDCeCdsBuZHYFzhTgm7HzfekOVW1b/wv
         PBcw/wxSw/CMuZK0kIrVrNja+SYPO1uq67OZ2m0TzNL95m+r6KzKr5edeWu5hRmC4t8v
         MfB8SMHwXfJ0WN/ahE7ozHFrvokS8MFxmXw1DZCr7kyuwfhPvJGvZxjCP5o0Z9d/MVkw
         TLZO2kntGL9hdqT6+TyqJzqZvI+gVbJjVZD8a9X5/DpIajTA1hFyFNejG1LVTxFdjpya
         w3m03cAjmdxjyui6XOq2jLIFZDCLFM8RMt/h/z923G/haBhIyiIqwpbLSCrA55xwJyYT
         AZXg==
X-Gm-Message-State: ACrzQf0RleRa8seEhvqJjKMEIvMT4r5fUtdmgsnMla5U7RBaKBLAy92G
        53CF3TkWj1FThPNjbaectD6bwNWKgqCf7KhpgLzpwICkdGDASrjMfY4GuKAR7UqhII2FkYtbEFT
        Hyu/Q95+XX9MUuMhNXP5oatOl
X-Received: by 2002:ad4:4ea2:0:b0:4b7:e8a3:e043 with SMTP id ed2-20020ad44ea2000000b004b7e8a3e043mr1727882qvb.34.1666999460665;
        Fri, 28 Oct 2022 16:24:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5O9D8mCa0VSNsJWqYFF4hzhXh38xZVkwpvXIFKcJlS4quyWCJ+vSPpcEiNhIciaQuZzCKa1g==
X-Received: by 2002:ad4:4ea2:0:b0:4b7:e8a3:e043 with SMTP id ed2-20020ad44ea2000000b004b7e8a3e043mr1727871qvb.34.1666999460480;
        Fri, 28 Oct 2022 16:24:20 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a240900b006b8e8c657ccsm3976351qkn.117.2022.10.28.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:24:19 -0700 (PDT)
Date:   Fri, 28 Oct 2022 19:24:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Y1xkonJ2DkQQbAaT@x1n>
References: <20221028181108.119432-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028181108.119432-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:11:08AM -0700, Mike Kravetz wrote:
> v4 -    Remove vma (pmd sharing) locking as this can be called with
> 	FOLL_NOWAIT. Peter

Thanks, Mike.  For the gup safety on pmd unshare, I'll prepare a few small
patches and post hopefully early next week (will be off-work on Mon & Tue,
but maybe I'll still try).

-- 
Peter Xu

