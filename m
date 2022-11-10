Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295E624595
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKJPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKJPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:06 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66E10B56;
        Thu, 10 Nov 2022 07:25:04 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso2454319fac.13;
        Thu, 10 Nov 2022 07:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xmjfoekNorwtXNFPR8+wc2e3NKk91Fqcl9jBDPzH2h0=;
        b=OoFJpuKP06gHaiTsiMKZxvVP/vRtZ6/vmOHy78Sq1coYwR8N06LS/U+x3T1L0kvd8x
         qAtJkzzJqGF/qbZ5EIsVFE2r77WABYlMpOuoXZm8P+tZPpudbaxw7lf0GLQ575BiC/QX
         +7BYUiUlAwo9/u1VPzmxh6U0KDQ6/GTAqHpcEnxbC22TFTy4cwi3AyWavssXjok3gGFo
         AwD/2tQf3+qcYnseDpA1VBTeiCHx3BhHGOM38ZY14LYizTjD9Hu4hkSXXa+lnZGiVvkj
         ydbYYfTeD8Wjbg514S+hoU/Vn/UAZmzLb7NR5hFvQYB5WwlBrxA/oY4bW0M1ePkEcE38
         UHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmjfoekNorwtXNFPR8+wc2e3NKk91Fqcl9jBDPzH2h0=;
        b=nmSO4AjzOj9oE8SdehoKTS68h9LtRKn224gaNpOU87R9cE43ECd16+DMzeeDQ4eXP1
         woGfRPgsJcmrvgXXyaUkJf2yaQDjDROPAPgDhGhdhn4IxUQi1F0S47RaVJVpbBQwPTgC
         paWOcB4IdCd3eYoZyQo5KywYgu+dkDG4WtYrZ5MdZDuqz+V/fTMuE16fSaH4US8wqRsl
         kvXi7CWeLHwb48S61ky3sVKexdYVekKe5cA7gYE6q53kN72Zj9FQGTVq3Gzy9MaONQnT
         ylGc2U996U79BW2cnuG76uASsqkUHt+S56wmea7fBEGPIuEw1vKi4SQRdNzyDJnttPpI
         jMow==
X-Gm-Message-State: ACrzQf0QHuMbrv8ahRIl3JPRifQdbR9xglBq3KPQseTaoO4rh3BAhjT/
        PHc/+dOG0dh/dqSRwfSuhxI=
X-Google-Smtp-Source: AMsMyM4tv6SJrs25LfigTFxxbKTX69rCzYOsQrWo/oRyq+T/KlzKa2ylTHnf6qQWc6lsUY1JZ3oNSQ==
X-Received: by 2002:a05:6870:a713:b0:131:8f4f:b8ea with SMTP id g19-20020a056870a71300b001318f4fb8eamr46141369oam.138.1668093903986;
        Thu, 10 Nov 2022 07:25:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y36-20020a05687045a400b0013ae39d0575sm7604236oao.15.2022.11.10.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/9] thermal/core: Protect thermal device operations against removal
Date:   Thu, 10 Nov 2022 07:24:51 -0800
Message-Id: <20221110152500.3032655-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accesses to thermal zones, and with it to thermal zone device operations,
are still possible after the thermal zone device has been unregistered.
For example, thermal_zone_get_temp() can be called from temp_show()
in thermal_sysfs.c if the sysfs attribute was opened before the thermal
device was unregistered. This is problematic and may result in crashes
since the operations data structure and the underlying code may be gone
when the calls are made.

The following series solves the problem by protecting accesses to thermal
device operations with the thermal device mutex, and by verifying that the
thermal device is still registered after the mutex has been acquired.

This was previously sent as RFC/RFT as single patch [1]. The code was reworked
to match thermal subsystem changes made between v6.0 and v6.1, and it was
split into several patches to simplify review.

[1] https://lore.kernel.org/linux-pm/20221004033936.1047691-1-linux@roeck-us.net/

v2: Improved documentation, rearranged code.
    No functional changes. See individual patches for details.

----------------------------------------------------------------
Guenter Roeck (9):
      thermal/core: Destroy thermal zone device mutex in release function
      thermal/core: Delete device under thermal device zone lock
      thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp
      thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp
      thermal/core: Introduce locked version of thermal_zone_device_update
      thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex
      thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
      thermal/core: Remove thermal_zone_set_trips()
      thermal/core: Protect thermal device operations against thermal device removal

 drivers/thermal/thermal_core.c    | 76 +++++++++++++++++++++++--------------
 drivers/thermal/thermal_core.h    |  3 +-
 drivers/thermal/thermal_helpers.c | 67 +++++++++++++++++++++------------
 drivers/thermal/thermal_hwmon.c   | 10 ++++-
 drivers/thermal/thermal_sysfs.c   | 79 ++++++++++++++++++++++++++++++++-------
 5 files changed, 168 insertions(+), 67 deletions(-)
