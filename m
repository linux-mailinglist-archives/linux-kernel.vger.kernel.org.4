Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B174BC5B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGHGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGHGSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 02:18:24 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB261110
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 23:18:23 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579ef51428eso34666087b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688797103; x=1691389103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MAxk2PgUZVgl0dal721qm8ALQS71HLK1RtEb8u+Uwo=;
        b=cqyYfDxLdjqJtLxZvV2GbMizhmrYthTgcuhRwhBgYix/yKS0ibfzGvoJRBMohHf1CU
         D4lflKWn7pSexpHeftC0T1/XOT3aiEyOsA1O3sr0GIVqSZ//yR6dw4pAzp3/Z6Xakxy4
         vJWHlVelLKCKW71lwRU8+VRQA0YOVGyNyNY1D6ytfKXU2NefWlzXpTLPgZHte2JgjtpK
         wOcHmIFBYW2j2yRIMoclCzweTy2z4eWaWU6OPw16559dwTqsRYwV9l+pwsFZ+z2hbgZO
         zGuJ60uSWUm9zc9+Zl5v+qXcOdVaNZbmCBpgt4zzqgoMpPvzb8S71wdDUG9EqYYpGu5x
         w7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688797103; x=1691389103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MAxk2PgUZVgl0dal721qm8ALQS71HLK1RtEb8u+Uwo=;
        b=CzSCQVUqMDv9NZrnMyJ1hNUNwOVYEqZXxNK7nL57sOC+R1qOL5hvx5nURQxWYFmA9o
         cirxJkzew1hMtO2sk1i++fuhW/CLNvQEtNcWRpXsjTaXIw46M9yEsQ4Wb/bqfEDtyOiV
         inq4BpiVQb7PF/6j/oeh/iX1kI9yG1q9+GxjgOXroQX2t3GSBHJy9bSi2gGctHC63Sb7
         NKt8qJH/sud7bzjKsnyWzwYXgnysxpi0DMczbqHSlnu9febXuNZWQB+NKEuDKomc9e0O
         6jCLKM4cUrwigUMuS2Sb1V699KOSR8997d0ul7ZMll9mjSLc5t82Y2UIOGCX5jpg5lL+
         yjEw==
X-Gm-Message-State: ABy/qLYbykfLCxgWogpocdd30NMqEqddqxXwA1goLJ+lWVw/jOYHF293
        4UM2Ll4WkXI5LCLnQlfZe4ImZAYgfg75PeQ+cNSNTg==
X-Google-Smtp-Source: APBJJlFPq7Gtkf1gegzIupdC1wtY0Z5UlJDkgN+ZBldyqD1P0gGQGWfsqFjAKdHb/f9sYflKNoiN4sM3WnrlT93J3nM=
X-Received: by 2002:a0d:e884:0:b0:56f:ff55:2b7d with SMTP id
 r126-20020a0de884000000b0056fff552b7dmr9312228ywe.17.1688797102896; Fri, 07
 Jul 2023 23:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230707043211.3682710-1-surenb@google.com> <e26c40f7-0329-c223-2544-503c64123f5a@web.de>
 <ZKhvgm6geUvLPQKk@casper.infradead.org> <CAJuCfpFj_OWi=SRgUp=f3MAhb988fZL46oWKpL1jM15i91x5Yw@mail.gmail.com>
 <b16b3a2c-4b91-de56-66b8-2f69cca6bb00@web.de>
In-Reply-To: <b16b3a2c-4b91-de56-66b8-2f69cca6bb00@web.de>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Jul 2023 23:18:11 -0700
Message-ID: <CAJuCfpEX8tXMKd7BKu7JOxhSfgeVnaerJ2db6PqfrScG5cUwig@mail.gmail.com>
Subject: Re: [1/2] mm: lock a vma before stack expansion
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Pasha Tatashin <tatashin@google.com>,
        Peter Xu <peterx@redhat.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Fri, Jul 7, 2023 at 10:55=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> >> Markus, your nitpicking is not useful.  Please stop.
> >
> > I'll fix the nits, at least the ones I can, if there is a need for v2.
>
> Thanks for such a constructive feedback.
>
> Would you like to take any further information better into account
> for subsequent patch variants?

All feedback is appreciated. The comments you provided so far seem to
be nice-to-haves but not critical enough to post a new version of the
patch IMHO. If something more substantial is found that requires a new
version then I'll address your feedback there as well.
Thanks,
Suren.

>
> Regards,
> Markus
