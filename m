Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E2636A15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiKWTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiKWTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3118B786E2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso2058691wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOCelKtodnOuBbyEk5ruc3Oby9rXzvati+Q8sVlxgR4=;
        b=FDq91Yc8KX6yqp7V+bpv/rzlnUdQv1LV7ogYwNkgupB/LvREIceWQQx4aiylWP/LJ9
         cXgrHE9z4D7ZlY8M068nacQXPnF00jDohjpADktaWNuJPlwQLQVzdjH61+LprPx/Mz+K
         cGZjcaSVyYv2LeXnsil0KNB2c3GDC9zUwAGhvm/XayaszG/BnNQn+YW9kFVUiwd5oadg
         ilXbD8/VCpEekWIb3VAt4jGXLH9F+LMfPvi41HF8AXHSe3g4wxtRA0Ra23oenqJgqF4v
         iYMInsZS6cLcUhiq0RxY2rdRUj5bQh3ix4BPk6v4hieHjlacUSJD6Lo0qW09hYi1uxUW
         4IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOCelKtodnOuBbyEk5ruc3Oby9rXzvati+Q8sVlxgR4=;
        b=WVR+BCe2uUjpOs/0SfABgT28Wj/nDm9Pm0sore0iEcxwQFzVuBfd+xfyMv0uzUzgu/
         Hw3VY1rnrrmRRrFHSqcmD0qplfINt9lhGm4Y0HAyF0HV9FzDy6EYDBCY3pRWt1efcoBN
         4W79PnoAvABqXLQTlg14Z5Bz7vDhTyjOAeE9e9U8WV2h9nPZEhkBvVDWeKLXD3bkGYFf
         eUwrmFsTIP8KLQtdDvby1yvfP0miPEGQNhHrOBv6Gnt+alBDQn8H1qQyZyRqR2qZIWTg
         jQSfkjYsjv9WZlJzXar5sWoO9R5T7UduEWvLoRwSXRTcgfyUt9cKkTQPPt89TR6apvA+
         tTuw==
X-Gm-Message-State: ANoB5pm8wOiHHP6ZVpcB2T+d0sZVSG+L2JTsGWpGuzFHJ6OwAaQNyEA3
        hyp4sBvYATekbDyKFA0BR3IpwA==
X-Google-Smtp-Source: AA0mqf6/pak5h2/DEE+iiJ8hWac6o6kj3rrZskaMGds1CWt9RBDVnvFzVyHSzvnF8IFrV5VfHEIDGQ==
X-Received: by 2002:a05:600c:2108:b0:3cf:aae0:802a with SMTP id u8-20020a05600c210800b003cfaae0802amr11677830wml.112.1669233020690;
        Wed, 23 Nov 2022 11:50:20 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:20 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 00/14] coresight: Add new API to allocate trace source ID values
Date:   Wed, 23 Nov 2022 19:49:56 +0000
Message-Id: <20221123195010.6859-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current method for allocating trace source ID values to sources is
to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
The STM is allocated ID 0x1.

This fixed algorithm is used in both the CoreSight driver code, and by
perf when writing the trace metadata in the AUXTRACE_INFO record.

The method needs replacing as currently:-
1. It is inefficient in using available IDs.
2. Does not scale to larger systems with many cores and the algorithm
has no limits so will generate invalid trace IDs for cpu number > 44.

Additionally requirements to allocate additional system IDs on some
systems have been seen.

This patch set  introduces an API that allows the allocation of trace IDs
in a dynamic manner.

Architecturally reserved IDs are never allocated, and the system is
limited to allocating only valid IDs.

Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
the new API.

For the ETMx.x devices IDs are allocated on certain events
a) When using sysfs, an ID will be allocated on hardware enable, or a read of
sysfs TRCTRACEID register and freed when the sysfs reset is written.

b) When using perf, ID is allocated on during setup AUX event, and freed on
event free. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
The ID allocator is notified when perf sessions start and stop
so CPU based IDs are kept constant throughout any perf session.


