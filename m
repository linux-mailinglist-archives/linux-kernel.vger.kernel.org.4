Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E338F61EC60
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKGHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiKGHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:46:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB362D2DE;
        Sun,  6 Nov 2022 23:46:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so9052235wmb.2;
        Sun, 06 Nov 2022 23:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2GjIT+VKQtS+q6FoJRHXYGGrtcB+OJPI0amuL9NtPs=;
        b=fVm1AqRcZ7XPh6jTIT7SJQCt5vf3BMfoerh8tOadi7dCT9F+8/DE8AM9TBwn5ntfpT
         9ReQZN3nOpR5LZ8wIp4FJSGYOhyj+CKqh6Mg5NRLHxpLMAkCpcaqc5gxCRT/DXEnje53
         b9b7YW0omGssdPJd7HxHzJFDQbXgDXsLEu82spejfLEOdJnPYVPAP7QT0cih+BoRvsUH
         rfUICzaKcCGb8b1f8mQ8cSetQDl+a7AeoLHfrO691uglS5fWKKRbBcEXL9b7sPi4hClM
         8CVSiayxIceQsyNAQeNq0c8NzkMNvWQ1reKYXRhG6yOgpKBclxBnlGPAUx6w2hwcCLEt
         Ya0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2GjIT+VKQtS+q6FoJRHXYGGrtcB+OJPI0amuL9NtPs=;
        b=VI3BLar6wWceXA3t3cmkKLl10y+Bpsn6IiWaasDyzCHf5qEp3/gvwe4WT1kiGFHSoS
         T5LMeUrJ2OmXrHyfM/BbiTd/BlfuDL383cagrrUP/Vi+X8F46glg+N5cOq9KMylXqBhd
         0cSeuIxlfwaI+LxcsXZPcdsQISukiFBjf7qCA3Ctr/gyTff5nNEHCEoQmak+CA79T4WL
         oA0+d6MOLDEg08mHeiYh/I8YUdwRW7/8EFXMRt4iJA6zOF1NrhoIJZwUxoWx7OUeRwGW
         b1tcUcr3uSaIooNHTTtPKbZreqqznkUhwnwt2KtcA4e5HeMD/CU7DFHd0tUZ3E43/63v
         bCnw==
X-Gm-Message-State: ACrzQf2ETVUvcr+miP67Cc4ajXWekjyLDFkPsoavVUSjoJBLFHlG4NAB
        I4HHGY07aqfImAt7SMZZXyY=
X-Google-Smtp-Source: AMsMyM7fpCgzEqFE6Kh/hlqNIrfyDj1YxguSfqTtLhN1lXptAX7tifxW21MzuK8LfDsfew3vlhVyQA==
X-Received: by 2002:a05:600c:6885:b0:3c2:9da1:5034 with SMTP id fn5-20020a05600c688500b003c29da15034mr32529359wmb.38.1667807183040;
        Sun, 06 Nov 2022 23:46:23 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b0023655e51c14sm6534436wrw.32.2022.11.06.23.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:46:22 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:46:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, 'Guanjun' <guanjun@linux.alibaba.com>,
        herbert@gondor.apana.org.au, elliott@hpe.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        zelin.deng@linux.alibaba.com, artie.ding@linux.alibaba.com,
        guanjun@linux.alibaba.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuchun.shang@linux.alibaba.com
Subject: Re: [PATCH v3 RESEND 2/9] crypto/ycc: Add ycc ring configuration
Message-ID: <202211052204.2NexxC29-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667461243-48652-3-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 'Guanjun',

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guanjun/Drivers-for-Alibaba-YCC-Yitian-Cryptography-Complex-cryptographic-accelerator/20221103-154448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/1667461243-48652-3-git-send-email-guanjun%40linux.alibaba.com
patch subject: [PATCH v3 RESEND 2/9] crypto/ycc: Add ycc ring configuration
config: ia64-randconfig-m031-20221104
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/crypto/ycc/ycc_ring.c:132 ycc_create_ring_debugfs() warn: passing zero to 'PTR_ERR'
drivers/crypto/ycc/ycc_ring.c:381 ycc_select_ring() warn: variable dereferenced before check 'found' (see line 374)

