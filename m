Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670846DBE55
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 04:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDIC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 22:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDIC4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 22:56:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8605B95
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 19:56:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso1544437pjp.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112; t=1681008959; x=1683600959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/lyW7gzXy0Icxsyp+KO+Ap3XL0aoTY3L/d7kHXsuylQ=;
        b=UgewHHVTLWm/WgAAWdp3/h972nlPYrCJPSjGQ/6Hp0IOEkS7tdz6HwIPJmSOripS4W
         ntjIplt/5VY8r3V3Nw/2qH3fLCsaLtIJQ2x7pHWaMKYREjzJRlU9DmJdF03MUzIKKLv6
         +jX+REQrPdQA2Uc/JoLu/7eAnIQoh9BsNAm2mRlNaRA3AU/WwRHC4RdZ5uKMYhYB2bfJ
         IrED1bz1r6uGwvKyUFETjgcGCGXVRdP05v8GIL0m3EmuqBWj/R2kgSsvVLjDtPMA/ogy
         Gv+8ae3cep5FdDPlRvhbuXLctDW38A07p6f0hii3YNtt/FQgsluDYzeKnYvlhDLk4QYn
         kPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681008959; x=1683600959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lyW7gzXy0Icxsyp+KO+Ap3XL0aoTY3L/d7kHXsuylQ=;
        b=13MHJxzCBBtBW1sGXhzoz6Z3RxC6Ce2uAkYfaeEVff54X9bnyPK0lLUaMdMICScakd
         51MStOz8Nd1C+Zbk7kkTuiCHy25F7/MIMjo+A3LC4ykav5vV/eYgoCDgvYQmYw7iiN3b
         951rwscaiXzMTrItgbJa7/4V3ZZY8xpexVS37KTbtQXlOZUX9mkzUlgq6EE8KkZR0K+Y
         IgWXR+tOgelYqtNhy85Sa9Kh22A6vjkfb/o1lxmJ5Qu8NRoKVooKn6QQneW5w8TkudFt
         Vm4hk1gP6OrhJc9tzCU8NFBSqIhmFbWU5LDg3AVfHusry3qpvxILkLrczBiENLvsPEIk
         yxpA==
X-Gm-Message-State: AAQBX9c1Zc04UtPee17eG1Yf68yxyMyREsywKO4xkcYocfZyXuePQ1cj
        NHS1YRcohzML/o91+0duPyZLbW/NV3vBT/mhask=
X-Google-Smtp-Source: AKy350bf+YZUeIZ8g15FiT5Q5ilujlK9Il8+EBEQo5eYpWOXWiduUTlCEdKdtSaWZGrwLVGYTslxSQ==
X-Received: by 2002:a05:6a20:47dc:b0:d6:a0a1:6c6c with SMTP id ey28-20020a056a2047dc00b000d6a0a16c6cmr7397748pzb.8.1681008959445;
        Sat, 08 Apr 2023 19:55:59 -0700 (PDT)
Received: from alpha.. (125-228-203-199.hinet-ip.hinet.net. [125.228.203.199])
        by smtp.googlemail.com with ESMTPSA id x10-20020aa784ca000000b00627df889420sm5487923pfn.173.2023.04.08.19.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 19:55:58 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: sm5703: Fix missing n_voltages for fixed regulators
Date:   Sun,  9 Apr 2023 10:55:29 +0800
Message-Id: <20230409025529.241699-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set n_voltages = 1 for fixed regulators.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sm5703-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/sm5703-regulator.c b/drivers/regulator/sm5703-regulator.c
index 38e66df378a5..702461cf075e 100644
--- a/drivers/regulator/sm5703-regulator.c
+++ b/drivers/regulator/sm5703-regulator.c
@@ -42,6 +42,7 @@ static const int sm5703_buck_voltagemap[] = {
 		.type = REGULATOR_VOLTAGE,				\
 		.id = SM5703_USBLDO ## _id,				\
 		.ops = &sm5703_regulator_ops_fixed,			\
+		.n_voltages = 1,					\
 		.fixed_uV = SM5703_USBLDO_MICROVOLT,			\
 		.enable_reg = SM5703_REG_USBLDO12,			\
 		.enable_mask = SM5703_REG_EN_USBLDO ##_id,		\
@@ -56,6 +57,7 @@ static const int sm5703_buck_voltagemap[] = {
 		.type = REGULATOR_VOLTAGE,				\
 		.id = SM5703_VBUS,					\
 		.ops = &sm5703_regulator_ops_fixed,			\
+		.n_voltages = 1,					\
 		.fixed_uV = SM5703_VBUS_MICROVOLT,			\
 		.enable_reg = SM5703_REG_CNTL,				\
 		.enable_mask = SM5703_OPERATION_MODE_MASK,		\
-- 
2.34.1

