Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9485E5F5AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJEU1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJEU1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0E8052B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665001627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irL9v4RVF7/aYmYVm2x3MQE53BoPEWEw/ly3HFpcK3M=;
        b=SnAGyJ7IvDI3UJFeV53DkIOTwsBxjqrnYMHBMCQ60fvk4B3lUka0j/4Qxt8AM+S9CpEkG2
        s1bnHSw5IWeO8LePZW5WTM42t+ueeSUspoOzgDK68KfNSACpbH9GmqcWJIDRZUUDrbo4kC
        EXaTYYKOmX90Mye5nsslHInTRw/4ASE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-yUKvU5MgM7WeA6v_tnsBvw-1; Wed, 05 Oct 2022 16:27:06 -0400
X-MC-Unique: yUKvU5MgM7WeA6v_tnsBvw-1
Received: by mail-qt1-f199.google.com with SMTP id w4-20020a05622a134400b0035cbc5ec9a2so11981944qtk.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=irL9v4RVF7/aYmYVm2x3MQE53BoPEWEw/ly3HFpcK3M=;
        b=twjm+12s+RMDyvDNCnDarSnFDAPLEKU8miN1Y6+Khi3dQ5C79404JDeLxFz4Rpxkmb
         ZtEJHdgDXJ02Qri6dlYxYOPg97Bhj1RLtxhbkcO0pUbDdVHZW7daMQMq+3KH1y+KBrV2
         nSJCDvnpD5ryw6T08CkNMYbFYQxm3NyT8oF0zisZ1FfBXiKAfV8aN9nJm/Z0nhIBy6pY
         mcnLmPCvDOpzk7qndVIrbcudnx+4yMkfqvSXRVuUqsOQ8REhIIdwgPeHxbhMiPyQBmPo
         U/DKsFm+eTJcpcFwMziOVxwvMZyOgTtI076ZS6XQ88UCqcEUWWqXQnIIcLCdeEXFb2dX
         0saA==
X-Gm-Message-State: ACrzQf01+630oGgh5vvEKsq10YHGm8FiCoBRmRMisYEbWXZwD8j0yZaT
        wQxIWrf2RJD+v3F7euT2/ADC272DzRT+uhjy1vXTOPRaiEFdXHy/NnGn2F7fvLGTWrwNk7/1yhw
        QdkxEekLrpTXOwILwmbzT+GFj
X-Received: by 2002:a05:622a:24d:b0:35d:4a77:3cf0 with SMTP id c13-20020a05622a024d00b0035d4a773cf0mr1058611qtx.28.1665001625596;
        Wed, 05 Oct 2022 13:27:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7SvsctwEXrw4dPRUCalzLH+RefoJ7FMG/zQCe6j6y45f5jAsslKsd1wQ1yesomiKMpK6FUTg==
X-Received: by 2002:a05:622a:24d:b0:35d:4a77:3cf0 with SMTP id c13-20020a05622a024d00b0035d4a773cf0mr1058603qtx.28.1665001625383;
        Wed, 05 Oct 2022 13:27:05 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i7-20020ac85c07000000b0035d420c4ba7sm16026331qti.54.2022.10.05.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:27:04 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:27:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 1/7] selftests/vm: add test to measure
 MADV_UNMERGEABLE performance
Message-ID: <Yz3ol51pE0XZM+Ah@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-2-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:25PM +0200, David Hildenbrand wrote:
> Let's add a test to measure performance of KSM breaking not triggered
> via COW, but triggered by disabling KSM on an area filled with KSM pages
> via MADV_UNMERGEABLE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

