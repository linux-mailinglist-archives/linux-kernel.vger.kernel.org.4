Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBDD6BF5F0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCQXEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCQXEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:04:36 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050F9ED0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:04:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536af432ee5so121705857b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679094256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2C+V/8voXxzsC2KICa9qM/vADLcn6b/HYkR0aaSEj8=;
        b=qadP/ybP7YOevfO52m8wnUG+YiHdnOn5wiTDCLm2VjUVfUOG5wAohBATwM/IL4n8wK
         EUonCnQCrjtmnZRLgAC03JV9/+QCTi0BqZVDxpFq8SqiyAubeFWwbgMfqbnZcZRTl18c
         P1tSJdCagaQjOfouDP1NBm1bVz0SB49wHTXq7N7Gtb10cvdkyrfhhznn8dfTLLzfQ5xn
         VHTktar+xrik+S2ltlWJ4wrDf2vjCcW8doNdhQxWFwKhPnui+CRO0C1yWNJIJNiJ5rCB
         wKdladKdkllKCIdJYUqadUqaVvHHE+1Xq2vf4P6OzQfmw3LxIqhH43Ggd4aPaJltT2yX
         CDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679094256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2C+V/8voXxzsC2KICa9qM/vADLcn6b/HYkR0aaSEj8=;
        b=ZIBb3tYn/D3aQRF+PG6zeGNndodFwUNO1c2go6x9Hed+Fwj4JIqw3fCloyr/w4HpEi
         gFGPB1MCScuMfwanGdQvPgh7GTzdAzveVreZfIHF7fkS/JajjMKheuEBxVbTiH0moX2o
         A4xHli+eaV8slzO8iFMkbKC7QXpT1UzJWXp8etEUh59kc7MOVpoVIsWF2PA3DOGV+Fs+
         7f5xG8iwaAIHz8cSpX5Ss39G+VRCmDMSpWTCqr9V4z8aQwySvo2vLro6blv9ow3cKb9d
         l2XSJuC56TnnQGjx3sCrPFPojII2QOC5KS5gOaU4TI1NlmTn3LU5PcCQd9nm8KOaGlqV
         et4A==
X-Gm-Message-State: AO0yUKWOpzEhx+fpN00RoBe/VMY22ktwTU5A2e8s+8hfh7DYWyqH+7yy
        Q33Otj0Qpy7OcT5YIvdCY92s9zhE4hkjcwtXTzlH/w==
X-Google-Smtp-Source: AK7set8hywCBVoHzE2HL9COIHr0uPX9RzbYv5voQJIobm2WkCY5b7MlTeFVb42odO3dQtnivkNUSPb3IzOuPUKYTNlk=
X-Received: by 2002:a81:c148:0:b0:544:51f7:83c5 with SMTP id
 e8-20020a81c148000000b0054451f783c5mr5551479ywl.1.1679094255994; Fri, 17 Mar
 2023 16:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com> <20230314141144.6a0892e6.alex.williamson@redhat.com>
 <CAJuCfpFkKuyBJkk8OzWEu2YCg-UYooS4bHuDaXvnCbeR-cBdVw@mail.gmail.com> <20230317164059.466d1c70.alex.williamson@redhat.com>
In-Reply-To: <20230317164059.466d1c70.alex.williamson@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 17 Mar 2023 16:04:05 -0700
Message-ID: <CAJuCfpFZ06DCzO01gFv4944tXtyPWt_KxidLRVZLY_wMgtsN1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] introduce vm_flags modifier functions
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        dimitri.sivanich@hpe.com
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

On Fri, Mar 17, 2023 at 3:41=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Fri, 17 Mar 2023 12:08:32 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Tue, Mar 14, 2023 at 1:11=E2=80=AFPM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > On Thu, 26 Jan 2023 11:37:45 -0800
> > > Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > This patchset was originally published as a part of per-VMA locking=
 [1] and
> > > > was split after suggestion that it's viable on its own and to facil=
itate
> > > > the review process. It is now a preprequisite for the next version =
of per-VMA
> > > > lock patchset, which reuses vm_flags modifier functions to lock the=
 VMA when
> > > > vm_flags are being updated.
> > > >
> > > > VMA vm_flags modifications are usually done under exclusive mmap_lo=
ck
> > > > protection because this attrubute affects other decisions like VMA =
merging
> > > > or splitting and races should be prevented. Introduce vm_flags modi=
fier
> > > > functions to enforce correct locking.
> > > >
> > > > The patchset applies cleanly over mm-unstable branch of mm tree.
> > >
> > > With this series, vfio-pci developed a bunch of warnings around not
> > > holding the mmap_lock write semaphore while calling
> > > io_remap_pfn_range() from our fault handler, vfio_pci_mmap_fault().
> > >
> > > I suspect vdpa has the same issue for their use of remap_pfn_range()
> > > from their fault handler, JasonW, MST, FYI.
> > >
> > > It also looks like gru_fault() would have the same issue, Dimitri.
> > >
> > > In all cases, we're preemptively setting vm_flags to what
> > > remap_pfn_range_notrack() uses, so I thought we were safe here as I
> > > specifically remember trying to avoid changing vm_flags from the
> > > fault handler.  But apparently that doesn't take into account
> > > track_pfn_remap() where VM_PAT comes into play.
> > >
> > > The reason for using remap_pfn_range() on fault in vfio-pci is that
> > > we're mapping device MMIO to userspace, where that MMIO can be disabl=
ed
> > > and we'd rather zap the mapping when that occurs so that we can sigbu=
s
> > > the user rather than allow the user to trigger potentially fatal bus
> > > errors on the host.
> > >
> > > Peter Xu has suggested offline that a non-lazy approach to reinsert t=
he
> > > mappings might be more inline with mm expectations relative to touchi=
ng
> > > vm_flags during fault.  What's the right solution here?  Can the faul=
t
> > > handling be salvaged, is proactive remapping the right approach, or i=
s
> > > there something better?  Thanks,
> >
> > Hi Alex,
> > If in your case it's safe to change vm_flags without holding exclusive
> > mmap_lock, maybe you can use __vm_flags_mod() the way I used it in
> > https://lore.kernel.org/all/20230126193752.297968-7-surenb@google.com,
> > while explaining why this should be safe?
>
> Hi Suren,
>
> Thanks for the reply, but I'm not sure I'm following.  Are you
> suggesting a bool arg added to io_remap_pfn_range(), or some new
> variant of that function to conditionally use __vm_flags_mod() in place
> of vm_flags_set() across the call chain?  Thanks,

I think either way could work but after taking a closer look, both
ways would be quite ugly. If we could somehow identify that we are
handling a page fault and use __vm_flags_mod() without additional
parameters it would be more palatable IMHO...
Peter's suggestion to avoid touching vm_flags during fault would be
much cleaner but I'm not sure how easily that can be done.

>
> Alex
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
