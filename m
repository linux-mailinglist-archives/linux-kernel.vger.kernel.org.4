Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76DB664456
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjAJPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjAJPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:17:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125E5BA29
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:17:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m3so9074317wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzboIXLTJPA/CndXjJQee1fr50X0HrhF4nPYCfs1XU0=;
        b=s2M+4R5+xJ7IBwXCD+r7bYx/xe4B+X65TcB6MadC7llHk9qljXzXPWxb0IzcEGnRm8
         +PmCX6alj6KZ9Px81+SFMDjlwRnPFD5UOTT82D9NxHeOSFYs7LgL/c19kGR54PWvrfi8
         iCwA6O3RPmy7YPmlW0l7WWG+EFFJ507m6LCDopm9/UmZl+Z/A52fHxf2HpnHIrdFCbeB
         RCd/znrtNCLNn3++UYSDZBYvIzEBrn0R4UXq0sSRLU32cqntJgdudfflCXHlAfC7pG+n
         ILpyx1G3j6DCxpGchxQOU0RVQU/LenMoSkKbpTNhneM7U4FMSlK10qT2O1gYhbY2pVYD
         9jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzboIXLTJPA/CndXjJQee1fr50X0HrhF4nPYCfs1XU0=;
        b=rkbuePd/IJ4Vbe0Goy4zu+x+VrVG5R/RWbdwdiet0qTPcMLYB9KuM68u6a24cjsbiA
         pD9sVO1z2oz5JrJQANWGClWYLRAGZg673CHv31t6ScdcdCGxX8b7EIOlfHlJdw0+OhKK
         DzhUvD9jk+3b3orYwmElYwTvvESnmp6Uedg1tXYLEcgti/f+EtYFpp7xFlQW1DrTU1tF
         9hmBQcnTTF4ixgQoag6sSc/Lb27lKIWwg+tzCAEr2HOK4Zp6WatQepxHH0NWpUfEVOve
         VgHndUbjXor/UFqP3nt4ps2cKCo0p+esQdape9HGzmE3pU0ZxJoE0GyCNQNUwvmVmc7u
         JVng==
X-Gm-Message-State: AFqh2koB2GxohRnyWkNu8sDQMmLUSiI/WGansg5bU43RMz2JSl9jD0VJ
        joFnYH6on2WPWuw32ym4pAg+GQ==
X-Google-Smtp-Source: AMrXdXu7O7gUKOxIlAJTx93hk0V+z8hFTJLZE8lDRHKCw9LYY61tcYom+IpefqFPQjV/fkBqrTumEg==
X-Received: by 2002:a05:600c:3844:b0:3cf:7dc1:f424 with SMTP id s4-20020a05600c384400b003cf7dc1f424mr49054728wmr.3.1673363872999;
        Tue, 10 Jan 2023 07:17:52 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id p21-20020a7bcc95000000b003c65c9a36dfsm14857281wma.48.2023.01.10.07.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:17:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
Subject: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Date:   Tue, 10 Jan 2023 16:17:42 +0100
Message-Id: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++-----------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  88 ++------
 drivers/thermal/thermal_acpi.c                | 211 ++++++++++++++++++
 include/linux/thermal.h                       |   8 +
 9 files changed, 287 insertions(+), 214 deletions(-)
 create mode 100644 drivers/thermal/thermal_acpi.c

-- 
2.34.1

