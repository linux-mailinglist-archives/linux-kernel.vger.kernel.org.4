Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FE6F42FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjEBLqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjEBLqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:46:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A104496
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:46:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315712406so165058995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683028008; x=1685620008;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTFNSvlNK9OLSuNfUZudfwb4eJQZN05dqmNmwC73cTc=;
        b=WDt4HwZKuTxhtTFvJzdvkyKlqlRuoWlMnrUZ7gi/kwR0y5kWfoD4CBneeatP/SmgiU
         At4yXcBE9n+u6xCrOk1V7OFqkEfkHZ1LGpyjvnaP/vMCNk6fyNh/21JKEuQBlow73Fb1
         hu7GhIr8AxoJ0DUgf0KyvjgnlnMyVV1Syf80qiN+hrcbPJKvZ0SiCAquvrzY4WquuR4/
         hzA8uVhPQHSYYBYG6iz8sFM0rsS86bOpAUuryjsYU5/ZNF0PlRTBFBnMjqI93f4YrX1p
         SmHo6jSiub/2+rnF9ZvpdI6Asfn94Thf6s78TDHLsRA3QmH52m/wy+95uLKnsJPO5v4M
         VhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683028008; x=1685620008;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTFNSvlNK9OLSuNfUZudfwb4eJQZN05dqmNmwC73cTc=;
        b=TkTAmpLGZMP92lfgpIQ5xXjwgP3FJzVdUgB7kE5LO86Qf5FAlQA2uK43rrI1p0uzJv
         Ge41R7ybyKIiX1jPXe61y1pbIJlGEH5/AbzF2j7QO3MDaBG7WjMeXwyeVZnh00KFPQQi
         C8dzDs0XuAYAQjbX2cTjOsE1y4iCuG2PKRoP6w2NnnXMQaQKTCcz/7g2ti5D5yCC9Vpw
         QsTSMfkFvbHikZyjQXqQe2OmeNacWCKGWpZxdgzC8TgvGHHwpiJrA3zmflCGkDgTMnZI
         XNK390ju3A2tEqPg4NNhBibfX3E5/jpYjzQtyALUsLwvNtzPODAib7TBzUZI6fiqFnvT
         z2sA==
X-Gm-Message-State: AC+VfDzravxO7mFTQxvKadL9jp2uDbwIkwgY7BxmjhCXsQQPYQO8dQBv
        zDM9QzijhKB2eMwOkQ0msvA2qw==
X-Google-Smtp-Source: ACHHUZ5rR7wCjfAAKk7jnBh8uBGAfKGBbPcT4RpfbFNkbLYg30cHXAdl/ws1cFihoZd3fLf1/QWhIA==
X-Received: by 2002:a05:6000:128e:b0:2fb:b869:bc08 with SMTP id f14-20020a056000128e00b002fbb869bc08mr13523307wrx.23.1683028008490;
        Tue, 02 May 2023 04:46:48 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003f1738e64c0sm38899117wmq.20.2023.05.02.04.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:46:46 -0700 (PDT)
Date:   Tue, 2 May 2023 14:46:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        matt.hsiao@hpe.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due to
 race condition with ilo_open
Message-ID: <cabf202f-a58e-4637-9d55-b0382360c27e@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417165246.467723-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/misc-hpilo-Fix-use-after-free-bug-in-ilo_remove-due-to-race-condition-with-ilo_open/20230418-005502
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230417165246.467723-1-zyytlz.wz%40163.com
patch subject: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due  to race condition with ilo_open
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230430/202304300909.ALHN6Vry-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304300909.ALHN6Vry-lkp@intel.com/

smatch warnings:
drivers/misc/hpilo.c:755 ilo_delete() warn: can 'ilo_hw' even be NULL?

vim +/ilo_hw +755 drivers/misc/hpilo.c

13a22f45e6cb1e Zheng Wang      2023-04-18  749  static void ilo_delete(struct kref *kref)
13a22f45e6cb1e Zheng Wang      2023-04-18  750  {
13a22f45e6cb1e Zheng Wang      2023-04-18  751  	int i, minor;
13a22f45e6cb1e Zheng Wang      2023-04-18  752  	struct ilo_hwinfo *ilo_hw = container_of(kref, struct ilo_hwinfo, refcnt);
13a22f45e6cb1e Zheng Wang      2023-04-18  753  	struct pci_dev *pdev = ilo_hw->ilo_dev;
89bcb05d9bbf8b David Altobelli 2008-07-02  754  
ebf1b764aa5cb3 Mark Rusk       2012-11-06 @755  	if (!ilo_hw)
                                                            ^^^^^^^

->refcnt member isn't the first struct member so this NULL check
doesn't make sense.  Generally checking container_of() is ugly.  Some
people do it and add BUILD_BUG_ON() to ensure that they're checking the
first struct member but really it's best to avoid that if possible.

ebf1b764aa5cb3 Mark Rusk       2012-11-06  756  		return;
ebf1b764aa5cb3 Mark Rusk       2012-11-06  757  
89bcb05d9bbf8b David Altobelli 2008-07-02  758  	clear_device(ilo_hw);
89bcb05d9bbf8b David Altobelli 2008-07-02  759  
89bcb05d9bbf8b David Altobelli 2008-07-02  760  	minor = MINOR(ilo_hw->cdev.dev);
98dcd59dd063dd Camuso, Tony    2012-06-10  761  	for (i = minor; i < minor + max_ccb; i++)
89bcb05d9bbf8b David Altobelli 2008-07-02  762  		device_destroy(ilo_class, MKDEV(ilo_major, i));
89bcb05d9bbf8b David Altobelli 2008-07-02  763  
89bcb05d9bbf8b David Altobelli 2008-07-02  764  	cdev_del(&ilo_hw->cdev);
9f7048412163d8 David Altobelli 2009-08-17  765  	ilo_disable_interrupts(ilo_hw);
9f7048412163d8 David Altobelli 2009-08-17  766  	free_irq(pdev->irq, ilo_hw);
89bcb05d9bbf8b David Altobelli 2008-07-02  767  	ilo_unmap_device(pdev, ilo_hw);
89bcb05d9bbf8b David Altobelli 2008-07-02  768  	pci_release_regions(pdev);
bcdee04ea7ae04 Jiri Slaby      2012-09-13  769  	/*
bcdee04ea7ae04 Jiri Slaby      2012-09-13  770  	 * pci_disable_device(pdev) used to be here. But this PCI device has
bcdee04ea7ae04 Jiri Slaby      2012-09-13  771  	 * two functions with interrupt lines connected to a single pin. The
bcdee04ea7ae04 Jiri Slaby      2012-09-13  772  	 * other one is a USB host controller. So when we disable the PIN here
bcdee04ea7ae04 Jiri Slaby      2012-09-13  773  	 * e.g. by rmmod hpilo, the controller stops working. It is because
bcdee04ea7ae04 Jiri Slaby      2012-09-13  774  	 * the interrupt link is disabled in ACPI since it is not refcounted
bcdee04ea7ae04 Jiri Slaby      2012-09-13  775  	 * yet. See acpi_pci_link_free_irq called from acpi_pci_irq_disable.
bcdee04ea7ae04 Jiri Slaby      2012-09-13  776  	 */
89bcb05d9bbf8b David Altobelli 2008-07-02  777  	kfree(ilo_hw);
98dcd59dd063dd Camuso, Tony    2012-06-10  778  	ilo_hwdev[(minor / max_ccb)] = 0;
89bcb05d9bbf8b David Altobelli 2008-07-02  779  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

