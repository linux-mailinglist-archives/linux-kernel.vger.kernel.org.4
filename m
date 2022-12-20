Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B10651A78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiLTGAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLTGA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:00:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B011474
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:00:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 7so2628905pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlt5L7PlVbNdJJaExwquyrI4ZxAOGOeQ6ynKwqgYwpA=;
        b=U4aWNeCxYSUN5ig1wQqKMbkaUkYM7c0YFJoV+eHi0OiAN/CzAW3LpMzr6H1o5c/aCU
         hAfqE/riijqebe1EKvmAr2wE70NX87sEQIgpMCGsMfHPZy82EX8541fD1iBLnLH8jldg
         X7yCrXbv9icl7HW072RwN5TSqB/LxwTagF5edyStp+OszCGE/A/0dECGM06Lf2s/WHkL
         Ohk2ukrdn2BsUFWbqmPgiJEjvofz4vARX9vtA3FbEkNfoe6sA8yFSMNCPtN4VyPJXOLi
         YsTtVEfW9qTQA7yVdc3nHPaNOrodY4yhdS1RZCaHKQSIt7/VzLibS2teawEx9rSqkOma
         ol1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlt5L7PlVbNdJJaExwquyrI4ZxAOGOeQ6ynKwqgYwpA=;
        b=DBrvNtdwwIn8ZzErxleuKJhCkbWEuKga/8cdbg55oX4ovZJuzCvn996WP2Bb1DZvdo
         3p6b7vR0ot9LP8G41YppxDpq+elVJ30UsZZS/Ueid8Yt/+8VxX3tMLaUZP9PFsGV0g2c
         aCb5bxGwEjJ+/gcX5DEGNuzOQPS8Uul+RHO2ogf2YYP9O6w3PDP3mlwU1m/TixoH/8eS
         OsS0fyOLAVFBS3/ry68kMKA0BGS1GXdsCjgGFFIM2EDqhMAIgc9QoHovrlWm/fr8bwQ5
         9aBkXFvnhcS+YPILRfH/TtqR7q0IgGj20Mm5MBQ1JXZn6e2Giqk00nD1Bvva8KL50tOt
         izrw==
X-Gm-Message-State: AFqh2kobcUH8KN1/zLw7eacTicj3N9CJxdJmajOW93OfEHLJgJPlK8/3
        ctvEbA6/WAPYn42PfptqNxeEoQ==
X-Google-Smtp-Source: AMrXdXsihtHIsVRfcKkT0WgAyl4LWKBQjahqEdXysshmOPl7jp1UPWw1Jij+kWJt93rhBxkxdY4qog==
X-Received: by 2002:a05:6a00:f0f:b0:578:4efa:e3ae with SMTP id cr15-20020a056a000f0f00b005784efae3aemr15144736pfb.33.1671516025983;
        Mon, 19 Dec 2022 22:00:25 -0800 (PST)
Received: from ruihai-HP.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id 12-20020a62150c000000b00574f83c5d51sm7637913pfv.198.2022.12.19.22.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 22:00:25 -0800 (PST)
From:   Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        knoxchiou@chromium.org, weishunc@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Subject: [PATCH] platform/chrome: cros_ec_typec: deferred probe when typec count mismatch
Date:   Tue, 20 Dec 2022 13:59:54 +0800
Message-Id: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel bootup is much faster with normal mode. In this case,
there is a chance that the cros-ec-typec module get the actual typec
port counts but not accurate from ec before ec is able to setup it.
It will block the HDMI mux function.
Hence, return -EPROBE_DEFER to put the device onto the deferred probe
list when the typec count mismatch between ec and node.

Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 59de4ce01fab..d821501e875c 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -382,7 +382,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 	if (nports > typec->num_ports) {
 		dev_err(dev, "More ports listed than can be supported.\n");
-		return -EINVAL;
+		return -EPROBE_DEFER;
 	}
 
 	/* DT uses "reg" to specify port number. */
-- 
2.17.1

