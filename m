Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF79672A16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjARVMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjARVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:12:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B5613E7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:11:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so199584wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCSbK/tUS4YMZH0NcLQxGFkztwrDFcL8VnBPGZktFY8=;
        b=xPY9/cO5/EuIVs4Cgywdqilx19aJ2ZwAnPWfnirCJG4lFggV0Tb+b9mheTBTeC6huW
         uUahlnhzRxpClnTTBHinSMDk8vc1ykObxIGduJ4/Bi5J9Zt657ed7U0HW7Ln7DFnQ8TU
         v5UUYzT2+UZjx8Phie1RHQaUQdNvQGfvHwklMMnhTgOKNPLBRcBtE3oGWHh5SovVdl43
         2a+ZAKuaCoS1UViHY+ljukwjO7xdJAJ2Eiy3xf/Fnh7/F8pLfJTEJUFtcD58xXujdbFj
         SNAX3QrB8xX2svHYV/FINCWrt02JyzknaHIVgJMVFRTXA8HWKugswWxff4psoameKk93
         zbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCSbK/tUS4YMZH0NcLQxGFkztwrDFcL8VnBPGZktFY8=;
        b=GzPyZqtmZj2eczsLqy0iFALV/2UhhONrIfakNyBtJnkzuKGWW4ziaJ5q1duPKvjZcr
         YqW3VeoEJ2D530LQEO736RGIZmL3tB1lh8QPyPOfMpKiB0KUPi9Uca8DpN0PxLwNEKSI
         IPGJrUD8v934O1ZrY0IjY96Mij+kqU+7cUjWH7sl4NPk7cEkGfssxEWpyplFpBtjFkks
         f6hSlRxBaCW+tw3FzOsfG8L1TZKkjC3i3K59/4kmufvVmCmsqVgZ43I8KDCKAnexJ9kD
         QxlmF6JhfLpA1OLAFB+xZUNLGZrbQppUF2XroB1z8H15EOqhFKlP667qYVw3qLkMypTO
         Auxg==
X-Gm-Message-State: AFqh2krrDVO1DH3DqHLbOytcI/IBLsjde2qPqrEhfs5Vm/O8YikNuncW
        Pq5GW781/7z3zY8vlayYoEvEsg==
X-Google-Smtp-Source: AMrXdXsQlKfp9joAHrVTBIXGNJsySK0e6291IUNQXhbBxKS20zOHcKxK7DQbr9aI9LFWHEZSbP2Nyw==
X-Received: by 2002:a05:600c:3ba9:b0:3da:b40f:7a55 with SMTP id n41-20020a05600c3ba900b003dab40f7a55mr14931741wms.6.1674076292174;
        Wed, 18 Jan 2023 13:11:32 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003d99da8d30asm3198835wmc.46.2023.01.18.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:11:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] thermal/core: Remove unneeded ida_destroy()
Date:   Wed, 18 Jan 2023 22:11:20 +0100
Message-Id: <20230118211123.111493-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118211123.111493-1-daniel.lezcano@linaro.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per documentation for the ida_destroy() function: "If the IDA is
already empty, there is no need to call this function."

The thermal framework is in the init sequence, so the ida was not yet
used and consequently it is empty in case of error.

There is no need to call ida_destroy(), let's remove the calls.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fddafcee5e6f..fad0c4a07d16 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1624,8 +1624,6 @@ static int __init thermal_init(void)
 unregister_netlink:
 	thermal_netlink_exit();
 error:
-	ida_destroy(&thermal_tz_ida);
-	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
 	return result;
-- 
2.34.1

