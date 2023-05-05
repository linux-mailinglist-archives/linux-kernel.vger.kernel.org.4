Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6EF6F7BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEEEBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEEEBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:01:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3BE12095
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 21:01:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf706768cso9464075ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 21:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683259289; x=1685851289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/hpytvk9GsGDABL6uGJ2Hb7EV0Fz7VkganmdIFkp+g=;
        b=CE0pNYK8WeclHlxI6G/QAdufi0DgkmmudyFmHewHO2Oq09GFG4o1mqKx6Z0vI7FBrL
         wEQONJdZ72VYtma59AOyWOyt/8qzae5j2XPSVVb4273VtXvkloRXgsiEBNMqBF7C0OjV
         t84CWGhc81+TAcSfYQApRrFAY3SfwdYgwxSfsX8JnyhXIhd6yxjy08FCyx8K1zlRL2GZ
         mcQAmH37Y0xgLYLKbCNR+DWiO2XXaPIgGhUzeAnWiWiMyylyuv9sb3aEeYXQB2YzmYCZ
         J+vEhE7p3re0wLB+iAZjvcQU115YRV/q3naJyl4byGqUrYBx6tqobcnHKg/nJiBpr79k
         JJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683259289; x=1685851289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/hpytvk9GsGDABL6uGJ2Hb7EV0Fz7VkganmdIFkp+g=;
        b=YxZFJUGoIMhhfIZnWp/6WqumGlzkKrRnOCUoLUSgukB5cBPqfSl4eQREWl+sUyHfP5
         LiXoYSqpUydONtO1h2rybMakvhHyfIwIARSF/jm45ijNHS0Mx+VIRJMc0Yu4dJTPN7Mx
         y9UWydjpdp7TQ3cxmxHEK06olKTI6+G/Zh64DfCi3shRujeLRRq27XHmrlMA2PnKyM9Z
         8wcZpRz0EDijagstwOdF6sRGOz6vOfVVrw0VZpqL9ktKNN4X7WgvB5s94+JNZtfqp0JE
         Bn4mq6IvCnpMWyIvIx7nCkZiZbILYRLRpmUtho1asc1pTCG31hG/LSKnJC1RKDA0+qf+
         97GA==
X-Gm-Message-State: AC+VfDwW5UcfERbA2/wSM6iypjYrNYpQje7cDWIKpeS+aiYpzfN0lDV5
        lWsWsWJLmRl9kouTwxhgcXumQnXxpEvP0QyLxb0=
X-Google-Smtp-Source: ACHHUZ7I+ve8nb2jvjCe2qqf3zifG+429J01lmt8lSIU5VIVepPGAQgR5DKXtb4TgVffCgWXkIIHxg7T3RNVFPkW5Qs=
X-Received: by 2002:a17:902:e745:b0:1ab:1b9d:50bf with SMTP id
 p5-20020a170902e74500b001ab1b9d50bfmr770plf.64.1683259288739; Thu, 04 May
 2023 21:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230417165246.467723-1-zyytlz.wz@163.com> <cabf202f-a58e-4637-9d55-b0382360c27e@kili.mountain>
In-Reply-To: <cabf202f-a58e-4637-9d55-b0382360c27e@kili.mountain>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 5 May 2023 12:01:17 +0800
Message-ID: <CAJedcCzuPkHHy=uxtyuRT-Qvs56ooZ_irL89KdPq99XxgxfLBw@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due to
 race condition with ilo_open
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        matt.hsiao@hpe.com, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dan,

Thanks for your reply. I'm not so familiar with the code here. Is the
warning says we should check ilo_hw to see if it's not NULL?

Best regards,
Zheng

