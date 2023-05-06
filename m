Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49C06F8FF0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjEFH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEFH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:27:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A92699
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:27:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f3331f928cso17757675e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358036; x=1685950036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyO3bd/dy/ShKSE4Wtgdi8b7qlXeUkRE0/PJNUctuDU=;
        b=X8HJOSXHh9sxiO01faufEmdtTyxOht0+qwkDUxFDoaqtV2MK9xTJpMOcuZKuhoTMxV
         /ITKcIC7uW1FVOfzuQFog560aAzZhrBKjr8m+5hoW4SX2OMWMAOGCnaZpMeqnnyT6IlC
         fVwrCAsgj1Qgka/ih1Xgoz/ps9i7rKsA/JQ4F9yHF3yfmjVZFuV84cSXXcTtsBooFsv+
         4SrDqfR7yeGFa5X/A8Jv4ctIVtvM3+EHkYqHeCaJMuLvnVvRrCBtIKYNM2Ac/8SQIbZw
         GRX3MHt/yXo++RKvx4Hu8LSVn1uWwFs40PpxZ+ioH2W6tjgBCxFAFrCjmsdRt/jJQkfH
         AXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358036; x=1685950036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyO3bd/dy/ShKSE4Wtgdi8b7qlXeUkRE0/PJNUctuDU=;
        b=Rx6XEjX9RD4GiH/LMbgWyCx4qXYDWlu08FyL8g9ROmZpJFkO5ULnxVV9xcoyVDqGjp
         hODqC9L9CiDUgRc8cMlzRw97ima8nCWdYJ7AzdHQcF7zN52DUt3rh/ZzStN0hsXHgJ8X
         LArTD25a7M6y5nSSehPtxShx1zzM4hB56zmbLx1Wx46aN4vzVflB7DRVsxBIfiDoZyY/
         A+iklrpBeRprlqHfg9dX6bQyX1q/+ZvWuP6Y6F709V1ZVQxJ1vte3DjZMgnkglLvkr00
         uIJVqc/1WaGKpl0ZJ3ykPWxmd58PsLijtms7CB+Q9qX213v1Xtfua6SvO5G/PImiLN0e
         KzYA==
X-Gm-Message-State: AC+VfDyKrp8I0j60eJDOM2C2qhGVMSf3qX4aWGymgPEkJlMwpzCryR0T
        sBCaxG25m8sRnYBDYTYR5xyQ3A==
X-Google-Smtp-Source: ACHHUZ4iTcz1CqJ/ZZpjtuurFjIyQgp+df5DDqtIMFXAaJWuamBMtxHkg+maT+c8bOZZXwfl6I5ZoA==
X-Received: by 2002:a05:600c:248:b0:3f1:82d8:8fde with SMTP id 8-20020a05600c024800b003f182d88fdemr2525723wmj.24.1683358035850;
        Sat, 06 May 2023 00:27:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l11-20020a7bc34b000000b003f195d2f1a9sm9994159wmj.15.2023.05.06.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:27:13 -0700 (PDT)
Date:   Sat, 6 May 2023 10:27:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: drivers/clk/mediatek/clk-mtk.c:588 __mtk_clk_simple_probe() error:
 uninitialized symbol 'base'.
