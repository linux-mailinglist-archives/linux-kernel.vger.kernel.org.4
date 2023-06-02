Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0035571F86F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjFBCbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBCbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:31:17 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F2180
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:31:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bacf5b89da7so1640620276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685673076; x=1688265076;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SF8Aly25fzS1LbEgHf3gEAMX1PFPP+yipG6c4kJY9FQ=;
        b=Rk5FbB+oAsrW8gZLb52SCCgKNsAmEqKYhOWM8mNovBu8VmM2uqP80AqT4JPjGmAkeF
         VCtjMjWEtncedQVl2suK2B9fG0YSu8ZDA/tlOrxLqonUjBDQrJOxs3lbfBBI/7Sfd52T
         F79+e4SbJdZWyOrach4YIr3gP3pRI1VMsJQiaCKv9seUQXwDdTbO8u52AhRq3Z9QMf95
         kPtCWY4hlVNHWYQvyoIEOMRbI+1a3QdcLlXwIu/X6EycrGuwLME9rtPwCQwbUpoqvelY
         438yqErUCjUNHPjps7KhCyOa0fzNX7M1hAaywgxQzZmew+OtFGVSCWpsqVFUU1qJ+4gm
         4+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685673076; x=1688265076;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SF8Aly25fzS1LbEgHf3gEAMX1PFPP+yipG6c4kJY9FQ=;
        b=VOSNaq6g/gAsC3wnF1fEZ8X0R6ZIHwYjnYMg+BOHSy1z7cEM6ZABvU1xcqWTsoe6n/
         vPL5Rhg4t5cR3xD85uejHD6UD7z+Jh6r+QlmaZDgVKObnT0BZEtdh/nOJDwj3VRoL2Dq
         QgQwp26mN/aHihl46upSCcDYk+RsHS1T7oPH/AThs1voJPHwyTNcHeurzzyE4/3awyMz
         +37uWpWKGDDHebKvLn4nA1HXnfa8c3AF3e50gwTugaZyNUkE9fz4AILnkNjsVnNtkEoy
         jJ5KzNa/eNzonWputSFDFwK8uuHY008ijOEdc+049MDJsDjWGOgIMnf64AeWNLEYz4Lv
         66LA==
X-Gm-Message-State: AC+VfDydpYx87BECmD/35XjUd/RjHljG7zyhq7sOKN1lYnjyXDG58p01
        QJtt2DbLHZ7zUTXZSE3LhceuGg==
X-Google-Smtp-Source: ACHHUZ4cgTUzJ+I9GJTslrfb2kQp5ZIcpj6rwg2qfGWXxU6xTSlqIS15v9Ch7w6GF0mPj/rbe8cH6g==
X-Received: by 2002:a81:6c48:0:b0:559:e954:edf8 with SMTP id h69-20020a816c48000000b00559e954edf8mr11588651ywc.6.1685673075667;
        Thu, 01 Jun 2023 19:31:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l190-20020a0de2c7000000b0055a7ff0a5cdsm54005ywe.27.2023.06.01.19.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:31:15 -0700 (PDT)
Date:   Thu, 1 Jun 2023 19:31:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
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
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
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
Subject: Re: [PATCH 01/31] mm: use pmdp_get_lockless() without surplus
 barrier()
In-Reply-To: <ZHDi8q6N9BPElAMH@x1n>
Message-ID: <e4d03b98-c83-96a6-2e6e-b9b9f5e18c@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <34467cca-58b6-3e64-1ee7-e3dc43257a@google.com> <ZG6PwAvIO4Z7lpkq@x1n> <427ea01f-345a-6086-d145-fe573894dbe@google.com> <ZHDi8q6N9BPElAMH@x1n>
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

On Fri, 26 May 2023, Peter Xu wrote:
> 
> The other confusing thing on this _lockless trick on PAE is, I think it
> _might_ go wrong with devmap..
> 
> The problem is here we assumed even if high & low may not match, we still
> can rely on most pte/pmd checks are done only on low bits (except _none()
> check) to guarantee at least the checks are still atomic on low bits.
> 
> But it seems to me it's not true anymore if with pmd_trans_huge() after
> devmap introduced, e.g.:

I agree that there would likely be a problem for p??_devmap() on 32-bit
PAE: but (I hope I followed the chain correctly!) I had earlier found
that pmd_devmap() can only return true when CONFIG_ZONE_DEVICE=y, and
config ZONE_DEVICE depends on ARCH_HAS_PTE_DEVMAP, and ARCH_HAS_PTE_DEVMAP
is only selected (in some cases) by arm64, powerpc if PPC_BOOK3S_64, and
x86 if X86_64.

So I stopped worrying about devmap.

Hugh
