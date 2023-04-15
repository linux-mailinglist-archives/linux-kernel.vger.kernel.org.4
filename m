Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4566E30CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDOKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDOKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD993D1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so2810144a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555410; x=1684147410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JY3jsR/xgkB17cBH5xBif+/bYELKytDPMGjtCShK30=;
        b=rrCnD2MJDWFKfYhL7x6nQnOh+YMKDuJI9rtquhzI+vLy8lcLiIW6BnVDdMIgT9ZGdS
         4br3TNxPAMwdnqae60DiBJkB/ehAtzVa/IsiKJFRzupmu6LA+mApQJg7YnfZCLzmECiL
         dyRl0mQXmPat6dmp2WMr5QIkCWnH7SrLfvBiKn/bknOM/O8OazYf3stnK5C/gx71gkx2
         YcWAf75XPGDbC5b0WI1ZVfypjCzs1ZgAI1eJgTYXzZduZYaS8QuZQv5Zj46D1VawW4fr
         UeqjJDXn6AUzXXnXZ3U+2c6biextlhNru2xr2kTrDmwPXEer8lYNF/Br7j7Y2l0IiSu4
         +2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555410; x=1684147410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JY3jsR/xgkB17cBH5xBif+/bYELKytDPMGjtCShK30=;
        b=IhDA7lyKDMiyUmuFlx6v2IIC4XyVDQJgcG1lO2eJ/y4URZg+RgrBb6Pjx01JwXKkgy
         4/Y2aRrHsTqWQHqElBsoJW8MvnMi5vyTyu6GttG7JzZJ6qqyn1Ri5Sn4+aNnFAiJARCJ
         TloSVzv77hfVB0qo/GXZSsKoCshmzSZD1JA7+Hw5GvCPqCN/3SMT1XsCKfPLQC9D1xl/
         ng6htjH/C8eBjezMNsJGMskbyabKbKkWg0KQe64aXWMbwRFC0gEvNWOkPPCv58CwvoC+
         tXMj6572fpVfUpAs6J3O4b0dOL+N61zezVV1rfwZ/rKY+und6wJfsSjt4bVxafFxMA2Q
         KPWw==
X-Gm-Message-State: AAQBX9dOmKrNNTMTznayTZiePNym+qY8NVd/nlB4YzUV5KSBUNsYlFBC
        kdmbZfAD1Y+dVDFDxSZ7WJb7+Q==
X-Google-Smtp-Source: AKy350ZATVXui9h9cXaUtzFUPITgQBvaiO//1uAf1DShc4vcU9QHEaLogN577tZwy6t7lyOCjeea1Q==
X-Received: by 2002:a05:6402:1486:b0:4fd:29a1:6a58 with SMTP id e6-20020a056402148600b004fd29a16a58mr9791328edv.19.1681555410463;
        Sat, 15 Apr 2023 03:43:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/15] w1: omap-hdq: add SPDX tag
Date:   Sat, 15 Apr 2023 12:43:02 +0200
Message-Id: <20230415104304.104134-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPLv2 license text with SPDX and drop unnecessary file name in
comment to fix checkpatch warnings:

  WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
  WARNING: It's generally not useful to have the filename in the file

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/omap_hdq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index ae3e504cd543..826207c24bd0 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -1,12 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- * drivers/w1/masters/omap_hdq.c
- *
  * Copyright (C) 2007,2012 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.34.1

