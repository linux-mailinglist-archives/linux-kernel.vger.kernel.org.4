Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D211727C47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjFHKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjFHKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:05:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1C530DA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:05:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9786c67ec32so81851166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686218723; x=1688810723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqGEdhtRpLQfdvhmpdvDRNJ/6MqO8TWpTquq8lMiOyo=;
        b=otejgLvWNENioG+/YiRpppJD8VZv1cF8TIAYPXrelh2AQKN7n3KdNQd9VPa6MlVvSO
         v3CEFVRyL102gYFN/0iT995Yaw64gN+uaWPnyarm0CWpx2U3hGHTCSdM55zwfn99XCKt
         VFkPC7PZCMYqj/Jgkrmqb1IRVjl3yFOlt6e4f2KoCO1QTu6R5AhVaeNRb4Qf0Xi0qKO6
         9geyvGwBaogFuUy9ky3C70V83gls8qREubwz8xN2vVtafPOBnmc9kw0A2Ee/x4veR8yl
         PGaf9d54s7BVVTmcFxYY05d0XuYJt1y6ydTzKWeqWhJzao0Ys3O5+bAynTGPvESxjLID
         W7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218723; x=1688810723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqGEdhtRpLQfdvhmpdvDRNJ/6MqO8TWpTquq8lMiOyo=;
        b=LFBM9GjJzXvhnPV2TMzOBICzSkZ4FwQHHsOZdA3bKQLUDUo/Eg3Q0ijUc5A80X3htd
         oJyF+JL1xJVTLrhdMOUQVgL6ptgYz6IHjzaMHMUqIQHkVNHUYPOckvES5PdNcA2JjfT3
         qR7jGCV8b+gJSDFHnkkd5kzk0DdAPQUaXvdgGPPQ1/EuRP1ZAe4EkgLk4wACx8Y0klZ3
         Z9OIQf9LUq28nboSTwrdOfAhX5F7uJ4K1FGViqUgc52lk7Bj1go60hBoj+FDWO/PKIYW
         I++3VRfVQhH5fNYBr9uqyt6V7B0SxpqFg5w9kJrxpB9tBkFmOHxp7TeDKlVFGxNOO+v9
         FK3w==
X-Gm-Message-State: AC+VfDxiImxKAWBxLGjDn94sE5kqhskXqve8cVFMwn42LDKRn1txSaHU
        PoQBNXoYpeHsBP+NMg4teMapX1FUGwbTLSUbdJagmw==
X-Google-Smtp-Source: ACHHUZ4JzWuVV63DhWdyJzBtDB0n669XnvENSEa/YND+EFl/YRLa+JcprO/yrxbiPbpMCv/RXjFd9z3bUIQdX0LVwMI=
X-Received: by 2002:a17:907:9404:b0:977:cdd6:6a5c with SMTP id
 dk4-20020a170907940400b00977cdd66a5cmr7237275ejc.10.1686218722765; Thu, 08
 Jun 2023 03:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n> <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
 <ZDbVMk0trT5UaqaA@x1n> <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
 <ZDghhTH2KtCeAwcZ@x1n> <6403a950-7367-0b00-8cd5-2f0a32dac953@suse.cz> <CAJuCfpFddcMRH8pNOE816ZrQr5qvrccxFjJqNj5JRPWkv+u=uA@mail.gmail.com>
In-Reply-To: <CAJuCfpFddcMRH8pNOE816ZrQr5qvrccxFjJqNj5JRPWkv+u=uA@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 8 Jun 2023 03:05:11 -0700
Message-ID: <CA+EESO6NkpugZa7zh=mj+A0BEqMuS4TKL0cpTm4EWeHgUUVksg@mail.gmail.com>
Subject: Re: RFC for new feature to move pages from one vma to another without split
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
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

On Tue, Jun 6, 2023 at 4:18=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jun 6, 2023 at 1:15=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> >
> > On 4/13/23 17:36, Peter Xu wrote:
> > > On Thu, Apr 13, 2023 at 10:10:44AM +0200, David Hildenbrand wrote:
> > >> So instead, we consider the whole address space as a virtual, anon f=
ile,
> > >> starting at offset 0. The pgoff of a VMA is then simply the offset i=
n that
> > >> virtual file (easily computed from the start of the VMA), and VMA me=
rging is
> > >> just the same as for an ordinary file.
> > >
> > > Interesting point, thanks!
> >
> > FYI, I've advised a master thesis exploring how to update page->index d=
uring
> > mremap() to keep things mergeable:
> >
> > https://dspace.cuni.cz/bitstream/handle/20.500.11956/176288/120426800.p=
df
> >
> > I think the last RFC posting was:
> > https://lore.kernel.org/all/20220516125405.1675-1-matenajakub@gmail.com=
/
> >
> > It was really tricky for the general case. Maybe it would be more feasi=
ble
> > for the limited case Lokesh describes, if we could be sure the pages th=
at
> > are moved aren't mapped anywhere else.

It's great that mremap is being improved for mereabilitly. However,
IIUC, it would still cause unnecessary splits and merges in the
private anonymous case. Also, mremap works with mmap_sem exclusively
held, thereby impacting scalability of concurrent mremap calls.

IMHO, Andrea's userfaultfd REMAP patch is a better alternative as it
doesn't have these downsides.

>
> Lokesh asked me to pick up this work and prepare patches for
> upstreaming. I'll start working on them after I finish with per-vma
> lock support for swap and userfaultd (targeting later this week).
> Thanks for all the input folks!

Thanks so much, Suren!
