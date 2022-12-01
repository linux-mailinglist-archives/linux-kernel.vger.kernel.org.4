Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17D63EC92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiLAJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLAJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:32:09 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C15A6D4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:32:08 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id i80so711607ioa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ExX3G3gkBnJUWc32+CDhQRweHtxmrn8z6j4Z35dZRPc=;
        b=kyjaVsokDTVxCiGPgkOYMbn02zXiSJSEJCfS2/vKoFQY/2Ujdx9bP+7Da8UWND3yi1
         9lcytZRbF1tzeeYYVEW0NPLivGtKCyGqw1Xhxmww6yjzZEgiz2vjrfJ435QnETurJFPS
         X2Ow2AJ5PUPi6r2EiGCBWyjAvuXPnZWLVRU5ypQP4h9h2Gs3idw9vTPnQwwzZQUvNRQD
         qv80zJUnW0jhSi9zvuxSKHygZGs5KeiEXNwXsM29uXdnycv2CIeLMI+kW/PD8BGidJ6k
         C2fKudfQQzyfeVx5TeBWmSIwHS7eWnYwzBTow0/Q8rSVnMtNap/P7aoF9lYxSwY+HvMv
         dhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExX3G3gkBnJUWc32+CDhQRweHtxmrn8z6j4Z35dZRPc=;
        b=nu6oKowpD80P53K7IfOXfZ7IhrWO4RrkJCkarCLgqNA7AH+QiSNPq71ESTnR5/4H6A
         tXuFSI+NrCkmU5vuxF6Bc5gHBpqYjtb0ubawZNLT4jhWbwkGTtuCOGrXGhe10MP0RtUQ
         NVZuCo6CU7qgVVPhkAYZDFLbl4vCIpFttpng2J9Y0aZ7PTqIG7/C6nW5gsZftgOqz2Sb
         9eju6b3tFxpbB4QJuyJ8z09a4bAfWIiDPoMVedxGGOb75SoqQVXtifykI/LNXUKE+KQl
         3rS22YeChRzQe7bPxvJdFUIchWqP6blS+aCJo/ckgopw5ib+MZLv8e78OquvrfktWvHb
         tswQ==
X-Gm-Message-State: ANoB5pmxV/qT46djVVkwHHgYlOinL06pToeALy2CJ9P9PwPDgxzt309Z
        rWrWm6Xfvv1WPioJT3dy30NIOf6JfFhmjie4imwFFA==
X-Google-Smtp-Source: AA0mqf6IUwisvqyqDqo3JJojHFmzcAuedM9nJqZvE2u7KtXpQacj6vSKLOROGwIXrkOHsq5UT3VmJEH4zQyYePIh8Yk=
X-Received: by 2002:a05:6638:89:b0:363:9e67:d9d9 with SMTP id
 v9-20020a056638008900b003639e67d9d9mr23171809jao.133.1669887127428; Thu, 01
 Dec 2022 01:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20221129191839.2471308-1-jannh@google.com> <20221129191839.2471308-2-jannh@google.com>
 <87fse1v4rf.ffs@tglx> <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
 <87y1rttid2.ffs@tglx> <1c767e89dcf8475f90d2d817b9096a55@AcuMS.aculab.com>
In-Reply-To: <1c767e89dcf8475f90d2d817b9096a55@AcuMS.aculab.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Dec 2022 10:31:31 +0100
Message-ID: <CAG48ez13gz12zQ_tEfO-GP+iA4KpE=27M5ziAtPqZezHiYVSfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] time/namespace: Forbid timens page faults under kthread_use_mm()
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Nov 30, 2022 at 11:48 PM David Laight <David.Laight@aculab.com> wrote:
> From: Thomas Gleixner
> > Sent: 30 November 2022 00:08
> ....
> > >> None of those VDSO (user space) addresses are subject to be faulted in
> > >> by anything else than the associated user space task(s).
> > >
> > > Are you saying that it's not possible or that it doesn't happen when
> > > userspace is well-behaved?
> >
> > My subconcious self told me that a kthread won't do that unless it's
> > buggered which makes the vdso fault path the least of our problems, but
> > thinking more about it: You are right, that there are ways that the
> > kthread ends up with a vdso page address.... Bah!
> >
> > Still my point stands that this is not a timens VDSO issue, but an issue
> > of: kthread tries to fault in a VDSO page of whatever nature.
>
> Isn't there also the kernel code path where one user thread
> reads data from another processes address space.
> (It does some unusual calls to the iov_import() functions.)
> I can't remember whether it is used by strace or gdb.
> But there is certainly the option of getting to access
> an 'invalid' address in the other process and then faulting.

That's a different mechanism. /proc/$pid/mem and process_vm_readv()
and PTRACE_PEEKDATA and so on go through get_user_pages_remote() or
pin_user_pages_remote(), which bail out on VMAs with VM_IO or
VM_PFNMAP. The ptrace-based access can also fall back to using
vma->vm_ops->access(), but the special_mapping_vmops used by the vvar
VMA explicitly don't have such a handler:

static const struct vm_operations_struct special_mapping_vmops = {
  .close = special_mapping_close,
  .fault = special_mapping_fault,
  .mremap = special_mapping_mremap,
  .name = special_mapping_name,
  /* vDSO code relies that VVAR can't be accessed remotely */
  .access = NULL,
  .may_split = special_mapping_split,
};

One path that I'm not sure about is the Intel i915 GPU virtualization
codepath ppgtt_populate_shadow_entry -> intel_gvt_dma_map_guest_page
-> gvt_dma_map_page -> gvt_pin_guest_page -> vfio_pin_pages ->
vfio_iommu_type1_pin_pages -> vfio_pin_page_external -> vaddr_get_pfns
-> follow_fault_pfn -> fixup_user_fault -> handle_mm_fault. That looks
like it might actually be able to trigger pagefault handling on the
vvar mapping from another process.

> ISTR not being convinced that there was a correct check
> for user/kernel addresses in it either.

The get_user_pages_remote() machinery only works on areas that are
mapped by VMAs (__get_user_pages() bails out if find_extend_vma()
fails and the address is not located in the gate area). There are no
VMAs for kernel memory.
