Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239FF70A6F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjETJzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjETJzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:55:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85632E5D;
        Sat, 20 May 2023 02:55:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-966400ee79aso785080966b.0;
        Sat, 20 May 2023 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684576514; x=1687168514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XA+rGR/5RZlOrKnSN2M7bLdRSVOCHkd7kIdBn+h4Kwg=;
        b=o34NDl/wkAzpmfsZvTL5p/J/yXeEDNTfzUlTQdeBULHCNGVnvAkCBoHbAAr7QaRT1S
         yrGobt0GaXBG1DEwchMWFG7oHEqZi/fglhoy2K+cGKbhtoXwuUZrlq7bxq966+JzTqgg
         DUjcExwylxhNvflTVhfxLhKQ5bsgk8e4y2xEqnCa8SECB6kGFUdvU17naUgLLEHIYxP3
         sFp24xxwV6YWOBT4Wd3tPzpJTwcBL6bETYP6IavEEzSd5xEvfNvc6Fr/z8YPImS7lnz/
         N45WnI4RWZaPlMYkH9QaaatASAQqKx2B+ZwwaxsWyW2vIMUpge1vGfKlJLRbrF7GrAc4
         r+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684576514; x=1687168514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XA+rGR/5RZlOrKnSN2M7bLdRSVOCHkd7kIdBn+h4Kwg=;
        b=X2Ee4cfJYjAjOcJ+0xT+pSqh1Ol/VqcLkdgY8rCf/9t34nYsUszPBO17WH9I8MnrHF
         2q0uc6QB4U7WhJ/P5N8uN4+hMSbYbqtP9C6BFn32xlZ5/3/HVpmwINjwDwXQROnHap/E
         ggMxfDSJcF2JdonAApgx5NZFXDposknGi9mWxiv68KPLu8qSOdeFK16wd6kGkuWePW3k
         /FAlYBGldrISh2kDsWDrCk32cJRCLrYRWvc3WDWJquUVJLSGgV1AU2i+/7ncvmTmc/Mk
         ml/Ieq8NRR5tGFQ8P2gEZzqU9UyLEk9B+zXVMKqAknWIUJznj2jJWHjKHnXqx+7jnXdX
         6s9A==
X-Gm-Message-State: AC+VfDyDiWE7DCao2T4Pvhaw8mBRsME7J3myOZDec65UFoGMHH7JygHv
        ZVfqXrLQtSwprgJN9XJT/V3VWIx3shR/9g==
X-Google-Smtp-Source: ACHHUZ5c1o4KIgwTYJtHveyqJAN0vCR8OjfKmltyw33QfRpyt05+kwFr6itV24zW0GqagnHxL4diJw==
X-Received: by 2002:a17:906:eec8:b0:932:7f5c:4bb2 with SMTP id wu8-20020a170906eec800b009327f5c4bb2mr4203606ejb.75.1684576513603;
        Sat, 20 May 2023 02:55:13 -0700 (PDT)
Received: from fedora.. ([87.116.164.240])
        by smtp.gmail.com with ESMTPSA id jy18-20020a170907763200b0094e1344ddfdsm628335ejc.34.2023.05.20.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 02:55:13 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     main@ehvag.de, Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (aquacomputer_d5next) Support for Aquacomputer Leakshield
Date:   Sat, 20 May 2023 11:54:45 +0200
Message-Id: <20230520095447.509287-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for reading sensors of the Aquacomputer
Leakshield leak prevention system. First patch renames a macro
that is now used for determining a missing reading for multiple
types of sensors. The second patch adds support for the device.

Changes in v2:
- Moved the macro renaming into a separate patch

Aleksa Savic (2):
  hwmon: (aquacomputer_d5next) Rename AQC_TEMP_SENSOR_DISCONNECTED
  hwmon: (aquacomputer_d5next) Add support for Aquacomputer Leakshield

 Documentation/hwmon/aquacomputer_d5next.rst |   9 ++
 drivers/hwmon/aquacomputer_d5next.c         | 117 ++++++++++++++++++--
 2 files changed, 118 insertions(+), 8 deletions(-)

-- 
2.40.1