Dan Carpenter <dan.carpenter@linaro.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=BA=8C 19:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/misc-hp=
ilo-Fix-use-after-free-bug-in-ilo_remove-due-to-race-condition-with-ilo_ope=
n/20230418-005502
> base:   char-misc/char-misc-testing
> patch link:    https://lore.kernel.org/r/20230417165246.467723-1-zyytlz.w=
z%40163.com
> patch subject: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove =
due  to race condition with ilo_open
> config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/202=
30430/202304300909.ALHN6Vry-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202304300909.ALHN6Vry-lkp@intel.com/
>
> smatch warnings:
> drivers/misc/hpilo.c:755 ilo_delete() warn: can 'ilo_hw' even be NULL?
>
> vim +/ilo_hw +755 drivers/misc/hpilo.c
>
> 13a22f45e6cb1e Zheng Wang      2023-04-18  749  static void ilo_delete(st=
ruct kref *kref)
> 13a22f45e6cb1e Zheng Wang      2023-04-18  750  {
> 13a22f45e6cb1e Zheng Wang      2023-04-18  751          int i, minor;
> 13a22f45e6cb1e Zheng Wang      2023-04-18  752          struct ilo_hwinfo=
 *ilo_hw =3D container_of(kref, struct ilo_hwinfo, refcnt);
> 13a22f45e6cb1e Zheng Wang      2023-04-18  753          struct pci_dev *p=
dev =3D ilo_hw->ilo_dev;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  754
> ebf1b764aa5cb3 Mark Rusk       2012-11-06 @755          if (!ilo_hw)
>                                                             ^^^^^^^
>
> ->refcnt member isn't the first struct member so this NULL check
> doesn't make sense.  Generally checking container_of() is ugly.  Some
> people do it and add BUILD_BUG_ON() to ensure that they're checking the
> first struct member but really it's best to avoid that if possible.
>
> ebf1b764aa5cb3 Mark Rusk       2012-11-06  756                  return;
> ebf1b764aa5cb3 Mark Rusk       2012-11-06  757
> 89bcb05d9bbf8b David Altobelli 2008-07-02  758          clear_device(ilo_=
hw);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  759
> 89bcb05d9bbf8b David Altobelli 2008-07-02  760          minor =3D MINOR(i=
lo_hw->cdev.dev);
> 98dcd59dd063dd Camuso, Tony    2012-06-10  761          for (i =3D minor;=
 i < minor + max_ccb; i++)
> 89bcb05d9bbf8b David Altobelli 2008-07-02  762                  device_de=
stroy(ilo_class, MKDEV(ilo_major, i));
> 89bcb05d9bbf8b David Altobelli 2008-07-02  763
> 89bcb05d9bbf8b David Altobelli 2008-07-02  764          cdev_del(&ilo_hw-=
>cdev);
> 9f7048412163d8 David Altobelli 2009-08-17  765          ilo_disable_inter=
rupts(ilo_hw);
> 9f7048412163d8 David Altobelli 2009-08-17  766          free_irq(pdev->ir=
q, ilo_hw);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  767          ilo_unmap_device(=
pdev, ilo_hw);
> 89bcb05d9bbf8b David Altobelli 2008-07-02  768          pci_release_regio=
ns(pdev);
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  769          /*
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  770           * pci_disable_de=
vice(pdev) used to be here. But this PCI device has
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  771           * two functions =
with interrupt lines connected to a single pin. The
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  772           * other one is a=
 USB host controller. So when we disable the PIN here
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  773           * e.g. by rmmod =
hpilo, the controller stops working. It is because
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  774           * the interrupt =
link is disabled in ACPI since it is not refcounted
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  775           * yet. See acpi_=
pci_link_free_irq called from acpi_pci_irq_disable.
> bcdee04ea7ae04 Jiri Slaby      2012-09-13  776           */
> 89bcb05d9bbf8b David Altobelli 2008-07-02  777          kfree(ilo_hw);
> 98dcd59dd063dd Camuso, Tony    2012-06-10  778          ilo_hwdev[(minor =
/ max_ccb)] =3D 0;
> 89bcb05d9bbf8b David Altobelli 2008-07-02  779  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
>
