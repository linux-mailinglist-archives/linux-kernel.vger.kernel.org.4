Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1F71012A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjEXWzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEXWzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:55:37 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642F90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:55:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33828a86ee2so66515ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684968936; x=1687560936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PFZGaJq8MtD3XUYUpQ3Rfh0TSuFecS+vZ1Ibl7OUjU=;
        b=gUKaYbvrWDvXXzik7sXzLzjnxqvbYtYE3pM1NUPgN29awaZVR4EehmK9rKNL20KEKe
         Fw25UT/6xwiF0VgjYMQ0JuGNHKULDipAzGoOd2DaW3S2Y/7+GsM3FTHzTBcakF9RjW1k
         +1MvvTOx78w5eVdgoLo9xXYSP7tcQI20xV6o0msYi1VvuqBCMFj985EM28z/4Ci1P9VI
         nRfj7RS9veK4oiWiFMgtbKIGLMMWBGALUtaHLybpM0FWv2fNhBGvdwhFZLOfR6B6ykT7
         ziDNo9OjqRZgcrmbl36VyssJlpFtOP5iX9AJN1Sm+J+qR6dkdq0v2YArBPfYKMAyI9yu
         /ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968936; x=1687560936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PFZGaJq8MtD3XUYUpQ3Rfh0TSuFecS+vZ1Ibl7OUjU=;
        b=JR7aBX2dz+XaVByHfCz2cOkYPohfqQaHiPmgzyuxANCsQQWW4mhjlRBYFQOThETwLu
         XIDA5chOB8XmcG+SrPhLhwz3fghfQ4pthnM6jijK1connib807GraZoMuMlMVWBcWAbX
         99Ky6wDa1azDvhbZkUrLs59IcrM+YNMsgpZz9CfCsHEJCsgWgC32AmCkMsdYwORQJHeL
         P91FJKrZMu2KryIZ7ONKhw28rggWpMSD39grF42TW4thW88RyqP02hVFJ7xrzl7+RluO
         EixYoQUiSPAUiaOhy6HAu8yxcE+L3hCmqbsrTUd/3y72q7sEtKeAab+5pf+InKr00d/d
         ObTQ==
X-Gm-Message-State: AC+VfDyHdOswMi7MNwxqlYmszQmPKtlr8TWEokRX8puoqZg0fk9vcfqY
        dAKE9tu2eOVeLVoeWnag9Tcp+8WL849fNyPIS6xQkw==
X-Google-Smtp-Source: ACHHUZ5eEhj9ZsAKnTiXjGz6qPhyaNR5/uMMUNsenrdXbGUwJuRCXcsx4UB6K5Ksp2W7U1rzG7mQQvoCfDx8qIEc/CQ=
X-Received: by 2002:a05:6e02:219a:b0:328:3a25:4f2e with SMTP id
 j26-20020a056e02219a00b003283a254f2emr23558ila.9.1684968935966; Wed, 24 May
 2023 15:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <34467cca-58b6-3e64-1ee7-e3dc43257a@google.com>
In-Reply-To: <34467cca-58b6-3e64-1ee7-e3dc43257a@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 24 May 2023 16:54:59 -0600
Message-ID: <CAOUHufbwyCRHx07e5VrDuG60X5wRUJ795qcBOz3u+ZEmx0Bgog@mail.gmail.com>
Subject: Re: [PATCH 01/31] mm: use pmdp_get_lockless() without surplus barrier()
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

On Sun, May 21, 2023 at 10:49=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> Use pmdp_get_lockless() in preference to READ_ONCE(*pmdp), to get a more
> reliable result with PAE (or READ_ONCE as before without PAE); and remove
> the unnecessary extra barrier()s which got left behind in its callers.
>
> HOWEVER: Note the small print in linux/pgtable.h, where it was designed
> specifically for fast GUP, and depends on interrupts being disabled for
> its full guarantee: most callers which have been added (here and before)
> do NOT have interrupts disabled, so there is still some need for caution.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>

The previous ask here:
https://lore.kernel.org/r/CAOUHufZo=3DfB2HcaCrj2aidLJ2zEhOpi7ou5M_7qOQiuQq8=
+wTQ@mail.gmail.com/
