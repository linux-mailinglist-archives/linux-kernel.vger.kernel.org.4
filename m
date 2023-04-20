Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE76E9E91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjDTWGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjDTWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066F270C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028405; x=1713564405;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g3FMFKUCVIXdVzkDlC27WDztHXzS33jMW7rPh/kfnX0=;
  b=E0b93rmLIQYwt4C8WAgnU/Rwoh04Fbr8CyxPuXHglouTwzLTn+pcJuRk
   ytg1bKBtSRvcImSpQtBcEXR0JE1dJpKmqBx+HSR0eBSorI00hvX1uwVz4
   07yDsV1JlHgld6UduP44Hgf/JBvZpksIYIEUwOL1TYNHZ4pcupYE//YFc
   23Gp81SG/vLTnscokNTaq1himp+TaOQVgf6lMo1bq6lbBx6ZF2SkXrPI/
   17rr5pnVwigc23R4fu+cMnkwHGSTgFgxdnRDs4lcvZbfgES1f9SKECL09
   rbGc/rwPXZTywPQw3JlZhK9v9WuG4nLqsUEKyt+MGcF+GKRx00fXFOtFP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650885"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650885"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583746"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583746"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:44 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Date:   Thu, 20 Apr 2023 15:06:29 -0700
Message-Id: <20230420220636.53527-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very much proof of concept code at this stage. I have a few
quality of service features that are hard to intergrate into the core
resctrl code because they are model specific, or have input parameters
that do not fit neatly into the existing schemata model.

Also, as AMD, ARM, and now RISC-V are looking to share the core resctrl
code, it might be helpful to have "driver" as a software layer for
per-CPU architectural code to avoid cluttering the core.

None of my drivers are ready to post, so this series has a simple example
driver that would meet the same debug requirements of Babu Moger's
patch to expose the CLOSID/RMID in files in each directory:

  https://lore.kernel.org/all/168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu/

Doing this debug with a driver that can be loaded unloaded without
having to unmount and remount the resctrl file system appears slightly
more convenient that a "-o debug" option. But this example driver is
really intended just as a toy example of what can be done.

The series is broken into steps that add callback functions into various
different parts of the resctrl hierarchy. That list of parts has been
driven by the needs of the drivers that I want to write. The
registration interface could be extended if there are additional
hooks need for other drivers.

I'm looking for high level comments on the desireability of this approach
at this time. I don't expect any of this to be merged until I have some
real drivers that use this to offer to upstream.

Tony Luck (7):
  x86/resctrl: Add register/unregister functions for driver to hook into
    resctrl
  x86/resctrl: Add an interface to add/remove a new info/directory
  x86/resctrl: Add driver callback when directories are removed
  x86/resctrl: Add capability to driver registration to create control
    files
  x86/resctrl: Enhance driver registration to hook into schemata files
  x86/resctrl: Allow a device to override an existing schemata entry
  x86/resctrl: Example resctrl driver

 include/linux/resctrl.h                       |  37 +++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  17 +-
 .../cpu/resctrl/drivers/resctrl_example.c     |  77 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 227 ++++++++++++++++++
 arch/x86/Kconfig                              |  11 +
 arch/x86/kernel/cpu/resctrl/Makefile          |   1 +
 arch/x86/kernel/cpu/resctrl/drivers/Makefile  |   1 +
 7 files changed, 368 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/resctrl/drivers/resctrl_example.c
 create mode 100644 arch/x86/kernel/cpu/resctrl/drivers/Makefile


base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
-- 
2.39.2

