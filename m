Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53670EB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjEXB5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEXB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:57:23 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F98130
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:57:22 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-562191bcfb9so3872397b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684893441; x=1687485441;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0tshfF7VbkB3ahpyG7j9+uSF5/xmyUxNJpS8HDSR6c=;
        b=nmhTg7sdGevKSn3w9kE12d2P3CP7b9UiGfoMMR/+Y0y6b0wbVHGrG26hVbXCs3d7HX
         qFb0dxId9p2cI8+fL/S8EjJhcbn7lA39do5yljFCYSveMEIOUmYELDjW9wtaiXClKwM9
         B+pF7IoAQrTNexDIgtnV3yfScMywq9BJftsOjdrlWXkz9YzUwS848Vu8/D+vjTZa5HWh
         PWQDtf1EGZyA5p9yViC7yHfAylqrKXOgwsgQK/zjUPY2UqTti8iJSu3TLEJdyO1niNAG
         jn0SKqzTEBKg5wjGDls0FwQG6uXRSO5kfS7Uak+ZR6l8yn84qkhn4c04vhj5ZfgomU0O
         H7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684893441; x=1687485441;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0tshfF7VbkB3ahpyG7j9+uSF5/xmyUxNJpS8HDSR6c=;
        b=Goxd7tS7A9H7rK3esBmrpvmW5hq1DKPfMItXKPtgKZ16XI17IYG+mGGYWzCkcy1zW9
         4h30SFkkAXcyY10wGYBsogZA4tIlvRxkrNnPOPq/bF2RPwvZTyrNEvJtHTQggv7OU8Fw
         4M8SFGJxoSStYo8irqqnC12gdxLbHhMNRXnnR929oViQMO02j5XLtaI8/WBDhI2vf5DL
         7jlxDRrxbtnyM7AxVjsdvpeJte6M5bDu+alvsgZDPOLKXMfCYJlXTMPk5HxN9/dEWara
         dGHKvw7Th4gTnltnL658i4GPC5iT/4ewpDHrlx/CHg0yTWYcLRP8b3xA6rj6aE4Q5CIO
         kL4Q==
X-Gm-Message-State: AC+VfDykrVjcCF8PH6xfTcBIrIDdwzGtEiTi9DuLhscHgy1vAmIsz4q5
        8h7YGdQCQg1HtytXqsh3Caa1jQ==
X-Google-Smtp-Source: ACHHUZ5hwSzTNlGTHTlYTyfOqKrgBIkCHhpg4UIiTToJbDusA1qw++7BzNQhm/L3M56AFQhfKnYalw==
X-Received: by 2002:a81:5289:0:b0:561:e7bb:1b24 with SMTP id g131-20020a815289000000b00561e7bb1b24mr16022359ywb.6.1684893441203;
        Tue, 23 May 2023 18:57:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d206-20020a814fd7000000b0054605c23114sm3346760ywb.66.2023.05.23.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 18:57:20 -0700 (PDT)
Date:   Tue, 23 May 2023 18:57:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alistair Popple <apopple@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/31] mm/migrate: remove cruft from
 migration_entry_wait()s
In-Reply-To: <87bkib95uj.fsf@nvidia.com>
Message-ID: <8bc94098-8a57-b62f-a26c-7c73bf945b41@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <1659568-468a-6d36-c26-6a52a335ab59@google.com> <87bkib95uj.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Alistair Popple wrote:
> 
> Hugh Dickins <hughd@google.com> writes:
> 
> > migration_entry_wait_on_locked() does not need to take a mapped pte
> > pointer, its callers can do the unmap first.  Annotate it with
> > __releases(ptl) to reduce sparse warnings.
> 
> Thanks Hugh, I debated doing something similar when I reworked this to
> not take a pageref. However I was unsure if the pte unmap/unlock
> ordering mattered as this reverses the order of operations (from unlock
> then unmap to unmap then unlock).
> 
> I never found any reason why that would be a problem though so please
> add:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks Alistair.  Right, the ordering doesn't matter: you might briefly
think that because I'm going to put the rcu_read_unlock() into the
pte_unmap(), that there's something wrong with doing that early; but
you'd quickly realize that holding on to the spinlock is good enough.

Hugh
