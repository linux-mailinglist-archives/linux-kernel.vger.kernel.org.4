Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69B69E70F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBUSJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjBUSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:08:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A82D15E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j2-20020a05600c1c0200b003e1e754657aso4337461wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=pW1yNT7Ypg9QAveNHmxbuLVe8plx5zHWNfuqnEbVNmVkjEZnMiTHM3RZrGV2APV+zt
         nIjNeiG8/jhE1NvBaSrrDa8LhWWqZp3/e+M6Ph11H4/o+aUinOTRyMm6ww44anM+S1Pi
         F/kmLz79x0lFOH137vS5Fi38ai+Fsb7Qj2Y+gvOfrW84VlYmrYRWjQsG4MEMy841oSOi
         wF+Rp5QnlOrvhQ0e0zz9VWps1u4SARLhAV7Nm97TefGQX/0vvrhsKstdA4IppyymyB6h
         mEuX4CmpML6PyqvFAO+iWmWOL3f9ttKSMXvZHGObdygGamdmasq3IGshOmIplO7go+z6
         hhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=SBXBFurkQyyaaUuhj4Gpf7wGzkgxNqjGuIMqlMM4bIjnA36Et5cY1LUdotgWL96/U6
         5aoj+hE2E6DyTO7S+f4Z2qmn5NEPyN/M9OWtTLKCLLGY8hRezh+wOv/PuPZk66cHM0NH
         F+3Psru73fEh16zgZIYggzM281asBFUMz6o8V+xQ+Sq8pWaO6FCF54ZIUqEkLDJWnoDX
         5YpSTP+6l9IlFOj/k+ZDcza+Ohidg0RKBQ2CAdHIXRxyENrSMhbrjH1LF7v8tgoeWppk
         KWcNnpkS7eakPjFqOvFFcNS/sMIq+BXKvgmdZdwL/kKjUbn1/e64ehmWhv+zxt/tASt7
         roRw==
X-Gm-Message-State: AO0yUKXYBdf+I580uzCb2U7JivIN5uZEaxMRrnGpckwM39OY7qpqif6d
        K4sn79JHz24a3+lvpoVFMasmZA==
X-Google-Smtp-Source: AK7set+9l12qHMXo5CMCIsJgjTPa/QxtFco0fmkL+uUNcV25BDUEEK4H9jR+vfidp7CoUY99d0jJQA==
X-Received: by 2002:a05:600c:4b2f:b0:3df:ee64:4814 with SMTP id i47-20020a05600c4b2f00b003dfee644814mr3493868wmp.20.1677002877095;
        Tue, 21 Feb 2023 10:07:57 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:07:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 07/16] thermal/drivers/spear: Don't use tz->device but pdev->dev
Date:   Tue, 21 Feb 2023 19:07:01 +0100
Message-Id: <20230221180710.2781027-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the spear associated device instead of the thermal zone device
which belongs to the thermal framework internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 653439b965c8..6e78616a576e 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -137,7 +137,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spear_thermal);
 
-	dev_info(&spear_thermal->device, "Thermal Sensor Loaded at: 0x%p.\n",
+	dev_info(&pdev->dev, "Thermal Sensor Loaded at: 0x%p.\n",
 			stdev->thermal_base);
 
 	return 0;
-- 
2.34.1