Message-ID: <6b5f2290-3019-4058-a857-60eceb4b7b79@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   418d5c98319f67b9ae651babea031b5394425c18
commit: 252091242404aa7cee131a827a04b8e3d9b88daa clk: mediatek: clk-mtk: Introduce clk_mtk_pdev_{probe,remove}()
config: microblaze-randconfig-m041-20230430 (https://download.01.org/0day-ci/archive/20230506/202305060920.yjRhTxrD-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305060920.yjRhTxrD-lkp@intel.com/

smatch warnings:
drivers/clk/mediatek/clk-mtk.c:588 __mtk_clk_simple_probe() error: uninitialized symbol 'base'.

vim +/base +588 drivers/clk/mediatek/clk-mtk.c

252091242404aa AngeloGioacchino Del Regno 2023-03-06  465  static int __mtk_clk_simple_probe(struct platform_device *pdev,
252091242404aa AngeloGioacchino Del Regno 2023-03-06  466  				  struct device_node *node)
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  467  {
252091242404aa AngeloGioacchino Del Regno 2023-03-06  468  	const struct platform_device_id *id;
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  469  	const struct mtk_clk_desc *mcd;
609cc5e1a82394 Chen-Yu Tsai               2022-05-19  470  	struct clk_hw_onecell_data *clk_data;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  471  	void __iomem *base;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  472  	int num_clks, r;
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  473  
4b476b0f453431 AngeloGioacchino Del Regno 2023-03-06  474  	mcd = device_get_match_data(&pdev->dev);
252091242404aa AngeloGioacchino Del Regno 2023-03-06  475  	if (!mcd) {
252091242404aa AngeloGioacchino Del Regno 2023-03-06  476  		/* Clock driver wasn't registered from devicetree */
252091242404aa AngeloGioacchino Del Regno 2023-03-06  477  		id = platform_get_device_id(pdev);
252091242404aa AngeloGioacchino Del Regno 2023-03-06  478  		if (id)
252091242404aa AngeloGioacchino Del Regno 2023-03-06  479  			mcd = (const struct mtk_clk_desc *)id->driver_data;
252091242404aa AngeloGioacchino Del Regno 2023-03-06  480  
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  481  		if (!mcd)
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  482  			return -EINVAL;
252091242404aa AngeloGioacchino Del Regno 2023-03-06  483  	}
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  484  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  485  	/* Composite clocks needs us to pass iomem pointer */
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  486  	if (mcd->composite_clks) {

Assume mcd->composite_clks is false.

7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  487  		if (!mcd->shared_io)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  488  			base = devm_platform_ioremap_resource(pdev, 0);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  489  		else
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  490  			base = of_iomap(node, 0);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  491  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  492  		if (IS_ERR_OR_NULL(base))
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  493  			return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  494  	}
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  495  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  496  	/* Calculate how many clk_hw_onecell_data entries to allocate */
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  497  	num_clks = mcd->num_clks + mcd->num_composite_clks;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  498  	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  499  	num_clks += mcd->num_mux_clks;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  500  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  501  	clk_data = mtk_alloc_clk_data(num_clks);
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  502  	if (!clk_data)
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  503  		return -ENOMEM;
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  504  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  505  	if (mcd->fixed_clks) {
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  506  		r = mtk_clk_register_fixed_clks(mcd->fixed_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  507  						mcd->num_fixed_clks, clk_data);
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  508  		if (r)
6203815bf97eea Chun-Jie Chen              2021-09-14  509  			goto free_data;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  510  	}
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  511  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  512  	if (mcd->factor_clks) {
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  513  		r = mtk_clk_register_factors(mcd->factor_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  514  					     mcd->num_factor_clks, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  515  		if (r)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  516  			goto unregister_fixed_clks;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  517  	}
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  518  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  519  	if (mcd->mux_clks) {
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  520  		r = mtk_clk_register_muxes(&pdev->dev, mcd->mux_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  521  					   mcd->num_mux_clks, node,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  522  					   mcd->clk_lock, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  523  		if (r)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  524  			goto unregister_factors;
b30a027779a501 Yang Li                    2023-02-02  525  	}
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  526  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  527  	if (mcd->composite_clks) {
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  528  		/* We don't check composite_lock because it's optional */
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  529  		r = mtk_clk_register_composites(&pdev->dev,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  530  						mcd->composite_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  531  						mcd->num_composite_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  532  						base, mcd->clk_lock, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  533  		if (r)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  534  			goto unregister_muxes;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  535  	}
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  536  
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  537  	if (mcd->clks) {
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  538  		r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  539  					   mcd->num_clks, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  540  		if (r)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  541  			goto unregister_composites;
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  542  	}
6203815bf97eea Chun-Jie Chen              2021-09-14  543  
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  544  	if (mcd->clk_notifier_func) {
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  545  		struct clk *mfg_mux = clk_data->hws[mcd->mfg_clk_idx]->clk;
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  546  
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  547  		r = mcd->clk_notifier_func(&pdev->dev, mfg_mux);
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  548  		if (r)
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  549  			goto unregister_clks;
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  550  	}
fd9fe654f41c02 AngeloGioacchino Del Regno 2023-01-20  551  
609cc5e1a82394 Chen-Yu Tsai               2022-05-19  552  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
6203815bf97eea Chun-Jie Chen              2021-09-14  553  	if (r)
2d18b7e31aa804 Chen-Yu Tsai               2022-02-08  554  		goto unregister_clks;
6203815bf97eea Chun-Jie Chen              2021-09-14  555  
2204d96b191912 Chen-Yu Tsai               2022-02-08  556  	platform_set_drvdata(pdev, clk_data);
2204d96b191912 Chen-Yu Tsai               2022-02-08  557  
b27a604a579310 Rex-BC Chen                2022-05-23  558  	if (mcd->rst_desc) {
b27a604a579310 Rex-BC Chen                2022-05-23  559  		r = mtk_register_reset_controller_with_dev(&pdev->dev,
b27a604a579310 Rex-BC Chen                2022-05-23  560  							   mcd->rst_desc);
b27a604a579310 Rex-BC Chen                2022-05-23  561  		if (r)
b27a604a579310 Rex-BC Chen                2022-05-23  562  			goto unregister_clks;
b27a604a579310 Rex-BC Chen                2022-05-23  563  	}
b27a604a579310 Rex-BC Chen                2022-05-23  564  
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  565  	return r;
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  566  
2d18b7e31aa804 Chen-Yu Tsai               2022-02-08  567  unregister_clks:
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  568  	if (mcd->clks)
2d18b7e31aa804 Chen-Yu Tsai               2022-02-08  569  		mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  570  unregister_composites:
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  571  	if (mcd->composite_clks)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  572  		mtk_clk_unregister_composites(mcd->composite_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  573  					      mcd->num_composite_clks, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  574  unregister_muxes:
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  575  	if (mcd->mux_clks)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  576  		mtk_clk_unregister_muxes(mcd->mux_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  577  					 mcd->num_mux_clks, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  578  unregister_factors:
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  579  	if (mcd->factor_clks)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  580  		mtk_clk_unregister_factors(mcd->factor_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  581  					   mcd->num_factor_clks, clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  582  unregister_fixed_clks:
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  583  	if (mcd->fixed_clks)
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  584  		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  585  					      mcd->num_fixed_clks, clk_data);
6203815bf97eea Chun-Jie Chen              2021-09-14  586  free_data:
6203815bf97eea Chun-Jie Chen              2021-09-14  587  	mtk_free_clk_data(clk_data);
7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20 @588  	if (mcd->shared_io && base)

Uninitialized "base".  Checking "base" makes no sense because it's
either valid or uninitialized...  Smatch wants this to be:

	if (mcd->composite_clks && mcd->shared_io)
		iounmap(base);

7b6183108c8ccf AngeloGioacchino Del Regno 2023-01-20  589  		iounmap(base);
6203815bf97eea Chun-Jie Chen              2021-09-14  590  	return r;
c58cd0e40ffac6 Chun-Jie Chen              2021-07-26  591  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

