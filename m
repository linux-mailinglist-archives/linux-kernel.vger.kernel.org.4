Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96E765B618
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjABSB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:01:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C534DD4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:01:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so13786593wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aa5rfp9VJf2+PTqFf57RAAtNyvl58KCXDQKlQWDHvTE=;
        b=h3jwXZizSoXbx0Ldi15X+Cor8OycomS3cWRqIO91vgMLAvC3ooYZlBnq+m2QteUsoP
         3XYqHPvwzz1nIUVdhV2hrZUpOtZ8N+A0NeQNSRbhX7OOXqxl5DQxa1C75mmHjE7ranck
         7h3q2t51WHOmynMvk/tLK61Qa9i2mSunYB8OFc9kxM6hgufGjD8LINCV6cvR16ETlJA0
         XMTsODVK9Y64yOONSIbLSQMCzCm52LyPBsrYrf2y+8W5LfGHPWqhozX2YbQoSliY6iFG
         9M4jVt6HP3wCoGKCYcNZcv8gOC/ThGrsNo09dmKEJBDG6eXPNwGhRDJ7/Anha10ZlFEx
         I+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aa5rfp9VJf2+PTqFf57RAAtNyvl58KCXDQKlQWDHvTE=;
        b=KAdOThRJ3ESCieCBM20PKN4kxRFVrJrsVh4fgJx2Th/Ywrw3sebnP7b8vQXeQ7dvsw
         RJlsA2G3vc6K6pGHN8dTNHRYbHpCjdB7c/yLz2VGDFh8xV43iJqlItTGSjYJhjRK+Vts
         MZJLjx5eEu7P30mZFPKHeWESwSDatEwY67m0OWd3DJHlcSgEAmJPx9O227uD0+OYAPyN
         GViXt2n0px2JeEtg4AnlaQrqpfu/knTV8sayxDLWhpsuackNZEFkuqAjHf6TChHfYHOe
         mYRBTSQ0gNcFzYnGoqQsBu/45SszmGgUj3ICdXVNq3mybqEEg0JiDXhBOrIMi4zVd756
         ivvQ==
X-Gm-Message-State: AFqh2kqIcbSmUizrPy4IXhJ8YIzlu0owG+PmXbnpRQNBz/gnrZ+dkCMY
        t3tr80yKnVzTo+J4P8Gl0LwHxA==
X-Google-Smtp-Source: AMrXdXuorMhJZ+hEqbdQC2iDTfPryxIrLt5l667lYwxxqEb/4WWFLz5a8z/OQ9P0uPn5copr/Q1vGg==
X-Received: by 2002:a5d:430f:0:b0:244:48b3:d12b with SMTP id h15-20020a5d430f000000b0024448b3d12bmr24639329wrq.45.1672682482028;
        Mon, 02 Jan 2023 10:01:22 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b0027cb20605e3sm21375588wrs.105.2023.01.02.10.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 10:01:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com
Subject: [PATCH v2 0/3] Thermal ACPI APIs for generic trip points
Date:   Mon,  2 Jan 2023 19:01:09 +0100
Message-Id: <20230102180112.1954082-1-daniel.lezcano@kernel.org>
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

 - V2:
   - Fix the thermal ACPI patch where the thermal_acpi.c was not included in
     the series

   - Provide a couple of users of this API which could have been tested on a
     real system

Daniel Lezcano (3):
  thermal/acpi: Add ACPI trip point routines
  thermal/drivers/intel: Use generic trip points for intel_pch
  thermal/drivers/intel: Use generic trip points int340x

 drivers/thermal/Kconfig                       |  13 +
 drivers/thermal/Makefile                      |   1 +
 .../int340x_thermal/int340x_thermal_zone.c    | 175 +++--------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  88 ++----
 drivers/thermal/thermal_acpi.c                | 279 ++++++++++++++++++
 include/linux/thermal.h                       |  16 +
 7 files changed, 368 insertions(+), 214 deletions(-)
 create mode 100644 drivers/thermal/thermal_acpi.c

-- 
2.34.1

