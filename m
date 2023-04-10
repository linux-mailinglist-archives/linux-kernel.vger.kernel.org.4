Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2AD6DCC52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDJUxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjDJUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:53:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C12129
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s2so2270414wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160017; x=1683752017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgjQsE1Hdvwl1NpUaWmvVlqrPBksB4aMkQUF06EbqG0=;
        b=GMbkVC5Odhohp4FRso5dq41lhdBBmwA0cCsSv1a/9GCDi+dGlj1xq07iL7kn4n0TDF
         jMzdfCAvDiEBAbWfWTOJ28/rnuViok0d2ohjI6x3Zarbg/Q6qJFMOPy0b6wlmFPGeK+C
         CUfQ3kR3yY03IQnrTOhxrvhYoyV9OKoyBqvvtfJJPjbDzSzTJOM7SQT28mIVUxyb3EZp
         g/wy70BBo/Rhg2Gn8Uy19Xu2Tddy6CZE5DcSPdcZPT39MtdYE0jUqBczrVMxREVIxqPR
         kxWKjRGAeJsOvmZOwKPXzRC0bP36mbDB6rVmh6WviMJ8nkDIg+qTqRNGHkwreBtp8N6+
         3VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160017; x=1683752017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgjQsE1Hdvwl1NpUaWmvVlqrPBksB4aMkQUF06EbqG0=;
        b=CDyUQyAKz2lPfEJPDh7zgmhGbxp17JAHDOfVLdrfg2oxYYTf+r0tISI6vZtYwRMHGS
         P1l6xi0XpvRB6/mWL50P/wXIzMdejZObHQlGjaeNSVUj31uUE9BWydITxJcL7Qrp1V2H
         ORhqnsi9iohkXSXNPJyEy5hADCgRnzOzbpBQHnzqdwuYB50aoGoEAjdRPzR9+Txgu02Q
         iHiLuqKP+QhRXsOTGDmStCA+ORiRPc1cg5Hl09TebGwCSEGnuFWBnP7rElKa1+KHP+lX
         0cfpMybcGPjdiH7jDJd21e2mUP40MoFElgncIpO/qxwiw58JrcGSPmJoQbPLkWuyhJ25
         CBEw==
X-Gm-Message-State: AAQBX9cZqKm4QqEdJs/ClG29H5qh9UsmPgpxR0frsOCXupC8U9dndnOn
        dqzNo4h5ERZgW6tX5zAu5Vh7mA==
X-Google-Smtp-Source: AKy350b05mU+al6g2Ror4NodaOndG1msKWfJ52vGjmVkxmCNOvPO/YJaOzW6kKCeQSvoVCDsdSThzg==
X-Received: by 2002:a5d:5510:0:b0:2ce:9877:84ae with SMTP id b16-20020a5d5510000000b002ce987784aemr8705347wrv.16.1681160017218;
        Mon, 10 Apr 2023 13:53:37 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/7] Thermal zone device structure encapsulation
Date:   Mon, 10 Apr 2023 22:52:58 +0200
Message-Id: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
	v2:
	- Add the Kconfig option to remove specific attributes
	- Add a thermal_zone_device() wrapper to access tz->device


Daniel Lezcano (7):
  thermal/drivers/intel_pch_thermal: Use thermal driver device to write
    a trace
  thermal/core: Encapsulate tz->device field
  thermal/drivers/acpi: Use thermal_zone_device()
  thermal/drivers/menlow: Use thermal_zone_device()
  thermal/core: Prepare sanitizing thermal class sysfs content
  thermal/drivers/acpi: Make cross dev link optional by configuration
  thermal/drivers/intel_menlow: Make additionnal sysfs information
    optional

 drivers/acpi/thermal.c                    | 57 +++++++++++++++++------
 drivers/thermal/Kconfig                   | 12 +++++
 drivers/thermal/intel/intel_menlow.c      | 12 +++--
 drivers/thermal/intel/intel_pch_thermal.c |  5 +-
 drivers/thermal/thermal_core.c            |  6 +++
 include/linux/thermal.h                   |  1 +
 6 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.34.1

