Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD065AC9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 01:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjABATE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 19:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABATC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 19:19:02 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE35101F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 16:19:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id i19so14899217ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 16:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoxOMirVxjVMz6HgPkWOUqIX78Qz87TJFD3kE2Q06Bs=;
        b=gligsVQqBH9gIy9eCjzeb01XC6qQLFpi5ixH3zZQLiwL9psiWcdVq5AUsNBnU1er9n
         iGMYTtnQIz1TUP0uZsGzh4uVk5tTQ+OwM7S+qcpk8WMMtxTKoZeF5BEfJJ9JUBPSK0HY
         QrhMm/9Zy73aTBMaTBg+4PnWf9JwlJdmV19p1G3nmf4XfZNVsTLCOiReFuHpuyjiJKhs
         Bs+/L94yTfIbUbArRLWFv3ENFTga10qjlk/zO0VvdWxs711biIh2aWFB3Stkk9hR2cI+
         NyxHosCcJAZl4fVpd7YhHtjId3Xp9bTFKGxvV8DU04EFWqaoAfjGIGdC7XEtSIjtZghm
         YAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoxOMirVxjVMz6HgPkWOUqIX78Qz87TJFD3kE2Q06Bs=;
        b=dtBKazDBqjIB3elo+qgCfxFZKPYE3VAwQ1I8ZpvZbBJ4dRMobfjfeKXgGc60oRoYfv
         cQQaDuBqP0Zd6ZkKEU8Jk/sMndZH6xi3A7Iu1nDTqSHiq6z/460nxsYNyEO0cXHAQzxq
         A3Xjr5Z5fO/OrNt5Hl7bu9hC6x9SoGBdhunQpcoRiY2vPtM0G5mj8xnNmplmVZ/xseWm
         eInX5fkEIbqHbZPIs3qaChO/PIPGo6POFS/NzIy52+BBhoK2nLuomA7eRUrdhTEaQVj4
         KivTMquYoCVvjR+pdpEQSbwSJRhwr12nHSFkHNVG0tFqsyTHctwnFY6pnIRXW3TOZiA0
         z1Gg==
X-Gm-Message-State: AFqh2koyvFJvgmXpOxeiR7bhPv9jq1vxu3gpV9/3zR9ZNjAIk/wHNZy9
        zJRHxgU1RewiKqFXHDhBCYiXs0px+89gWDbHDRg=
X-Google-Smtp-Source: AMrXdXvDbbRTyNk+bpvsscRHHwZYT8L1loW/+diapeAM178vk5gfZddeodS0b+g4h+zL6qub3NbZpR1QVy3/eUo3HGY=
X-Received: by 2002:a2e:87ce:0:b0:27f:f062:8957 with SMTP id
 v14-20020a2e87ce000000b0027ff0628957mr157098ljj.479.1672618739315; Sun, 01
 Jan 2023 16:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20221231051954.2038772-1-yoochan1026@gmail.com> <202301020540.wMrbqIkY-lkp@intel.com>
In-Reply-To: <202301020540.wMrbqIkY-lkp@intel.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Mon, 2 Jan 2023 09:18:48 +0900
Message-ID: <CALQpDLd+eEYv=qkPOoPkRGe5RX2eTgUfj_pp838eDX39Cfke2w@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee_smc_open
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

I fix the errors in the previous patch.

From 2046cc19aeaddb5f6fb5e9b1d9a380a116892657 Mon Sep 17 00:00:00 2001
From: Yoochan Lee <yoochan1026@gmail.com>
Date: Mon, 2 Jan 2023 09:18:23 +0900
Subject: [PATCH 2/2] fix errors in previous patch

---
 drivers/tee/optee/smc_abi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 4fbec2acc255..be662f263f29 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1103,12 +1103,7 @@ static void optee_smc_release_supp(struct
tee_context *ctx)
 {
  struct optee *optee =3D tee_get_drvdata(ctx->teedev);

- optee_release_helper(ctx, optee_close_session_helper);
- if (optee->scan_bus_wq) {
- destroy_workqueue(optee->scan_bus_wq);
- optee->scan_bus_wq =3D NULL;
- }
- optee_supp_release(&optee->supp);
+ optee_release_supp(ctx)
  kref_put(&optee->refcnt, optee_smc_delete);
 }

@@ -1116,7 +1111,7 @@ static void optee_smc_release(struct tee_context *ctx=
)
 {
  struct optee *optee =3D tee_get_drvdata(ctx->teedev);

- optee_release_helper(ctx, optee_close_session_helper);
+ optee_release(ctx);
  kref_put(&optee->refcnt, optee_smc_delete);
 }

--
2.39.0

2023=EB=85=84 1=EC=9B=94 2=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 6:43, ke=
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
tee-smc_abi-Fix-use-after-free-in-optee_smc_open/20221231-132046
> patch link:    https://lore.kernel.org/r/20221231051954.2038772-1-yoochan=
1026%40gmail.com
> patch subject: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee_s=
mc_open
> config: arm-randconfig-c002-20221231
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project f570=
0e7b69048de958172fb513b336564e7f8709)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/6d3d5f78a2463a577=
c1a908cdedda61affba9c01
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Yoochan-Lee/tee-optee-smc_abi-Fi=
x-use-after-free-in-optee_smc_open/20221231-132046
>         git checkout 6d3d5f78a2463a577c1a908cdedda61affba9c01
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
> All errors (new ones prefixed by >>):
>
> >> drivers/tee/optee/smc_abi.c:1106:2: error: call to undeclared function=
 'optee_release_helper'; ISO C99 and later do not support implicit function=
 declarations [-Wimplicit-function-declaration]
>            optee_release_helper(ctx, optee_close_session_helper);
>            ^
>    drivers/tee/optee/smc_abi.c:1106:2: note: did you mean 'optee_release_=
supp'?
>    drivers/tee/optee/optee_private.h:258:6: note: 'optee_release_supp' de=
clared here
>    void optee_release_supp(struct tee_context *ctx);
>         ^
>    drivers/tee/optee/smc_abi.c:1119:2: error: call to undeclared function=
 'optee_release_helper'; ISO C99 and later do not support implicit function=
 declarations [-Wimplicit-function-declaration]
>            optee_release_helper(ctx, optee_close_session_helper);
>            ^
>    2 errors generated.
>
>
> vim +/optee_release_helper +1106 drivers/tee/optee/smc_abi.c
>
>   1101
>   1102  static void optee_smc_release_supp(struct tee_context *ctx)
>   1103  {
>   1104          struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>   1105
> > 1106          optee_release_helper(ctx, optee_close_session_helper);
>   1107          if (optee->scan_bus_wq) {
>   1108                  destroy_workqueue(optee->scan_bus_wq);
>   1109                  optee->scan_bus_wq =3D NULL;
>   1110          }
>   1111          optee_supp_release(&optee->supp);
>   1112          kref_put(&optee->refcnt, optee_smc_delete);
>   1113  }
>   1114
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
