Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE31665A34B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiLaI5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 03:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 03:57:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE5101E2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 00:57:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bt23so18033391lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 00:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kha2tT7dBejCSALXzjUHHZXjCdc+lr2ifT1wD2AI3Tw=;
        b=mjFIFJesYgLYrqFWrtufcdg/123HCc0OB3JNvqjCjbceXUPEPQKzpWAvSftAQcg26z
         RJB1mVZEVcqyps9Avy0K59AoXEBmR+qLYr8sc7sre/9JKhEG7uTZ6rfPm885bdhMJ1D4
         XUAoyLUR+rIIjBVq4/GiLYHUby87dnl9EHq3oZBnCFsNOsp5cT/yJuOIY5LR/KbKoMRq
         5A4uSeE1q84DXjctqj56mvOyWPBFvqswlku3pxjcTocCb5V2hL8YpVUabKuOkx4pqaPb
         EUgGPkyxP664ByJ5/E1wFrM9xKFmA9zlnMHqAF6c9swpK0N9HryAX8XKrxFzD1yOVtfc
         ue0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kha2tT7dBejCSALXzjUHHZXjCdc+lr2ifT1wD2AI3Tw=;
        b=VmU7umjxJ4Zr3GnwKGBI9+KVlp4agvKiCcpkTbDhxx+ShevwMyx8zSNXtV5fPIWg4J
         IPpSccRyv+nehVvj8qURhbymZPnWv1JROHNdy5RA8wyg/dcRov0QL2b1pFRstjfJSsIF
         b14rcKp76fZIyYl2rEbtN09RGkGFADU9PxHGXB/meBaktXaJ7RyjlQppBJOt9u9wLuNQ
         RjyNkhG+9HKXvgHdKaEgIH6t5mjUhd3MLGefdQUUjdwJRpK8WuBwNfDBBLxUulYWS7Jf
         3rcnFahLyCOch3c57frvJhm942BWf+xKTQB8qjcR+kDNMmCnkWZXHB0tuxn99NtHW1ZD
         l1YQ==
X-Gm-Message-State: AFqh2kq7/9CtLDkI72zYGqqwHNUXw9I7sI+7Cl1xBVJebE6YTRenLWgW
        biHl4fi0dERdqTA53rrVt46f82dPaOoRvrvyKVw=
X-Google-Smtp-Source: AMrXdXuu9/dF7hrjIEMt3G7aKxjuEWQIORqtozPRNv8pRy3v1fjj/aPPiEXLiylLOyMXkPFRlPyDibaEdBB94MbSuvc=
X-Received: by 2002:a05:6512:5d1:b0:4b5:5f97:6a18 with SMTP id
 o17-20020a05651205d100b004b55f976a18mr3474576lfo.77.1672477027400; Sat, 31
 Dec 2022 00:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20221231055310.2040648-1-yoochan1026@gmail.com> <202212311612.EwRjxghc-lkp@intel.com>
In-Reply-To: <202212311612.EwRjxghc-lkp@intel.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Sat, 31 Dec 2022 17:56:56 +0900
Message-ID: <CALQpDLeQOrwsO5EjS5Q1Cy7DadNGqB966jkJvCTfsvqgZc=gZw@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
To:     kernel test robot <lkp@intel.com>
Cc:     matt.hsiao@hpe.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
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

Hi, there is some typos in my patch.

Therefore, here are additional patches.

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index b4a99676a642..ea5bfbb231bd 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -778,7 +778,7 @@ static void ilo_remove(struct pci_dev *pdev)
        if (!ilo_hw)
                return;

