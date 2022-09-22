Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFB5E5CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIVIFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIVIEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:04:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE1C29;
        Thu, 22 Sep 2022 01:04:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x18so8161962wrm.7;
        Thu, 22 Sep 2022 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zi7UhzBBoawVZbsqCfFPCg7VnpB6tq6adFaLB65QOv8=;
        b=BGHilbCbUvVM/l1cum80tSQfW2USk/eDCElhmvok5aZedIcyUE+jYwkXQK6LqDQAB1
         zXz19u+p6p7jz4wKrFXj/vSLkXJNGvcTgXQ2hmJcdevj9SvmgknFUg67anFdjl1wiW3l
         XR7+1R3Aw0lcAzdHg5S433i4btiQOGRczkBvaq+vws8l+un+hIcqIYSu+2wY6lSaEt2q
         sxhf/x+OqTIR+jH/tpaP2LQgykB7hbvOnuMpMl65ArmegLp6uGOrGEyKpjOdjsqlm2kZ
         RrdA5cWN4zjupAU/127shLVMbBMkAPhBb82CURSH8EhUsd3+GJzS7nHv7OodizEOYViV
         Ebtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zi7UhzBBoawVZbsqCfFPCg7VnpB6tq6adFaLB65QOv8=;
        b=vjoSQFDP7An33x3RK0MHp2x6JHPFknhJ2Z+Ra5gZ/WpmpP9ARdQ4K+cYkQ8v8cx2So
         9htzf13GH4t5ubSOM4uQjwcdMN7t7Tu3QHyk5zdcrEYoDy4chDq0bZc82Ao5wpMBFPYm
         epTy5o6FXO3jrg1UMJsr/TzNRaLHjB4GYjCzacQqJE0lON3WXso2jULssDQ99/hIMkrQ
         m2OldHGeSTxgfnS+lhLvqU8NMaupJC8K3ZX3wlYfJ6K01DXaCXqkAi/MUaCOlCR2VRhm
         HFbwcvEpC/4nus+rPfphi9P66aitg157qnCwu7kYYsv0Hx69+WGfgVsH8rbsefQaxfw/
         S4Yg==
X-Gm-Message-State: ACrzQf3S93oS9Axgqcs8/jlYiwZUF6HYVK2CkyMfsRO3JaWxSmKFxhmI
        glGEH98wSjKXkLg/QplVxD4=
X-Google-Smtp-Source: AMsMyM66eNPo8hZsj24TA8ZIwyuPGzmdbhZrqAPWvNczWEqkWcgpbYYj0T9ssKm0bunZQ3QP9G+SNQ==
X-Received: by 2002:adf:fa83:0:b0:205:c0cb:33c6 with SMTP id h3-20020adffa83000000b00205c0cb33c6mr1182135wrr.39.1663833887336;
        Thu, 22 Sep 2022 01:04:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v125-20020a1cac83000000b003a845621c5bsm5102518wme.34.2022.09.22.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:04:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: mmio: replace return 0 with break in switch statement
Date:   Thu, 22 Sep 2022 09:04:45 +0100
Message-Id: <20220922080445.818020-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable min_stride is assigned a value that is never read, fix this by
replacing the return 0 with a break statement. This also makes the case
statement consistent with the other cases in the switch statement.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/base/regmap/regmap-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 8bd8d42de3fe..3ccdd86a97e7 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -48,7 +48,7 @@ static int regmap_mmio_get_min_stride(size_t val_bits)
 	case 8:
 		/* The core treats 0 as 1 */
 		min_stride = 0;
-		return 0;
+		break;
 	case 16:
 		min_stride = 2;
 		break;
-- 
2.37.1

