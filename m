Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BD6FF048
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjEKK5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjEKK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:57:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D6C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:57:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42d937d61so25751925e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683802634; x=1686394634;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=riHRWt/DT+R28lyCQk8l026iqpHj8sFQPrXZkKMI/V8=;
        b=NlqxWhQSqp4pPP59kmIiP6KPGwkBx08LzsGm5JsdqN3td5dPO+XFwobTm0PqtfPBHg
         4l6907DDc2X68t7KDWg8o8avYdocnLTiKS6QPBP5Vd5mnExC95O0xoSVoyQEdhi39CC8
         o0WYpK7xCePuEnZUHdcVc1vjT7t79VXMTMiEvkl8uYN5MFvh/Wz/JHhbqQHhV32HJRrC
         i3u+iWOZApClFv5zvbFR+lPb7iu85MysO+nTlF+DnoRrcRbzeKclryegFYCdS3eL0VZl
         vG/6/Me2bbPRQeqp2s1iza9kYcHtnxMFOVFenwm8YNnuAGDOwPUwTRaub4LSlf5sM+gF
         xhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802634; x=1686394634;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riHRWt/DT+R28lyCQk8l026iqpHj8sFQPrXZkKMI/V8=;
        b=R/vnsIWgEDOSKW58omqlJhJ/Lork6a1BAaAuVwaTj51EuI/wx23GBGT7iJ5jk5PjJh
         lPumafzkyOhrpmnlN/wfcBwAD4sNSHsjHo0bq2ppEmFCNJ1phsEFg0c6JOjQg917xjpy
         BzSlYeSbLnvvX4zatoF1AvlyX0io8Y8pY6ocTIWawTTXGRyGZifqXfXwJx0RvHFcZW/9
         +AFREaD9EG1yU0E9/7mxlMYIjeDtlUyTfjRjHPN5pcSchJ28+Qk4jmvLFik+sefUbIW7
         WHXZu3cEymVCwrTeJta3gNrBgRGERG3tGIw4/DE6+7ZeLHVbNDb9aF21q4cnvX2xaGcA
         6mdQ==
X-Gm-Message-State: AC+VfDwRHpDc/Voxi36m2yn1dY7uXhg7F4s4URDLFFXZ8lhgpxZBRQ2m
        0EKSn0b3B4Z14O8tSDKKEZ2n1w==
X-Google-Smtp-Source: ACHHUZ4IgK5mNu3z2Q2O5fEX2GY1HT2CzWIHuj09gR8HPhiprguCuf6QlexEz5Hz9AoAYzkpp0ixNQ==
X-Received: by 2002:a05:600c:3646:b0:3f4:2215:6d6 with SMTP id y6-20020a05600c364600b003f4221506d6mr12162026wmq.33.1683802634018;
        Thu, 11 May 2023 03:57:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b0030796e103a1sm11826810wru.5.2023.05.11.03.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:57:12 -0700 (PDT)
Date:   Thu, 11 May 2023 13:57:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linfeilong@huawei.com, louhongxiang@huawei.com,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: Re: [PATCH v2 2/6] scsi:scsi_debug: Add interface to manage single
 device's error inject
Message-ID: <5f8d3e23-9ac7-4ed2-bf5b-1d247109869a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428013320.347050-3-haowenchao2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/scsi-scsi_debug-create-scsi_debug-directory-in-the-debugfs-filesystem/20230427-201534
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230428013320.347050-3-haowenchao2%40huawei.com
patch subject: [PATCH v2 2/6] scsi:scsi_debug: Add interface to manage single device's error inject
config: mips-randconfig-m041-20230509 (https://download.01.org/0day-ci/archive/20230511/202305110949.SGOuSCr6-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305110949.SGOuSCr6-lkp@intel.com/

smatch warnings:
drivers/scsi/scsi_debug.c:5359 scsi_debug_slave_destroy() warn: variable dereferenced before check 'devip' (see line 5358)

vim +/devip +5359 drivers/scsi/scsi_debug.c

8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5349  static void scsi_debug_slave_destroy(struct scsi_device *sdp)
8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5350  {
8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5351  	struct sdebug_dev_info *devip =
8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5352  		(struct sdebug_dev_info *)sdp->hostdata;
a34c4e98367965 FUJITA Tomonori 2008-03-25  5353  
773642d95b8220 Douglas Gilbert 2016-04-25  5354  	if (sdebug_verbose)
c1287970f4847a Tomas Winkler   2015-07-28  5355  		pr_info("slave_destroy <%u %u %u %llu>\n",
8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5356  		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
46ab9018f5b07d Wenchao Hao     2023-04-28  5357  
46ab9018f5b07d Wenchao Hao     2023-04-28 @5358  	debugfs_remove(devip->debugfs_entry);
                                                                       ^^^^^^^^^^^^^^^^^^^^
Dereference

8dea0d02f8bb71 FUJITA Tomonori 2008-03-30 @5359  	if (devip) {
                                                            ^^^^^
Checked too late.

25985edcedea63 Lucas De Marchi 2011-03-30  5360  		/* make this slot available for re-use */
c2248fc974df7b Douglas Gilbert 2014-11-24  5361  		devip->used = false;
8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5362  		sdp->hostdata = NULL;
8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5363  	}
8dea0d02f8bb71 FUJITA Tomonori 2008-03-30  5364  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

