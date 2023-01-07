Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44806660D05
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjAGIdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAGIde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:33:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741281C15
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:33:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso4570360wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPT2ZOMOLUsQNvf+1YxI5DBhgI/ld9FbsEi0DhjkRXc=;
        b=PTPSoiZySlrJx+P5BRk096MdPTKVWN9It9WUFZAxC2/7H5TvIJTQe/xajq1L6dD5On
         JaDM/Ck1ZOWEmPodgRKCOdK+X4q8cjxrgkXhj24s8sBu5e3t2o3jS7bRfFE6L4vZRZgh
         WzAoOtxQBm96sQtrS3VAxFxfSPIvDn/laxhjxQ1uFqZnqslJytquQVIe4HX1S7BmyB3S
         To5HnO0ZLu3wwhsf7p+dEN5I+vz6SS97T7L+3ztuzsSw0lp3Vq4YlyonLkbuiEGyma/P
         Mjf0DXulD2ZQU3umeqeQxZSbpNGWpPrnbNZxVoD5MzcNxFtk7aXIbYRKe/KgZW/wjt0m
         2sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPT2ZOMOLUsQNvf+1YxI5DBhgI/ld9FbsEi0DhjkRXc=;
        b=sTJt5v9Pvco5qUO+9/MUTfkUymBTXzfJk4knfNbbCQ8eyLo9VlYkBMaKdMZcn6u6or
         UDJShpLymL1F9XMAgGS+ApqkO3XD5rDNUAw0jaCsGOMoqk+VBO3byxU/AegbuT4ODq8L
         gQgfw4APNi46naMRxw7vaNdz+qErWsgdFCjVD1jtVBBRnFckXrALmfDiu7OMOrdz54et
         T+WBhF7NQAI8BQqIeQ/XkndDo8gmtY1/80DZW6DCqYG3jpJCTVU0eCEOwtvGiPag8azI
         bqHsWkuyJylRx7DqsHuES3evG2oHQvIoz2zfClmuCisf0esur0KdylMy+AkC82avD76U
         tCMg==
X-Gm-Message-State: AFqh2krTVxR/5fzcsssYrcMZJ49BHciLfeBlG9vm3VAMvEhXv+TX8pXb
        +sXjk9XP2z8kQXRR1+YQEmU=
X-Google-Smtp-Source: AMrXdXtPX80UYKugy/n70TxupH81z1Ius9dBnYabO/H+QM4/tur/Mgnj3NgY2SuZJ/38t/vfJzAmFQ==
X-Received: by 2002:a05:600c:54eb:b0:3c6:e63e:89aa with SMTP id jb11-20020a05600c54eb00b003c6e63e89aamr40850700wmb.6.1673080411342;
        Sat, 07 Jan 2023 00:33:31 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003d34faca949sm4510206wmb.39.2023.01.07.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 00:33:30 -0800 (PST)
Date:   Sat, 7 Jan 2023 11:33:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Divya Koppera <Divya.Koppera@microchip.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn: passing
 zero to 'PTR_ERR'
Message-ID: <202301070307.5CkACLRd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f5abbd77e2c1787e74b7c2caffac97def78ba52
commit: ece19502834d84ece2e056db28257ca2aa6e4d48 net: phy: micrel: 1588 support for LAN8814 phy
config: arc-randconfig-m041-20230106
compiler: arc-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/net/phy/micrel.c:1750 ksz886x_cable_test_get_status() error: uninitialized symbol 'ret'.

vim +/PTR_ERR +2613 drivers/net/phy/micrel.c

