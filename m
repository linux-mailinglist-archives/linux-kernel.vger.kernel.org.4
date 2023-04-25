Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A116EE402
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjDYOgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDYOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:36:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BBC94EC0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:36:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B59C74B3;
        Tue, 25 Apr 2023 07:36:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CF693F587;
        Tue, 25 Apr 2023 07:36:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/13] coresight: Fix CTI module refcount leak by making it a helper device
Date:   Tue, 25 Apr 2023 15:35:27 +0100
Message-Id: <20230425143542.2305069-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v5:

 * Formatting fixes
 * helper->type != CORESIGHT_DEV_TYPE_HELPER -> !coresight_is_helper()
 * Remove ect from coresight_dev_type and add a static assert so that
   it stays in sync with the enum

------------------

Changes since v4:

 * Update commit message on patch 1
 * Drop previous change that added lockdep checks to coresight_add_helper()
   because they are already in mutex_lock(). But keep extra comment.
 * Check for allocation failure in coresight_add_out_conn()

------------------

Changes since v3:

 * Put connection loss fix at the beginning so that it can be backported
 * Replace coresight_find_link_{x}() with coresight_find_out_connection()
 * Reorder coresight_enable_source() arguments for consistency
 * Add source and destination reference counts so that two link devices
   connected together don't clash
 * Add coresight_is_helper()
 * Fix overwriting csdev bug in coresight_orphan_match()
 * Don't clear conns[i]->dest_fwnode in coresight_remove_conns() in case
   it's used again
 * Use dev instead of adev->dev for devmem allocation in
   acpi_coresight_parse_graph() so that it's consistent with DT mode and
   doesn't cause a warning on free.
 * Rename coresight_add_helper_mutex() -> coresight_add_helper()
 * Ensure coresight_mutex isn't already held in coresight_add_helper()
 * Return new connection from coresight_add_out_conn()
 * Comment and formatting improvements

------------------

Changes since v2:

 * Make out_conns array contiguous instead of sparse which simplifies
   filling and using it. New connections are always added to the end
 * Store pointers to individual connection objects so that they can be
   shared between inputs and outputs
 * Fix an existing bug where connection info was lost when unloading a
   device
 * Simplify connection fixup functions. Now the orphan mechanism is used
   for inputs in the same way as outputs to guarantee that all
   connections have both an input and an output set
 * Use input connections to disconnect devices on unload instead of
   iterating through them all
 * Make refcount a property of the connection rather than use it's own
   array based on the number of inputs and outputs
 * Fix a bug in v2 where helpers attached to the source device weren't
   disabled because coresight-etm-perf.c was making a raw call to
   disable rather than using a helper.
 * Change names of connection members to make direction explicit now
   that the connection is shared between input and outputs
   
------------------

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

Applies to coresight/next (18996a113f256) but everything except the
first fixes commit requires the realloc_array patch here [1].

Also available in full here [2].

[1]: https://lore.kernel.org/linux-arm-kernel/20230320145710.1120469-1-james.clark@arm.com/
[2]: https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-cti-module-refcount-fix-v6

James Clark (13):
  coresight: Fix loss of connection info when a module is unloaded
  coresight: Use enum type for cs_mode wherever possible
  coresight: Change name of pdata->conns
  coresight: Rename nr_outports to nr_outconns
  coresight: Rename connection members to make the direction explicit
  coresight: Dynamically add connections
  coresight: Store pointers to connections rather than an array of them
  coresight: Simplify connection fixup mechanism
  coresight: Store in-connections as well as out-connections
  coresight: Make refcount a property of the connection
  coresight: Refactor out buffer allocation function for ETR
  coresight: Enable and disable helper devices adjacent to the path
  coresight: Fix CTI module refcount leak by making it a helper device

 drivers/hwtracing/coresight/coresight-catu.c  |  21 +-
 drivers/hwtracing/coresight/coresight-core.c  | 605 +++++++++---------
 .../hwtracing/coresight/coresight-cti-core.c  |  52 +-
 .../hwtracing/coresight/coresight-cti-sysfs.c |   4 +-
 drivers/hwtracing/coresight/coresight-cti.h   |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  13 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   4 +-
 .../coresight/coresight-etm3x-core.c          |   6 +-
 .../coresight/coresight-etm4x-core.c          |   6 +-
 .../hwtracing/coresight/coresight-funnel.c    |  26 +-
 .../hwtracing/coresight/coresight-platform.c  | 269 +++-----
 drivers/hwtracing/coresight/coresight-priv.h  |  17 +-
 .../coresight/coresight-replicator.c          |  23 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   6 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |  17 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  26 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 110 ++--
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 drivers/hwtracing/coresight/coresight-tpda.c  |  23 +-
 drivers/hwtracing/coresight/coresight-tpdm.c  |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |   7 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |   3 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  11 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
 include/linux/coresight.h                     | 126 ++--
 25 files changed, 714 insertions(+), 673 deletions(-)

-- 
2.34.1