Note: This patchset breaks some backward compatibility for perf record and
perf report.

The version of the AUXTRACE_INFO has been updated to reflect the fact that
the trace source IDs are generated differently. This will
mean older versions of perf report cannot decode the newer file.

Appies to coresight/next

Changes since v5: (requested by suzuki)
1) Prefer odd ID values for system IDs to avoid overlap with legacy CPU IDs
2) Some style changes

Changes since v4:
1) update to ensure that compiling after each individual patch added still
works - ie. git bisect not broken through the patchset..

2) Revision to some of the now redundant code in cs-etm (James)

3) Comments and other minor fixes requested by Suzuki.

Changes since v3:
1) Fixed aarch32 build error in ETM3.x driver.
Reported-by: kernel test robot <lkp@intel.com>

Changes since v2:
1) Improved backward compatibility: (requested by James)

Using the new version of perf on an old kernel will generate a usable file
legacy metadata values are set by the new perf and will be used if mew
ID packets are not present in the file.

Using an older version of perf / simpleperf on an updated kernel may still
work. The trace ID allocator has been updated to use the legacy ID values
where possible, so generated file and used trace IDs will match up to the
point where the legacy algorithm is broken anyway.

2) Various changes to the ID allocator and ID packet format.
(suggested by Suzuki)

3) per CPU ID info in allocator now stored as atomic type to allow a passive read
without taking the allocator spinlock. perf flow now allocates and releases ID
values in setup_aux / free_event. Device enable and event enable use the passive
read to set the allocated values. This simplifies the locking mechanisms on the
perf run and fixes issues that arose with locking dependencies.

Changes since v1:
(after feedback & discussion with Mathieu & Suzuki).

1) API has changed. The global trace ID map is managed internally, so it
is no longer passed in to the API functions.

2) perf record does not use sysfs to find the trace IDs. These are now
output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
have been updated accordingly to generate and handle these events.

Mike Leach (14):
  coresight: trace-id: Add API to dynamically assign Trace ID values
  coresight: Remove obsolete Trace ID unniqueness checks
  coresight: perf: traceid: Add perf ID allocation and notifiers
  coresight: stm: Update STM driver to use Trace ID API
  coresight: etm4x: Update ETM4 driver to use Trace ID API
  coresight: etm3x: Update ETM3 driver to use Trace ID API
  coresight: etmX.X: stm: Remove trace_id() callback
  coresight: trace id: Remove legacy get trace ID function.
  perf: cs-etm: Move mapping of Trace ID and cpu into helper function
  perf: cs-etm: Update record event to use new Trace ID protocol
  kernel: events: Export perf_report_aux_output_id()
  perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
  coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
  coresight: trace-id: Add debug & test macros to Trace ID allocation

 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  45 ---
 .../hwtracing/coresight/coresight-etm-perf.c  |  23 ++
 drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
 .../coresight/coresight-etm3x-core.c          |  93 +++--
 .../coresight/coresight-etm3x-sysfs.c         |  27 +-
 .../coresight/coresight-etm4x-core.c          |  73 +++-
 .../coresight/coresight-etm4x-sysfs.c         |  27 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
 drivers/hwtracing/coresight/coresight-stm.c   |  49 +--
 .../hwtracing/coresight/coresight-trace-id.c  | 298 ++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  | 156 +++++++++
 include/linux/coresight-pmu.h                 |  34 +-
 include/linux/coresight.h                     |   3 -
 kernel/events/core.c                          |   1 +
 tools/include/linux/coresight-pmu.h           |  48 ++-
 tools/perf/arch/arm/util/cs-etm.c             |  21 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
 tools/perf/util/cs-etm.c                      | 328 +++++++++++++++---
 tools/perf/util/cs-etm.h                      |  14 +-
 20 files changed, 1024 insertions(+), 231 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

-- 
2.17.1

