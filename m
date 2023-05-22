Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E170B48B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjEVF11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVF1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:27:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4DAA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:27:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so21795e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733243; x=1687325243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUYFaqomu9xKCIIon32Rhv6GrSs1+seRAs7JgNCqEgg=;
        b=CxIsFQHwfyWbdkzEiDB/txSO5lO5sVYC/zo3XI6Xj25esFKzII8g1yoA22hibu5Q87
         6gehC/W/72gBWD0eoa+P1wNYSuhEBB4kY5IXaO4rctzM0q8bsr+6DUvX8HVFc8geHGV/
         ajJxq7ZmtbOY2jGLThnRLZ8+Mo+4G3dSDSzSqcM+5dCrzKo3WBZbcEo+3XBnhevROzam
         Cv3lXP58kCnvv0/O3viPTNxvlPRlX9w0y2BANaW1ArY4SkSAZptMKAGOb2iALTJ25P/A
         UQXSDJ/qDvDrFV9mpht10TADWK597uzu2+1Xkphk7Gku9ebuGOMI4i8oINAH3KAHuCWU
         rZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733243; x=1687325243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUYFaqomu9xKCIIon32Rhv6GrSs1+seRAs7JgNCqEgg=;
        b=WzZxFtTCetsTbSSAqdkXCuv0+SHqbU6d96VA8TtECXq3KA9caIGrlz8EpF8idvIggu
         ZpgJmHxoOC3YsCm8IMjIXyIOVfBP8I/djFJh5k7Xo78f9kTnvzlrPBIJMTQ+MV1mbP1K
         32VYE0FR5T/9Opd56L51OIiXYUip3r9rGhm6dLBRhWmWh0/VcV5wMm9AeqYXpfmc9IJf
         wU7BMlJu9XBhvphjYvtsTLdHvpgYLcIy9LAB4bbLsQ5zUvWFbLXSnQmyXDh7eFo48Kw4
         f/9uTfdFe6/5UXYpObPHTfW+dHl9lBh4QS+x2xkv64bf3FXQlopHrH4JZGv/ieywjdti
         itEg==
X-Gm-Message-State: AC+VfDwWkbgncFQSAbCOdadcjDOZzrsrR0clahDpgaz2tj9gaDNX73hg
        JxffimBZZsUiq2qiOE3xAQn5IhxyKT1L9JR4N/a47A==
X-Google-Smtp-Source: ACHHUZ7UiBcuBYwvsDB0X8S8S7MU+Y3lAiMkx4braM41bjoBrYtHeyBL0CSFnikDS9zVfC3DYqDh3Grt1MnpTaNQR4c=
X-Received: by 2002:a05:600c:4f4f:b0:3f4:2594:118a with SMTP id
 m15-20020a05600c4f4f00b003f42594118amr631680wmq.2.1684733243392; Sun, 21 May
 2023 22:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <242721-1e64-845e-226a-bf2b2dc72dd@google.com>
In-Reply-To: <242721-1e64-845e-226a-bf2b2dc72dd@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 21 May 2023 23:26:46 -0600
Message-ID: <CAOUHufYKUw3X7YyLLhEBb=nRyQBiWST_Ub9LitqGL27N6zTFyg@mail.gmail.com>
Subject: Re: [PATCH 23/31] mm/mglru: allow pte_offset_map_nolock() to fail
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
        Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, May 21, 2023 at 11:19=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> MGLRU's walk_pte_range() use the safer pte_offset_map_nolock(), rather
> than pte_lockptr(), to get the ptl for its trylock.  Just return false
> and move on to next extent if it fails, like when the trylock fails.
> Remove the VM_WARN_ON_ONCE(pmd_leaf) since that will happen, rarely.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>
