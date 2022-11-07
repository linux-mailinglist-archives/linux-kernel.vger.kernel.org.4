Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9990261EC6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiKGHuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiKGHus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:50:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C663D8;
        Sun,  6 Nov 2022 23:50:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso7863500wmb.0;
        Sun, 06 Nov 2022 23:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn1piaXxc21W8WIXCvaPByn+C5mJyUz3dv2gAqZymug=;
        b=Jdd40BIHbir1vpkDqGuu45WPRNXRhjkMSSndFd7uA/NemHVnSYCy7FMm8SgVWagKGo
         zOGDtO61jet2Hzhh4gG/4mmZkcT1R7IW+mscOjRVaiztllIa+eZn5B0F6vzWKmdygOg8
         ZZ10l365Tyla9Vs+TejOOdmScVsHQlgodivyPnLq3A9hTIADHVnLefI300zKpAIVKhvv
         InOMuMQGk+0IZtvTHW45u7fGsL9mjinyaSiS8BoSG+p9tH5zLAoMYuHGlT0I87WY+rAS
         ia/ErsT770AQ7ABjbLQr+AXqE1FUk6mf8xBpYYgoWntLMpXajjwpNIdo4BXN3ruWJGbr
         BV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn1piaXxc21W8WIXCvaPByn+C5mJyUz3dv2gAqZymug=;
        b=NRDBPT195BRhpV/8oLmSvWraWZ68bBbj/sCwIiY6FeEjbo46ev9YUqtMSPHYABn+Fh
         mYKdAMfAabkNZsN+m2Af2KGLeL9rThev7Rf7hNj7NQ6+6l+AXUbQ5H3WcDHBkXIrjSpb
         /mPqc0Jmb0IQmtaJYJOpxZLwNM9CIBpS6ffgGY5emeAyON49v5GJ3a3YZa5UtGnayw0i
         KTzuVL9Sf4/Qk4BwgCliz0ZipNRaXr4a8l7g6CNJoYVOqdq0uwyj0DtAN6mvy0uPyfvS
         AQjyDr7IFuVC622C9XzuPO2Uff3OrH+GHUClfnWkfYWXr6fkuyZ3LQj4QzbDEjt5ppNq
         ZgEA==
X-Gm-Message-State: ACrzQf1Yi1h04F8gfko5hC8lYmPl1s/kmGR7TGJJrpljy3xKCu7kLrk1
        Iglevh81ZN05sZH/zDIOey4=
X-Google-Smtp-Source: AMsMyM5Y0xS9zKpwtO3S/J2nFpEkEf4LKkL2xR9sTBwwc4rJmFzmVbCISYRZ3sj48GXkSOTGubkEDg==
X-Received: by 2002:a1c:a107:0:b0:3cf:a25f:eef2 with SMTP id k7-20020a1ca107000000b003cfa25feef2mr6468699wme.195.1667807445967;
        Sun, 06 Nov 2022 23:50:45 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bca55000000b003c6c182bef9sm12584534wml.36.2022.11.06.23.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:50:45 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:50:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, 'Guanjun' <guanjun@linux.alibaba.com>,
        herbert@gondor.apana.org.au, elliott@hpe.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        zelin.deng@linux.alibaba.com, artie.ding@linux.alibaba.com,
        guanjun@linux.alibaba.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuchun.shang@linux.alibaba.com
Subject: Re: [PATCH v3 RESEND 3/9] crypto/ycc: Add irq support for ycc kernel
 rings
Message-ID: <202211060128.TZF4P1Ko-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667461243-48652-4-git-send-email-guanjun@linux.alibaba.com>
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
patch link:    https://lore.kernel.org/r/1667461243-48652-4-git-send-email-guanjun%40linux.alibaba.com
patch subject: [PATCH v3 RESEND 3/9] crypto/ycc: Add irq support for ycc kernel rings
config: ia64-randconfig-m031-20221104
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/crypto/ycc/ycc_isr.c:124 ycc_alloc_irqs() warn: missing error code 'ret'

vim +/ret +124 drivers/crypto/ycc/ycc_isr.c

