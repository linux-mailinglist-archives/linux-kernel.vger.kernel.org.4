Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988E65AC98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 01:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjABARQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 19:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABARO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 19:17:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641AAFE9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 16:17:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 1so39518974lfz.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6nRfoijxk3uR6m8/DRVshsbz5chvsyMXxKmiNheHYI=;
        b=nSYTyI0gdEIvPfWAftFUh7mxyN23liDdjpH6Lcpq4XS85cAm/X9vx8OU/YZiTGcm0K
         uhrsGADtuL8qR899y9460r/GCueYJ+ctiOrdNTXprJXwlWcd6Z/UJIf4Mxb6Hd5XM/4s
         xtjtzr6vw0V+2or7SukhShpEJa0N0dj/taWID2vyWGly5ZA0C4+IUm+cFF37LOiZfK6S
         Kfu0ttjeBwMg8BAOkmxRK+moWOUlfh9DteZYBhxbcM90Qx0B9tsxpBDmguIYUgj0Aas7
         45mbEujVKVzLyeAaQVGBXVcxcidUvgdLssRDhjqtW6ZSf6P7knB+8l4KdRdhrD1N2WgZ
         NM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6nRfoijxk3uR6m8/DRVshsbz5chvsyMXxKmiNheHYI=;
        b=QFnnM62Q+WRxtreQzJ/a9eV2WypozGXKDdlh0XBjEFkBD4xA9OqEsi7F6KJOAg61Hz
         j7DP1OLtTqZtO03uw8eJ38nV8J5j2VWbf7uL43tOirwwOAVF+a1LUEf4etjeghbp9mTI
         K4Ru60eS+gJVE/o8A9UIZctLGGPq+9a3yxnC4rwbJNOyCoUFT4o6AQkxQkpougZJDlSh
         eZ9qcHAj78ATw0DJLOEJ+45CSDd+25itx0vOQvB/LYovmDzUDQ+lv6C/w6Baohx6J4Qa
         nVu4VrC3xJNlnG1AaLaRmxZSwAa15R3eASgoJqvEv2mXat21LFucam7+b9w/8FzV0kth
         6nGA==
X-Gm-Message-State: AFqh2kpGz4p8DL36Yao53v0pD5h+GMUS+Wyc00/BAh764ScsXBq9KWqC
        UKgdbcYQ25+u0RK8zKxl8gBsZVVQdGJaFMHDCZo=
X-Google-Smtp-Source: AMrXdXtJrmmkBFGHvmuH0AKQO7lues9gnuOYmAmAOHmTU5Rewfka6tN+7qWOaHRqXtlxk9vnP5rmr8D6sT2H2hAJSwg=
X-Received: by 2002:ac2:5492:0:b0:4cb:19fe:5640 with SMTP id
 t18-20020ac25492000000b004cb19fe5640mr1523073lfk.556.1672618631532; Sun, 01
 Jan 2023 16:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20221231053421.2039591-1-yoochan1026@gmail.com> <202301020326.pzL5zDsa-lkp@intel.com>
In-Reply-To: <202301020326.pzL5zDsa-lkp@intel.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Mon, 2 Jan 2023 09:17:00 +0900
Message-ID: <CALQpDLcLghTY44YumjGj8McLsTUDkcxTKMOmjA5-oqEPGBG3ww@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee_ffa_open
To:     kernel test robot <lkp@intel.com>
Cc:     jens.wiklander@linaro.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fix the error in the previous patch.

From fde49d86f6401789ba51f267a0d79fbe4e7ffc24 Mon Sep 17 00:00:00 2001
From: Yoochan Lee <yoochan1026@gmail.com>
Date: Mon, 2 Jan 2023 09:16:05 +0900
Subject: [PATCH 2/2] fix errors in previous patch

