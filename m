Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6462D65A890
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 02:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjAABj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 20:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAABjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 20:39:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A062DDB
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:39:23 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bt23so20344285lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSDmMj8Zj2JpGcdk91mqxIwFY6redfKEMs+PhYIGZs8=;
        b=n6CggSLh+ISZfdjwNDvrB9QiNqFeXM/vh3j8yQENKteNcE4UpICvpijhY0bL3xOH+Q
         W0Yz615Bq6kIVLTgJA9l8giou+kk0Mo901GfNC5u2BZvzjjRDTaBv8gIxDS8XeOp691b
         ZN8PYnp5wRnlx1qrLirY8IrsLgNmcXLV2lQz40Ch3UOQVErmaflMzl9mc6+eQ9OPOibL
         Q+94im7AuycVL6QUzfIZk9Z0DjXMuqi5dM/EKrHRQAQkjpc9smDlNSBNTVYIDtfIK+Ke
         8WhD2PMvHvS9wL+5hJqYSz3AW4aDFE3+o3PlNjYlkoBHGaEWb1F2tKCoi34EEOkWEb+/
         jaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSDmMj8Zj2JpGcdk91mqxIwFY6redfKEMs+PhYIGZs8=;
        b=jnaqvmrmXjRAOJhbF3a3Xo1Lb/ELMoq65Ux3yC2XgegFltx5RsRem1AU8BgeUFifC8
         9PjgXuOkbrR9Vt1XO5Eg21/P/VkpfbRGXEEDdppLJtXv5SHc6rqQXMjZrENg3AmYecoj
         IGekI5YLS97KXxtwh+f9run6Tc1M8t1ZQBxVOBF98zev39umRVjIBwGDk1qrohfwSir8
         lF7Qe22fOMjEilufmTE/eDgPoePn66RFZ9z6cGrjxydkO1c5YH2tXMMid+8vmtYjYbsq
         PbBLxDnbbhwwBIhueXiMDMC40fPrq5h47wbcy6beDlwCZfMadO59P910W03G/xYGIH8i
         +4Kg==
X-Gm-Message-State: AFqh2koAm40D2AHgRetN0RdoJT+IIduWttqfN6pA9i1UG2I7P0OKu5i0
        plPDlcQfy2011ZVHIHyGaSZSat8yeqQ3zGqhfEu/JTCQtXjYDg==
X-Google-Smtp-Source: AMrXdXvwdlwOCfYns0Gk4lbSGGyBwR+/ptTcsc0KgS9GidSLzYWTElSIPTAh4sovoCAJew0EOE4Itpzj9EagJ5gfj/A=
X-Received: by 2002:a05:6512:2188:b0:4b5:769e:7437 with SMTP id
 b8-20020a056512218800b004b5769e7437mr2949065lft.510.1672537161573; Sat, 31
 Dec 2022 17:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20221231032826.2034288-1-yoochan1026@gmail.com> <202301010221.JnaEBOiq-lkp@intel.com>
In-Reply-To: <202301010221.JnaEBOiq-lkp@intel.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Sun, 1 Jan 2023 10:39:09 +0900
Message-ID: <CALQpDLfxFeznz_YA87fbDYOu7bgcqtcyqJv6WT-We08uL2+jqg@mail.gmail.com>
Subject: Re: [PATCH] char: xilinx_hwicap: xilinx_hwicap: Fix use-after-free in hwicap_open
To:     kernel test robot <lkp@intel.com>
Cc:     arnd@arndb.de, oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

I fix an error in the previous patch.

From ac8e2271ddc68ff53279d6f8d7ae8c114f3cfbf7 Mon Sep 17 00:00:00 2001
From: Yoochan Lee <yoochan1026@gmail.com>
Date: Sun, 1 Jan 2023 10:38:48 +0900
Subject: [PATCH 2/2] Fix errors in previous patch

---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index d93abd99bd37..b219ee3142dc 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -217,6 +217,7 @@ static const struct config_registers v6_config_register=
s =3D {
  .CTL_1 =3D 24,
 };

+static void hwicap_delete(struct kref *kref);
 /**
  * hwicap_command_desync - Send a DESYNC command to the ICAP port.
  * @drvdata: a pointer to the drvdata.
@@ -733,6 +734,10 @@ static int hwicap_remove(struct device *dev)
  if (!drvdata)
  return 0;

+ mutex_lock(&icap_sem);
+ probed_devices[MINOR(dev->devt)-XHWICAP_MINOR] =3D 0;
+ mutex_unlock(&icap_sem);
+
  kref_put(&drvdata->refcnt, hwicap_delete);

  return 0; /* success */
@@ -835,10 +840,6 @@ static void hwicap_delete(struct kref *kref)
  iounmap(drvdata->base_address);
  release_mem_region(drvdata->mem_start, drvdata->mem_size);
  kfree(drvdata);
-
- mutex_lock(&icap_sem);
- probed_devices[MINOR(dev->devt)-XHWICAP_MINOR] =3D 0;
- mutex_unlock(&icap_sem);
 }

 #ifdef CONFIG_OF
