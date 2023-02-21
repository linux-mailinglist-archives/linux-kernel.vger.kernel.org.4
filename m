Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A077269E4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjBUQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjBUQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:33:54 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E31C58F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:33:52 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id f20so935735uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676997232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5QwKbkm/iOD0eivN0JrThpRZ2kVJDMNRvNnQDn2lDA=;
        b=bLISuwzeGIS8YsfOGNVhMY7o3t/I8jG9xLtk8algVvWbUp3rqa3pSHW3El2RyqBzx8
         mzx5XDR+nbzv97GJujE0YSjGSkoUeLpBvCItgnLFo7AdALEccac+WdfHxj8iNuG45FXO
         80iupZjQuzPUN7pzHKFrizo6Q9X+Cs3TSBw4Wr9W3WuuQX5H+waoDql8MJwXdyV5bbyK
         CIsWz8J2MkN+qftTf6w9SXxP9XQexWox+oGSZd2Avfq3NzXlI9pazULMf6Krc1cVrM8k
         YvGzh4r3cClx/jLw2xBf9uXbxm5dwD75OzNSb7LRAd2sM7I3v0YnBQN5p0EkdQNN6oeB
         idLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676997232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5QwKbkm/iOD0eivN0JrThpRZ2kVJDMNRvNnQDn2lDA=;
        b=M8v9spwX5d4GaHywU1YAyW/3AryzC7B0/o02ilKv2KiGMORiDMzexahBiYXUScZeJ/
         LlhS6UsyiNJ3T0ojN64DP6h9RRSm582qrVx0viJZKdFI2M+eXTM480PEJXeYD0+dovKE
         8ET9i/zZARae1RdDM4MykwbzJqY/7dHYjff+2qM4ZDkZxoZYeBM5i2aq/XQNEBm1RKdA
         CjzJBgoXl0GAS0s5KpQkTYk2z7EihvQROaWlB8LPNNSipoZ422XFOd6Rv/T3+7CxKPyW
         R58SGGMU/AcyA5xQMmhVhe00GzvtYtmK4xqblacHHNL2sDYcyHuP24bckkAop+R/34eg
         G4Tw==
X-Gm-Message-State: AO0yUKUluH+Wmz85bmQHWQUsFUn9vW+zCmVclChSw8MZBImN91Qd8YLn
        0XF+ppMmE2dOnT8A+Jb6kWSC9hm5eGrSjeQkzSkxlQ==
X-Google-Smtp-Source: AK7set+E3SnRZ3Fn68UCuWNhXRHpJ+sjMpQ0ZiyBUMfYfhAN6dSMGYPcTe2Jov2CFDVOkG1EKEXhmFzlvD0AhbEKhuw=
X-Received: by 2002:a05:6122:71b:b0:401:72fb:a212 with SMTP id
 27-20020a056122071b00b0040172fba212mr1118157vki.27.1676997231766; Tue, 21 Feb
 2023 08:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-10-jthoughton@google.com> <CAHS8izPDXHan7bwaiLO6mfNgjVMm=LRqUcuaCJbu8Wb_NN7kTw@mail.gmail.com>
In-Reply-To: <CAHS8izPDXHan7bwaiLO6mfNgjVMm=LRqUcuaCJbu8Wb_NN7kTw@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 21 Feb 2023 08:33:15 -0800
Message-ID: <CADrL8HXCopaYXZz_PO-6k4xnER+fAUjiNBu2=qp6NUyN1XeDBg@mail.gmail.com>
Subject: Re: [PATCH v2 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 5:58 PM Mina Almasry <almasrymina@google.com> wrote=
:
>
> On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google=
.com> wrote:
> >
> > Issuing ioctl(MADV_SPLIT) on a HugeTLB address range will enable
> > HugeTLB HGM. MADV_SPLIT was chosen for the name so that this API can be
> > applied to non-HugeTLB memory in the future, if such an application is
> > to arise.
> >
> > MADV_SPLIT provides several API changes for some syscalls on HugeTLB
> > address ranges:
> > 1. UFFDIO_CONTINUE is allowed for MAP_SHARED VMAs at PAGE_SIZE
> >    alignment.
> > 2. read()ing a page fault event from a userfaultfd will yield a
> >    PAGE_SIZE-rounded address, instead of a huge-page-size-rounded
> >    address (unless UFFD_FEATURE_EXACT_ADDRESS is used).
> >
> > There is no way to disable the API changes that come with issuing
> > MADV_SPLIT. MADV_COLLAPSE can be used to collapse high-granularity page
> > table mappings that come from the extended functionality that comes wit=
h
> > using MADV_SPLIT.
> >
>
> So is a hugetlb page or VMA that has been MADV_SPLIT + MADV_COLLAPSE
> distinct from a hugetlb page or vma that has not been? I thought
> COLLAPSE would reverse the effects on SPLIT completely.

Right now, MADV_COLLAPSE does *not* completely undo the effects of an
MADV_SPLIT. The API changes that come from MADV_SPLIT aren't undone
with an MADV_COLLAPSE.

>
> > For post-copy live migration, the expected use-case is:
> > 1. mmap(MAP_SHARED, some_fd) primary mapping
> > 2. mmap(MAP_SHARED, some_fd) alias mapping
> > 3. MADV_SPLIT the primary mapping
> > 4. UFFDIO_REGISTER/etc. the primary mapping
> > 5. Copy memory contents into alias mapping and UFFDIO_CONTINUE the
> >    corresponding PAGE_SIZE sections in the primary mapping.
> >
>
> Huh, so MADV_SPLIT doesn't actually split an existing PMD mapping into
> high granularity mappings. Instead it says that future mappings may be
> high granularity? I assume they may not even be high granularity, like
> if the alias mapping faulted in a full hugetlb page (without
> UFFDIO_CONTINUE) that page would be regular mapped not high
> granularity mapped.

MADV_SPLIT just means "userspace is aware that they are able to start
mapping HugeTLB pages at high-granularity". Right now the only way to
get high-granularity mappings is with UFFDIO_CONTINUE, but there may
be other ways in the future.

As of this series, if you MADV_SPLIT a HugeTLB VMA and you aren't
using userfaultfd minor faults, it's basically a no-op. The mappings
that are created will still be huge. I could change this, but I don't
really see a reason to right now.

>
> This may be bikeshedding but I do think a clearer name is warranted.
> Maybe MADV_MAY_SPLIT or something.

I agree -- MADV_MAY_SPLIT more accurately describes the HugeTLB
functionality. I really don't mind what the MADV is called.

I think enabling the high-granularity userfaultfd bits with a
userfaultfd feature[1] worked reasonably well. There is some API
discussion in that thread[1].

[1]: https://lore.kernel.org/linux-mm/20221021163703.3218176-34-jthoughton@=
google.com/
