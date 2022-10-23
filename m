Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF660960D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJWUQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJWUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:16:45 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA4B5F105
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:16:43 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o64so8967438oib.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1yJrBm1zn8SsyErR4f1/ZvN1KDaJleCkqUq/AOdhu8=;
        b=jLw2qhpgAORoIlqfrBx49W3wtNa7rjk5WfKxVvNUpbMRZlZ4pSh97O9QGQSNk3Yjdh
         yIgh1ZN1JJQ3HOgVqxzHyEwgNLUSZEQO2VUbAifhdNbmGZ+it5TS39F/oA08gBsNQypL
         Te8pj3B8Wm1Tlf5nAWIp2zDE2Qj1gv/6PStyxeltT/Wqb/hGgikHt+TNM5oHLH41kyU7
         hyoUJLAUbQZNA9Qd4rWCdEjjGGpTYHmbaROGXidatd/KBAefoJkAxKTe4CVf20WSH/hQ
         KvhVvv6P9h424Bhfcqkx8HrO4VNWMtMi0/9c8qWqsA/qmo9hu0FBVcrp2GUSDjD2AZk+
         zFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1yJrBm1zn8SsyErR4f1/ZvN1KDaJleCkqUq/AOdhu8=;
        b=157+RhGBxgHoaFgh4CwFXDnCKuVDD5eO0zc9v/meqyb68BbAW2PU/99axM/2q/ZcAI
         hWrIuwBQxvXSpluWn7dFYAjmfKNhTBf0DVz2oSN/tar/M2nyks85TPIA2u8xm96z4bCk
         XaO3mmbBMjnSM3Qqo97vwqwW2hT4lV3Mux+A1MAEC3k2TZURk/sf4CmrH3rKPt/1QOp7
         W4qgAvn3KKZghGsYEFklaVWgAI9g67LE9FgGJs7uSjFQzyXEESbyE/ECgoqXS0ee9TQY
         O+MYrtOADGOqOrig4IBPVh48Lv0Yezk7DPcVWkb1SNB9noDyToZMh7nFK0wS3i/oxYCS
         p6zw==
X-Gm-Message-State: ACrzQf21Bm/JLCtc09aJ9Tvfx+l/+Eu0HkUHWUNg0TAnbFrKUyYVjdJd
        T0JH7oSEnbf0GeDhRp4658CKyojhmF1iFw==
X-Google-Smtp-Source: AMsMyM7ai7/LrlShKt0cDcHy/wofRnIoUy4OQ+EdVaPjQHqH5uKzvbOZHVjZ4EHzAumeshE2t5L6vw==
X-Received: by 2002:a05:6808:10c6:b0:355:3ff8:b88e with SMTP id s6-20020a05680810c600b003553ff8b88emr17313996ois.209.1666556202691;
        Sun, 23 Oct 2022 13:16:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m4-20020a4ae3c4000000b00475d676d2d4sm5973709oov.16.2022.10.23.13.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:16:42 -0700 (PDT)
Date:   Sun, 23 Oct 2022 13:16:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     =?ISO-2022-JP?Q?=1B$B2+=5B=3F=1B=28J?= 
        <huangjie.albert@bytedance.com>
cc:     Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
In-Reply-To: <CABKxMyNEWVBd8hvZfOHqxgtLi7gts+X53pVvag-zEsvqYqRnhw@mail.gmail.com>
Message-ID: <b96374a-c5df-6ac3-c598-341eface774@google.com>
References: <20221012081526.73067-1-huangjie.albert@bytedance.com> <5f7ef6ee-6241-9912-f434-962be53272c@google.com> <CABKxMyNEWVBd8hvZfOHqxgtLi7gts+X53pVvag-zEsvqYqRnhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-794960718-1666556202=:8441"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-794960718-1666556202=:8441
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Oct 2022, =E9=BB=84=E6=9D=B0 wrote:
> Hugh Dickins <hughd@google.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B 03:45=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, 12 Oct 2022, Albert Huang wrote:
> > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > >
> > > implement these two functions so that we can set the mempolicy to
> > > the inode of the hugetlb file. This ensures that the mempolicy of
> > > all processes sharing this huge page file is consistent.
> > >
> > > In some scenarios where huge pages are shared:
> > > if we need to limit the memory usage of vm within node0, so I set qem=
u's
> > > mempilciy bind to node0, but if there is a process (such as virtiofsd=
)
> > > shared memory with the vm, in this case. If the page fault is trigger=
ed
> > > by virtiofsd, the allocated memory may go to node1 which  depends on
> > > virtiofsd.
> > >
> > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> >
> > Aha!  Congratulations for noticing, after all this time.  hugetlbfs
> > contains various little pieces of code that pretend to be supporting
> > shared NUMA mempolicy, but in fact there was nothing connecting it up.
> >
> > It will be for Mike to decide, but personally I oppose adding
> > shared NUMA mempolicy support to hugetlbfs, after eighteen years.
> >
> > The thing is, it will change the behaviour of NUMA on hugetlbfs:
> > in ways that would have been sensible way back then, yes; but surely
> > those who have invested in NUMA and hugetlbfs have developed other
> > ways of administering it successfully, without shared NUMA mempolicy.
> >
> > At the least, I would expect some tests to break (I could easily be
> > wrong), and there's a chance that some app or tool would break too.
>=20
> Hi : Hugh
>=20
> Can you share some issues here?

Sorry, I don't think I can: precisely because it's been such a relief
to know that hugetlbfs is not in the shared NUMA mempolicy game, I've
given no thought to what issues it might have if it joined the game.

Not much memory is wasted on the unused fields in hugetlbfs_inode_info,
just a few bytes per inode, that aspect doesn't concern me much.

Reference counting of shared mempolicy has certainly been a recurrent
problem in the past (see mpol_needs_cond_ref() etc): stable nowadays
I believe; but whether supporting hugetlbfs would cause new problems
to surface there, I don't know; but whatever, those would just be
bugs to be fixed.

/proc/pid/numa_maps does not represent shared NUMA mempolicies
correctly: not for tmpfs, and would not for hugetlbfs.  I did have
old patches to fix that, but not patches that I'm ever likely to
have time to resurrect and present and push.

My main difficulties in tmpfs were with how to deal correctly and
consistently with non-hugepage-aligned mempolicies when hugepages
are in use.  In the case of hugetlbfs, it would be simpler, since
you're always dealing in hugepages of a known size: I recommend
being as strict as possible, demanding correctly aligned mempolicy
or else EINVAL.  (That may already be enforced, I've not looked.)

But my main concern in extending shared NUMA mempolicy to hugetlbfs
is exactly what I already said earlier:

The thing is, it will change the behaviour of NUMA on hugetlbfs:
in ways that would have been sensible way back then, yes; but surely
those who have invested in NUMA and hugetlbfs have developed other
ways of administering it successfully, without shared NUMA mempolicy.

At the least, I would expect some tests to break (I could easily be
wrong), and there's a chance that some app or tool would break too.

It's a risk, and a body of complication, that I would keep away from
myself.  The shared mempolicy rbtree: makes sense, but no madvise()
since has implemented such a tree, to attach its advice to ranges
of the shared object rather than to vma.

Hugh
---1463760895-794960718-1666556202=:8441--
