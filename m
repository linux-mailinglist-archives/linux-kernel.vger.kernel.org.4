Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5C6E0CED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDMLrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDMLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:46:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3AF2727
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:46:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3637436wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681386412; x=1683978412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iotwQsr/kOHjjpurHuJsSYaCEG7qITgV4cqr3+JO1jo=;
        b=g8o2vRz2kuCuOmX2UW05FQ2lDy/JVfB2q2eIKV5d6EaYtLMJvqTCoR51HDtHFnvTdG
         U4yxn+sf183bHPi2BMPCJ99zxaj3+4/+cZgGAfkzAFuVfgzi3r2e5SNjJJj8xxBGuCow
         /eQ8PUsoHsP+LtX5AgyuPqtAizZy3AiPU79w0qwv7V3QeKxJswMLmghsT8MzfWUxSKsW
         w80PVF9UMEKV/qMLP84+Cyk4uoHaNsefg/eT1ICO9aMVTdGEeVcTAZXVp1eYHzrMgCn0
         oEwMqLfTwCuEwWciKVwP62p72EnY5E2Ou9zhHFsPNZvccNmGoBtVDRQdKRKNR1fSnGY8
         oTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386412; x=1683978412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iotwQsr/kOHjjpurHuJsSYaCEG7qITgV4cqr3+JO1jo=;
        b=V9O3XJ9z48nGCqpW27WuWJ3soD/6GjHOe1Zqu7uEpuqfBRhcNkAYsflb7zPrZRb4Ry
         3AsAZhqbj7XrnpKiSj7puzsaYDv8FkGWEzbAzXnsUHeB97nKl1tMBtC2IO9NmH9RGL1O
         Goc+9CW0UrUvujdMVF9Fz63gc2Tywtzj7vgWTypPuwNsXB6BFSklBdNifkgZa/nv0Yf4
         OpJdhRB5PlTONpWFUqD+amPiXi4aMXUxZCVNtBmB4CPXmMS24zEhXdZ1x9nciClePSB5
         4kAucwHBNLdmm1mVdeJzuzpntCnG0ZoYMO37F9ZA7MrOQlb2ndPvgc9x+NCjlT+DQrYV
         v4cA==
X-Gm-Message-State: AAQBX9dBTDMF9cn/8EIOA1ijec1oT6UQwxFgLtO427EcegfNmY7UlK2O
        ZCqBYNdF8N6/KcLEFlSS4Nlvtg==
X-Google-Smtp-Source: AKy350Y16HxIytAoC3IafWBI2hPd/VqT9vZqlqLUIBAYq+LwkII++deS/3PP2ay887eFJdc1pDcmwQ==
X-Received: by 2002:a7b:c40a:0:b0:3dc:4b87:a570 with SMTP id k10-20020a7bc40a000000b003dc4b87a570mr1332193wmi.35.1681386412414;
        Thu, 13 Apr 2023 04:46:52 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm6730590wmb.1.2023.04.13.04.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:46:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/6] Thermal zone device structure encapsulation
Date:   Thu, 13 Apr 2023 13:46:41 +0200
Message-Id: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The thermal zone device structure is defined in the exported thermal
header include/linux/thermal.h

Given the definition being public, the structure is exposed to the
external components other than the thermal framework core code. It
results the drivers are tampering the structure internals like taking
the lock or changing the field values.

Obviously that is bad for several reasons as the drivers can hook the
thermal framework behavior and makes very difficult the changes in the
core code as external components depend on it directly.

Moreover, the thermal trip points being reworked, we don't want the
drivers to access the trips array directly in the thermal zone
structure and doing assumptions on how they are organized.

This series provides a second set of changes moving to the thermal
zone device structure self-encapsulation.

The ACPI and the Menlon drivers are using the thermal zone's device
fields to create symlinks and new attributes in the sysfs thermal zone
directory. These changes provide a hopefully temporary wrapper to
access it in order to allow moving forward in the thermal zone device
self-encapsulation and a Kconfig option to disable by default such a
extra sysfs information.

Changelog:
	v3:
	- Split the Kconfig option to be driver related when disabling
          the specific attributes
	- Use the thermal zone's device wrapper to write a trace in
          the pch intel driver
	v2:
	- Add the Kconfig option to remove specific attributes
	- Add a thermal_zone_device() wrapper to access tz->device

Daniel Lezcano (6):
  thermal/core: Encapsulate tz->device field
  thermal/drivers/intel_pch_thermal: Use thermal driver device to write
    a trace
  thermal/drivers/acpi: Use thermal_zone_device()
  thermal/drivers/menlow: Use thermal_zone_device()
  thermal/drivers/acpi: Make cross dev link optional by configuration
  thermal/drivers/intel_menlow: Make additionnal sysfs information
    optional

 drivers/acpi/Kconfig                      | 13 ++++++
 drivers/acpi/thermal.c                    | 57 +++++++++++++++++------
 drivers/thermal/intel/Kconfig             | 11 +++++
 drivers/thermal/intel/intel_menlow.c      | 12 +++--
 drivers/thermal/intel/intel_pch_thermal.c |  3 +-
 drivers/thermal/thermal_core.c            |  6 +++
 include/linux/thermal.h                   |  1 +
 7 files changed, 84 insertions(+), 19 deletions(-)

-- 
2.34.1

