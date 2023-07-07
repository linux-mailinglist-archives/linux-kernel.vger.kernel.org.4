Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7792874B812
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjGGUhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGGUhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:37:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839721994
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:37:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so2409756f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688762270; x=1691354270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g4HspQwLyN/0KAF6AN2JANGXDGJX10XlJGv3FkdFNB0=;
        b=Ba1f/ZqrWpPeZua5hrhiX1yu+18Aq/SUp2ZUZdpBJ9lbeMsUD1LejL8c4xqHz6oJhA
         Sl3MPw3LaQ/r4Uit3N7tIILLyCcUQ+5bnpQHEhHYKnm01O4xNYg88/8QuqfKcFm8K18R
         lBVLbMceymzB8wFF4PFMP0gJCiOfJz7PVNFg/VJExJuv1ZAjEW6w7ciu7TNMddiWk8Tv
         nRkCaSHa8eKcHmtvjuk1vONVTJrWPITKZzlEnoHtbBUYFNvtKmjvhjaOn4lN32ErSU5W
         9ivpVJHLkaDUtJSBn+xqNdDYEGxGjNJ7lSaRl9v0R46kxU4UNbvFP8W7Q37Pjg/T9h1B
         wqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762270; x=1691354270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4HspQwLyN/0KAF6AN2JANGXDGJX10XlJGv3FkdFNB0=;
        b=HPd9IDa71qHs/uH0me2ZR0wZe0rgsu7rcTth88Lq++6GGvlttLCTiSVAKMLdergZ8d
         noCZEAjyH/07q6jHg4tuKqjB+0AjPeAbVGekgJ9HL8IQPdS1MMxJvwAssZ0sOxLgfetv
         Afh2SaSGkCB9Yt5XAgH4PdUXXL8rWjXRntsHwlkw9YHO78icj4WnLBd5lTB93MpxbE7n
         1LW1EpqAPvfNUpA1sz+PNldtlvSoepfQZFDFGhEBEAsuHAKitAQZyv9NIFx77Mnm3kLq
         lK9GUg6IKXxwdb6rDxZ/dH3cTnhf7SZtxatLFvz4Zms/v32mJie1xNTN9wIm6UhpQc84
         x8vQ==
X-Gm-Message-State: ABy/qLazSn7G/Oru44FhFxchU9eQ6UDGAGAjUViSenlWH0Rnk4UEY8/l
        jcXNgXqZZ89GufDVYT+CSdo9dQ==
X-Google-Smtp-Source: APBJJlF47znCRWOhugTz/uinATCfMNp8DhqRHIDR/KHzbL3FP/enIaX40ctSi4pY9QKXNw62dK9fEg==
X-Received: by 2002:adf:ee51:0:b0:314:25d:c8f4 with SMTP id w17-20020adfee51000000b00314025dc8f4mr4949402wro.2.1688762269939;
        Fri, 07 Jul 2023 13:37:49 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b003143be36d99sm5260674wrp.58.2023.07.07.13.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 13:37:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH v2 0/4] One more step to the thermal zone structure encapsulation
Date:   Fri,  7 Jul 2023 22:37:27 +0200
Message-Id: <20230707203731.848188-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series provides more changes to self-encapsulate the thermal zone device
structure in order to protect wild accesses to the thermal zone device
internals, especially the trip points and the locks.

The first patch adds a macro to warn at compilation time if the
thermal_core.h is included in a file not belonging to the thermal core
code. One warning will happen with the nvidia drivers but this is in
the way to be solved.

The second patch reorders the headers inclusion in the core code.

The next patches makes the int340x drivers to use the thermal trip
update above and the different accessors for thermal zone structure.

Daniel Lezcano (4):
  thermal/core: Hardening the self-encapsulation
  thermal/core: Reorder the headers inclusion
  thermal/drivers/int3400: Use thermal zone device wrappers
  thermal/drivers/int340x: Do not check the thermal zone state

 drivers/thermal/gov_bang_bang.c               |  1 +
 drivers/thermal/gov_fair_share.c              |  1 +
 drivers/thermal/gov_power_allocator.c         |  7 +--
 drivers/thermal/gov_step_wise.c               |  1 +
 drivers/thermal/gov_user_space.c              |  1 +
 .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++++++----------
 drivers/thermal/thermal_acpi.c                |  1 +
 drivers/thermal/thermal_core.c                |  7 +--
 drivers/thermal/thermal_core.h                |  4 ++
 drivers/thermal/thermal_helpers.c             |  1 +
 drivers/thermal/thermal_hwmon.c               |  1 +
 drivers/thermal/thermal_netlink.c             |  1 +
 drivers/thermal/thermal_of.c                  |  1 +
 drivers/thermal/thermal_sysfs.c               |  1 +
 drivers/thermal/thermal_trip.c                |  1 +
 15 files changed, 45 insertions(+), 28 deletions(-)

-- 
2.34.1