---
 drivers/tee/optee/ffa_abi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ea76d7532419..65d9463d9ed8 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -741,28 +741,23 @@ static void optee_ffa_delete(struct kref *kref)

 static void optee_ffa_release(struct tee_context *ctx)
 {
- struct optee *optee =3D tee_get_drvdata(teedev);
-
- optee_release_helper(ctx, optee_close_session_helper);
+ struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+
+ optee_release(ctx);
  kref_put(&optee->refcnt, optee_ffa_delete);
 }

 void optee_ffa_release_supp(struct tee_context *ctx)
 {
  struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-
- optee_release_helper(ctx, optee_close_session_helper);
- if (optee->scan_bus_wq) {
- destroy_workqueue(optee->scan_bus_wq);
- optee->scan_bus_wq =3D NULL;
- }
- optee_supp_release(&optee->supp);
+
+ optee_release_supp(ctx);
  kref_put(&optee->refcnt, optee_ffa_delete);
 }

 static int optee_ffa_open(struct tee_context *ctx)
 {
- struct optee *optee =3D tee_get_drvdata(teedev);
+ struct optee *optee =3D tee_get_drvdata(ctx->teedev);
  kref_get(&optee->refcnt);

  return optee_open(ctx, true);
--
2.39.0

2023=EB=85=84 1=EC=9B=94 2=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 5:12, ke=
rnel test robot <lkp@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Yoochan,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.2-rc1 next-20221226]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yoochan-Lee/tee-op=
tee-ffa_abi-Fix-use-after-free-in-optee_ffa_open/20221231-133611
> patch link:    https://lore.kernel.org/r/20221231053421.2039591-1-yoochan=
1026%40gmail.com
> patch subject: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee_f=
fa_open
> config: arm-randconfig-c002-20221231
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project f570=
0e7b69048de958172fb513b336564e7f8709)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/3fe68a00d912f9e5d=
bec5002a7d30cf2a0868679
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Yoochan-Lee/tee-optee-ffa_abi-Fi=
x-use-after-free-in-optee_ffa_open/20221231-133611
>         git checkout 3fe68a00d912f9e5dbec5002a7d30cf2a0868679
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash drivers/tee/optee/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
> >> drivers/tee/optee/ffa_abi.c:744:40: error: use of undeclared identifie=
r 'teedev'
>            struct optee *optee =3D tee_get_drvdata(teedev);
>                                                  ^
> >> drivers/tee/optee/ffa_abi.c:746:2: error: call to undeclared function =
'optee_release_helper'; ISO C99 and later do not support implicit function =
declarations [-Wimplicit-function-declaration]
>            optee_release_helper(ctx, optee_close_session_helper);
>            ^
>    drivers/tee/optee/ffa_abi.c:746:2: note: did you mean 'optee_release_s=
upp'?
>    drivers/tee/optee/optee_private.h:258:6: note: 'optee_release_supp' de=
clared here
>    void optee_release_supp(struct tee_context *ctx);
>         ^
>    drivers/tee/optee/ffa_abi.c:754:2: error: call to undeclared function =
'optee_release_helper'; ISO C99 and later do not support implicit function =
declarations [-Wimplicit-function-declaration]
>            optee_release_helper(ctx, optee_close_session_helper);
>            ^
> >> drivers/tee/optee/ffa_abi.c:750:6: warning: no previous prototype for =
function 'optee_ffa_release_supp' [-Wmissing-prototypes]
>    void optee_ffa_release_supp(struct tee_context *ctx)
>         ^
>    drivers/tee/optee/ffa_abi.c:750:1: note: declare 'static' if the funct=
ion is not intended to be used outside of this translation unit
>    void optee_ffa_release_supp(struct tee_context *ctx)
>    ^
>    static
>    drivers/tee/optee/ffa_abi.c:765:40: error: use of undeclared identifie=
r 'teedev'
>            struct optee *optee =3D tee_get_drvdata(teedev);
>                                                  ^
>    1 warning and 4 errors generated.
>
>
> vim +/teedev +744 drivers/tee/optee/ffa_abi.c
>
>    741
>    742  static void optee_ffa_release(struct tee_context *ctx)
>    743  {
>  > 744          struct optee *optee =3D tee_get_drvdata(teedev);
>    745
>  > 746          optee_release_helper(ctx, optee_close_session_helper);
>    747          kref_put(&optee->refcnt, optee_ffa_delete);
>    748  }
>    749
>  > 750  void optee_ffa_release_supp(struct tee_context *ctx)
>    751  {
>    752          struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>    753
>    754          optee_release_helper(ctx, optee_close_session_helper);
>    755          if (optee->scan_bus_wq) {
>    756                  destroy_workqueue(optee->scan_bus_wq);
>    757                  optee->scan_bus_wq =3D NULL;
>    758          }
>    759          optee_supp_release(&optee->supp);
>    760          kref_put(&optee->refcnt, optee_ffa_delete);
>    761  }
>    762
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
