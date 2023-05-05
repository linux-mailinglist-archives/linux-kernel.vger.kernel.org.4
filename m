Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC16F7DE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjEEHbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjEEHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:31:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0817DFC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:31:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f4000ec74aso9717295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683271861; x=1685863861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+nS3lrEgjg5+DyDEA8xq0GFvgL3TmjfGzhmQUlWqlyI=;
        b=BMRovTyX4OazZJ5iWQoExmIeSS0DODWl32sy/SyDVltcpKDtMMuT7Do+axEPzlXah8
         jE9AAEMSYGDQs61qQCXQ2HD3H1v5FlFYpa4tlictuvLDyMluubycduj+9Xc2G1/wflqC
         nEUzxjZtV2Bnu+eXasX2wu+sfCNpL04jrAIWR/Q1MpR1zKAhY6ySN9bxjcRhOZEBEYNx
         GUQARlC713gm6iECv99dPZnwrYRu/LmAf1Urfq0wIqYiJLhLdwZYzqs8UqxczZuO1vd5
         sBqLCQ8H/ru01DS3B5IXXbnjK3EoryZpVXRo7T0KLa0TGQiuqc3hQm3vAxzkAi4AW7rn
         gViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683271861; x=1685863861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nS3lrEgjg5+DyDEA8xq0GFvgL3TmjfGzhmQUlWqlyI=;
        b=Z/V0qZw25GTPWC163z5lFSkUKdbfRpLTaVBc63v1Aj18AmRzNlVbthOhzzl5awzIIR
         elM+MxGVG1hLZo8ZcMQBkKTWyK7XMLUbBxF2seV+AKJxEw7t92ZVEfefZYFtr7Q+GcDU
         NEvZ1MhGm0TxZE2FwHkYkv3Vlc29wbLB5J79jIo8PVORzczBSBkGFIJea+l7E5NK6w7z
         v6KflXGcCIH+k5cTVrQ2P76YieuErW402r7nS7Ouc2CWrl4CHsd3aw6loqmWkpg4HsEA
         nqOFilBcXfIuHCDHcPEJvurgW+gkg2y/WBbH+3qNIIOeHS7+zObxkJqMiohcBsV1GSZF
         JWqw==
X-Gm-Message-State: AC+VfDydSsTcMpnRcD6K+tPOCuqk6lioxC1/K3/ti4yutv7HPHhPS10Z
        JvNdbIP++3eZn8/Jkn9GxfvWcA==
X-Google-Smtp-Source: ACHHUZ7Zo9IqzeS2xrJcXIqKuyuzQJZuaOkInR2SI/joF7KB1nVOTELcTBGJaN0JrAqrEs8gbvN53Q==
X-Received: by 2002:a05:600c:ad8:b0:3f2:54ae:6921 with SMTP id c24-20020a05600c0ad800b003f254ae6921mr362642wmr.2.1683271860892;
        Fri, 05 May 2023 00:31:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b003f1957ace1fsm7073128wml.13.2023.05.05.00.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 00:30:59 -0700 (PDT)
Date:   Fri, 5 May 2023 10:30:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        matt.hsiao@hpe.com, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due to
 race condition with ilo_open
Message-ID: <daacdf0d-605a-4a3b-a599-3a15857ec224@kili.mountain>
References: <20230417165246.467723-1-zyytlz.wz@163.com>
 <cabf202f-a58e-4637-9d55-b0382360c27e@kili.mountain>
 <CAJedcCzuPkHHy=uxtyuRT-Qvs56ooZ_irL89KdPq99XxgxfLBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCzuPkHHy=uxtyuRT-Qvs56ooZ_irL89KdPq99XxgxfLBw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 12:01:17PM +0800, Zheng Hacker wrote:
> Dear Dan,
> 
> Thanks for your reply. I'm not so familiar with the code here. Is the
> warning says we should check ilo_hw to see if it's not NULL?
> 

Just delete the NULL check.  It's impossible.

regards,
dan carpenter

> Best regards,
> Zheng
> 
> Dan Carpenter <dan.carpenter@linaro.org> 于2023年5月2日周二 19:46写道：
> >
> > Hi Zheng,
> >
> > kernel test robot noticed the following build warnings:
> >
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/misc-hpilo-Fix-use-after-free-bug-in-ilo_remove-due-to-race-condition-with-ilo_open/20230418-005502
> > base:   char-misc/char-misc-testing
> > patch link:    https://lore.kernel.org/r/20230417165246.467723-1-zyytlz.wz%40163.com
> > patch subject: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due  to race condition with ilo_open
> > config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230430/202304300909.ALHN6Vry-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Link: https://lore.kernel.org/r/202304300909.ALHN6Vry-lkp@intel.com/
> >
> > smatch warnings:
> > drivers/misc/hpilo.c:755 ilo_delete() warn: can 'ilo_hw' even be NULL?
> >
> > vim +/ilo_hw +755 drivers/misc/hpilo.c
> >
> > 13a22f45e6cb1e Zheng Wang      2023-04-18  749  static void ilo_delete(struct kref *kref)
> > 13a22f45e6cb1e Zheng Wang      2023-04-18  750  {
> > 13a22f45e6cb1e Zheng Wang      2023-04-18  751          int i, minor;
> > 13a22f45e6cb1e Zheng Wang      2023-04-18  752          struct ilo_hwinfo *ilo_hw = container_of(kref, struct ilo_hwinfo, refcnt);
> > 13a22f45e6cb1e Zheng Wang      2023-04-18  753          struct pci_dev *pdev = ilo_hw->ilo_dev;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  754
> > ebf1b764aa5cb3 Mark Rusk       2012-11-06 @755          if (!ilo_hw)
> >                                                             ^^^^^^^
> >
> > ->refcnt member isn't the first struct member so this NULL check
> > doesn't make sense.  Generally checking container_of() is ugly.  Some
> > people do it and add BUILD_BUG_ON() to ensure that they're checking the
> > first struct member but really it's best to avoid that if possible.
> >
> > ebf1b764aa5cb3 Mark Rusk       2012-11-06  756                  return;
> > ebf1b764aa5cb3 Mark Rusk       2012-11-06  757
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  758          clear_device(ilo_hw);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  759
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  760          minor = MINOR(ilo_hw->cdev.dev);
> > 98dcd59dd063dd Camuso, Tony    2012-06-10  761          for (i = minor; i < minor + max_ccb; i++)
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  762                  device_destroy(ilo_class, MKDEV(ilo_major, i));
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  763
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  764          cdev_del(&ilo_hw->cdev);
> > 9f7048412163d8 David Altobelli 2009-08-17  765          ilo_disable_interrupts(ilo_hw);
> > 9f7048412163d8 David Altobelli 2009-08-17  766          free_irq(pdev->irq, ilo_hw);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  767          ilo_unmap_device(pdev, ilo_hw);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  768          pci_release_regions(pdev);
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  769          /*
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  770           * pci_disable_device(pdev) used to be here. But this PCI device has
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  771           * two functions with interrupt lines connected to a single pin. The
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  772           * other one is a USB host controller. So when we disable the PIN here
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  773           * e.g. by rmmod hpilo, the controller stops working. It is because
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  774           * the interrupt link is disabled in ACPI since it is not refcounted
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  775           * yet. See acpi_pci_link_free_irq called from acpi_pci_irq_disable.
> > bcdee04ea7ae04 Jiri Slaby      2012-09-13  776           */
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  777          kfree(ilo_hw);
> > 98dcd59dd063dd Camuso, Tony    2012-06-10  778          ilo_hwdev[(minor / max_ccb)] = 0;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  779  }
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests
> >
