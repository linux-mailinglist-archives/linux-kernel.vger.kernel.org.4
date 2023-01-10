Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9806663F04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjAJLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbjAJLIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:08:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCC7637524
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:08:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BEFE4B3;
        Tue, 10 Jan 2023 03:08:49 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF81B3F587;
        Tue, 10 Jan 2023 03:08:05 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com, mike.leach@linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] coresight: cti: Add PM runtime call in enable_store
Date:   Tue, 10 Jan 2023 11:07:33 +0000
Message-Id: <20230110110736.2709917-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:

  * Reword first commit message and add fixes tag
  * Pickup Jinlong's tested-by tags

----

This should be a slight improvement on Jinlong's previous version.
Now it's not possible to trigger the error message from
pm_runtime_put() by calling disable twice.

It's also similar to the original pre-breaking change version where
pm_runtime_put() was only called if the device was actually disabled,
but with one difference: Previously pm_runtime_put() was only called
once for the last disable call, but because of the reference counting
in pm_runtime, it should have been called once for each enable call.
This meant that the clock would have never been disabled if there were
ever multiple enable calls. This is now fixed.

The third commit is a refactor and doesn't need to be backported. I
removed one of the atomic types because it didn't appear to be
required. Maybe it was added for a reason which I'm not aware of, if
so it should be pretty easy to drop that change.

James Clark (2):
  coresight: cti: Prevent negative values of enable count
  coresight: cti: Remove atomic type from enable_req_count

Mao Jinlong (1):
  coresight: cti: Add PM runtime call in enable_store

 .../hwtracing/coresight/coresight-cti-core.c  | 23 ++++++++++++-------
 .../hwtracing/coresight/coresight-cti-sysfs.c | 15 +++++++++---
 drivers/hwtracing/coresight/coresight-cti.h   |  2 +-
 3 files changed, 28 insertions(+), 12 deletions(-)


base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
-- 
2.25.1