vim +/PTR_ERR +132 drivers/crypto/ycc/ycc_ring.c

9f7d1fe6059378 Zelin Deng 2022-11-03  101  static int ycc_create_ring_debugfs(struct ycc_ring *ring)
9f7d1fe6059378 Zelin Deng 2022-11-03  102  {
9f7d1fe6059378 Zelin Deng 2022-11-03  103  	struct dentry *debugfs;
9f7d1fe6059378 Zelin Deng 2022-11-03  104  	char name[8];
9f7d1fe6059378 Zelin Deng 2022-11-03  105  
9f7d1fe6059378 Zelin Deng 2022-11-03  106  	if (!ring || !ring->ydev || !ring->ydev->debug_dir)
9f7d1fe6059378 Zelin Deng 2022-11-03  107  		return -EINVAL;
9f7d1fe6059378 Zelin Deng 2022-11-03  108  
9f7d1fe6059378 Zelin Deng 2022-11-03  109  	snprintf(name, sizeof(name), "ring%02d", ring->ring_id);
9f7d1fe6059378 Zelin Deng 2022-11-03  110  	debugfs = debugfs_create_dir(name, ring->ydev->debug_dir);
9f7d1fe6059378 Zelin Deng 2022-11-03  111  	if (IS_ERR_OR_NULL(debugfs))
9f7d1fe6059378 Zelin Deng 2022-11-03  112  		goto out;
9f7d1fe6059378 Zelin Deng 2022-11-03  113  
9f7d1fe6059378 Zelin Deng 2022-11-03  114  	ring->debug_dir = debugfs;

The static checker is correct to complain.  Debugfs code is not required
to be checked.  It should just be:

	ring->debug_dir = debugfs_create_dir(name, ring->ydev->debug_dir);

	debugfs_create_file("status", 0400, ring->debug_dir, (void *)ring,
			    &ycc_ring_status_fops);
	debugfs_create_file("dump", 0400, ring->debug_dir, (void *)ring,
			    &ycc_ring_dump_fops);

	return 0;

9f7d1fe6059378 Zelin Deng 2022-11-03  115  
9f7d1fe6059378 Zelin Deng 2022-11-03  116  	debugfs = debugfs_create_file("status", 0400, ring->debug_dir,
9f7d1fe6059378 Zelin Deng 2022-11-03  117  				      (void *)ring, &ycc_ring_status_fops);
9f7d1fe6059378 Zelin Deng 2022-11-03  118  	if (IS_ERR_OR_NULL(debugfs))
9f7d1fe6059378 Zelin Deng 2022-11-03  119  		goto remove_debugfs;
9f7d1fe6059378 Zelin Deng 2022-11-03  120  
9f7d1fe6059378 Zelin Deng 2022-11-03  121  	debugfs = debugfs_create_file("dump", 0400, ring->debug_dir,
9f7d1fe6059378 Zelin Deng 2022-11-03  122  				      (void *)ring, &ycc_ring_dump_fops);
9f7d1fe6059378 Zelin Deng 2022-11-03  123  	if (IS_ERR_OR_NULL(debugfs))
9f7d1fe6059378 Zelin Deng 2022-11-03  124  		goto remove_debugfs;
9f7d1fe6059378 Zelin Deng 2022-11-03  125  
9f7d1fe6059378 Zelin Deng 2022-11-03  126  	return 0;
9f7d1fe6059378 Zelin Deng 2022-11-03  127  
9f7d1fe6059378 Zelin Deng 2022-11-03  128  remove_debugfs:
9f7d1fe6059378 Zelin Deng 2022-11-03  129  	debugfs_remove_recursive(ring->debug_dir);
9f7d1fe6059378 Zelin Deng 2022-11-03  130  out:
9f7d1fe6059378 Zelin Deng 2022-11-03  131  	ring->debug_dir = NULL;
9f7d1fe6059378 Zelin Deng 2022-11-03 @132  	return PTR_ERR(debugfs);
9f7d1fe6059378 Zelin Deng 2022-11-03  133  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

