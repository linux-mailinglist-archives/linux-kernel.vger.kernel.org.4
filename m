Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F786036D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJRXyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:54:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541CCF868
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:54:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l6so14712484pgu.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d44HchEdwR7h9k5EzO4aimsT++0qdKmEQe35d8c3CvQ=;
        b=KpS1SdjaXEMwyhOhxcJssQBtfHQba78I6I7+bpn9LxAHFWocCtcy7YA273GmqOKN8z
         bmrxzDf9NRyWib2bvXF6Iguk0RcCcNjYBXvyRffIG+yuq/20uJzXxq7U5k33u5smqIan
         2CsZutEf+00brb01b15SAJv/SX7CH0lGUsAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d44HchEdwR7h9k5EzO4aimsT++0qdKmEQe35d8c3CvQ=;
        b=PfGeQb4vWualQ1TAWAD+e2QqqdkVpyqhNGvSRENRI5C+ctM7KEIpV30N1JG7Lx/AJu
         x6qTW+tfuljjVoze5ItSDQV3R4DmBUS0JPMtH+WuaZyxh5ctVSN00PtRqbisKzksZbSy
         7Cw9U2SkUboj6Sh4/HmX0PvqfXkoRCupB6866OUW1va3k9BqFCdQ/rH1u8TAM0MzYXml
         v/aVIqpKxdcamMQF/ArR7c6UAArNR7JKmJ9LuViRulm3g61D3GZ+6oiIXlLFEQoHWUKA
         lo9+nfBfVZnwrRhZGVN2AmPLKfUXSZDZcG5UseZ8GmKNRHuGUgx60ZpF54+LtfChSknb
         OL+A==
X-Gm-Message-State: ACrzQf0HyJ/Vf4iq9okw6zcsiMVYM0mk/HtkLXZANEk4e14QXRSz9q/u
        iBmRaC+UaNarrle9YGCGhTEDvQ==
X-Google-Smtp-Source: AMsMyM6XanfpWRavEw9YBgGcdQqTNtut+fHMVgxbS3ocGwJJXrNQYwGCK38MXZg/E0l1ijsvG2NJeA==
X-Received: by 2002:a63:8ac3:0:b0:461:ec25:8b89 with SMTP id y186-20020a638ac3000000b00461ec258b89mr4676929pgd.89.1666137250836;
        Tue, 18 Oct 2022 16:54:10 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:c37d:7907:a273:1c56])
        by smtp.gmail.com with UTF8SMTPSA id p65-20020a625b44000000b0053e4296e1d3sm9799231pfb.198.2022.10.18.16.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 16:54:10 -0700 (PDT)
From:   Dan Callaghan <dcallagh@chromium.org>
To:     chrome-platform@lists.linux.dev
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Dan Callaghan <dcallagh@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/chrome: cros_hps_i2c: make remove callback return void
Date:   Wed, 19 Oct 2022 10:52:37 +1100
Message-Id: <20221018235237.2274969-1-dcallagh@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed5c2f5fd10d ("i2c: Make remove callback return void") changed
the return type of the 'remove' callback to void, but this driver was
originally written before that change landed. Update the remove callback
to match.

Fixes: 5f9952548d91 ("platform/chrome: add a driver for HPS")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Callaghan <dcallagh@chromium.org>
---
 drivers/platform/chrome/cros_hps_i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chrome/cros_hps_i2c.c
index 92da59d94745..62ccb1acb5de 100644
--- a/drivers/platform/chrome/cros_hps_i2c.c
+++ b/drivers/platform/chrome/cros_hps_i2c.c
@@ -95,7 +95,7 @@ static int hps_i2c_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int hps_i2c_remove(struct i2c_client *client)
+static void hps_i2c_remove(struct i2c_client *client)
 {
 	struct hps_drvdata *hps = i2c_get_clientdata(client);
 
@@ -107,8 +107,6 @@ static int hps_i2c_remove(struct i2c_client *client)
 	 * (i.e. powered on).
 	 */
 	hps_set_power(hps, true);
-
-	return 0;
 }
 
 static int hps_suspend(struct device *dev)

base-commit: c7e2618e12562ba6f9d230d8ed4257dfa94d2d9d
-- 
2.38.0.413.g74048e4d9e-goog