--
2.39.0

2023=EB=85=84 1=EC=9B=94 1=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 3:26, ke=
rnel test robot <lkp@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Yoochan,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on char-misc/char-misc-testing char-misc/char-misc=
-next char-misc/char-misc-linus linus/master v6.2-rc1 next-20221226]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yoochan-Lee/char-x=
ilinx_hwicap-xilinx_hwicap-Fix-use-after-free-in-hwicap_open/20221231-11295=
7
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-n=
ext
> patch link:    https://lore.kernel.org/r/20221231032826.2034288-1-yoochan=
1026%40gmail.com
> patch subject: [PATCH] char: xilinx_hwicap: xilinx_hwicap: Fix use-after-=
free in hwicap_open
> config: microblaze-randconfig-r013-20221226
> compiler: microblaze-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/85568c4b21398a7da=
51b017dbbf78424b59f1f2f
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Yoochan-Lee/char-xilinx_hwicap-x=
ilinx_hwicap-Fix-use-after-free-in-hwicap_open/20221231-112957
>         git checkout 85568c4b21398a7da51b017dbbf78424b59f1f2f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dmicroblaze olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dmicroblaze SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/char/xilinx_hwicap/xilinx_hwicap.c: In function 'hwicap_releas=
e':
> >> drivers/char/xilinx_hwicap/xilinx_hwicap.c:587:36: error: 'hwicap_dele=
te' undeclared (first use in this function); did you mean 'hwicap_release'?
>      587 |         kref_put(&drvdata->refcnt, hwicap_delete);
>          |                                    ^~~~~~~~~~~~~
>          |                                    hwicap_release
>    drivers/char/xilinx_hwicap/xilinx_hwicap.c:587:36: note: each undeclar=
ed identifier is reported only once for each function it appears in
>    drivers/char/xilinx_hwicap/xilinx_hwicap.c: In function 'hwicap_remove=
':
>    drivers/char/xilinx_hwicap/xilinx_hwicap.c:736:36: error: 'hwicap_dele=
te' undeclared (first use in this function); did you mean 'hwicap_release'?
>      736 |         kref_put(&drvdata->refcnt, hwicap_delete);
>          |                                    ^~~~~~~~~~~~~
>          |                                    hwicap_release
>    In file included from include/linux/fs.h:7,
>                     from include/linux/huge_mm.h:8,
>                     from include/linux/mm.h:737,
>                     from arch/microblaze/include/asm/io.h:14,
>                     from include/linux/io.h:13,
>                     from include/linux/irq.h:20,
>                     from include/asm-generic/hardirq.h:17,
>                     from ./arch/microblaze/include/generated/asm/hardirq.=
h:1,
>                     from include/linux/hardirq.h:11,
>                     from include/linux/interrupt.h:11,
>                     from drivers/char/xilinx_hwicap/xilinx_hwicap.c:78:
>    drivers/char/xilinx_hwicap/xilinx_hwicap.c: In function 'hwicap_delete=
':
> >> drivers/char/xilinx_hwicap/xilinx_hwicap.c:840:30: error: 'dev' undecl=
ared (first use in this function); did you mean 'cdev'?
>      840 |         probed_devices[MINOR(dev->devt)-XHWICAP_MINOR] =3D 0;
>          |                              ^~~
>    include/linux/kdev_t.h:11:43: note: in definition of macro 'MINOR'
>       11 | #define MINOR(dev)      ((unsigned int) ((dev) & MINORMASK))
>          |                                           ^~~
>    drivers/char/xilinx_hwicap/xilinx_hwicap.c: At top level:
>    drivers/char/xilinx_hwicap/xilinx_hwicap.c:829:13: warning: 'hwicap_de=
lete' defined but not used [-Wunused-function]
>      829 | static void hwicap_delete(struct kref *kref)
>          |             ^~~~~~~~~~~~~
>
>
> vim +587 drivers/char/xilinx_hwicap/xilinx_hwicap.c
>
>    564
>    565  static int hwicap_release(struct inode *inode, struct file *file)
>    566  {
>    567          struct hwicap_drvdata *drvdata =3D file->private_data;
>    568          int i;
>    569          int status =3D 0;
>    570
>    571          mutex_lock(&drvdata->sem);
>    572
>    573          if (drvdata->write_buffer_in_use) {
>    574                  /* Flush write buffer. */
>    575                  for (i =3D drvdata->write_buffer_in_use; i < 4; i=
++)
>    576                          drvdata->write_buffer[i] =3D 0;
>    577
>    578                  status =3D drvdata->config->set_configuration(drv=
data,
>    579                                  (u32 *) drvdata->write_buffer, 1)=
;
>    580                  if (status)
>    581                          goto error;
>    582          }
>    583
>    584          status =3D hwicap_command_desync(drvdata);
>    585          if (status)
>    586                  goto error;
>  > 587          kref_put(&drvdata->refcnt, hwicap_delete);
>    588
>    589   error:
>    590          drvdata->is_open =3D 0;
>    591          mutex_unlock(&drvdata->sem);
>    592          return status;
>    593  }
>    594
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
