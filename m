Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849061D99D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKELMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKELMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:12:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF38101D0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 04:12:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h9so10203691wrt.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EnJIVNdbuecqVYinDVXfKkkTbjDs+68dueBt4aQTIg=;
        b=WWeqqgbM2iA2X21Wf3NP6VyiIUxQurUo929lhwjXaIesY9ZAWBAcducLScj7cDnEX2
         oC6weS3CYdKHx53JE5xehuLj1Dzvv2xDbcDwEEzFcn4wsjTZ5LaQ6d9tCV5c5uAbzmtS
         bdW2kz7fyl9iiRnH7vb8dBNWidNz/W1RWMDg8qdJgWRukXqKfmiWv0UKxevoGu/qXadm
         0JTufSaUabRNCqSb48kp7KNh28nYdxpbM2MEHWF07tTGosbDz2XcMeIACCQHDSHjRffG
         6d8ceB4CPajcZse6K7FXJdzZNCFvSXTkvZEmtmeEIZZzYXGNm9/oyDKMJv/F0BNzss5Z
         mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EnJIVNdbuecqVYinDVXfKkkTbjDs+68dueBt4aQTIg=;
        b=lNWzQGxE8GNwAVXzOLxjEm+65s5GP4xeU+0U7bJZHRCMg+6D209Uojljk/5aQEHm9x
         dcSswB0mjCK6ekaNRZ/DeIz+2ioEcs45E4jP1torVnZO3Sy/wIsZNB1+DE7/qgbEBMls
         xpiEn0o19kZtMOMsFQBHc4DstU1Es3NdDa6oKMwYcnIzJN0oGLbqpAY81/LEN5O5pkd6
         1ZkAI4K5YMWj2bpUnB91cXqk5O4rSadNBdMHgg1DaVVxBzVHO3V+zYMQRRoVN/zBSsQT
         INpDhxazR5Lj5AqzieHMjuJ6uFeg/KzF/JlUhpkkP4cfV61sPFEQ4CpSz0Qri2VouXpt
         pHfQ==
X-Gm-Message-State: ACrzQf2/hB1fPVuuftrosqr7IzKNHAyyCTuI7twUqehvUeAQphCKmAWY
        AQEsJ/ZWRDIMDKt5ZYWe2MQAX0Eav4s=
X-Google-Smtp-Source: AMsMyM7Jt/Q0qwraXiWlsCXnYhdxRBpumJ0L1tVcbQvaoMbVJMokoWqeeKKSe+S5MKkUNLRpGVvuXA==
X-Received: by 2002:adf:f58f:0:b0:236:eea6:d4c with SMTP id f15-20020adff58f000000b00236eea60d4cmr13192456wro.39.1667646737665;
        Sat, 05 Nov 2022 04:12:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b002365b759b65sm1854011wrb.86.2022.11.05.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 04:12:17 -0700 (PDT)
Date:   Sat, 5 Nov 2022 14:12:13 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Kees Cook <keescook@chromium.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: fs/pstore/zone.c:1421 register_pstore_zone() warn: inconsistent
 returns '&cxt->pstore_zone_info_lock'.
Message-ID: <202211050153.EzdXBoMu-lkp@intel.com>
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

Hi Kees,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
commit: d1faacbf67b1944f0e0c618dc581d929263f6fe9 Revert "mark pstore-blk as broken"
config: s390-randconfig-m031-20221104
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
fs/pstore/zone.c:1421 register_pstore_zone() warn: inconsistent returns '&cxt->pstore_zone_info_lock'.

vim +1421 fs/pstore/zone.c

