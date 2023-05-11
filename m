Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A596FF055
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbjEKLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbjEKLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:00:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA81FF1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:00:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso4783126f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683802854; x=1686394854;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=No3f3XYm65FiTi/tGYNWmvzfDsXpYVeAInSdfToVGkw=;
        b=Gw8m1hmSqv0JY+Jojcl23Btzr7FMILcpcs3RbVDAbSr4al5kK7V+I26ziHRHvBr1eV
         HJYo5+93EF8CKN45vYTt4aljDWg5mWyL0NxyD/3Ot4sEtPBbHSDw8rhvIB6Dt0Pc9Hif
         QXildXNioAzaJ8FE2e6qydS1nSrB+woMjbuxLA5JIrzomsttxrk9Ocq4lcI7mmKXdRre
         j+k7KGuowS8vi8CQ0GNyskQOw42w5B3bphAqloLtMbQcnvORVePmWbz2RQonAdtBKWcm
         GoiXh9Du5s54N6CvClw9TtrpSiI7pom5cbG6/OZuIOg4yPj/oBxtmM+KUPfKnIYJ+2WN
         aEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802854; x=1686394854;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=No3f3XYm65FiTi/tGYNWmvzfDsXpYVeAInSdfToVGkw=;
        b=ZjzJ7FkYZTP3RQqHCzB74ZIsye25XUJK/mzlpX69A8rAtsQJmYuYGl6HJI+sNn07Lt
         NtZcw2FK8ldwURk0PHOaehWHFay6KEa1AMgC/9ppnr4886v9cAJ7I/313vwXSld4Peqk
         ZSmVcT4sHdtW76WYWJlNmr1CN4SLt8KHxJEaH5uX2MogUn8s+GPU6YOIKgLSaOiM5zyW
         pJoQ3y1mtaUiPMLjJA7XHinhGYyakFgwE4hVxwSF4zzq/RoKd5J9xG8L9pWPL6qHXG9w
         Ze2s4smZrZMqvNUlc1BNuleFg9CcJfAdsy8dSZGJ6MpwHloaxCSwdeaZX0KNInRQJbHX
         t12Q==
X-Gm-Message-State: AC+VfDxzLkBd/WYh6kF5G3FTn2Qvnpry+BFZObrQljhLHGEWaT3TmPvm
        7TfBUOfpkotaYUN4e2/GMFw9t076oPOUGtka7+E=
X-Google-Smtp-Source: ACHHUZ5spGHEVKzzlbthoUbcLHutZ9tVihG1g4dphMFvVuSJ9avqCo2YQe0Ca++3W/gC2FqQ4m5PSA==
X-Received: by 2002:adf:f790:0:b0:2f2:7a0e:5cc9 with SMTP id q16-20020adff790000000b002f27a0e5cc9mr12838024wrp.19.1683802853948;
        Thu, 11 May 2023 04:00:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d6308000000b003079ed1f0a0sm9138430wru.44.2023.05.11.04.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:00:52 -0700 (PDT)
Date:   Thu, 11 May 2023 14:00:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: drivers/power/supply/rt9467-charger.c:1026
 rt9467_request_interrupt() warn: passing zero to 'dev_err_probe'
Message-ID: <36fa5481-36f8-415a-b4dc-8831878cab2d@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d295b66a7b66ed504a827b58876ad9ea48c0f4a8
commit: 6f7f70e3a8dd1fbce95eaea2a8eff70f01363c00 power: supply: rt9467: Add Richtek RT9467 charger driver
config: m68k-randconfig-m031-20230511 (https://download.01.org/0day-ci/archive/20230511/202305111228.bHLWU6bq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305111228.bHLWU6bq-lkp@intel.com/

smatch warnings:
drivers/power/supply/rt9467-charger.c:1026 rt9467_request_interrupt() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +1026 drivers/power/supply/rt9467-charger.c

6f7f70e3a8dd1f ChiaEn Wu 2023-01-03   995  static int rt9467_request_interrupt(struct rt9467_chg_data *data)
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03   996  {
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03   997  	struct device *dev = data->dev;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03   998  	static const struct {
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03   999  		const char *name;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1000  		int hwirq;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1001  		irq_handler_t handler;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1002  	} rt9467_exclusive_irqs[] = {
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1003  		RT9467_IRQ_DESC(statc, statc, RT9467_IRQ_TS_STATC),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1004  		RT9467_IRQ_DESC(wdt, wdt, RT9467_IRQ_WDTMR),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1005  		RT9467_IRQ_DESC(attach, usb_state, RT9467_IRQ_ATTACH),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1006  		RT9467_IRQ_DESC(detach,	usb_state, RT9467_IRQ_DETACH),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1007  		RT9467_IRQ_DESC(aiclmeas, aiclmeas, RT9467_IRQ_CHG_AICLM),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1008  	}, rt9466_exclusive_irqs[] = {
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1009  		RT9467_IRQ_DESC(statc, statc, RT9467_IRQ_TS_STATC),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1010  		RT9467_IRQ_DESC(wdt, wdt, RT9467_IRQ_WDTMR),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1011  		RT9467_IRQ_DESC(aiclmeas, aiclmeas, RT9467_IRQ_CHG_AICLM),
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1012  	}, *chg_irqs;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1013  	int num_chg_irqs, i, virq, ret;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1014  
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1015  	if (data->vid == RT9466_VID) {
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1016  		chg_irqs = rt9466_exclusive_irqs;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1017  		num_chg_irqs = ARRAY_SIZE(rt9466_exclusive_irqs);
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1018  	} else {
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1019  		chg_irqs = rt9467_exclusive_irqs;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1020  		num_chg_irqs = ARRAY_SIZE(rt9467_exclusive_irqs);
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1021  	}
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1022  
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1023  	for (i = 0; i < num_chg_irqs; i++) {
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1024  		virq = regmap_irq_get_virq(data->irq_chip_data, chg_irqs[i].hwirq);
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1025  		if (virq <= 0)
                                                            ^^^^^^^^^
It's unfortunate that regmap_irq_get_virq() returns zero on failure...
*sad face*.  Someone should fix that.  The IRQ functions are that way
for ancient historical reasons and it leads to a lot of mess.

6f7f70e3a8dd1f ChiaEn Wu 2023-01-03 @1026  			return dev_err_probe(dev, virq, "Failed to get (%s) irq\n",
                                                                                          ^^^^
This will return success and lead to a crash.

6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1027  					     chg_irqs[i].name);
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1028  
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1029  		ret = devm_request_threaded_irq(dev, virq, NULL, chg_irqs[i].handler,
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1030  						IRQF_ONESHOT, chg_irqs[i].name, data);
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1031  		if (ret)
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1032  			return dev_err_probe(dev, ret, "Failed to request (%s) irq\n",
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1033  					     chg_irqs[i].name);
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1034  	}
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1035  
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1036  	return 0;
6f7f70e3a8dd1f ChiaEn Wu 2023-01-03  1037  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

