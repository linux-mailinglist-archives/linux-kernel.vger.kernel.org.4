Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F3A6B4C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjCJQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCJQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:08:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81BD31086BE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:06:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00584B3;
        Fri, 10 Mar 2023 08:07:25 -0800 (PST)
Received: from e127643.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB6403F5A1;
        Fri, 10 Mar 2023 08:06:40 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] coresight: Fix CTI module refcount leak by making it a helper device
Date:   Fri, 10 Mar 2023 16:05:59 +0000
Message-Id: <20230310160610.742382-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

 * Don't dereference handle in tmc_etr_get_buffer() when not in perf mode.
 * Fix some W=1 warnings
 * Add a commit to rename child/output in terms of local/remote

-------------------

Currently there is a refcount leak in CTI when using system wide mode
or tracing multithreaded applications. See the last commit for a
reproducer. This prevents the module from being unloaded.

Historically there have been a few issues and fixes attempted around
here which have resulted in some extra logic and a member to keep
track of CTI being enabled 'struct coresight_device->ect_enabled'.
The fix in commit 665c157e0204 ("coresight: cti: Fix hang in
cti_disable_hw()") was also related to CTI having its own
enable/disable path which came later than other devices.

If we make CTI a helper device and enable helper devices adjacent to
the path we get very similar enable/disable behavior to now, but with
more reuse of the existing reference counting logic in the coresight
core code. This also affects CATU which can have a little bit of
its hard coded enable/disable code removed.

Enabling CATU on the generic path does require that input connections
are tracked so that it can get its associated ETR buffer.

Applies to coresight/next (669c4614236a7) but also requires the
realloc_array patch here [1].

Also available in full here [2].

[1]: https://lore.kernel.org/linux-arm-kernel/20230306152723.3090195-1-james.clark@arm.com/
[2]: https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-cti-module-refcount-fix-v2

James Clark (9):
  coresight: Use enum type for cs_mode wherever possible
  coresight: Change name of pdata->conns
  coresight: Rename nr_outports to nr_outconns
  coresight: Rename connection members to allow for input connections
  coresight: Dynamically add connections
  coresight: Store in-connections as well as out-connections
  coresight: Refactor out buffer allocation function for ETR
  coresight: Enable and disable helper devices adjacent to the path
  coresight: Fix CTI module refcount leak by making it a helper device

 drivers/hwtracing/coresight/coresight-catu.c  |  34 +-
 drivers/hwtracing/coresight/coresight-core.c  | 312 +++++++++++-------
 .../hwtracing/coresight/coresight-cti-core.c  |  56 ++--
 .../hwtracing/coresight/coresight-cti-sysfs.c |   4 +-
 drivers/hwtracing/coresight/coresight-cti.h   |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c |   3 +-
 .../coresight/coresight-etm3x-core.c          |   6 +-
 .../coresight/coresight-etm4x-core.c          |   6 +-
 .../hwtracing/coresight/coresight-platform.c  | 178 +++++++---
 drivers/hwtracing/coresight/coresight-priv.h  |   9 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   6 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   9 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  89 ++---
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 drivers/hwtracing/coresight/coresight-tpdm.c  |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |   3 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |   3 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |   3 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
 include/linux/coresight.h                     | 109 +++---
 21 files changed, 530 insertions(+), 314 deletions(-)

-- 
2.34.1

