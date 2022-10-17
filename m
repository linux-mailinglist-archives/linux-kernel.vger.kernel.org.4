Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A40600FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJQNJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJQNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E98C50;
        Mon, 17 Oct 2022 06:09:14 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n130so12006667oia.6;
        Mon, 17 Oct 2022 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=asfx+wgkxvJPbTs13K/0EwEbD7Yq5Qo6s+tsNBTt1s8=;
        b=QV3Lq2NYdMmnxtyeg6kYTKhOuLkISsgy8JIab5P9gHsVp20UGbmq++4PM1/Hwj01y8
         4uodYGCTFmo4WgvKzZcw/5jNrmEaCRpPgMFUemijjBReRkp4i/HVbXyPCalDtW5MX3vG
         ebydNoXULTjYKq9DukZ6Y3B/cUeE/fSO/MEOrUxolBnL45Gk/L1scu5kgiXaTtsMYPP1
         x4DFSG4A6fQNZivwhaP94rB7RLMQvn6sCVaVi08PvZ0zDjTGETDMGSbW42SO7rtUwj5w
         nfyiQ/JvX97EwoKT3Z4SgEld0cAWEvcHrB46DSQWIdseqHKprs4RyRuxle+CVwNJxYxl
         SKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asfx+wgkxvJPbTs13K/0EwEbD7Yq5Qo6s+tsNBTt1s8=;
        b=XMx+llYP7z5Nv4Nt941xREJXrD+5bg7HzYwHjXcnyl88obBQM41B2+x+yIymBisdCR
         PYmpYbn4QmeRuK431OknNZh2ulQxG705lWH0XH0q8fbiDoMyS2cmFi+v/8WWxOQXa4/y
         0tRstJRIj3GKLnLsQK/in1EpEbAhkghBRYcurEem/tNn7XS3gxo1pqU6wf2Njp84srtx
         CldnBXF40g4+RUFnUuj2Fmnv8buOnn6VqeMyqC+5+TeOz7e4937lwAORFA1GbMQJX1f9
         CngrSG/Kzyaf5DST6LpQ8AUvuC6eJdUVzLwv/0/UwKOTNiLXDZyv4gIqDRE+qWf6VaOE
         R3sQ==
X-Gm-Message-State: ACrzQf10sZ5tm6VkzjShnunBDd/rFtbP0eV6YTJMV6bShtaSqPNuROIL
        Bgd/9G7kXcA9Le0TsyCS2Ts=
X-Google-Smtp-Source: AMsMyM46PrYwurjTfe/487yyZ645sEz+BOtV3Ak2d0yiQ5d1C1GGe63+mzc+YtSFFWPXAHwqGxc0Og==
X-Received: by 2002:a54:4001:0:b0:355:385e:c07b with SMTP id x1-20020a544001000000b00355385ec07bmr2302726oie.36.1666012154049;
        Mon, 17 Oct 2022 06:09:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r41-20020a056808212900b0034fd36e95bfsm4311478oiw.31.2022.10.17.06.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/9] thermal/core: Protect thermal device operations against removal
Date:   Mon, 17 Oct 2022 06:09:01 -0700
Message-Id: <20221017130910.2307118-1-linux@roeck-us.net>
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

 drivers/thermal/thermal_core.c    | 76 ++++++++++++++++++++++++--------------
 drivers/thermal/thermal_core.h    |  3 +-
 drivers/thermal/thermal_helpers.c | 65 ++++++++++++++++++++++-----------
 drivers/thermal/thermal_hwmon.c   | 14 +++++--
 drivers/thermal/thermal_sysfs.c   | 77 +++++++++++++++++++++++++++++++++------
 5 files changed, 169 insertions(+), 66 deletions(-)
