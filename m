Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D416931DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBKPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBKPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:00:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F92597C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:00:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o13so8176561pjg.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzrp2VEngTn0KdxtJ4lCs916qknhy6yObiJsqzoB7iM=;
        b=Pzag8d1RYEpSqrNLAYo5LtD9pHXkno8kywYVMUkyLqDWD+QWVkUwC1+fHaGwwhKHwP
         FGDNAdb2SLmTVHc+EfGQbAHj2cXX9xXPv+stsD31K4D3pv0SLd3Mt+HC6pKwLIrHL3MR
         lEgfSqeo40zr2HgO308dCnAODvt3j4KqlsJTOryg1sIAWhU1RzokhhL7iUsjBLDVw+CP
         DJILnPN9gwsEtk7z5zgg8+hG6Dg00dehSb+4tpnmkWmkf9Py/wyAJOuGdsuVkou+U4z8
         PgLNIo0/XMeQ7SAjmCM6WRV55tWSyeUdFEj0x6vc1cnLvtPmrjeGFYFRy4YJZTqKqSRH
         Io4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzrp2VEngTn0KdxtJ4lCs916qknhy6yObiJsqzoB7iM=;
        b=71/EkiNmvooBuRRd/ZlJ5unopX2YfxqOF4TzOwCvJ0AiiOvGp52Uh3uXHt8jAH8/bi
         7Otptc5ybBDJ4dfYeCyCgCCoFqrFWUtBpt6kjdZa4R3zXPvqY2g8bBSVrus4RgoOqQ46
         1TB/gQ+M+M4e/MWKYdYAOJjjYQAP8gRSP5+H7iikgDWbP6ruKfApQszFc+WoDDHgxDOv
         Bc/JrUZykUYK8C4LUUHbc6EHbnOZ/syzwG12rT76UYR4Jbh01qcceYnlfpaXw+IE0Krj
         eLcvGvkeUjB7jONhwZfO1Oe+VE8cYAfdhsj7s+tdb97ZE1RTHVl5HLPwKZmdjQYHVZ3Y
         x+WQ==
X-Gm-Message-State: AO0yUKVGjqyGCEDJWuXto/QR2lvh8y7O5mB1d0NcTXB1m5GMnWKvxiUK
        PsQyJiP7qbqJm9pXSmlBXHxwmoIyNHCVIqdw
X-Google-Smtp-Source: AK7set+Oo8DwOc1Zehma9wnuhpdIbCV8JqnwsJH/ITkL7gXGSfpTq9/8bGdXYF/0+0lgmqESG3VSkA==
X-Received: by 2002:a17:90b:33c6:b0:231:ffc:7593 with SMTP id lk6-20020a17090b33c600b002310ffc7593mr14942248pjb.20.1676127634546;
        Sat, 11 Feb 2023 07:00:34 -0800 (PST)
Received: from alpha.. (122-117-179-2.hinet-ip.hinet.net. [122.117.179.2])
        by smtp.googlemail.com with ESMTPSA id jw14-20020a17090b464e00b002338ff973d4sm3247360pjb.11.2023.02.11.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:00:33 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max20411: Fix off-by-one for n_voltages setting
Date:   Sat, 11 Feb 2023 23:00:19 +0800
Message-Id: <20230211150019.1545542-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise regulator_list_voltage returns -EINVAL for MAX20411_MAX_SEL.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max20411-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
index e75d16048e2f..83dacb4ff173 100644
--- a/drivers/regulator/max20411-regulator.c
+++ b/drivers/regulator/max20411-regulator.c
@@ -85,7 +85,7 @@ static const struct regulator_desc max20411_desc = {
 	.min_uV = MAX20411_BASE_UV,
 	.uV_step = MAX20411_UV_STEP,
 	.linear_min_sel = MAX20411_MIN_SEL,
-	.n_voltages = MAX20411_MAX_SEL,
+	.n_voltages = MAX20411_MAX_SEL + 1,
 
 	.vsel_reg = MAX20411_VID_OFFSET,
 	.vsel_mask = MAX20411_VID_MASK,
-- 
2.34.1

