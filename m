Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6099169B587
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBQWco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQWcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:32:41 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A675FBD5;
        Fri, 17 Feb 2023 14:32:40 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id h16-20020a9d6a50000000b00690ed91749aso576602otn.7;
        Fri, 17 Feb 2023 14:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hibrcR3FpohMCi2GhALxLrhNLj3j0HrNrmzVssYuDY0=;
        b=ZV72aJtOZw0a6eug4Wp6X8rtWj6OnlajTRpUbVvHsxxeK7Mjmyj8P7OHwlc06L2b98
         27biEt4uEmubqimOMaBWBU1K2sjd+ToVO9iolgwHZRaJU8FiNSev3KiYZlKMG0QHYhlv
         7ve67XzRxhziSHpHbPhL1y3RSk2tCZi9CPMJUN/U2aOFPeWp2V/nGyiHikO9GTQIo7Qk
         cW1rRiPPWbn/GZy5b6ulArHM0D2Atn3EX6f8Mhh5eIj4edHf8DvSjuUf1jm15mfqP+uF
         h/2CW3R26oRMYt+eu49+IDtOBT0+VouI6oIN68noUFGZtSmVAkCqVzMlBjt6xwWtKh5f
         aRyw==
X-Gm-Message-State: AO0yUKXRAdMlTCHlcd0YimOHWC+mA4eKS6/83y8UET/lS7BKw6mDr/TA
        pHfWBCQAKSNmCSr9QzFleQ==
X-Google-Smtp-Source: AK7set8CQp2VTDIvRs7aGGnR2LQQ0imuAn3sVaPBcsvlLKTg7pxCAc1tzt9MKsFoIvm/+WDFMOlSqw==
X-Received: by 2002:a05:6830:3148:b0:690:958e:f0e9 with SMTP id c8-20020a056830314800b00690958ef0e9mr591827ots.1.1676673159323;
        Fri, 17 Feb 2023 14:32:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a13-20020a9d470d000000b00690e42f0da8sm1678619otf.24.2023.02.17.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 14:32:39 -0800 (PST)
Received: (nullmailer pid 1684705 invoked by uid 1000);
        Fri, 17 Feb 2023 22:32:38 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v5 0/2] perf tool: 'config3' attribute support
Date:   Fri, 17 Feb 2023 16:32:09 -0600
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkA8GMC/43NQQ7CIBAF0KsY1o6hlFZw5T2MC0qnLRGhGSqJa
 Xp30Z0rXU3+T/6blSUkh4mddisjzC65GEpo9jtmJxNGBNeXzAQXgutKgqE7zEgDLDF6SDNWICA
 LsKY7Km2bvtGKlXVnEkJHJtip7MPD+1JOLi2Rnp9vuS7n8hvONXBQldKD5bK3tj3fkAL6Q6SRX
 Qua5Z+QfEO15VphKyqBX9C2bS9VX+CmDQEAAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the perf tool support for 'config3' attr. This is 
the last part to enable Arm SPEv1.2 support. The necessary kernel side 
changes are pending for v6.3[1].

[1] https://lore.kernel.org/all/20230207124250.GA12385@willie-the-truck/

---
Changes in v5:
- Rebase on v6.2-rc1
- Drop applied config attr fix
- Link to v4: https://lore.kernel.org/r/20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org

Changes in v4:
- Fix event parsing test segfault
- Add 'config3' in event parsing tests
- Link to v3: https://lore.kernel.org/r/20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org

---
Rob Herring (2):
      perf tools: Sync perf_event_attr::config3 addition
      perf: Add support for perf_event_attr::config3

 tools/include/uapi/linux/perf_event.h |  3 +++
 tools/perf/tests/parse-events.c       | 13 ++++++++++++-
 tools/perf/util/parse-events.c        |  6 ++++++
 tools/perf/util/parse-events.h        |  1 +
 tools/perf/util/parse-events.l        |  1 +
 tools/perf/util/pmu.c                 |  3 +++
 tools/perf/util/pmu.h                 |  1 +
 7 files changed, 27 insertions(+), 1 deletion(-)
---
base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
change-id: 20220914-arm-perf-tool-spe1-2-v2-cab789c5d598

Best regards,
-- 
Rob Herring <robh@kernel.org>

