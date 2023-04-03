Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF46D4645
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjDCNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDCNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:55:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B004EDF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:55:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c29so38209036lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680530122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr44TItuNnAYmCkMRyFWU+nFevs9m8NmW2Lwd9YRKcg=;
        b=Q2fhX+thL4tkyX0Ki80dZq5Pju+tv40Q8K2n4Y0xnEzkorp4WZf5ud7tBgGXoK7DZK
         m4r2lxcXXRgGPZMil0ep6eoOUxx1bqk7NeIeSwgqH+5KErGoWIkobnR4ouMXvdLsgR2a
         GM1+e7Kw+szzLtlXE334gkHp7R+C01/2lSs/eVPhY6F71Dvu5TwdV0LeM8C2Dk4IkM6p
         ilnDSFA8VA+FhdxyYSrwu7N/68hcn5nWLyU4kuYFHT44MVBt9ttk5atb6BJ2iAnqyTzN
         mC740GKeL/yu5ecfhLdL6euakyah1dMaI8qsWu7SVvxblCvS5MhSvP8dRkboHNjoTMPh
         lIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cr44TItuNnAYmCkMRyFWU+nFevs9m8NmW2Lwd9YRKcg=;
        b=pXoQzQwRv3MS26k662XMA27n3rZ99sNmXFxQuVXwALVa5pcJEaQpooIPXuZaNXoRlL
         gXeMnTlZyJWB6i+aqNIRVu2GoMpdBS/mTissMwOagy1Cvg2eq67zGwLnZyOSfyneWjHx
         2nl6TZVDS1YxsPicMuTynKC2/IFabNAegK+s6OQTmJQ17Hdd2jAkOXufzApvRbaOSU4H
         4+W506JLWTijxUVHZFA23bKHSp24a25l8/SalRNN9YR/bcfqVWVe44iNB+VZjxaZ8/QM
         zjiO5bf0rTvrux2ApwJlNuZ4TP0RQ7xKPYVL4IXTlMiN4vSs/8zeFJohEAWfu0EekTe2
         qTXQ==
X-Gm-Message-State: AAQBX9dpAZrs04wrw83ewdrGEXibYhnLqdOD7tb084xLpBkZ5nAwl4zf
        4LJGLEK844pzxp3w9SBsE9kHMx1pMyC2kdGMj97czg==
X-Google-Smtp-Source: AKy350YFRak7MV4KuwcbOFrzdYnIESU6ZH4j05logCd/WNnVznAWadJB528qykijbARZewuA+mSaWBSmScEvXBSYUj0=
X-Received: by 2002:a19:ae04:0:b0:4eb:4160:7ca8 with SMTP id
 f4-20020a19ae04000000b004eb41607ca8mr777178lfc.6.1680530121691; Mon, 03 Apr
 2023 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com> <20230403111020.3136-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230403111020.3136-3-kirill.shutemov@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 15:55:09 +0200
Message-ID: <CACT4Y+YoS9e=QVq6iKda5Gv852kVv9OTLaOZ=XCJ65mP0oyAOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/mm/iommu/sva: Do not allow to set
 FORCE_TAGGED_SVA bit from outside
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 13:10, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> arch_prctl(ARCH_FORCE_TAGGED_SVA) overrides the default and allows LAM
> and SVA to co-exist in the process. It is expected by called by the
> process when it knows what it is doing.
>
> arch_prctl() operates on the current process, but the same code is
> reachable from ptrace where it can be called on arbitrary task.
>
> Make it strict and only allow to set MM_CONTEXT_FORCE_TAGGED_SVA for the
> current process.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  arch/x86/kernel/process_64.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index c7dfd727c9ec..cefac2d3a9f6 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -885,6 +885,8 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>         case ARCH_ENABLE_TAGGED_ADDR:
>                 return prctl_enable_tagged_addr(task->mm, arg2);
>         case ARCH_FORCE_TAGGED_SVA:
> +               if (current != task)
> +                       return -EINVAL;

prctl_enable_tagged_addr() checks "task->mm != current->mm".
Should we check the same here for consistency? Or also change the
check in prctl_enable_tagged_addr().

arch_prctl() can only do task==current, so I guess "current != task"
is a more reasonable check for prctl_enable_tagged_addr() as well.



>                 set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
>                 return 0;
>         case ARCH_GET_MAX_TAG_BITS:
> --
> 2.39.2
>