d26c3321fe18dc WeiXiong Liao 2020-03-25  1341  	if (!info->read || !info->write) {
d26c3321fe18dc WeiXiong Liao 2020-03-25  1342  		pr_err("no valid general read/write interface\n");
d26c3321fe18dc WeiXiong Liao 2020-03-25  1343  		return -EINVAL;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1344  	}
d26c3321fe18dc WeiXiong Liao 2020-03-25  1345  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1346  	mutex_lock(&cxt->pstore_zone_info_lock);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1347  	if (cxt->pstore_zone_info) {
d26c3321fe18dc WeiXiong Liao 2020-03-25  1348  		pr_warn("'%s' already loaded: ignoring '%s'\n",
d26c3321fe18dc WeiXiong Liao 2020-03-25  1349  				cxt->pstore_zone_info->name, info->name);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1350  		mutex_unlock(&cxt->pstore_zone_info_lock);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1351  		return -EBUSY;

This is a false positive.  Smatch can't see that
"&cxt->pstore_zone_info_lock" and "&pstore_zone_cxt.pstore_zone_info_lock"
are the same.  (Presumably they are.  I haven't looked at the context
outside this email).

d26c3321fe18dc WeiXiong Liao 2020-03-25  1352  	}
d26c3321fe18dc WeiXiong Liao 2020-03-25  1353  	cxt->pstore_zone_info = info;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1354  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1355  	pr_debug("register %s with properties:\n", info->name);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1356  	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1357  	pr_debug("\tkmsg size : %ld Bytes\n", info->kmsg_size);
0dc068265a1c59 WeiXiong Liao 2020-03-25  1358  	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
cc9c4d1b559716 WeiXiong Liao 2020-03-25  1359  	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
34327e9fd21341 WeiXiong Liao 2020-03-25  1360  	pr_debug("\tftrace size : %ld Bytes\n", info->ftrace_size);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1361  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1362  	err = psz_alloc_zones(cxt);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1363  	if (err) {
d26c3321fe18dc WeiXiong Liao 2020-03-25  1364  		pr_err("alloc zones failed\n");
d26c3321fe18dc WeiXiong Liao 2020-03-25  1365  		goto fail_out;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1366  	}
d26c3321fe18dc WeiXiong Liao 2020-03-25  1367  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1368  	if (info->kmsg_size) {
d26c3321fe18dc WeiXiong Liao 2020-03-25  1369  		cxt->pstore.bufsize = cxt->kpszs[0]->buffer_size -
d26c3321fe18dc WeiXiong Liao 2020-03-25  1370  			sizeof(struct psz_kmsg_header);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1371  		cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1372  		if (!cxt->pstore.buf) {
d26c3321fe18dc WeiXiong Liao 2020-03-25  1373  			err = -ENOMEM;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1374  			goto fail_free;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1375  		}
d26c3321fe18dc WeiXiong Liao 2020-03-25  1376  	}
d26c3321fe18dc WeiXiong Liao 2020-03-25  1377  	cxt->pstore.data = cxt;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1378  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1379  	pr_info("registered %s as backend for", info->name);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1380  	cxt->pstore.max_reason = info->max_reason;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1381  	cxt->pstore.name = info->name;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1382  	if (info->kmsg_size) {
d26c3321fe18dc WeiXiong Liao 2020-03-25  1383  		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1384  		pr_cont(" kmsg(%s",
d26c3321fe18dc WeiXiong Liao 2020-03-25  1385  			kmsg_dump_reason_str(cxt->pstore.max_reason));
d26c3321fe18dc WeiXiong Liao 2020-03-25  1386  		if (cxt->pstore_zone_info->panic_write)
d26c3321fe18dc WeiXiong Liao 2020-03-25  1387  			pr_cont(",panic_write");
d26c3321fe18dc WeiXiong Liao 2020-03-25  1388  		pr_cont(")");
d26c3321fe18dc WeiXiong Liao 2020-03-25  1389  	}
0dc068265a1c59 WeiXiong Liao 2020-03-25  1390  	if (info->pmsg_size) {
0dc068265a1c59 WeiXiong Liao 2020-03-25  1391  		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
0dc068265a1c59 WeiXiong Liao 2020-03-25  1392  		pr_cont(" pmsg");
0dc068265a1c59 WeiXiong Liao 2020-03-25  1393  	}
cc9c4d1b559716 WeiXiong Liao 2020-03-25  1394  	if (info->console_size) {
cc9c4d1b559716 WeiXiong Liao 2020-03-25  1395  		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
cc9c4d1b559716 WeiXiong Liao 2020-03-25  1396  		pr_cont(" console");
cc9c4d1b559716 WeiXiong Liao 2020-03-25  1397  	}
34327e9fd21341 WeiXiong Liao 2020-03-25  1398  	if (info->ftrace_size) {
34327e9fd21341 WeiXiong Liao 2020-03-25  1399  		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
34327e9fd21341 WeiXiong Liao 2020-03-25  1400  		pr_cont(" ftrace");
34327e9fd21341 WeiXiong Liao 2020-03-25  1401  	}
d26c3321fe18dc WeiXiong Liao 2020-03-25  1402  	pr_cont("\n");
d26c3321fe18dc WeiXiong Liao 2020-03-25  1403  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1404  	err = pstore_register(&cxt->pstore);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1405  	if (err) {
d26c3321fe18dc WeiXiong Liao 2020-03-25  1406  		pr_err("registering with pstore failed\n");
d26c3321fe18dc WeiXiong Liao 2020-03-25  1407  		goto fail_free;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1408  	}
d26c3321fe18dc WeiXiong Liao 2020-03-25  1409  	mutex_unlock(&pstore_zone_cxt.pstore_zone_info_lock);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1410  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1411  	return 0;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1412  
d26c3321fe18dc WeiXiong Liao 2020-03-25  1413  fail_free:
d26c3321fe18dc WeiXiong Liao 2020-03-25  1414  	kfree(cxt->pstore.buf);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1415  	cxt->pstore.buf = NULL;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1416  	cxt->pstore.bufsize = 0;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1417  	psz_free_all_zones(cxt);
d26c3321fe18dc WeiXiong Liao 2020-03-25  1418  fail_out:
d26c3321fe18dc WeiXiong Liao 2020-03-25  1419  	pstore_zone_cxt.pstore_zone_info = NULL;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1420  	mutex_unlock(&pstore_zone_cxt.pstore_zone_info_lock);
d26c3321fe18dc WeiXiong Liao 2020-03-25 @1421  	return err;
d26c3321fe18dc WeiXiong Liao 2020-03-25  1422  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

