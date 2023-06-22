Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8260073A463
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFVPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjFVPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:11:51 -0400
Received: from mail-lj1-x262.google.com (mail-lj1-x262.google.com [IPv6:2a00:1450:4864:20::262])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A4DC2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:11:49 -0700 (PDT)
Received: by mail-lj1-x262.google.com with SMTP id 38308e7fff4ca-2b46cad2fd9so81510231fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google; t=1687446707; x=1690038707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=olAp2+0MdstCG5gkpvORG59fsTEvqEnOht9BvAwOzw4=;
        b=m5cWgz4schnRjMOHJBuVxJ1ufPYhldgyOTJfJDBsH5jAXHiAF47rF3WDfkSh9Fl31K
         d40SeOzgRLZhDk57HQ79flB+uaB/sgcFSyXSVteRQKIK9pqX8wkN9XAJPuJc6LTGPcfk
         LEhhFuvhS3roaIAkxKEDYZYWkmejBFK5JUjOJcHuaegXPSCANL9nQIIY6IcStakjBygS
         qTitjJlDILliyFtmWN+nlTL4L2eoiV7CWQFkkTpdJRfue+y40ddOPR4vY6rGjAQEJfVn
         ak1Hh/29CdsmrxbtRkP2roOyjBtP8YkjOLp6PNATdG9IMBOfsIMFKd91rI+ux+RnFTse
         qJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446707; x=1690038707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olAp2+0MdstCG5gkpvORG59fsTEvqEnOht9BvAwOzw4=;
        b=Zqtd5DJgnvQ4W9YBFEnM/6YATwhEnppd+4Np3uiyTje3ishBbEdlgVFbXKzBEL0jCD
         RIoGtFIOsUgBOngmvzCC9tVDc4323zvCSAe4KHBrfZG6eSqaKmQ7u9EsdTPBHsQn918C
         SLvxc2WIypqXiCDlOJW7EaeRHw3DdXs/1LALIxOJvNfNfg/G1o9HSyQZBdoNEtxKAamX
         jS66CNu11qf0d5KxfLAnLKcUw2VyppXKSnoBxZJVZsv8UQJSbjI4+qx7lRHjHKcFgf7P
         z+4REOmhmKymANykcZjNNEwV9gAmwsJDlYm+N0qJGUQkCScqxotW3zRRfZQwsV/yvXpz
         5Kaw==
X-Gm-Message-State: AC+VfDybgVZ3f1XgylLKrjhS11nEpYuulhCfU/8yUY6X3Y0hlIkiByvX
        3ilZbCwrxaR+mAR2M7oa0Y8bo7RGzuLLjdSGqgALlMCAqPts
X-Google-Smtp-Source: ACHHUZ5s0j1DVx5LyOQyVX0uS+Hl9B/9ZEFpzx20VzY44n1UrM77g1v/zQpWkXCRZZHoMTlGWEYQN31r+Bmx
X-Received: by 2002:a2e:9c14:0:b0:2b5:800e:3f17 with SMTP id s20-20020a2e9c14000000b002b5800e3f17mr5077464lji.49.1687446707449;
        Thu, 22 Jun 2023 08:11:47 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id gv46-20020a1709072bee00b00987e74958desm2081333ejc.24.2023.06.22.08.11.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2023 08:11:47 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.78] (port=40646 helo=FR-BES-DKT15120.home)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1qCM0m-00013U-IJ; Thu, 22 Jun 2023 17:14:16 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulator: da9063: fix null pointer deref with partial DT config
Date:   Thu, 22 Jun 2023 17:11:02 +0200
Message-Id: <20230622151146.1459250-1-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When some of the da9063 regulators do not have corresponding DT nodes
a null pointer dereference occurs on boot:

[    1.559034] 8<--- cut here ---
[    1.564014] Unable to handle kernel NULL pointer dereference at virtual address 00000098 when read
[    1.578055] [00000098] *pgd=00000000
[    1.593575] Internal error: Oops: 5 [#1] SMP ARM
[    1.634870] PC is at da9063_regulator_probe+0x35c/0x788
[    1.647934] LR is at da9063_regulator_probe+0x2e8/0x788
[    2.073626]  da9063_regulator_probe from platform_probe+0x58/0xb8
[    2.079759]  platform_probe from really_probe+0xd8/0x3c0
[    2.085092]  really_probe from __driver_probe_device+0x94/0x1e8
[    2.091026]  __driver_probe_device from driver_probe_device+0x2c/0xd0
[    2.097479]  driver_probe_device from __device_attach_driver+0xa4/0x11c
[    2.104107]  __device_attach_driver from bus_for_each_drv+0x84/0xdc
[    2.110402]  bus_for_each_drv from __device_attach_async_helper+0xb0/0x110
[    2.117295]  __device_attach_async_helper from async_run_entry_fn+0x3c/0x158
[    2.124369]  async_run_entry_fn from process_one_work+0x1d4/0x3e4
[    2.130485]  process_one_work from worker_thread+0x30/0x520
[    2.136070]  worker_thread from kthread+0xdc/0xfc

This is because such regulators have no init_data causing the pointers
calculated in da9063_check_xvp_constraints() to be invalid.

Do not dereference them in this case.

Fixes: b8717a80e6ee ("regulator: da9063: implement setter for voltage monitoring")
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---

Changes since V1:
 -  Following review by Mark Brown avoid previous dereferences too.
    With the GCC versions I tried this didn't cause problems
    because it only takes the address ie
        &config->init_data->constraints
    doesn't fault if config->init_data is NULL (it would without the &)
    But this behaviour isn't guaranteed and other compilers or compiler
    versions could behave differently so completely avoid calling the
    function if config->init_data is NULL.

 drivers/regulator/da9063-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index c5dd77be558b..a0621665a6d2 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1028,9 +1028,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			config.of_node = da9063_reg_matches[id].of_node;
 		config.regmap = da9063->regmap;
 
-		ret = da9063_check_xvp_constraints(&config);
-		if (ret)
-			return ret;
+		/* Checking constraints requires init_data from DT. */
+		if (config.init_data) {
+			ret = da9063_check_xvp_constraints(&config);
+			if (ret)
+				return ret;
+		}
 
 		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
 						     &config);
-- 
2.25.1

