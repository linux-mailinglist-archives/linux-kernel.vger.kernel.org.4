Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4182565A36B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiLaJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:49:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBC5D131
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:49:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p36so34748513lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17jMHQq8/uMXbL94GbeXOBClwVQn718NCObnVGdB5GQ=;
        b=XuBCkuBzlClWFA4xeenlbpw/3ALe+XwOy8WO5XDjSu/O2eaN2gyovG9neEkopIFAJr
         82he37eoBiKgg8JAtlyuaQ9ksLk7Vfsb50+NelP7YArUwCUw6z0GWPC8nJ2Y7EJA8fAL
         dl7UgG3W/6hHBUYdX098HtHMi1pDoD2makVkJxlT87c8ZCo+PZqr7tRRn5tfYNOHqWID
         Rh5415vULU4gjQr3tSQxfPVmOWamUfBXaIil+IiQ3naOZvFRsgXXJkrKwPHidZG93vEo
         d3P+AGoxzJTjlkHS3m5CJQESIu/sTvZRS3uZWNMy5WXO91GBRTBVQLVSVtmS6WPHfgZG
         hrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17jMHQq8/uMXbL94GbeXOBClwVQn718NCObnVGdB5GQ=;
        b=2+Fb7a7K1u5/Z3bDXGb/H0CFk7UZ3dtyk1LdwtzE2ePlgQSezloULBCMZkQe/qSnKX
         FiwTnCdGgs/ERMglxpNc6DpZiMB5OYaYvC3UZZQRJvGznhPkPGp5wUKKgn/hL41TxmhL
         I6gYeAde1EKUQqE2HvPuy4SKgQqOxFBDeRVE2/k8Zf3Pb9/Z7FWY0qfqacDNxLJ8wLsM
         +b32Gc48MuiYwKeKbiTAjmpB3gYU0GOKrKqds4Ie/cIlANoE9gdbDsqO28mn+9j4+vCR
         iFrQDtEfG4Z9cLi5OrjiEwKgGJFcTDqXkD7aJb5+twtiNKjzmOkVGkarncA4v7NgJZl8
         cr6w==
X-Gm-Message-State: AFqh2kqBGPqWiYx/1j+8JEeRLeWdmKLCZUeDJ0o3T/rka5qerq+HYZc2
        0I6nEZb37Cik1XNW4Kj3cTNO5GZ6di689yfj61c=
X-Google-Smtp-Source: AMrXdXuWtzQ3TzexbHK3yHqyjFxVL0geFcFLsvSa61yTkEkG+fX+wgGK1+ZlHsbuz99Znp0sjikoFfhtv6/Toi/W1oM=
X-Received: by 2002:a05:6512:39cc:b0:4b5:88da:17e0 with SMTP id
 k12-20020a05651239cc00b004b588da17e0mr2300345lfu.71.1672480185619; Sat, 31
 Dec 2022 01:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20221231060459.2041173-1-yoochan1026@gmail.com> <202212311714.gS30xDjv-lkp@intel.com>
In-Reply-To: <202212311714.gS30xDjv-lkp@intel.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Sat, 31 Dec 2022 18:49:34 +0900
Message-ID: <CALQpDLe1buF47SyVToD6R4Dp1vyOYOhPquEEsijRhHxi3evMdQ@mail.gmail.com>
Subject: Re: [PATCH] misc: phantom: Fix use-after-free in phantom_open
To:     kernel test robot <lkp@intel.com>
Cc:     jirislaby@kernel.org, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
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

I missed the error in my patches.

Here is the fixed version of the patches.


From c6fb094d3dcf7c4441924cb0a56ba739ed3b2d44 Mon Sep 17 00:00:00 2001
From: Yoochan Lee <yoochan1026@gmail.com>
Date: Sat, 31 Dec 2022 18:49:03 +0900
Subject: [PATCH 2/2] fix error in previous patches

---
 drivers/misc/phantom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index ee75aa1f56ae..37c26e728be1 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -55,6 +55,7 @@ struct phantom_device {
  /* used in NOT_OH mode */
  struct phm_regs oregs;
  u32 ctl_reg;
+ struct pci_dev *pdev;
  struct kref refcnt;
 };

