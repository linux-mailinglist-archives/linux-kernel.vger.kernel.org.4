Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC57333B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjFPOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:37:42 -0400
Received: from mail-ed1-x562.google.com (mail-ed1-x562.google.com [IPv6:2a00:1450:4864:20::562])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C394294C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:37:39 -0700 (PDT)
Received: by mail-ed1-x562.google.com with SMTP id 4fb4d7f45d1cf-51a324beca6so1037641a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google; t=1686926258; x=1689518258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WhJCmlXzPv7Xh5M050Emf6ghXi1y27NhVMoOZWW1E8=;
        b=ePh/qSRf2nz/yocVWK+VY/47GBD5KEr9ZNq5m0V7xpFkEvpNd0eWIMvRYEHHVuxIgG
         F+HuEzggllhZnkkB5mgGFo1npZYcmqImvULjlMOQFDFW0kOx7B6gmZB+9Jn7ppumlYiD
         HtQRPdjrl7nZpIkddhl7c1GbimsFNvLHo4qOYKm2L1i6t1LLO4TnyU5Xq5tcUiKCmbaj
         so0glNguxjnf8ZitR8ZmhErzqfA6p0NLExZsKdTs+1DGk3mXsq8heBUva2JJ42XOdGMH
         uWTgvtzj++xfl/yR4UVfc7rFqIEhHjUcHsjpAScnO5PZBwL8TzjnfpjhDMMV0pbZ7jOf
         YwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926258; x=1689518258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WhJCmlXzPv7Xh5M050Emf6ghXi1y27NhVMoOZWW1E8=;
        b=d0gYL5N8Y4BCsIADkq0dMRyMb3bZ+4UXfc7eyoSCxEWmX5OHIHSwlcZ1KL5YDKrplQ
         vRqopgfw4FL6cWcNrcg0U0yerQMRgmCFeJEpG4NUvrW91X06ry/iOn5J9BJxE3JiaQ1e
         18/JYuSQlvn6Td8ruGzfi775J2az/MlOVYgpqhD1fXDuLBeefrwwV6V2rBedUcay1JNn
         yaEYHJZU6EHfeuWlL1MG7LK+hbSKcc5RuTzl55ayy8xnCmPbbMqClJBW+Ibof2DnwhPI
         lUqldoR85/LSo+GHd7VkwPtRR2QJebgDuqlsra6C958QEMdrZb45P1mHZvgmk4yBr4SX
         vCDg==
X-Gm-Message-State: AC+VfDzqWvC8BuNHDcKVJF0JUhrMREgcMFrUW9Yb4Y55TwB8UqjYkM7F
        JIXnBsb3qYWwIPQeg06CZ4JFBoShkqeCIpU3YnPA2UFmZdAI
X-Google-Smtp-Source: ACHHUZ58QDW4e5hZy2czgbq8C6VA/xYUZ4CsYXRWcWr1leJ4B2jWId12rpB0L7uNRj3SI0vyvj9qzeMonD0M
X-Received: by 2002:a17:907:844:b0:982:9dc1:a434 with SMTP id ww4-20020a170907084400b009829dc1a434mr2003708ejb.19.1686926257835;
        Fri, 16 Jun 2023 07:37:37 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id gx12-20020a170906f1cc00b0097877ad6047sm10004812ejb.99.2023.06.16.07.37.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2023 07:37:37 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.142] (port=34864 helo=FR-BES-DKT15120.home)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1qAAcR-0005hl-MD; Fri, 16 Jun 2023 16:40:07 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da9063: fix null pointer deref with partial DT config
Date:   Fri, 16 Jun 2023 16:36:28 +0200
Message-Id: <20230616143736.2946173-1-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/regulator/da9063-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index c5dd77be558b..dfd5ec9f75c9 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -778,6 +778,9 @@ static int da9063_check_xvp_constraints(struct regulator_config *config)
 	const struct notification_limit *uv_l = &constr->under_voltage_limits;
 	const struct notification_limit *ov_l = &constr->over_voltage_limits;
 
+	if (!config->init_data) /* No config in DT, pointers will be invalid */
+		return 0;
+
 	/* make sure that only one severity is used to clarify if unchanged, enabled or disabled */
 	if ((!!uv_l->prot + !!uv_l->err + !!uv_l->warn) > 1) {
 		dev_err(config->dev, "%s: at most one voltage monitoring severity allowed!\n",
-- 
2.25.1

