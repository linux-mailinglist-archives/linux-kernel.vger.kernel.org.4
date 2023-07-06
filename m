Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C135274A68F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGFWFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGFWFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:05:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18161FEB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:05:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1222975f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688681104; x=1691273104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=095hVI2EWirxAlkmhEDyiv1L1+keL+0mbtKAzVVggwk=;
        b=WXmiyVCY+NLlIK9v9BEY8CAwJuUEHu7nxwfCTtrrUYJQPCh9MowVSJDhRqGxSwhLNV
         vHw0OzGaFZaZX/qNdLD0QRzodzYCKlaUa0utyPpMbv5rPtyfEYGXmMqWJa3Nkp+TqSay
         G8WoN+aFMELxcjhw/xb6rJdHUOFYTq1jeV9J009LNUuzyCau4Q2ZD+UTCVkdBGP/ihAR
         f/lnhjKeToOeqSakJ3SCIURANruWkY8IGOGbBXNhUwdmpshSAhvDeiCB95mCW2p15SG7
         j8c3+ymI+YXyUQ1H3sP9oqyboocoC0wyh8sJtysqOYl7ERavUso7qY48UK1RQjAOs1Ml
         yjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688681104; x=1691273104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=095hVI2EWirxAlkmhEDyiv1L1+keL+0mbtKAzVVggwk=;
        b=JqYHcs3P8T109i8ZZG/SFdeMgFLXTsD0tLmht+pwdpK/7mkMLUcMJ4D4sgEi6UNE7F
         cBeHaB3ybzoRnomqMtRkcnXUoAdupO1+AKiLc/ZUJccgCz+sHt0qiS0pH/CCflcvZME2
         Pk0PSSSihtvDbRtKRzgxwxarITKFp4SZHG9GhMOeQK+MqGUPPpRseqzVbwdpzDRS44FN
         9KDScZsWj5RANLbAnjVi7B9LS0TmZlr2bH7PwMJ0R4vaotWdEFb2BowWCu1MzS0frMV9
         BsOCQJXiIvN92pt8XE5B6Aw6ybB9wueunje0c3ERzX1P2hKrvPmVnskkCW7o4a/TcrM1
         ksUg==
X-Gm-Message-State: ABy/qLYHOSZLcoRiM2EJ93mDX0MLX37rXMynwZfPR8kW9AOtlXbEVjme
        z+MD7g+45V9Z2oGMqIgrv3mIkE/HQi81cgDFt6QaTg==
X-Google-Smtp-Source: APBJJlF+1RaJl/q4Src0LsWuzMtRR0Y38MJITaCoy8SGhE5EiEEerwpRMwFAhnSBiK0C/DDDzupmZ4QeKgA345lyk/c=
X-Received: by 2002:adf:fed1:0:b0:30e:4515:1529 with SMTP id
 q17-20020adffed1000000b0030e45151529mr2084387wrs.37.1688681103470; Thu, 06
 Jul 2023 15:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230606124939.93561-1-yu.ma@intel.com> <20230606192013.viiifjcgb6enyilx@revolver>
 <20230705165411.tfqqipcla7exkb7k@box.shutemov.name> <20230705173348.rxgzxge6ipb4hapy@revolver>
 <20230705190601.4atlxzh2wxc7zlu6@box.shutemov.name>
In-Reply-To: <20230705190601.4atlxzh2wxc7zlu6@box.shutemov.name>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 6 Jul 2023 15:04:51 -0700
Message-ID: <CAJuCfpHu+etUuRkaw=hyBN6pHV3sP8-Mov3YKqUMU-EqNfHsHg@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
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

On Wed, Jul 5, 2023 at 12:06=E2=80=AFPM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Wed, Jul 05, 2023 at 01:33:48PM -0400, Liam R. Howlett wrote:
> > * Kirill A. Shutemov <kirill@shutemov.name> [230705 12:54]:
> > > On Tue, Jun 06, 2023 at 03:20:13PM -0400, Liam R. Howlett wrote:
> > > > * Yu Ma <yu.ma@intel.com> [230606 08:23]:
> > > > > UnixBench/Execl represents a class of workload where bash scripts=
 are
> > > > > spawned frequently to do some short jobs. When running multiple p=
arallel
> > > > > tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both =
of them
> > > > > come from load_elf_binary through the call chain
> > > > > "execl->do_execveat_common->bprm_execve->load_elf_binary". In do_=
mmap,it will
> > > > > call mmap_region to create vma node, initialize it and insert it =
to vma
> > > > > maintain structure in mm_struct and i_mmap tree of the mapping fi=
le, then
> > > > > increase map_count to record the number of vma nodes used. The ho=
t osq_lock
> > > > > is to protect operations on file=E2=80=99s i_mmap tree. For the m=
m_struct member
> > > > > change like vma insertion and map_count update, they do not affec=
t i_mmap
> > > > > tree. Move those operations out of the lock's critical section, t=
o reduce
> > > > > hold time on the lock.
> > > > >
> > > > > With this change, on Intel Sapphire Rapids 112C/224T platform, ba=
sed on
> > > > > v6.0-rc6, the 160 parallel score improves by 12%. The patch has n=
o
> > > > > obvious performance gain on v6.4-rc4 due to regression of this be=
nchmark
> > > > > from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: co=
nvert
> > > > > mm's rss stats into percpu_counter).
> > > >
> > > > I didn't think it was safe to insert a VMA into the VMA tree withou=
t
> > > > holding this write lock?  We now have a window of time where a file
> > > > mapping doesn't exist for a vma that's in the tree?  Is this always
> > > > safe?  Does the locking order in mm/rmap.c need to change?
> > >
> > > We hold mmap lock on write here, right?
> >
> > Yes.
> >
> > >Who can observe the VMA until the
> > > lock is released?
> >
> > With CONFIG_PER_VMA_LOCK we can have the VMA read under the rcu
> > read lock for page faults from the tree.  I am not sure if the vma is
> > initialized to avoid page fault issues - vma_start_write() should eithe=
r
> > be taken or initialise the vma as this is the case.
>
> Right, with CONFIG_PER_VMA_LOCK the vma has to be unusable until it is
> fully initialized, effectively providing the same guarantees as mmap writ=
e
> lock. If it is not the case, it is CONFIG_PER_VMA_LOCK bug.

Jumping into the conversation.

If we are adding a VMA into the tree before it's fully usable then we
should write-lock it before it becomes visible to page faults. Kirill
is right that there is a problem and we should not rely on
vma->vm_file->f_mapping lock here. Instead we should write-lock the
VMA before adding it into the tree even without this change.
IIUC, the rule with mmap_lock is that VMA can be safely modified if it
is either isolated or if we write-locked the mmap_lock. With
CONFIG_PER_VMA_LOCK the same rule should apply to per-VMA locks - the
VMA should be either isolated or we should write-lock it. Here we are
adding the unlocked VMA into the tree and then we keep modifying it.
This did not bite us because modifications are only done to
file-backed VMAs and we do not handle file-backed page faults under
per-VMA locks yet, however this will become a problem once we start
supporting that.
If we all agree to the above I can post a change to lock the VMA
before adding it into the tree.

>
> > There is also a possibility of a driver mapping a VMA and having entry
> > points from other locations.  It isn't accessed through the tree though
> > so I don't think this change will introduce new races?
>
> Right.
>
> > > It cannot be retrieved from the VMA tree as it requires at least read=
 mmap
> > > lock. And the VMA doesn't exist anywhere else.
> > >
> > > I believe the change is safe.
> >
> > I guess insert_vm_struct(), and vma_link() callers should be checked an=
d
> > updated accordingly?
>
> Yep.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>
