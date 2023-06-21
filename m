Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD40737BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFUHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUHBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:01:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77D1995
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:01:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-be49e41a3d6so4228158276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687330913; x=1689922913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnM3sYZw3GQcW3MdVZ0ugqF6RBJgBdIColQtb9ed96U=;
        b=a4iI/7HHF7LWkvUxwasul3Oew6a00PDMS+4RRczoEtTu+rn1akG807FhZCMtKt9V33
         Z2PPMEixfV4XZEyq7gKkigWK/VmisCkTXu2hnCwMYe5rLG1csEPQcEa6r1ib1p/l0pR8
         6v4jOz9tC6E0g53EIYbxaWQlhF9bHX2ggVBNZLrnkJrJifl4xcqJ2xhAc+wh3A2/cTlJ
         eCRkJc6WiDONnk5ad+3oM6GVBRZsWaIVmcL/koFlqBoAT+hDJTSNtdrWQ0hYkEEmp2+m
         AGZtTYcRKckzbLixgJt7UA5RPLtt4eXVvSxnBMPaRznjQzApDE48uzkhva80M8spyvzJ
         jhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687330913; x=1689922913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnM3sYZw3GQcW3MdVZ0ugqF6RBJgBdIColQtb9ed96U=;
        b=lvJKMeBhSCBYIz7J5g2z6IT2O+Kk1u8u7ZbtvGPbxJmr/kNcz5Il01V1iiZf0uzcXP
         626+5L/0S5WKriHcVBMZ38tkllgHCkZTqG/epK9g5PrYsmC7KHjrtDxMt6aKuxkEIhWe
         3JtxhX0oT9KMQ+e0rRj22qo6MyzyZssySsNOjEziau2XyOtOzGCujeXfbNm9PcccR183
         01wFuRmUIjnkD4gLInfl9AgI2vqt0aVw2AjQUivnVn+b5IltzMjtxe74OVwj6ObhIjG9
         xDbui+QF8MpPj4gljvN5j0VDF5bRRfkUHjU7OIdHUFUNHJv3n1l6uSLXdW54ax1sSIgw
         D5FQ==
X-Gm-Message-State: AC+VfDwhCAJCWBKaSi1PaVKlDCF9jx0EwhW2vpPPQ9ok2Oucb7lFuVQ2
        X0g7Mzm45LvEb4nwgilW0q8mDiwSoNY5I0rbvwNGLg==
X-Google-Smtp-Source: ACHHUZ7mdnwc40MDjB3o9RSDv/jVj8fi7F6Bg8LeH5WY2hbfqm3Z3rPjfVpRya0+1GDilZrRCM5V09DyYLeDpHfPkMU=
X-Received: by 2002:a25:9391:0:b0:bd5:8625:89fc with SMTP id
 a17-20020a259391000000b00bd5862589fcmr5016173ybm.26.1687330912645; Wed, 21
 Jun 2023 00:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230620235726.3873043-3-surenb@google.com> <202306211007.hQoEsMrP-lkp@intel.com>
In-Reply-To: <202306211007.hQoEsMrP-lkp@intel.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Jun 2023 00:01:41 -0700
Message-ID: <CAJuCfpGQb9ULrumZH3x=21--Sh9yJzWLHNcYTZGxi8DxeVkxGA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: check for VMA being detached before destroying it
To:     kernel test robot <lkp@intel.com>
Cc:     akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev,
        willy@infradead.org, torvalds@linuxfoundation.org,
        vegard.nossum@oracle.com, mpe@ellerman.id.au,
        Liam.Howlett@oracle.com, lrh2000@pku.edu.cn, mgorman@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 7:15=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Suren,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan=
/mm-change-vma_start_read-to-fail-to-lock-a-detached-VMA/20230621-075833
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20230620235726.3873043-3-surenb%=
40google.com
> patch subject: [PATCH 3/3] mm: check for VMA being detached before destro=
ying it
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230=
621/202306211007.hQoEsMrP-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211007=
.hQoEsMrP-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306211007.hQoEsMrP-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflic=
ts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconfli=
cts-rr]
>    scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' =
to generate conflict counterexamples
>    In file included from include/linux/pid_namespace.h:7,
>                     from include/linux/ptrace.h:10,
>                     from arch/alpha/kernel/asm-offsets.c:11:
>    include/linux/mm.h: In function 'vma_init':
> >> include/linux/mm.h:753:12: error: 'struct vm_area_struct' has no membe=
r named 'detached'
>      753 |         vma->detached =3D true;
>          |            ^~

Yep, missed #ifdef CONFIG_PER_VMA_LOCK here. Will fix it in the next
version but will wait a bit for possible feedback.

>    arch/alpha/kernel/asm-offsets.c: At top level:
>    arch/alpha/kernel/asm-offsets.c:15:6: warning: no previous prototype f=
or 'foo' [-Wmissing-prototypes]
>       15 | void foo(void)
>          |      ^~~
>    make[2]: *** [scripts/Makefile.build:114: arch/alpha/kernel/asm-offset=
s.s] Error 1
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:1287: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:226: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
>
> vim +753 include/linux/mm.h
>
>    740
>    741  /*
>    742   * WARNING: vma_init does not initialize vma->vm_lock.
>    743   * Use vm_area_alloc()/vm_area_free() if vma needs locking.
>    744   */
>    745  static inline void vma_init(struct vm_area_struct *vma, struct mm=
_struct *mm)
>    746  {
>    747          static const struct vm_operations_struct dummy_vm_ops =3D=
 {};
>    748
>    749          memset(vma, 0, sizeof(*vma));
>    750          vma->vm_mm =3D mm;
>    751          vma->vm_ops =3D &dummy_vm_ops;
>    752          INIT_LIST_HEAD(&vma->anon_vma_chain);
>  > 753          vma->detached =3D true;
>    754          vma_numab_state_init(vma);
>    755  }
>    756
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
