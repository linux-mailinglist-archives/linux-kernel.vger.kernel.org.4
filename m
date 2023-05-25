Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA427118E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjEYVQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEYVQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:16:48 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35797194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:16:47 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5621a279cbbso3128917b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685049406; x=1687641406;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9pQOGdYsjdZbdCHHypN1w7tMBLEjB+ZZ/4gmvVnzrE=;
        b=OayEOOVEDoRCfVgPBQP7q3z8x8raeYdqUtCTiEzo/KCJT2OF/mliqW4VfVw3blftBB
         YB9D0kFzVJK4jUvggsNfjY/J8TSjLPHQCEa+bsaNfsJu957213ZxBXcctz5fwMsbudlf
         B+iEIyTXHb/Z3r1gdJGtM09lzyZFhu7QkO3GpWcMlW3KPGuHRrYGWKQP5LuS5IFzltat
         V8+Jc+THw7D+s8FCtrXddxKOOyuh8vmN3SZh5xV6urmV0BmGCVh99kdyy0QEH19dlWf0
         5Di+Uk6uMV8gTVpTwVnHaEPGFyvLyfVNq3Ik5SIpizBO6wgKeIycuyYeqbcxXOKCGXNG
         lrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685049406; x=1687641406;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9pQOGdYsjdZbdCHHypN1w7tMBLEjB+ZZ/4gmvVnzrE=;
        b=MB6ei9LCAvV5EKGQY+Rm3z4t8dz/0Zp3vS/4buvnefogcnJTbVv8mHk9ol4FNSXoGP
         Cq9t1kUbAIisFnvWhXHjg38J/uhMlJT5luQFOlow86vM3N+ZKNwDPKpWa5qpvsdJstK0
         CpYk9wBZKEwlZ0RdmeU/Ua5QnG2ADTVIa1Bfzzxyq47DMmJEdpm6gW+g//H2nEYk2DHn
         RnANWTvyLE45/a/KmDOrzoT4GLjfLqthePLlZVA1YaX+4L6FGIL7GUV7seIx6YTqwmOP
         GoRMBz2eE7oga4bz6VIU9W4mo11jjUI+T4yhLU69ZHpJ8JtipvsfFppCsNUWKePAG1kI
         JK8w==
X-Gm-Message-State: AC+VfDyDXlvSLV7uQA7vsPtksiYV2eX0kmed+nlM2kyjR0RSTy6lZLOb
        Rxt6g8tLr2ULW05ZQ3pjRfANPg==
X-Google-Smtp-Source: ACHHUZ7lPieMWiIbLy5ZAvMbt8Ai9mzflKlXhdst9cXNlI6EwObACsnmib2ZBLhQn0ABNPnTuOhCSw==
X-Received: by 2002:a81:f207:0:b0:55a:776e:95f3 with SMTP id i7-20020a81f207000000b0055a776e95f3mr206336ywm.25.1685049406300;
        Thu, 25 May 2023 14:16:46 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z141-20020a0dd793000000b0054c0a8ceb2fsm674804ywd.28.2023.05.25.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:16:45 -0700 (PDT)
Date:   Thu, 25 May 2023 14:16:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
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
Subject: Re: [PATCH 25/31] mm/gup: remove FOLL_SPLIT_PMD use of
 pmd_trans_unstable()
In-Reply-To: <CAHbLzkrkGx-+OVLexWAx0THeOsD1C1DHt2VjgnkYJe-MqeW3Zw@mail.gmail.com>
Message-ID: <7538c751-9bee-75f9-50a5-1bc12f919e8e@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com> <CAHbLzkpdWqLM1+Jb+rzVjxGyRBUtJFU_2O7=7PtE0dNgsvXSrQ@mail.gmail.com> <CAHbLzkpOs4fz5NuAzQDdMRQYDLn6HzR1CHQoU5OYZyPW1GQmHg@mail.gmail.com>
 <3d548f45-9ff9-d73a-83e0-bdd312f524@google.com> <CAHbLzkrkGx-+OVLexWAx0THeOsD1C1DHt2VjgnkYJe-MqeW3Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1817524506-1685049405=:5227"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1817524506-1685049405=:5227
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 24 May 2023, Yang Shi wrote:
> On Tue, May 23, 2023 at 9:26=E2=80=AFPM Hugh Dickins <hughd@google.com> w=
rote:
> > On Mon, 22 May 2023, Yang Shi wrote:
> >
> > > For other unstable cases, it will return -ENOMEM instead of -EBUSY.
> >
> > I don't think so: the possibly-failing __pte_alloc() only gets called
> > in the pmd_none() case.
>=20
> I mean what if pmd is not none for huge zero page. If it is not
> pmd_none pte_alloc() just returns 0,

Yes, I agree with you on that.

> then returns -ENOMEM instead of -EBUSY.

But disagree with you on that.

=09=09return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
=09=09=09follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);

Doesn't that say that if pte_alloc() returns 0, then follow_page_mask()
will call follow_page_pte() and return whatever that returns?

> Or it is impossible that pmd end up being pmd_huge_trans or
> !pmd_present? It should be very unlikely, for example, migration does
> skip huge zero page, but I'm not sure whether there is any corner case
> that I missed.

I'm assuming both are possible there (but not asserting that they are).

Hugh
---1463760895-1817524506-1685049405=:5227--
