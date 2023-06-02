Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A309D72014D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjFBMPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjFBMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:15:07 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340A1A7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:15:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75b14216386so194232285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685708105; x=1688300105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fUqXWlJ7lOi6jGaXDr+3k1lI6v7YmcWJa5TzCsAfQ=;
        b=djzFovwDfDw/YWbNLlEkijaHy+/emg+qoFOhQt066k8y7eW0hTlMePfrnYmuQ/TT6l
         d70TUlIzOVtlyaZIA/kRvBZRW52TVi/fieL9Uv4tiaV3F1pWuXYr7FBQh9RfbRxnphIn
         nIOOpE05COs4CBgwbOrTscQAp+nS6Tk8Iv2UDHWeAHyeCW+fEyc3ctU7cgeLL3sBwLok
         ifN7Ap+HhdKODLWUosw9jkC+w1v/s/a6CGlG9Me6OF17ZaxzMYB4I1oIF5wWR3fHyTGr
         08q6Rpe08Gpj6mZ/RNU2DbMTQT+rS4iJPNpmpLyZGzEJB5e0jQtm57AIXlZP3QoFdL6G
         nNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685708105; x=1688300105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6fUqXWlJ7lOi6jGaXDr+3k1lI6v7YmcWJa5TzCsAfQ=;
        b=bp4LXI570VxdY2WBgXGVmG0TDhBGcxB/WuxnSKjwanDeD3MvWYUZ0ovXBKIKvvrsFX
         AiLqpOKhoLzTBdq4WqSMv3l6Zw6s3iw8FyWXFXua7YZL3L4Eo/sFhELCu89BNpFHzviG
         NuVSVuOf3U3oNOq181K4YSmGMr9uBKKX215NlkwnJqMWjmSl+3n6dJ+hGFKHb1bnfbRB
         oiHYMKHrn0BgkBKJc3suhOfPh3BNaTLiH64QZhKMjnCUeNq4F/In6ZHVD6iuzhB0D087
         V1vtAZuuTjCRRuVeN6JaG9ymMvSvxtBgXoJPDde13cCxOuyxn/CP8r/Jhj53ugS7zAjM
         g4Sw==
X-Gm-Message-State: AC+VfDxYUKnCj4cPAa2A1B51CgqaB+f3+8Bo9IVN2/MEV9gwo4kETQhE
        bbLnjBIpgtaW45HQ0B0XzH98rQ==
X-Google-Smtp-Source: ACHHUZ6mKX5TGzVXplRRXyH/OZZR/wmHkSAtgpVVJf05zVAhB435FtzWVMzs8VPH+7iFQ08B9IrtzA==
X-Received: by 2002:a05:620a:4481:b0:75b:23a0:e7cc with SMTP id x1-20020a05620a448100b0075b23a0e7ccmr17244216qkp.45.1685708104769;
        Fri, 02 Jun 2023 05:15:04 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p18-20020ae9f312000000b0075cad1e5907sm581918qkg.7.2023.06.02.05.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 05:15:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q53gM-001uE9-W9;
        Fri, 02 Jun 2023 09:15:03 -0300
Date:   Fri, 2 Jun 2023 09:15:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/12] mm/pgtable: add pte_free_defer() for pgtable as
 page
Message-ID: <ZHndRujtRhT6bhBs@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <739964d-c535-4db4-90ec-2166285b4d47@google.com>
 <ZHekpAKJ05cr/GLl@ziepe.ca>
 <a7f4722-8af2-f7be-eada-ff1e6e918da1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f4722-8af2-f7be-eada-ff1e6e918da1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:03:11PM -0700, Hugh Dickins wrote:
> > I was hoping Mathew's folio conversion would help clarify this..
> 
> I doubt that: what we have for use today is pages, however they are
> dressed up.

I mean the part where Matthew is going and splitting the types and
making it much clearer and type safe how the memory is layed out. eg
no more guessing if the arch code is overlaying something else onto
the rcu_head.

Then the hope against hope is that after doing all this we can find
enough space for everything including the rcu heads..

Jason
