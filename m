Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39499702641
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjEOHnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEOHnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:43:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3DFC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:43:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f427118644so79734695e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684136581; x=1686728581;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj4ZdnW0M2NIw/r58RrNWbXPLf2ZkNkSYUhgr2sJBMM=;
        b=YOKgTp21/RP+G49WeMaFO2vL1Rgoatf9FXSjtOc25d4CZxgUZnaQjlwFHOciw3b9iL
         79vYLsMC+Z4StgWaAjf8TCBd6EnAsUOMhsQE914QJysRTUa8OMhn8DpBS2EJJCVehpjJ
         C0Hl9KyP2L6B2lYVGO1yTOPwuEGcoEmvQG3znrkZPzYmUCT9WJQ/cMS2r9Aim95oCuie
         QYdXpBM9pSHv09uhiamjo39x+6wv0VZHpHVgrUmpzzae3Vn56MihnNyd2aoVrjbw67xt
         dePqSiLaKMhgAi3VdPZBllq3tt47p3jR16LHz8+g3vLfOIQbt+CCf8qyLAyUGf6g6MiN
         xp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684136581; x=1686728581;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kj4ZdnW0M2NIw/r58RrNWbXPLf2ZkNkSYUhgr2sJBMM=;
        b=VvxDR8Eck74RYFyCIa1DnWF1EVvRR72shOaN5Gf8yxB08u4a7PA4X3Zi14BqB/WLQ5
         onLxEBA8qdlGQD9U/pWjsF01WlGN/8soXLMgYvYVMpT8UE7y/NUuGMjUuCPNyfD6mflp
         hyuIofyknXj1/pML1yX+NQRb7vCJpngggLJsnGwijCLJ48Q1T/Am9/Q6umv44EhtA95F
         ErnAqUjBFmapLTkDlFybp+SChmSep2F5b6FzPbIqnWNrz0kPI0ghlyQ+8unvdXNeP1tN
         1Wcht5uepsrmWd1DqxFD3iBaRpO6af9IIE+abSD7GT0wStPW8bIyAVgMlPhKOCHuU6mx
         tXtw==
X-Gm-Message-State: AC+VfDw3PQGWtdbhxM+HXjg7KdqrMBFvvGmCV+86gnM3KlYpyyVdLuKT
        JRkDOMOvBBX3NkS1dznd9p6lpA==
X-Google-Smtp-Source: ACHHUZ5b52vQ0CkeGQYDfkS3Z25fWaiHt1VhYG7BMaDGcGnNpNppedd5n7WuHUZAH2kWSh7v6fcOlw==
X-Received: by 2002:a1c:f619:0:b0:3f5:ce4:6c3f with SMTP id w25-20020a1cf619000000b003f50ce46c3fmr1151671wmc.7.1684136581208;
        Mon, 15 May 2023 00:43:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v25-20020a1cf719000000b003f50e88ffb5sm846967wmh.24.2023.05.15.00.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:42:59 -0700 (PDT)