-       kref_put(&hw->refcnt, ilo_delete);
+       kref_put(&ilo_hw->refcnt, ilo_delete);
 }

 static int ilo_probe(struct pci_dev *pdev,
@@ -820,7 +820,7 @@ static int ilo_probe(struct pci_dev *pdev,
        spin_lock_init(&ilo_hw->alloc_lock);
        spin_lock_init(&ilo_hw->fifo_lock);
        spin_lock_init(&ilo_hw->open_lock);
-       kref_init(&iol_hw->refcnt);
+       kref_init(&ilo_hw->refcnt);

        error =3D pci_enable_device(pdev);
        if (error)

Sincerely,
Yoocahn


2022=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 5:51, =
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
> url:    https://github.com/intel-lab-lkp/linux/commits/Yoochan-Lee/misc-h=
pilo-Fix-use-after-free-in-ilo_open/20221231-135458
> patch link:    https://lore.kernel.org/r/20221231055310.2040648-1-yoochan=
1026%40gmail.com
> patch subject: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
> config: x86_64-rhel-8.3-bpf
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/aca13e7e71e5c2b68=
742270a834fd67929850ef9
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Yoochan-Lee/misc-hpilo-Fix-use-a=
fter-free-in-ilo_open/20221231-135458
>         git checkout aca13e7e71e5c2b68742270a834fd67929850ef9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/=
misc/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    drivers/misc/hpilo.c: In function 'ilo_delete':
>    drivers/misc/hpilo.c:541:9: error: 'minor' undeclared (first use in th=
is function); did you mean 'iminor'?
>      541 |         minor =3D MINOR(ilo_hw->cdev.dev);
>          |         ^~~~~
>          |         iminor
>    drivers/misc/hpilo.c:541:9: note: each undeclared identifier is report=
ed only once for each function it appears in
>    drivers/misc/hpilo.c:542:14: error: 'i' undeclared (first use in this =
function)
>      542 |         for (i =3D minor; i < minor + max_ccb; i++)
>          |              ^
>    drivers/misc/hpilo.c:547:18: error: 'pdev' undeclared (first use in th=
is function); did you mean 'cdev'?
>      547 |         free_irq(pdev->irq, ilo_hw);
>          |                  ^~~~
>          |                  cdev
>    drivers/misc/hpilo.c:548:9: error: implicit declaration of function 'i=
lo_unmap_device' [-Werror=3Dimplicit-function-declaration]
>      548 |         ilo_unmap_device(pdev, ilo_hw);
>          |         ^~~~~~~~~~~~~~~~
>    drivers/misc/hpilo.c: At top level:
>    drivers/misc/hpilo.c:715:13: warning: conflicting types for 'ilo_unmap=
_device'; have 'void(struct pci_dev *, struct ilo_hwinfo *)'
>      715 | static void ilo_unmap_device(struct pci_dev *pdev, struct ilo_=
hwinfo *hw)
>          |             ^~~~~~~~~~~~~~~~
>    drivers/misc/hpilo.c:715:13: error: static declaration of 'ilo_unmap_d=
evice' follows non-static declaration
>    drivers/misc/hpilo.c:548:9: note: previous implicit declaration of 'il=
o_unmap_device' with type 'void(struct pci_dev *, struct ilo_hwinfo *)'
>      548 |         ilo_unmap_device(pdev, ilo_hw);
>          |         ^~~~~~~~~~~~~~~~
>    drivers/misc/hpilo.c: In function 'ilo_remove':
>    drivers/misc/hpilo.c:781:19: error: 'hw' undeclared (first use in this=
 function)
>      781 |         kref_put(&hw->refcnt, ilo_delete);
>          |                   ^~
> >> drivers/misc/hpilo.c:775:16: warning: unused variable 'minor' [-Wunuse=
d-variable]
>      775 |         int i, minor;
>          |                ^~~~~
> >> drivers/misc/hpilo.c:775:13: warning: unused variable 'i' [-Wunused-va=
riable]
>      775 |         int i, minor;
>          |             ^
>    drivers/misc/hpilo.c: In function 'ilo_probe':
>    drivers/misc/hpilo.c:823:20: error: 'iol_hw' undeclared (first use in =
this function); did you mean 'ilo_hw'?
>      823 |         kref_init(&iol_hw->refcnt);
>          |                    ^~~~~~
>          |                    ilo_hw
>    cc1: some warnings being treated as errors
>
>
> vim +/minor +775 drivers/misc/hpilo.c
>
> 9f7048412163d8 David Altobelli 2009-08-17  714
> 89bcb05d9bbf8b David Altobelli 2008-07-02 @715  static void ilo_unmap_dev=
ice(struct pci_dev *pdev, struct ilo_hwinfo *hw)
> 89bcb05d9bbf8b David Altobelli 2008-07-02  716  {
> 89bcb05d9bbf8b David Altobelli 2008-07-02  717          pci_iounmap(pdev,=
 hw->db_vaddr);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  718          pci_iounmap(pdev,=
 hw->ram_vaddr);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  719          pci_iounmap(pdev,=
 hw->mmio_vaddr);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  720  }
> 89bcb05d9bbf8b David Altobelli 2008-07-02  721
> 80c8ae28926652 Bill Pemberton  2012-11-19  722  static int ilo_map_device=
(struct pci_dev *pdev, struct ilo_hwinfo *hw)
> 89bcb05d9bbf8b David Altobelli 2008-07-02  723  {
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  724          int bar;
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  725          unsigned long off=
;
> 23d51b81815127 Matt Hsiao      2021-05-31  726          u8 pci_rev_id;
> 23d51b81815127 Matt Hsiao      2021-05-31  727          int rc;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  728
> 89bcb05d9bbf8b David Altobelli 2008-07-02  729          /* map the memory=
 mapped i/o registers */
> 89bcb05d9bbf8b David Altobelli 2008-07-02  730          hw->mmio_vaddr =
=3D pci_iomap(pdev, 1, 0);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  731          if (hw->mmio_vadd=
r =3D=3D NULL) {
> 89bcb05d9bbf8b David Altobelli 2008-07-02  732                  dev_err(&=
pdev->dev, "Error mapping mmio\n");
> 89bcb05d9bbf8b David Altobelli 2008-07-02  733                  goto out;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  734          }
> 89bcb05d9bbf8b David Altobelli 2008-07-02  735
> 89bcb05d9bbf8b David Altobelli 2008-07-02  736          /* map the adapte=
r shared memory region */
> 23d51b81815127 Matt Hsiao      2021-05-31  737          rc =3D pci_read_c=
onfig_byte(pdev, PCI_REVISION_ID, &pci_rev_id);
> 23d51b81815127 Matt Hsiao      2021-05-31  738          if (rc !=3D 0) {
> 23d51b81815127 Matt Hsiao      2021-05-31  739                  dev_err(&=
pdev->dev, "Error reading PCI rev id: %d\n", rc);
> 23d51b81815127 Matt Hsiao      2021-05-31  740                  goto out;
> 23d51b81815127 Matt Hsiao      2021-05-31  741          }
> 23d51b81815127 Matt Hsiao      2021-05-31  742
> 23d51b81815127 Matt Hsiao      2021-05-31  743          if (pci_rev_id >=
=3D PCI_REV_ID_NECHES) {
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  744                  bar =3D 5=
;
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  745                  /* Last 8=
k is reserved for CCBs */
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  746                  off =3D p=
ci_resource_len(pdev, bar) - 0x2000;
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  747          } else {
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  748                  bar =3D 2=
;
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  749                  off =3D 0=
;
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  750          }
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  751          hw->ram_vaddr =3D=
 pci_iomap_range(pdev, bar, off, max_ccb * ILOHW_CCB_SZ);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  752          if (hw->ram_vaddr=
 =3D=3D NULL) {
> 89bcb05d9bbf8b David Altobelli 2008-07-02  753                  dev_err(&=
pdev->dev, "Error mapping shared mem\n");
> 89bcb05d9bbf8b David Altobelli 2008-07-02  754                  goto mmio=
_free;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  755          }
> 89bcb05d9bbf8b David Altobelli 2008-07-02  756
> 89bcb05d9bbf8b David Altobelli 2008-07-02  757          /* map the doorbe=
ll aperture */
> 98dcd59dd063dd Camuso, Tony    2012-06-10  758          hw->db_vaddr =3D =
pci_iomap(pdev, 3, max_ccb * ONE_DB_SIZE);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  759          if (hw->db_vaddr =
=3D=3D NULL) {
> 89bcb05d9bbf8b David Altobelli 2008-07-02  760                  dev_err(&=
pdev->dev, "Error mapping doorbell\n");
> 89bcb05d9bbf8b David Altobelli 2008-07-02  761                  goto ram_=
free;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  762          }
> 89bcb05d9bbf8b David Altobelli 2008-07-02  763
> 89bcb05d9bbf8b David Altobelli 2008-07-02  764          return 0;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  765  ram_free:
> 89bcb05d9bbf8b David Altobelli 2008-07-02  766          pci_iounmap(pdev,=
 hw->ram_vaddr);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  767  mmio_free:
> 89bcb05d9bbf8b David Altobelli 2008-07-02  768          pci_iounmap(pdev,=
 hw->mmio_vaddr);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  769  out:
> c9fef1cc3dd367 Rusk, Mark      2016-09-19  770          return -ENOMEM;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  771  }
> 89bcb05d9bbf8b David Altobelli 2008-07-02  772
> 89bcb05d9bbf8b David Altobelli 2008-07-02  773  static void ilo_remove(st=
ruct pci_dev *pdev)
> 89bcb05d9bbf8b David Altobelli 2008-07-02  774  {
> 89bcb05d9bbf8b David Altobelli 2008-07-02 @775          int i, minor;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  776          struct ilo_hwinfo=
 *ilo_hw =3D pci_get_drvdata(pdev);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  777
> ebf1b764aa5cb3 Mark Rusk       2012-11-06  778          if (!ilo_hw)
> ebf1b764aa5cb3 Mark Rusk       2012-11-06  779                  return;
> ebf1b764aa5cb3 Mark Rusk       2012-11-06  780
> aca13e7e71e5c2 Yoochan Lee     2022-12-31 @781          kref_put(&hw->ref=
cnt, ilo_delete);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  782  }
> 89bcb05d9bbf8b David Altobelli 2008-07-02  783
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