ece19502834d84 Divya Koppera 2022-03-04  2589  static int lan8814_ptp_probe_once(struct phy_device *phydev)
ece19502834d84 Divya Koppera 2022-03-04  2590  {
ece19502834d84 Divya Koppera 2022-03-04  2591  	struct lan8814_shared_priv *shared = phydev->shared->priv;
ece19502834d84 Divya Koppera 2022-03-04  2592  
ece19502834d84 Divya Koppera 2022-03-04  2593  	/* Initialise shared lock for clock*/
ece19502834d84 Divya Koppera 2022-03-04  2594  	mutex_init(&shared->shared_lock);
ece19502834d84 Divya Koppera 2022-03-04  2595  
ece19502834d84 Divya Koppera 2022-03-04  2596  	shared->ptp_clock_info.owner = THIS_MODULE;
ece19502834d84 Divya Koppera 2022-03-04  2597  	snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
ece19502834d84 Divya Koppera 2022-03-04  2598  	shared->ptp_clock_info.max_adj = 31249999;
ece19502834d84 Divya Koppera 2022-03-04  2599  	shared->ptp_clock_info.n_alarm = 0;
ece19502834d84 Divya Koppera 2022-03-04  2600  	shared->ptp_clock_info.n_ext_ts = 0;
ece19502834d84 Divya Koppera 2022-03-04  2601  	shared->ptp_clock_info.n_pins = 0;
ece19502834d84 Divya Koppera 2022-03-04  2602  	shared->ptp_clock_info.pps = 0;
ece19502834d84 Divya Koppera 2022-03-04  2603  	shared->ptp_clock_info.pin_config = NULL;
ece19502834d84 Divya Koppera 2022-03-04  2604  	shared->ptp_clock_info.adjfine = lan8814_ptpci_adjfine;
ece19502834d84 Divya Koppera 2022-03-04  2605  	shared->ptp_clock_info.adjtime = lan8814_ptpci_adjtime;
ece19502834d84 Divya Koppera 2022-03-04  2606  	shared->ptp_clock_info.gettime64 = lan8814_ptpci_gettime64;
ece19502834d84 Divya Koppera 2022-03-04  2607  	shared->ptp_clock_info.settime64 = lan8814_ptpci_settime64;
ece19502834d84 Divya Koppera 2022-03-04  2608  	shared->ptp_clock_info.getcrosststamp = NULL;
ece19502834d84 Divya Koppera 2022-03-04  2609  
ece19502834d84 Divya Koppera 2022-03-04  2610  	shared->ptp_clock = ptp_clock_register(&shared->ptp_clock_info,
ece19502834d84 Divya Koppera 2022-03-04  2611  					       &phydev->mdio.dev);
ece19502834d84 Divya Koppera 2022-03-04  2612  	if (IS_ERR_OR_NULL(shared->ptp_clock)) {
ece19502834d84 Divya Koppera 2022-03-04 @2613  		phydev_err(phydev, "ptp_clock_register failed %lu\n",
ece19502834d84 Divya Koppera 2022-03-04  2614  			   PTR_ERR(shared->ptp_clock));
ece19502834d84 Divya Koppera 2022-03-04  2615  		return -EINVAL;

I sent a detailed explanation of this bug earlier but it still has not
been fixed.  Search lore.kernel.org for more info.

ece19502834d84 Divya Koppera 2022-03-04  2616  	}
ece19502834d84 Divya Koppera 2022-03-04  2617  
ece19502834d84 Divya Koppera 2022-03-04  2618  	phydev_dbg(phydev, "successfully registered ptp clock\n");
ece19502834d84 Divya Koppera 2022-03-04  2619  
ece19502834d84 Divya Koppera 2022-03-04  2620  	shared->phydev = phydev;
ece19502834d84 Divya Koppera 2022-03-04  2621  
ece19502834d84 Divya Koppera 2022-03-04  2622  	/* The EP.4 is shared between all the PHYs in the package and also it
ece19502834d84 Divya Koppera 2022-03-04  2623  	 * can be accessed by any of the PHYs
ece19502834d84 Divya Koppera 2022-03-04  2624  	 */
ece19502834d84 Divya Koppera 2022-03-04  2625  	lanphy_write_page_reg(phydev, 4, LTC_HARD_RESET, LTC_HARD_RESET_);
ece19502834d84 Divya Koppera 2022-03-04  2626  	lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
ece19502834d84 Divya Koppera 2022-03-04  2627  			      PTP_OPERATING_MODE_STANDALONE_);
ece19502834d84 Divya Koppera 2022-03-04  2628  
ece19502834d84 Divya Koppera 2022-03-04  2629  	return 0;
ece19502834d84 Divya Koppera 2022-03-04  2630  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

