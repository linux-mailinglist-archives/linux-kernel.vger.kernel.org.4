Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9A6A35F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 01:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjB0Al1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 19:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjB0Al0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:41:26 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74D14993;
        Sun, 26 Feb 2023 16:41:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q189so2584254pga.9;
        Sun, 26 Feb 2023 16:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbCPVQtiESRrldU5N97vl2jVTNR3CI+lTkLJPv/JlxY=;
        b=FIhL7WvMTJJI0MvKC8BuE83lhEBcgqpFgltetQFkUhlFharmOUhsjX1gsyTSdrgqvf
         gnb4RP6bIYIRXKe0E+ZVZ5IOVqkA2LE1FSRRm02NN3rVGpgjjKnLEjjOTUIEwBoy5JF8
         +67Nap3EZcr6sqPx4V5JPbV2LjFrwBbOXG0vCbKIzStdQT5uh8ZWYzlrtW3rB15B5r9G
         ytNrKbDYwLHLv8GcKsdfIaha3HJlcQ6m4BL/ndv5tFi1+u3YNOc/+163gnbgr0LjpFJy
         KdecQpTvJ6H2r0ZlDGfibheaxRX2wRtYdiEH9FT8nOjqez4P8d0QJHCEaOQgb81s6BaK
         jw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbCPVQtiESRrldU5N97vl2jVTNR3CI+lTkLJPv/JlxY=;
        b=5avMCkBVG7tqCnbpZItUQC6IZhsEOK2HxIFEfsTiRanOPJNRgt8FNuGZMzoc2LA6do
         JiF9tOWyQwF3ULQb/5bgvYsfcOG9F8qSjeb28YXi/gf42V6gQPzDzH2baqzUqQLkKxAs
         NysH6NGmjvqvbyP9XQtOms4i3rpEVJ41Iizy2k5GahqwWEHpV92F4lCDoC3N0xYifXKq
         iTVYuLpk3udNWI9g7qhack7zYpEDQ5VElAm4cMFee5lBIrv7DKMuxaUcm2IC6GVO21N8
         +QBSxKAbvCHuAXToEfXSN/BhafWQhDUOV7QatudI746IsGOeSfkrErcmA0Ci/iMq3pBF
         GHgQ==
X-Gm-Message-State: AO0yUKW3u/+DISvzE1RDqZdiL5ymQkS+h5Hl7NmT33DCJDzPYK/on29Q
        lgFkRy6jWgVpTjp/1bOMLoI=
X-Google-Smtp-Source: AK7set/9dfT1kX/+D9/ExaK6VxhqfV4WwZG/fOXQiLyvCUAHB5NX4ks34kXfo7q0J0zbGORvDjXr5g==
X-Received: by 2002:a62:1dd0:0:b0:5e0:316a:39ce with SMTP id d199-20020a621dd0000000b005e0316a39cemr9681985pfd.27.1677458483279;
        Sun, 26 Feb 2023 16:41:23 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id l12-20020a62be0c000000b005da23d8cbffsm2951023pff.158.2023.02.26.16.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 16:41:22 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     lkp@intel.com
Cc:     agross@kernel.org, andersson@kernel.org,
        baolin.wang@linux.alibaba.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, ohad@wizery.com, void0red@gmail.com
Subject: [PATCH v2] hwspinlock: add a check of devm_regmap_field_alloc in qcom_hwspinlock_probe
Date:   Mon, 27 Feb 2023 08:41:16 +0800
Message-Id: <20230227004116.1273988-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202302270034.DqtDwv49-lkp@intel.com>
References: <202302270034.DqtDwv49-lkp@intel.com>
MIME-Version: 1.0
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

devm_regmap_field_alloc may fails, priv field might be error pointer and
cause illegal address access later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
v2 -> v1: add missing parenthesis and switch to use PTR_ERR

 drivers/hwspinlock/qcom_hwspinlock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index 9cf186362..dee7bb5ea 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -197,6 +197,8 @@ static int qcom_hwspinlock_probe(struct platform_device *pdev)
 
 		bank->lock[i].priv = devm_regmap_field_alloc(&pdev->dev,
 							     regmap, field);
+		if (IS_ERR(bank->lock[i].priv))
+			return PTR_ERR(bank->lock[i].priv);
 	}
 
 	return devm_hwspin_lock_register(&pdev->dev, bank, &qcom_hwspinlock_ops,
-- 
2.34.1

