Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3C5B8D14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiINQbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiINQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:31:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A691ADA2;
        Wed, 14 Sep 2022 09:29:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 445D81576;
        Wed, 14 Sep 2022 09:29:54 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.78.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B97853F73D;
        Wed, 14 Sep 2022 09:29:45 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Save cpuhp dynamic state
Date:   Wed, 14 Sep 2022 18:28:13 +0200
Message-Id: <20220914162815.1954866-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting a CPUHP_AP_ONLINE_DYN cpuhp state reserves a state
among the range [CPUHP_AP_ONLINE_DYN:CPUHP_AP_ONLINE_DYN_END].
The reserved state must be saved in order to remove it later.

Cf. __cpuhp_setup_state_cpuslocked() documentation:
Return:
  On success:
    Positive state number if @state is CPUHP_AP_ONLINE_DYN;
    0 for all other states

Indeed, the following:
  cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
removes the first dynamic states added to the cpuhp state machine.

Patches were tested as:
- powercap/drivers/dtpm: on a Juno-r2, using a late_initcall()
  to init and exit the dtpm framework.
- driver: soc: xilinx: the patch was only compile tested
  due to missing hardware.

Pierre Gondois (2):
  driver: soc: xilinx: Save cpuhp dynamic state
  powercap/drivers/dtpm: Save cpuhp dynamic state

 drivers/powercap/dtpm_cpu.c             |  7 ++++++-
 drivers/soc/xilinx/xlnx_event_manager.c | 12 ++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.25.1

