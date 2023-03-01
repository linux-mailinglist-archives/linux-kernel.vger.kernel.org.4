Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C06A652F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCACBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCACBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:01:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474D71116E;
        Tue, 28 Feb 2023 18:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677636071; x=1709172071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HpxabiM1acdSdwfWAu6jEfJlRvw6++g6eFsBCHiaOiM=;
  b=bHlEysnrn/BYsuAitP5DOf+MZohNKhKfkEarupgTh4+guSOg033WFYtz
   kS+dYcMu6GUab24iALPaOfsn3VDqtUTlTAKDoY+F8Rd5ttlhoOZO0S10J
   luRlAxv5Osq7pURrIscJrdZss4rYA0ry5OB9uYxro8r7izb+FDl5aIp4v
   rxVb9tRc7xwEymoepRELtxbEbyTO6QzLzzWS/OWS1L/+UNSzHtVl3lb2m
   pemgAVWs2ltSA9N0epkS84K9nKoFdX5Qtc56jm6TBU03wyoB3AKmPSvDY
   oxtX894W2P+K3NFFMkC2GhdVjdVwXV2Oueav7Ajq69qt8eTx8+YIOxXrk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="420558397"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="420558397"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704639930"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704639930"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:09 -0800
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
Subject: [PATCH v3 0/8] Add Array BIST test support to IFS
Date:   Tue, 28 Feb 2023 17:59:34 -0800
Message-Id: <20230301015942.462799-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214234426.344960-1-jithu.joseph@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
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

Changes in v3
 - GregKH 
    -  Separating read-only fields from rw fields in
       struct ifs_device (patch 1/8)
    -  Remove the subdirectory intel_ifs/<n> for devicenode (patch 2/8)
    -  Replaced an enum with #define (patch 4/8)
 - Dave Hansen
    - Remove tracing patch
    - ifs_array_test_core() (patch 6/8)
        - fix an initialization bug
        - other suggested changes
    - Use basic types in ifs_array for first two fields. (kept
      the union to avoid type castings)

v2 submission:
Link: https://lore.kernel.org/lkml/20230214234426.344960-1-jithu.joseph@intel.com/

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

Jithu Joseph (8):
  platform/x86/intel/ifs: Reorganize driver data
  platform/x86/intel/ifs: IFS cleanup
  x86/include/asm/msr-index.h: Add IFS Array test bits
  platform/x86/intel/ifs: Introduce Array Scan test to IFS
  platform/x86/intel/ifs: Sysfs interface for Array BIST
  platform/x86/intel/ifs: Implement Array BIST test
  platform/x86/intel/ifs: Update IFS doc
  Documentation/ABI: Update IFS ABI doc

 arch/x86/include/asm/msr-index.h              |  2 +
 drivers/platform/x86/intel/ifs/ifs.h          | 62 +++++++++----
 drivers/platform/x86/intel/ifs/core.c         | 92 ++++++++++++++-----
 drivers/platform/x86/intel/ifs/load.c         |  8 +-
 drivers/platform/x86/intel/ifs/runtest.c      | 91 +++++++++++++++++-
 drivers/platform/x86/intel/ifs/sysfs.c        | 17 ++--
 .../ABI/testing/sysfs-platform-intel-ifs      |  8 +-
 7 files changed, 221 insertions(+), 59 deletions(-)

-- 
2.25.1

