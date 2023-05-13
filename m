Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1BA701616
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbjEMKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjEMKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:14:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E24549FF
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:14:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3062db220a3so7061877f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683972845; x=1686564845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maF/0RlragViZoWm89VtDYMWcUKFsGrII2Djwtu1jtU=;
        b=IY4i2rLxvErb1U5L0tYIo81smIefYT8H0FMMKwyURlxzfwft3QTw/mPGVY4CPhGX/i
         mjC132r2PIX6KWf6iN/X1aaVpjqWABRx124Rbzundkx750o3WiS/dswL9Nv65Oy0TVT4
         8kh/w7AqpigGtZB+Do6lZMbcanI5GEL2wvGGCjAd2uldTtGNWLnIUu7R0ri8WC2PFZhc
         zzWEeacsV1eWPF/Pp16UWF7lSArPDxw86Hy9yy5ie9hlAiXa2JumfGeUh7l8qB4CXVoR
         9efCuQ/sSL2KdIZ/CJKg2wYCtCnueWj2jYY5uNFsucQAP9mydrQfroWa04LFsgDxS9AZ
         VMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683972845; x=1686564845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maF/0RlragViZoWm89VtDYMWcUKFsGrII2Djwtu1jtU=;
        b=Z33PLW+1CPPl6FohESK9RssorDDD5GFM+7OijX5BTASr7/VPjJb2zGwF2Il0aJnYkM
         9RBte3EOoT27qQjEVCwgV5uQ/leC4QUIGDoLlxNOa6vLSmraHpSPoKLyqPZSj6hWzA5H
         SewYClYK6O0nDcExVavVxreRkT3HfNs6/Yl4F7oIwqdnYoYSh16hes8tKaCC/t7iv3T8
         OV7HEXxr199FkeC+1EvUEsz7ixViYIuZHuTC5vZ3nkDE9BoWoDRmqEZkpylAbNN0CsRo
         hz0M9KABaivFmMWD4tNNuube8p8cjZH3S5K6vPOhBiTCh4L9DDr6O7KqpodlU7FjnVOm
         +8YQ==
X-Gm-Message-State: AC+VfDwHZzN6MB1TjmOGvL7aAxUKgmOm8ne5XLtVWk2LVGNotZlargQ8
        Vk3awA5I6FCGL7UfQjrK4uhQjS6BVbQ3q6mvUtI=
X-Google-Smtp-Source: ACHHUZ6Ff1DQQv+XVzMZzYyuoqJo1osoXgw0EXDX9whkG2ReNHwn193nIbpCCOymcbltHnv8DCHzSA==
X-Received: by 2002:a5d:61ce:0:b0:306:30ea:a072 with SMTP id q14-20020a5d61ce000000b0030630eaa072mr21699723wrv.53.1683972844853;
        Sat, 13 May 2023 03:14:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n18-20020adfe792000000b002f7780eee10sm25984067wrm.59.2023.05.13.03.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 03:14:03 -0700 (PDT)
Date:   Sat, 13 May 2023 13:14:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: drivers/soc/qcom/icc-bwmon.c:360 bwmon_probe() warn: passing zero to
 'dev_err_probe'
Message-ID: <98e45455-7d5d-48e1-a87e-e0b3a05f1bb0@kili.mountain>
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
head:   9a48d604672220545d209e9996c2a1edbb5637f6
commit: b9c2ae6cac403dee3195fda9eb28d8ee733b225b soc: qcom: icc-bwmon: Add bandwidth monitoring driver
config: openrisc-randconfig-m031-20230509 (https://download.01.org/0day-ci/archive/20230513/202305131657.76XeHDjF-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305131657.76XeHDjF-lkp@intel.com/

New smatch warnings:
drivers/soc/qcom/icc-bwmon.c:360 bwmon_probe() warn: passing zero to 'dev_err_probe'

Old smatch warnings:
drivers/soc/qcom/icc-bwmon.c:365 bwmon_probe() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +360 drivers/soc/qcom/icc-bwmon.c

b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  327  static int bwmon_probe(struct platform_device *pdev)
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  328  {
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  329  	struct device *dev = &pdev->dev;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  330  	struct dev_pm_opp *opp;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  331  	struct icc_bwmon *bwmon;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  332  	const struct icc_bwmon_data *data;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  333  	int ret;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  334  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  335  	bwmon = devm_kzalloc(dev, sizeof(*bwmon), GFP_KERNEL);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  336  	if (!bwmon)
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  337  		return -ENOMEM;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  338  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  339  	data = of_device_get_match_data(dev);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  340  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  341  	bwmon->base = devm_platform_ioremap_resource(pdev, 0);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  342  	if (IS_ERR(bwmon->base)) {
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  343  		dev_err(dev, "failed to map bwmon registers\n");
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  344  		return PTR_ERR(bwmon->base);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  345  	}
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  346  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  347  	bwmon->irq = platform_get_irq(pdev, 0);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  348  	if (bwmon->irq < 0) {
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  349  		dev_err(dev, "failed to acquire bwmon IRQ\n");
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  350  		return bwmon->irq;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  351  	}
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  352  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  353  	ret = devm_pm_opp_of_add_table(dev);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  354  	if (ret)
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  355  		return dev_err_probe(dev, ret, "failed to add OPP table\n");
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  356  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  357  	bwmon->max_bw_kbps = UINT_MAX;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  358  	opp = dev_pm_opp_find_bw_floor(dev, &bwmon->max_bw_kbps, 0);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  359  	if (IS_ERR(opp))
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04 @360  		return dev_err_probe(dev, ret, "failed to find max peak bandwidth\n");
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  361  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  362  	bwmon->min_bw_kbps = 0;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  363  	opp = dev_pm_opp_find_bw_ceil(dev, &bwmon->min_bw_kbps, 0);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  364  	if (IS_ERR(opp))
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  365  		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");

s/ret/PTR_ERR(opp)/

b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  366  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  367  	bwmon->sample_ms = data->sample_ms;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  368  	bwmon->default_lowbw_kbps = data->default_lowbw_kbps;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  369  	bwmon->dev = dev;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  370  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  371  	bwmon_disable(bwmon);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  372  	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  373  					bwmon_intr_thread,
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  374  					IRQF_ONESHOT, dev_name(dev), bwmon);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  375  	if (ret)
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  376  		return dev_err_probe(dev, ret, "failed to request IRQ\n");
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  377  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  378  	platform_set_drvdata(pdev, bwmon);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  379  	bwmon_start(bwmon, data);
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  380  
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  381  	return 0;
b9c2ae6cac403de Krzysztof Kozlowski 2022-07-04  382  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

