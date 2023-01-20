Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17C67614E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjATXPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjATXPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:15:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A73B0E7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:15:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h12so2100079wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcdsDDfSv/wOa26KZForZ8gEXRm+p3O2oR+ZEYCfkv4=;
        b=TMyYtdLS+kw/Y7uOKSZDlvFr4P5eCu4SU6aqXmXP5IhaJx/7BOZpvvn9IQ1Y2gmX2Y
         0HTPw2tiIat4yLQmAPd5zBqbGRCWHkdnHe+ynj9z7oXVvilNcnk8Wt1dnFB0bc95MMyz
         VzEdMjlN7BF5n0zW5MqttwEvZdP0gpy09qLK/XdrD2pGNqdOKlwIHTH5jtYXhDqe11AX
         jmKoEWhoQYKPIAVckHP9BFHmR80Run9MlE1TWsgHpcBO5q1CbpjpqcXs53voEcUiaqBm
         5Wj/MS+2Ej1I0mt8ydXvrxeqkgmkYuKgyVobfadhI4sSjW96Pf3PmUychMxqT7otDILe
         vMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcdsDDfSv/wOa26KZForZ8gEXRm+p3O2oR+ZEYCfkv4=;
        b=2CPISDY8Ru2So0yw8J4py3o3EfHA+ozOvWTQYib9MRqz/MApD/EHEfID4R8G0Tmncs
         hUDyVPawAx+BdOyhLVo83fjTpU0P96jTyrqw1XgDeYIF+8ME4jVvIHp07oGvhygpa0DU
         xqslDg1UKQGeiciaRO6ky3P2df9yFph5Wvk9DrYmaoMA4DEvMGLrZh7YVUxynyzJa3MI
         Ua9D9s4cjy1bLV33SN3b7dmpqjDtGURJ1zxV7sysSzfWTymeLBSDdXef/JOu/1bUPIi3
         AqcPFG+gduCderbja9Y3K6Qda3Tx8B2Rf/YRWeDaRcMVo9NE3BKlE5PCnwsyVC/0t5Sw
         TQsw==
X-Gm-Message-State: AFqh2krigWFd9JkWTXYm0Be8/AUej+AX3cfCyiAx3m8ZLTf1q4ZjpZIf
        w6u4Q0Wu2ikdQo5xYFsMMduvOA==
X-Google-Smtp-Source: AMrXdXu5uRtEXEjUmBxsqEg9GL5wXWVse6JOwIon7LMB1tEA+GaItIVqoZboTQ60rlO/FQLPmy2ChA==
X-Received: by 2002:a5d:6102:0:b0:2bd:beac:ef7b with SMTP id v2-20020a5d6102000000b002bdbeacef7bmr14686709wrt.52.1674256543948;
        Fri, 20 Jan 2023 15:15:43 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm36436828wrx.21.2023.01.20.15.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 15:15:43 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
Subject: [PATCH v6 0/3] Thermal ACPI APIs for generic trip points
Date:   Sat, 21 Jan 2023 00:15:27 +0100
Message-Id: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Recently sent as a RFC, the thermal ACPI for generic trip points is a set of
functions to fill the generic trip points structure which will become the
standard structure for the thermal framework and its users.

Different Intel drivers and the ACPI thermal driver are using the ACPI tables to
get the thermal zone information. As those are getting the same information,
providing this set of ACPI function with the generic trip points will
consolidate the code.

Also, the Intel PCH and the Intel 34xx drivers are converted to use the generic
trip points relying on the ACPI generic trip point parsing functions.

These changes have been tested on a Thinkpad Lenovo x280 with the PCH and
INT34xx drivers. No regression have been observed, the trip points remain the
same for what is described on this system.

Changelog:
 - V6:
   - Changed thermal ACPI function names according the changes done in the first patch
   - Put back the GTSH function here as it is specific to int340x
   - Propagate the function name change from thermal ACPI
   - Changed the functions name and prototype to return the temperature
     instead of passing a pointer
   - Removed the GTSH function as it does not belong to the ACPI standard
   - Changed hysteresis -> hyst, temperature -> temp
   - Changed message level info -> debug
   - Changed error messages
   - Return -ENODATA error only
   - Fixed description functions
 
 - V5:
   - Fixed GTSH unit conversion, deciK -> milli C

 - V4:
   - Fixed Kconfig option dependency, select THERMAL_ACPI if ACPI is set
     only for the PCH driver

 - V3:
   - Took into account Rafael's comments
   - Used a silence option THERMAL_ACPI in order to stay consistent
     with THERMAL_OF. It is up to the API user to select the option.

 - V2:
   - Fix the thermal ACPI patch where the thermal_acpi.c was not included in
     the series
   - Provide a couple of users of this API which could have been tested on a
     real system

Daniel Lezcano (3):
  thermal/acpi: Add ACPI trip point routines
  thermal/drivers/intel: Use generic trip points for intel_pch
  thermal/drivers/intel: Use generic trip points int340x

 drivers/thermal/Kconfig                       |   4 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/intel/Kconfig                 |   1 +
 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../int340x_thermal/int340x_thermal_zone.c    | 168 ++++------------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  88 ++-------
 drivers/thermal/thermal_acpi.c                | 185 ++++++++++++++++++
 include/linux/thermal.h                       |   7 +
 9 files changed, 263 insertions(+), 202 deletions(-)
 create mode 100644 drivers/thermal/thermal_acpi.c

-- 
2.34.1

