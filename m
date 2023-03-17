Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976AC6BF173
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCQTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCQTIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:08:46 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CE1B316
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:08:44 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5418c2b8ef2so111528137b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679080124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtkQvqCybTAazWJPrit1AMvXQMfmRWKtxssDGkkt4aI=;
        b=A9Xx39VsDfAww1P3KBrqNePQW4nRTeWl/oDLqWC2n9XHSShzJU08lYLiMMTwNuGaEL
         KdK8emE8pLHmmgtPc3KiKRt8iMMNn6bunG0BxWE+/Y0kXLIqyLLMQ/d6v9MSPL73Gv8G
         55ALxvCKGbWb3efEI06Hlt57hqgzCVfid+MBX1/Uz7NSfxcBnnWoXIlEDRiTefNn2JGN
         Hpx42UiDje0uBZczcnQwT5097VwnM434IYLfWDKadih442QI8+PFv9m6tYDQUEFxb4rW
         vwF/X+YfmBG3+KdUHmX/M29EsSkeE9vOoDQ2BJ8aA2WNpChMeA9ztvHHxtdzHaiBKQyl
         Ar2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtkQvqCybTAazWJPrit1AMvXQMfmRWKtxssDGkkt4aI=;
        b=isMKKy14CM0nfWyvOZ7oM5X5tQU74tTWJrRHte6xNuDAck1RriPJ6VCmlbzQL+8G1+
         1YuqolxuNCjD64cSEHJhua46+o0aZLMntR7+jhTyx+Zqaee4h4kbdVAQKBZuMVIg9Bya
         d8m/UtpXeNg3fXNgi7xYQarNbuegtp/9ugBOFWIPvp+/pUbObA7IkZFGVAR3lrNInpE0
         c+6TnpVF/3Ok8tnd3vO6D3qvpiMTrp50402ZxfNbCnCa5/xffZcY9Qsarjb0eRoJm+S9
         oQo7cNbtWrmKTB0Cw5OXgG6dB00w1DCT7ewE6zxuMQee5lw4qX2EXw2HAXgZBavseIOM
         eNGA==
X-Gm-Message-State: AO0yUKUxIil/6LKpAoYUBlo8PiNijaLSLMK1q5F3Oni1tyYfowFQNRW8
        rKG5QZY3wfRiAsmG9gqmqe0d81mAFq/AuMSo0xLdbPFSLSHfjS/B/GJrsA==
X-Google-Smtp-Source: AK7set9XdXibjKhLKLOpCgfHP3zHh4i0ReloLFIdYIvJHM4aukAMgg/kqZsVAHifAGiXEo7BWTSJHGdDz1qRr77kcJo=
X-Received: by 2002:a81:4517:0:b0:536:38b4:f50 with SMTP id
 s23-20020a814517000000b0053638b40f50mr5188310ywa.1.1679080123783; Fri, 17 Mar
 2023 12:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com> <20230314141144.6a0892e6.alex.williamson@redhat.com>
In-Reply-To: <20230314141144.6a0892e6.alex.williamson@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 17 Mar 2023 12:08:32 -0700
Message-ID: <CAJuCfpFkKuyBJkk8OzWEu2YCg-UYooS4bHuDaXvnCbeR-cBdVw@mail.gmail.com>
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

On Tue, Mar 14, 2023 at 1:11=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Thu, 26 Jan 2023 11:37:45 -0800
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > This patchset was originally published as a part of per-VMA locking [1]=
 and
> > was split after suggestion that it's viable on its own and to facilitat=
e
> > the review process. It is now a preprequisite for the next version of p=
er-VMA
> > lock patchset, which reuses vm_flags modifier functions to lock the VMA=
 when
> > vm_flags are being updated.
> >
> > VMA vm_flags modifications are usually done under exclusive mmap_lock
> > protection because this attrubute affects other decisions like VMA merg=
ing
> > or splitting and races should be prevented. Introduce vm_flags modifier
> > functions to enforce correct locking.
> >
> > The patchset applies cleanly over mm-unstable branch of mm tree.
>
> With this series, vfio-pci developed a bunch of warnings around not
> holding the mmap_lock write semaphore while calling
> io_remap_pfn_range() from our fault handler, vfio_pci_mmap_fault().
>
> I suspect vdpa has the same issue for their use of remap_pfn_range()
> from their fault handler, JasonW, MST, FYI.
>
> It also looks like gru_fault() would have the same issue, Dimitri.
>
> In all cases, we're preemptively setting vm_flags to what
> remap_pfn_range_notrack() uses, so I thought we were safe here as I
> specifically remember trying to avoid changing vm_flags from the
> fault handler.  But apparently that doesn't take into account
> track_pfn_remap() where VM_PAT comes into play.
>
> The reason for using remap_pfn_range() on fault in vfio-pci is that
> we're mapping device MMIO to userspace, where that MMIO can be disabled
> and we'd rather zap the mapping when that occurs so that we can sigbus
> the user rather than allow the user to trigger potentially fatal bus
> errors on the host.
>
> Peter Xu has suggested offline that a non-lazy approach to reinsert the
> mappings might be more inline with mm expectations relative to touching
> vm_flags during fault.  What's the right solution here?  Can the fault
> handling be salvaged, is proactive remapping the right approach, or is
> there something better?  Thanks,

Hi Alex,
If in your case it's safe to change vm_flags without holding exclusive
mmap_lock, maybe you can use __vm_flags_mod() the way I used it in
https://lore.kernel.org/all/20230126193752.297968-7-surenb@google.com,
while explaining why this should be safe?

>
> Alex
>
