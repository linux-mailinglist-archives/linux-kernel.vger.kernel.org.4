Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF88F6CD839
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjC2LOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC2LO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:14:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E53C3A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:14:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r11so15230652wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680088466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcF0vX8j8gqWH3Qe03F1mOXxKH3Dih4Bs0j11Tzpjbo=;
        b=CqtWfSA0HALwgFr3US5SPtV4WTVD8MrH6cLx8wHXzh3tnzeet1qd2KiWvrHn8n+GKb
         JeQiOhybZTrUMrETQIqsTgV6BXwYXaHKXuD6AjLcFnOlcpWau3a38xNF5aCj0d+Dgqal
         787y/V5xfOmzgxeU9Nzwg0fP5pskAakWQFy2Qb+mVET7X5aX3RhaZS0iF2OeQIoZv/BP
         RixWO032QlUy7U6Mn9m5Ixm7jI+DggEFAtq/n5qucER7y9nsiaq7mm0nDf0twJrPry1W
         UOfKThT8RaimVyatAY882OCvpRQs6PKPcS1PD11H7Yc70EpdpLaYigt0aUEj9+zVB8Ft
         Y4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcF0vX8j8gqWH3Qe03F1mOXxKH3Dih4Bs0j11Tzpjbo=;
        b=MoZLgDpbwXvFQfpiMD05fFuu+hZLthyzlddd8duQy08oxb9+oYSmpTwwhfAVUtCOXt
         aIHCGxSyAXDN5Fcxfx23CN2LYC7FyMy8cYupcgCAs/HyN1qsy0LT6wP7y2+GiVkuNh1O
         mDINv6lpVwAortFEirfmFMYCrLqClxmN1JgwKJ0LsdpysGSc4Cq59W4pKCOmac+qV6Bh
         +5rmV05u1qloccarwbNmS/OgnAnfrtcY5szS+PHs7enDCpq6crn0lqrdBlTgQ/H5KDrG
         e28goJOXHqWheRkx2bh1vfMbJ4UDL56gVoDKv3VaPoHqmm0tXLRikjMWHFUDrBxYGox4
         rSqA==
X-Gm-Message-State: AAQBX9dcpsNluZX4VVwVngh5gkxF5jCm0lkL+M3X511L59GxqsZHUQKl
        HzdG3lxk1geuv+eZV87KmNG5aw==
X-Google-Smtp-Source: AKy350ZwYFFQU329m4ivgWvusumP663lpxpwBKfi5CMKQa2WHao1B/T4u3EW5VhN5eZvjO+v4BgLeQ==
X-Received: by 2002:adf:e242:0:b0:2cf:e15b:c1c5 with SMTP id bl2-20020adfe242000000b002cfe15bc1c5mr14341071wrb.22.1680088465952;
        Wed, 29 Mar 2023 04:14:25 -0700 (PDT)
Received: from linaro.org (host86-131-79-192.range86-131.btcentralplus.com. [86.131.79.192])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000008600b002cde25fba30sm30067163wrx.1.2023.03.29.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 04:14:25 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        suzuki.poulose@arm.com
Cc:     leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v8 0/3] perf: cs-etm: Update perf to handle new Coresight Trace ID
Date:   Wed, 29 Mar 2023 12:14:19 +0100
Message-Id: <20230329111422.3693-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The original method for allocating trace source ID values to sources was
to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
The STM was allocated ID 0x1.

This mechanism is broken for systems with more than 47 cores.

The kernel related patches the provide a fixed Trace ID allocation mechanism
are now upstreamed.

This patchset updates the perf code to handle the changes to the trace ID
notification mechanism that now uses the PERF_RECORD_AUX_OUTPUT_HW_ID
packet to set Trace ID in the perf ETM decoders.

Applies to perf/core 

Changes since v7:
Split from original patchset [1] to be sent separately as kernel related
patches are now upstream.

[1] https://lore.kernel.org/linux-arm-kernel/20230116124928.5440-1-mike.leach@linaro.org/

Mike Leach (3):
  perf: cs-etm: Move mapping of Trace ID and cpu into helper function
  perf: cs-etm: Update record event to use new Trace ID protocol
  perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet

 tools/include/linux/coresight-pmu.h           |  47 ++-
 tools/perf/arch/arm/util/cs-etm.c             |  21 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
 tools/perf/util/cs-etm.c                      | 326 +++++++++++++++---
 tools/perf/util/cs-etm.h                      |  14 +-
 5 files changed, 350 insertions(+), 65 deletions(-)

-- 
2.32.0

