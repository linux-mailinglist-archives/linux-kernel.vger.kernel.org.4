Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A5697202
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjBNXp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNXpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:45:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23B2BF18;
        Tue, 14 Feb 2023 15:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676418354; x=1707954354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Cj3Syzv7QMiztKpNMcsBxv1om5/0tyCLVQ/++gUu1s=;
  b=kLPYhL30fEsjfU0qBIwB3xsCf6gGG2xcOwVRzePZib+NGDsisxJCQYpY
   2gu0CLIxhQmv6oGrK8A387qy/FXBccjRRSQAUMr/+kHi9qCHMHGJOw4y3
   pRNXzdsOVa4uQevr2RnaoulJtXLcPIXk8fSAI1FyyI9NKABJVf7q1X7QC
   HOz4lqgnHevl6t114dfMcD98bHD9iGO9bnxquZBDMguV6wxg30hnyPvvs
   rNjoXthJfRlkGuAGh3m9XwXUKv7FYlb0JtRbd3H14ktn1yEDvnUctMgMp
   LtchQeRqD7ES28+97hm3lhRab85U9fALiMuF015+BAwgAW3qxKsDYsOIo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417522981"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="417522981"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669391003"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="669391003"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:52 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 0/7] Add Array BIST test support to IFS
Date:   Tue, 14 Feb 2023 15:44:19 -0800
Message-Id: <20230214234426.344960-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131234302.3997223-1-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2
 - remove duplicate initializations from ifs_array_test_core()
   (Dave Hansen, patch 4/7)
 - remove bit parsing from tracing fast path to tracing 
   output (Steven Rostedt, patch 5/7)
 - move "ATTRIBUTE_GROUPS(plat_ifs_array)" to core.c and remove
   exporting function ifs_get_array_groups() (Greg KH, patch 3/7)
 - Generalized doc and ABI doc (Greg KH, patches 6/7 and 7/7)

v1 submission:
Link: https://lore.kernel.org/lkml/20230131234302.3997223-1-jithu.joseph@intel.com/

Array BIST is a new type of core test introduced under the Intel Infield
Scan (IFS) suite of tests.

Emerald Rapids (EMR) is the first CPU to support Array BIST.
Array BIST performs tests on some portions of the core logic such as
caches and register files. These are different portions of the silicon
compared to the parts tested by Scan at Field (SAF).

Unlike SAF, Array BIST doesn't require any test content to be loaded.

Jithu Joseph (7):
  x86/include/asm/msr-index.h: Add IFS Array test bits
  platform/x86/intel/ifs: Introduce Array Scan test to IFS
  platform/x86/intel/ifs: Sysfs interface for Array BIST
  platform/x86/intel/ifs: Implement Array BIST test
  platform/x86/intel/ifs: Trace support for array test
  platform/x86/intel/ifs: Update IFS doc
  Documentation/ABI: Update IFS ABI doc

 arch/x86/include/asm/msr-index.h              |   2 +
 drivers/platform/x86/intel/ifs/ifs.h          |  41 +++++--
 include/trace/events/intel_ifs.h              |  25 +++++
 drivers/platform/x86/intel/ifs/core.c         |  85 ++++++++++-----
 drivers/platform/x86/intel/ifs/runtest.c      | 102 +++++++++++++++++-
 drivers/platform/x86/intel/ifs/sysfs.c        |  10 +-
 .../ABI/testing/sysfs-platform-intel-ifs      |   8 +-
 7 files changed, 233 insertions(+), 40 deletions(-)


base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
-- 
2.25.1