99da43fc5ee114 Zelin Deng 2022-11-03   98  
99da43fc5ee114 Zelin Deng 2022-11-03   99  int ycc_alloc_irqs(struct ycc_dev *ydev)
99da43fc5ee114 Zelin Deng 2022-11-03  100  {
99da43fc5ee114 Zelin Deng 2022-11-03  101  	struct pci_dev *rcec_pdev = ydev->assoc_dev->pdev;
99da43fc5ee114 Zelin Deng 2022-11-03  102  	int num = ydev->is_vf ? 1 : YCC_RINGPAIR_NUM;
3c2d80e20cfe81 Zelin Deng 2022-11-03  103  	int cpu, cpus = num_online_cpus();
3c2d80e20cfe81 Zelin Deng 2022-11-03  104  	int ret, i, j;
99da43fc5ee114 Zelin Deng 2022-11-03  105  
3c2d80e20cfe81 Zelin Deng 2022-11-03  106  	/* The 0 - (YCC_RINGPAIR_NUM-1) are rings irqs, the last one is dev error irq */
99da43fc5ee114 Zelin Deng 2022-11-03  107  	sprintf(ydev->err_irq_name, "ycc_dev_%d_global_err", ydev->id);
99da43fc5ee114 Zelin Deng 2022-11-03  108  	ret = request_irq(pci_irq_vector(rcec_pdev, num),
99da43fc5ee114 Zelin Deng 2022-11-03  109  			  ycc_g_err_isr, 0, ydev->err_irq_name, ydev);
3c2d80e20cfe81 Zelin Deng 2022-11-03  110  	if (ret) {
99da43fc5ee114 Zelin Deng 2022-11-03  111  		pr_err("Failed to alloc global irq interrupt for dev: %d\n", ydev->id);
3c2d80e20cfe81 Zelin Deng 2022-11-03  112  		goto out;
3c2d80e20cfe81 Zelin Deng 2022-11-03  113  	}
3c2d80e20cfe81 Zelin Deng 2022-11-03  114  
3c2d80e20cfe81 Zelin Deng 2022-11-03  115  	if (ydev->is_polling)
3c2d80e20cfe81 Zelin Deng 2022-11-03  116  		goto out;
3c2d80e20cfe81 Zelin Deng 2022-11-03  117  
3c2d80e20cfe81 Zelin Deng 2022-11-03  118  	for (i = 0; i < num; i++) {
3c2d80e20cfe81 Zelin Deng 2022-11-03  119  		if (ydev->rings[i].type != KERN_RING)
3c2d80e20cfe81 Zelin Deng 2022-11-03  120  			continue;
3c2d80e20cfe81 Zelin Deng 2022-11-03  121  
3c2d80e20cfe81 Zelin Deng 2022-11-03  122  		ydev->msi_name[i] = kzalloc(16, GFP_KERNEL);
3c2d80e20cfe81 Zelin Deng 2022-11-03  123  		if (!ydev->msi_name[i])
3c2d80e20cfe81 Zelin Deng 2022-11-03 @124  			goto free_irq;

ret = -ENOMEM;

3c2d80e20cfe81 Zelin Deng 2022-11-03  125  		snprintf(ydev->msi_name[i], 16, "ycc_ring_%d", i);
3c2d80e20cfe81 Zelin Deng 2022-11-03  126  		ret = request_irq(pci_irq_vector(rcec_pdev, i), ycc_resp_isr,
3c2d80e20cfe81 Zelin Deng 2022-11-03  127  				  0, ydev->msi_name[i], &ydev->rings[i]);
3c2d80e20cfe81 Zelin Deng 2022-11-03  128  		if (ret) {
3c2d80e20cfe81 Zelin Deng 2022-11-03  129  			kfree(ydev->msi_name[i]);
3c2d80e20cfe81 Zelin Deng 2022-11-03  130  			goto free_irq;
3c2d80e20cfe81 Zelin Deng 2022-11-03  131  		}
3c2d80e20cfe81 Zelin Deng 2022-11-03  132  		if (!ydev->is_vf)
3c2d80e20cfe81 Zelin Deng 2022-11-03  133  			cpu = (i % YCC_RINGPAIR_NUM) % cpus;
3c2d80e20cfe81 Zelin Deng 2022-11-03  134  		else
3c2d80e20cfe81 Zelin Deng 2022-11-03  135  			cpu = smp_processor_id() % cpus;
3c2d80e20cfe81 Zelin Deng 2022-11-03  136  
3c2d80e20cfe81 Zelin Deng 2022-11-03  137  		ret = irq_set_affinity_hint(pci_irq_vector(rcec_pdev, i),
3c2d80e20cfe81 Zelin Deng 2022-11-03  138  					    get_cpu_mask(cpu));
3c2d80e20cfe81 Zelin Deng 2022-11-03  139  		if (ret) {
3c2d80e20cfe81 Zelin Deng 2022-11-03  140  			free_irq(pci_irq_vector(rcec_pdev, i), &ydev->rings[i]);
3c2d80e20cfe81 Zelin Deng 2022-11-03  141  			kfree(ydev->msi_name[i]);
3c2d80e20cfe81 Zelin Deng 2022-11-03  142  			goto free_irq;
3c2d80e20cfe81 Zelin Deng 2022-11-03  143  		}
3c2d80e20cfe81 Zelin Deng 2022-11-03  144  	}
3c2d80e20cfe81 Zelin Deng 2022-11-03  145  
3c2d80e20cfe81 Zelin Deng 2022-11-03  146  	return 0;
3c2d80e20cfe81 Zelin Deng 2022-11-03  147  
3c2d80e20cfe81 Zelin Deng 2022-11-03  148  free_irq:
3c2d80e20cfe81 Zelin Deng 2022-11-03  149  	for (j = 0; j < i; j++) {
3c2d80e20cfe81 Zelin Deng 2022-11-03  150  		if (ydev->rings[i].type != KERN_RING)
3c2d80e20cfe81 Zelin Deng 2022-11-03  151  			continue;
3c2d80e20cfe81 Zelin Deng 2022-11-03  152  
3c2d80e20cfe81 Zelin Deng 2022-11-03  153  		free_irq(pci_irq_vector(rcec_pdev, j), &ydev->rings[j]);
3c2d80e20cfe81 Zelin Deng 2022-11-03  154  		kfree(ydev->msi_name[j]);
3c2d80e20cfe81 Zelin Deng 2022-11-03  155  	}
3c2d80e20cfe81 Zelin Deng 2022-11-03  156  	free_irq(pci_irq_vector(rcec_pdev, num), ydev);
3c2d80e20cfe81 Zelin Deng 2022-11-03  157  out:
99da43fc5ee114 Zelin Deng 2022-11-03  158  
99da43fc5ee114 Zelin Deng 2022-11-03  159  	return ret;
99da43fc5ee114 Zelin Deng 2022-11-03  160  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

