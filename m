Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9F6E7CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjDSOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjDSOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:38:45 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A078A69
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:38:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id u13so31970416ybu.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681915120; x=1684507120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWZiMALMH89i7PDBcLl9ZeqJbldqh6JjZ32NtRW6De4=;
        b=LQN4aCOqoHQ5A0XxtIiHiweiMtxVPWBLvrXNdIl/cTWwf0SCEDWxa5DtjLN5b0TV0b
         pqweuMH6UWw3sANhI2F9HIF3EqYZivxt5L57nmH365GJ9Ngtnjy/C+cfy3U/9cc/ej0d
         lK0TAHQT1xBmSO80pIojRmzPa6Iaxsctu0wnpC9zX8wIpZM0lGsIx+qkSxsHf5YnVw/3
         kNdwdnoEy9auCi7Ib1PuezR6J2Djb7+mawoXuzRMjRfLTELeh0o7Rawec08WY7tiXPV7
         Io7koP2QS0TNmmsZ4i4wnYWbZ7Nda5sOYWMm+mtC0yVEQKAydo6G019+TMJVpgAgt+9E
         xctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915120; x=1684507120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWZiMALMH89i7PDBcLl9ZeqJbldqh6JjZ32NtRW6De4=;
        b=mHVXU4zBLJXa1i4qYmJlkXFP2PDhfvOoYGJGPthCoUhVzEB1qWpZAZUnxbThdurgfR
         dKt9WFvMKKXAMMEJgARR+m2J870EksvMU70cCizk9bBHxfBG4/EP6n5k2l623OT/mWVn
         ubafAIwqbBtCKbUXRDA88Nv/vIcd18HHtpXjoGchWmhY2s3d1JQDCEtHJwzi3OmgRfEG
         vVoM38Q1UErfMvJdOW2kC0yubgeUyAdFc3rBOh62Et0+4YHrwKfRFGdobmcnbZR+phuz
         nSQEsBdLuvbU+0Fp9kcIDtWFyKqOz0pNXGrrNVaPE8DRumlzzJH7dwm8ZM1HCS04nv2i
         SGxQ==
X-Gm-Message-State: AAQBX9c6l8KlUN+sKOBNJSXraxbtW83v+BP+auaUepnrUHYS06P7mexk
        t2Ub7m/vYOXxGiSM6XrNr4vLF9VSfHcn/QQmDjkg
X-Google-Smtp-Source: AKy350Z4qMNIiRgB/vcByC5+mNU91yN6YSfmxnRnim0l4y4Smf7s0LYagf+ZnWYtLR5cTFGYaT3phWDJ7z6zjqPa6EI=
X-Received: by 2002:a25:aea2:0:b0:b8f:523f:3d02 with SMTP id
 b34-20020a25aea2000000b00b8f523f3d02mr21147135ybj.21.1681915119903; Wed, 19
 Apr 2023 07:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230418210230.3495922-1-longman@redhat.com> <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com> <cffc7454-614-1939-f235-7b139dc46b41@google.com>
 <22aee5ea-dd6b-ac2b-0b28-a25ee6602b48@redhat.com> <ZD9e7A4gaZ6qkGhy@casper.infradead.org>
In-Reply-To: <ZD9e7A4gaZ6qkGhy@casper.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Apr 2023 10:38:29 -0400
Message-ID: <CAHC9VhTcVzth0N+tTj_HHCPfHnp+-MfWkj+Ft2Uk4xMncDL9HA@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:24=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
> On Tue, Apr 18, 2023 at 09:45:34PM -0400, Waiman Long wrote:
> > On 4/18/23 21:36, Hugh Dickins wrote:
> > > On Tue, 18 Apr 2023, Waiman Long wrote:
> > > > On 4/18/23 17:18, Andrew Morton wrote:
> > > > > On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.co=
m> wrote:
> > > > >
> > > > > > One of the flags of mmap(2) is MAP_STACK to request a memory se=
gment
> > > > > > suitable for a process or thread stack. The kernel currently ig=
nores
> > > > > > this flags. Glibc uses MAP_STACK when mmapping a thread stack. =
However,
> > > > > > selinux has an execstack check in selinux_file_mprotect() which=
 disallows
> > > > > > a stack VMA to be made executable.
> > > > > >
> > > > > > Since MAP_STACK is a noop, it is possible for a stack VMA to be=
 merged
> > > > > > with an adjacent anonymous VMA. With that merging, using mprote=
ct(2)
> > > > > > to change a part of the merged anonymous VMA to make it executa=
ble may
> > > > > > fail. This can lead to sporadic failure of applications that ne=
ed to
> > > > > > make those changes.
> > > > > "Sporadic failure of applications" sounds quite serious.  Can you
> > > > > provide more details?
> > > > The problem boils down to the fact that it is possible for user cod=
e to mmap a
> > > > region of memory and then for the kernel to merge the VMA for that =
memory with
> > > > the VMA for one of the application's thread stacks. This is causing=
 random
> > > > SEGVs with one of our large customer application.
> > > >
> > > > At a high level, this is what's happening:
> > > >
> > > >   1) App runs creating lots of threads.
> > > >   2) It mmap's 256K pages of anonymous memory.
> > > >   3) It writes executable code to that memory.
> > > >   4) It calls mprotect() with PROT_EXEC on that memory so
> > > >      it can subsequently execute the code.
> > > >
> > > > The above mprotect() will fail if the mmap'd region's VMA gets merg=
ed with the
> > > > VMA for one of the thread stacks.  That's because the default RHEL =
SELinux
> > > > policy is to not allow executable stacks.
> > > Then wouldn't the bug be at the SELinux end?  VMAs may have been merg=
ed
> > > already, but the mprotect() with PROT_EXEC of the good non-stack rang=
e
> > > will then split that area off from the stack again - maybe the SELinu=
x
> > > check does not understand that must happen?
> >
> > The SELinux check is done per VMA, not a region within a VMA. After VMA
> > merging, SELinux is probably not able to determine which part of a VMA =
is a
> > stack unless we keep that information somewhere and provide an API for
> > SELinux to query. That can be quite a lot of work. So the easiest way t=
o
> > prevent this problem is to avoid merging a stack VMA with a regular
> > anonymous VMA.
>
> To paraphrase you, "Yes, SELinux is buggy, but we don't want to fix it".
>
> Cc'ing the SELinux people so it can be fixed properly.

SELinux needs some way to determine what memory region is currently
being used by an application's stacks.  The current logic can be found
in selinux_file_mprotect(), the relevant snippet is below:

int selinux_file_mprotect(struct vm_area_struct *vma, ...)
{
  ...
  } else if (!vma->vm_file &&
    ((vma->vm_start <=3D vma->vm_mm->start_stack &&
      vma->vm_end >=3D vma->vm_mm->start_stack) ||
    vma_is_stack_for_current(vma))) {
      rc =3D avc_has_perm(&selinux_state,
                        sid, sid, SECCLASS_PROCESS,
                        PROCESS__EXECSTACK, NULL);
 }
  ...
}

If someone has a better, more foolproof way to determine an
application's stack please let us know, or better yet submit a patch
:)

--=20
paul-moore.com