@@ -82,6 +83,8 @@ static int phantom_status(struct phantom_device
*dev, unsigned long newstat)
 static void phantom_delete(struct kref *kref)
 {
  struct phantom_device *pht =3D container_of(kref, struct
phantom_device, refcnt);
+ struct pci_dev *pdev =3D pht->pdev;
+ unsigned int minor =3D MINOR(pht->cdev.dev);

  device_destroy(phantom_class, MKDEV(phantom_major, minor));

@@ -414,6 +417,7 @@ static int phantom_probe(struct pci_dev *pdev,
  mutex_init(&pht->open_lock);
  spin_lock_init(&pht->regs_lock);
  kref_init(&pht->refcnt);
+ pht->pdev =3D pdev;
  init_waitqueue_head(&pht->wait);
  cdev_init(&pht->cdev, &phantom_file_ops);
  pht->cdev.owner =3D THIS_MODULE;
@@ -464,7 +468,6 @@ static int phantom_probe(struct pci_dev *pdev,
 static void phantom_remove(struct pci_dev *pdev)
 {
  struct phantom_device *pht =3D pci_get_drvdata(pdev);
- unsigned int minor =3D MINOR(pht->cdev.dev);

  kref_put(&pht->refcnt, phantom_delete);
 }
--
2.39.0

2022=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 6:31, =
kernel test robot <lkp@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:


>
> Hi Yoochan,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on char-misc/char-misc-testing]
> [also build test WARNING on char-misc/char-misc-next char-misc/char-misc-=
linus soc/for-next linus/master v6.2-rc1 next-20221226]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yoochan-Lee/misc-p=
hantom-Fix-use-after-free-in-phantom_open/20221231-140519
> patch link:    https://lore.kernel.org/r/20221231060459.2041173-1-yoochan=
1026%40gmail.com
> patch subject: [PATCH] misc: phantom: Fix use-after-free in phantom_open
> config: x86_64-allyesconfig
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/350dcfa1ef8b394d7=
9ef66c82a0ec66b813708ef
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Yoochan-Lee/misc-phantom-Fix-use=
-after-free-in-phantom_open/20221231-140519
>         git checkout 350dcfa1ef8b394d79ef66c82a0ec66b813708ef
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/fs.h:7,
>                     from include/linux/compat.h:17,
>                     from drivers/misc/phantom.c:11:
>    drivers/misc/phantom.c: In function 'phantom_delete':
>    drivers/misc/phantom.c:86:60: error: 'minor' undeclared (first use in =
this function); did you mean 'iminor'?
>       86 |         device_destroy(phantom_class, MKDEV(phantom_major, min=
or));
>          |                                                            ^~~=
~~
>    include/linux/kdev_t.h:12:49: note: in definition of macro 'MKDEV'
>       12 | #define MKDEV(ma,mi)    (((ma) << MINORBITS) | (mi))
>          |                                                 ^~
>    drivers/misc/phantom.c:86:60: note: each undeclared identifier is repo=
rted only once for each function it appears in
>       86 |         device_destroy(phantom_class, MKDEV(phantom_major, min=
or));
>          |                                                            ^~~=
~~
>    include/linux/kdev_t.h:12:49: note: in definition of macro 'MKDEV'
>       12 | #define MKDEV(ma,mi)    (((ma) << MINORBITS) | (mi))
>          |                                                 ^~
>    drivers/misc/phantom.c:92:18: error: 'pdev' undeclared (first use in t=
his function); did you mean 'cdev'?
>       92 |         free_irq(pdev->irq, pht);
>          |                  ^~~~
>          |                  cdev
>    drivers/misc/phantom.c: In function 'phantom_remove':
> >> drivers/misc/phantom.c:467:22: warning: unused variable 'minor' [-Wunu=
sed-variable]
>      467 |         unsigned int minor =3D MINOR(pht->cdev.dev);
>          |                      ^~~~~
>
>
> vim +/minor +467 drivers/misc/phantom.c
>
> cef2cf07273d12 Jiri Slaby     2007-05-08  463
> 486a5c28c2e7d6 Bill Pemberton 2012-11-19  464  static void phantom_remove=
(struct pci_dev *pdev)
> cef2cf07273d12 Jiri Slaby     2007-05-08  465  {
> cef2cf07273d12 Jiri Slaby     2007-05-08  466   struct phantom_device *ph=
t =3D pci_get_drvdata(pdev);
> cef2cf07273d12 Jiri Slaby     2007-05-08 @467   unsigned int minor =3D MI=
NOR(pht->cdev.dev);
> cef2cf07273d12 Jiri Slaby     2007-05-08  468
> 350dcfa1ef8b39 Yoochan Lee    2022-12-31  469   kref_put(&pht->refcnt, ph=
antom_delete);
> cef2cf07273d12 Jiri Slaby     2007-05-08  470  }
> cef2cf07273d12 Jiri Slaby     2007-05-08  471
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
