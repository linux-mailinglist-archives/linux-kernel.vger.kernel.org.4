Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F064A905
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiLLU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiLLU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:59:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D575183B0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:58:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so6391712wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+MGbDKBj7Xl7l5uM094vkfbwnyYsqUfMcbA7UwcKv8=;
        b=SjzaM+2btuSfkz8AWjTFtJVlZybj7rrPB8boF2vBrq6CoOeSDTJM2TanyGG3gHUPxM
         9xKuUgrxCd5hNCIlt54LCR4iyRuyIRrD8PhjqHKSgrmXxfphQ9MNAHy9Wa7SJGjtqIiF
         RioGfFSNNXP62D/EHsrdMwMoQgW0LON+6zbwYdE+BZMQ1asjMT1hfPXh/r3e599EM2OE
         YxxYWKDtS1bhoIL0zJfnfpQviqh/G8xmsPh6B4kzLOVejq6E3/HV6t1+VG9nSpsgYfRt
         6YUWQKH5msz7cZA/c/exg2tTfgHS53yy2XQctjaaH34iLI2qzsHWGAvcZuqj+pBwR2pE
         7lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+MGbDKBj7Xl7l5uM094vkfbwnyYsqUfMcbA7UwcKv8=;
        b=X+7iwpyBmg/UGQE6GbcCeiCSH+XI4kV2zOL/BP185QJGRQ+SzuV9MzVNou0bsBrTVY
         v//taj2wNPFaJ/A92QGbgtXStgwdiL60AXckffFM3kaiuum6SrlsWbzsOcjvfUQQLGKg
         Ry3YD34bLcpXtg5K7vEB60buIt/HgC+JUP10QQMSOPk4v5sKxhmwT73DRwAnsQ//bQjO
         nSqKT1r11JmVNgrjfOz0nOLBuGTKG/Ypz/x1a+RkKP9g/xM0I3Sf0013WpFQkBEBK5/z
         MBVP3Tcb9zLf6RNYukxXB1AwA7Fmlw5JUkl4VizjKG7Ed+nQzrxtynNNbUit9jrDOANZ
         QMlw==
X-Gm-Message-State: ANoB5plAXCdyYSk9OXGop4JnB+1i+F+hErfV+Vq4XqJvlMHEUBkXeG9Q
        0JGqXK/R2nGeDNcLZJntn4LMJw==
X-Google-Smtp-Source: AA0mqf7wlfDb73bkiORt5TqHF0OVyAMRBVW5u4sp7eJW3H616JHtJzB0aroPO8lza0STB44Uj9f1xg==
X-Received: by 2002:a1c:f216:0:b0:3cf:87c6:890e with SMTP id s22-20020a1cf216000000b003cf87c6890emr14161784wmc.27.1670878737858;
        Mon, 12 Dec 2022 12:58:57 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10537201wma.4.2022.12.12.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:58:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add ACPI trip points parser helpers
Date:   Mon, 12 Dec 2022 21:58:38 +0100
Message-Id: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
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

Regarding thermal, the ACPI code parsing the trip points is duplicated
inside different Intel drivers. The generic ACPI thermal driver also
duplicates this code.

Those ACPI parsing actions are used to define trip points and these
ones are defined by, and specific to, the backend driver.

The different get_trip_* ops, also very similar between each other,
are using the specific trip point structure to return the requested
trip point information.

From there, there is nothing new, all this can be converted to the
generic trip point.

The first patch provides the functions to parse trip point description
from the ACPI table but based on the generic trip point structure. The
other patches convert the different Intel driver to use the ACPI
functions along with a migration to the generic trip point.

Daniel Lezcano (5):
  thermal/acpi: Add ACPI trip point routines
  thermal/drivers/intel: Use generic trip points for intel_pch
  thermal/drivers/intel: Use generic trip points int340x
  thermal/drivers/intel: Use generic trip points for quark_dts
  thermal/drivers/intel: Use generic trip points for
    processor_thermal_device_pci

 drivers/thermal/Kconfig                       |  13 +
 drivers/thermal/Makefile                      |   1 +
 .../int340x_thermal/int340x_thermal_zone.c    | 175 +++---------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 .../processor_thermal_device_pci.c            |  53 ++--
 drivers/thermal/intel/intel_pch_thermal.c     |  88 ++-----
 .../thermal/intel/intel_quark_dts_thermal.c   |  45 ++--
 drivers/thermal/thermal_acpi.c                | 249 ++++++++++++++++++
 include/linux/thermal.h                       |  15 ++
 9 files changed, 377 insertions(+), 272 deletions(-)
 create mode 100644 drivers/thermal/thermal_acpi.c

-- 
2.34.1

