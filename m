Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87247732082
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjFOTw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:52:54 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B4A268A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:52:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62ffb5f6aafso674306d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686858772; x=1689450772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTzq5hSsnrdspp0Q8Z2qZmybbO9m5q4PJef6PuPlxY4=;
        b=mFfch2X5A3Z/L3a+HkNlCsTl9QrojoGGyOvNVq/cpYjoXF6aDPK3raQfeMzOy2r0oM
         1+usKYqvfqZid6JeZDP0SrR0fzhFRG4tT1LIsbdEK60B9GcrlxvoXGhjTXOyBjkIWu/A
         kSe289SSpJXtx54Rgsicd0rrJQgwfRh3co5y0XIPxIrW8A3aEbpLn9aPFk0CqdEvt5CU
         WQggEC46WAdmJ3XruSBEpFXSzYQFO8l5E2n3ZtzZ6o7MXsHMh1465uz+OkKRxfxFkylv
         Fd7pn4HxPBsPSs6uVtBOPypSSa99c2y0w4TMMVjsVpy/3aGJNZpBO0MoC+Uly56Qi9fl
         FlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686858772; x=1689450772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTzq5hSsnrdspp0Q8Z2qZmybbO9m5q4PJef6PuPlxY4=;
        b=X97UgpjhfFZvk5RGoWWATom45mU5Dl1ghdQWLvp63wVDvzwPjfUNmgAY/4hJNIettj
         jXJiTV92+JcDabyobbRAc7xY46tO/YB2t4a44ZBbgjOALfmTWrwc8utkSs7nqS7hntK9
         yxqJAyHODuKIaGaivFJKD34rk2BlTLi0HODL5s9zhBn0B8Ct1OOEw5mCJkfsb/8+qWFj
         oZ4bv847LVIILZ1ufrTFemGlW4MxbfsrY1ATBYxw9+Fgmqyjjdm7rN8NERbENO3Ucl7V
         +eOfECSGxGYCVwuOfj+LxntZan/4BHbBGWk+dtANktY2KoeT3O66DF8quBEOdhb9ev+f
         If7w==
X-Gm-Message-State: AC+VfDxKTDuTEd+CoxSIpZvYaqQgcgyLAqaYzI+grNp5nTpVGUCJCupE
        dS/neylckr4h7+XUS1oUMupQYiJxx62tazTgLcP7KA==
X-Google-Smtp-Source: ACHHUZ7Sb3rvv0FFQfN7pGUeRbEn+6TYdTX8b2ZZ5a0LX/Fre8Y9zeSsAgqT+GEm/Edwv6sphAndGZmjGOXmIYbQksg=
X-Received: by 2002:a05:6214:d6c:b0:626:1e4e:b5b7 with SMTP id
 12-20020a0562140d6c00b006261e4eb5b7mr21421626qvs.59.1686858772406; Thu, 15
 Jun 2023 12:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <202306151433.QKcn7ZNn-lkp@intel.com> <ZIr0hZV/jcpZkRq2@smile.fi.intel.com>
In-Reply-To: <ZIr0hZV/jcpZkRq2@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Jun 2023 15:52:40 -0400
Message-ID: <CAKwvOd=Fj51=m0EZznjOmkqeZy_5uDZ_Gyf-Pv=yd2=53Gb6Sw@mail.gmail.com>
Subject: Re: lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239'
 declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
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

On Thu, Jun 15, 2023 at 7:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 15, 2023 at 02:32:02PM +0800, kernel test robot wrote:
> > Hi Alexander,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   b6dad5178ceaf23f369c3711062ce1f2afc33644
> > commit: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add =
compile-time optimization/evaluations assertions
> > date:   12 months ago
> > config: arm64-randconfig-r025-20230615 (https://download.01.org/0day-ci=
/archive/20230615/202306151433.QKcn7ZNn-lkp@intel.com/config)

^ randconfig

> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.gi=
t ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce (this is a W=3D1 build):
> >         mkdir -p ~/bin
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Ddc34d5036692c614eef23c1130ee42a201c316bf
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout dc34d5036692c614eef23c1130ee42a201c316bf
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Darm64 olddefconfig
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash lib/
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306151433.QKcn7ZNn-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
>
> >    888                /*
> >    889                 * Equals to `unsigned long bitmap[1] =3D { GENMA=
SK(6, 5), }`.
> >    890                 * Clang on s390 optimizes bitops at compile-time=
 as intended, but at
> >    891                 * the same time stops treating @bitmap and @bito=
pvar as compile-time
> >    892                 * constants after regular test_bit() is executed=
, thus triggering the
> >    893                 * build bugs below. So, call const_test_bit() th=
ere directly until
> >    894                 * the compiler is fixed.
> >    895                 */
> >    896                bitmap_clear(bitmap, 0, BITS_PER_LONG);
> >    897        #if defined(__s390__) && defined(__clang__)
> >    898                if (!const_test_bit(7, bitmap))
> >    899        #else
> >    900                if (!test_bit(7, bitmap))
> >    901        #endif
>
> Hmm... Reveals the bug in clang/arm64?

Seems related to the config.  ARCH=3Darm64 defconfig +
CONFIG_TEST_BITMAP=3Dy doesn't trigger this for me, but the randconfig
does.  We'll bisect the config, and update the thread tracking this:
https://github.com/ClangBuiltLinux/linux/issues/1874

>
> >    919                res =3D !test_bit(18, &bitopvar);
> >  > 920                BUILD_BUG_ON(!__builtin_constant_p(res));
> >    921                BUILD_BUG_ON(!res);
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>


--=20
Thanks,
~Nick Desaulniers