Date:   Mon, 15 May 2023 10:42:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        prathubaronia2011@gmail.com
Subject: Re: [PATCH v2 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <30f4e6ff-5ad3-4b57-b7c7-228b97369b72@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514130148.138624-2-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prathu,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prathu-Baronia/axis-fifo-cleanup-space-issues-with-fops-struct/20230514-220201
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20230514130148.138624-2-prathubaronia2011%40gmail.com
patch subject: [PATCH v2 1/2] axis-fifo: use devm_kasprintf() for allocating formatted strings
config: i386-randconfig-m021
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305150358.nt1BkbXz-lkp@intel.com/

New smatch warnings:
drivers/staging/axis-fifo/axis-fifo.c:858 axis_fifo_probe() warn: missing unwind goto?

Old smatch warnings:
drivers/staging/axis-fifo/axis-fifo.c:907 axis_fifo_probe() error: '%pa' expects argument of type 'phys_addr_t*', argument 4 has type 'void**'

vim +858 drivers/staging/axis-fifo/axis-fifo.c

4a965c5f89decd Jacob Feder        2018-07-22  806  static int axis_fifo_probe(struct platform_device *pdev)
4a965c5f89decd Jacob Feder        2018-07-22  807  {
4a965c5f89decd Jacob Feder        2018-07-22  808  	struct resource *r_mem; /* IO mem resources */
4a965c5f89decd Jacob Feder        2018-07-22  809  	struct device *dev = &pdev->dev; /* OS device (from device tree) */
4a965c5f89decd Jacob Feder        2018-07-22  810  	struct axis_fifo *fifo = NULL;
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  811  	char *device_name;
4a965c5f89decd Jacob Feder        2018-07-22  812  	int rc = 0; /* error return value */
4a965c5f89decd Jacob Feder        2018-07-22  813  
4a965c5f89decd Jacob Feder        2018-07-22  814  	/* ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  815  	 *     init wrapper device
4a965c5f89decd Jacob Feder        2018-07-22  816  	 * ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  817  	 */
4a965c5f89decd Jacob Feder        2018-07-22  818  
4a965c5f89decd Jacob Feder        2018-07-22  819  	/* allocate device wrapper memory */
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  820  	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
4a965c5f89decd Jacob Feder        2018-07-22  821  	if (!fifo)
4a965c5f89decd Jacob Feder        2018-07-22  822  		return -ENOMEM;
4a965c5f89decd Jacob Feder        2018-07-22  823  
4a965c5f89decd Jacob Feder        2018-07-22  824  	dev_set_drvdata(dev, fifo);
4a965c5f89decd Jacob Feder        2018-07-22  825  	fifo->dt_device = dev;
4a965c5f89decd Jacob Feder        2018-07-22  826  
4a965c5f89decd Jacob Feder        2018-07-22  827  	init_waitqueue_head(&fifo->read_queue);
4a965c5f89decd Jacob Feder        2018-07-22  828  	init_waitqueue_head(&fifo->write_queue);
4a965c5f89decd Jacob Feder        2018-07-22  829  
0443b3f4436321 Quentin Deslandes  2020-01-21  830  	mutex_init(&fifo->read_lock);
0443b3f4436321 Quentin Deslandes  2020-01-21  831  	mutex_init(&fifo->write_lock);
4a965c5f89decd Jacob Feder        2018-07-22  832  
4a965c5f89decd Jacob Feder        2018-07-22  833  	/* ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  834  	 *   init device memory space
4a965c5f89decd Jacob Feder        2018-07-22  835  	 * ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  836  	 */
4a965c5f89decd Jacob Feder        2018-07-22  837  
4a965c5f89decd Jacob Feder        2018-07-22  838  	/* get iospace for the device */
4a965c5f89decd Jacob Feder        2018-07-22  839  	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
4a965c5f89decd Jacob Feder        2018-07-22  840  	if (!r_mem) {
4a965c5f89decd Jacob Feder        2018-07-22  841  		dev_err(fifo->dt_device, "invalid address\n");
4a965c5f89decd Jacob Feder        2018-07-22  842  		rc = -ENODEV;
4a965c5f89decd Jacob Feder        2018-07-22  843  		goto err_initial;
4a965c5f89decd Jacob Feder        2018-07-22  844  	}
4a965c5f89decd Jacob Feder        2018-07-22  845  
4a965c5f89decd Jacob Feder        2018-07-22  846  	/* request physical memory */
354e27a86b4c64 Quentin Deslandes  2019-11-01  847  	fifo->base_addr = devm_ioremap_resource(fifo->dt_device, r_mem);
6a20d283ed6867 Quentin Deslandes  2019-11-01  848  	if (IS_ERR(fifo->base_addr)) {
6a20d283ed6867 Quentin Deslandes  2019-11-01  849  		rc = PTR_ERR(fifo->base_addr);
4a965c5f89decd Jacob Feder        2018-07-22  850  		goto err_initial;
4a965c5f89decd Jacob Feder        2018-07-22  851  	}
4a965c5f89decd Jacob Feder        2018-07-22  852  
4a965c5f89decd Jacob Feder        2018-07-22  853  	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
4a965c5f89decd Jacob Feder        2018-07-22  854  
4a965c5f89decd Jacob Feder        2018-07-22  855  	/* create unique device name */
c5cab4f62648eb Prathu Baronia     2023-05-14  856  	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%pa", DRIVER_NAME, &r_mem->start);
c5cab4f62648eb Prathu Baronia     2023-05-14  857  	if (!device_name)
c5cab4f62648eb Prathu Baronia     2023-05-14 @858  		return -ENOMEM;

		rc = -ENOMEM;
		goto err_initial;

4a965c5f89decd Jacob Feder        2018-07-22  859  	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
4a965c5f89decd Jacob Feder        2018-07-22  860  
4a965c5f89decd Jacob Feder        2018-07-22  861  	/* ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  862  	 *          init IP
4a965c5f89decd Jacob Feder        2018-07-22  863  	 * ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  864  	 */
4a965c5f89decd Jacob Feder        2018-07-22  865  
ed6daf2b2832d9 Quentin Deslandes  2019-11-01  866  	rc = axis_fifo_parse_dt(fifo);
4a965c5f89decd Jacob Feder        2018-07-22  867  	if (rc)
6a20d283ed6867 Quentin Deslandes  2019-11-01  868  		goto err_initial;
4a965c5f89decd Jacob Feder        2018-07-22  869  
4a965c5f89decd Jacob Feder        2018-07-22  870  	reset_ip_core(fifo);
4a965c5f89decd Jacob Feder        2018-07-22  871  
4a965c5f89decd Jacob Feder        2018-07-22  872  	/* ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  873  	 *    init device interrupts
4a965c5f89decd Jacob Feder        2018-07-22  874  	 * ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  875  	 */
4a965c5f89decd Jacob Feder        2018-07-22  876  
4a965c5f89decd Jacob Feder        2018-07-22  877  	/* get IRQ resource */
790ada0e6ec33e Lad Prabhakar      2021-12-24  878  	rc = platform_get_irq(pdev, 0);
790ada0e6ec33e Lad Prabhakar      2021-12-24  879  	if (rc < 0)
6a20d283ed6867 Quentin Deslandes  2019-11-01  880  		goto err_initial;
4a965c5f89decd Jacob Feder        2018-07-22  881  
4a965c5f89decd Jacob Feder        2018-07-22  882  	/* request IRQ */
790ada0e6ec33e Lad Prabhakar      2021-12-24  883  	fifo->irq = rc;
6a20d283ed6867 Quentin Deslandes  2019-11-01  884  	rc = devm_request_irq(fifo->dt_device, fifo->irq, &axis_fifo_irq, 0,
6a20d283ed6867 Quentin Deslandes  2019-11-01  885  			      DRIVER_NAME, fifo);
4a965c5f89decd Jacob Feder        2018-07-22  886  	if (rc) {
4a965c5f89decd Jacob Feder        2018-07-22  887  		dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
4a965c5f89decd Jacob Feder        2018-07-22  888  			fifo->irq);
6a20d283ed6867 Quentin Deslandes  2019-11-01  889  		goto err_initial;
4a965c5f89decd Jacob Feder        2018-07-22  890  	}
4a965c5f89decd Jacob Feder        2018-07-22  891  
4a965c5f89decd Jacob Feder        2018-07-22  892  	/* ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  893  	 *      init char device
4a965c5f89decd Jacob Feder        2018-07-22  894  	 * ----------------------------
4a965c5f89decd Jacob Feder        2018-07-22  895  	 */
4a965c5f89decd Jacob Feder        2018-07-22  896  
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  897  	/* create character device */
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  898  	fifo->miscdev.fops = &fops;
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  899  	fifo->miscdev.minor = MISC_DYNAMIC_MINOR;
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  900  	fifo->miscdev.name = device_name;
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  901  	fifo->miscdev.groups = axis_fifo_attrs_groups;
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  902  	fifo->miscdev.parent = dev;
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  903  	rc = misc_register(&fifo->miscdev);
4a965c5f89decd Jacob Feder        2018-07-22  904  	if (rc < 0)
6a20d283ed6867 Quentin Deslandes  2019-11-01  905  		goto err_initial;
4a965c5f89decd Jacob Feder        2018-07-22  906  
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  907  	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i\n",
                                                                                                                      ^^^^^
d2d7aa53891ea1 Greg Kroah-Hartman 2021-09-07  908  		 &r_mem->start, &fifo->base_addr, fifo->irq);
                                                                                ^^^^^^^^^^^^^^^^
I think Smatch is correct that it should just be %p instead of %pa but
I don't know the rules here too well.

4a965c5f89decd Jacob Feder        2018-07-22  909  
4a965c5f89decd Jacob Feder        2018-07-22  910  	return 0;
4a965c5f89decd Jacob Feder        2018-07-22  911  
4a965c5f89decd Jacob Feder        2018-07-22  912  err_initial:
4a965c5f89decd Jacob Feder        2018-07-22  913  	dev_set_drvdata(dev, NULL);
4a965c5f89decd Jacob Feder        2018-07-22  914  	return rc;
4a965c5f89decd Jacob Feder        2018-07-22  915  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

