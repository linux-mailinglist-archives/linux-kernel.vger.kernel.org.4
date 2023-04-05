Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C586D81CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbjDEP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbjDEP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:27:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E9F65A6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680708472; x=1712244472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jFz3mcuwvxLK4peDOd1fOVOYB1iBDnaLvmVg+Ie6v6g=;
  b=SQlBhL8GHnfCWQg9v66bA5R06Tur5fifNzzNgrdVBl1YRQ9SM9ENQHMe
   dUpj5ADl5/ckkQJ7xlaMJ57yqm0Xr5+EyneMwfjEEnZoDwlm4SGu+vZvR
   NEu/pS6gSB3MLUeJQYb9UySQ4OcARlyFwBpzqIRY+UgGnSE/YHTP3S+y7
   Gygj4mUcsGHLac+MKVfJkChrFAV/CkxQRZhaFogVkmEb/2Mt2RQANomIv
   HgSOew46mmROqd/FFDkAd5+NuD/Y31aHMzBk7vaYNMdiQVwgXFz0rREsp
   TdXnlbpmHJheP8EdAnKPGF46QLtJRZAyx3S6ttaTecXkjJFONK7CYjvIm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="405261162"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="405261162"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="797951017"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="797951017"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2023 08:27:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 968F01D5; Wed,  5 Apr 2023 18:27:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cwchoi00@gmail.com>
Subject: [PATCH v2 0/5] extcon: Core cleanups and documentation fixes
Date:   Wed,  5 Apr 2023 18:27:40 +0300
Message-Id: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few fixes and some cleanups against extcon core module.

Changelog v2:
- dropped applied patches
- completely rewrote the patch to handle name field
- dropped kasprintf_strarray() patch for now (Chanwoo)
- used new IDA APIs (Chanwoo)
- added tag (Bumwoo) to the patches that haven't changed

Cc: Chanwoo Choi <cwchoi00@gmail.com>

Note, MAINTAINERS shows what it has and hence the above Cc is manually
added. If the database has issues it should be updated, but it's out of
scope of this series.

Andy Shevchenko (5):
  extcon: Make the allocation and freeing to be private calls
  extcon: Get rid of not really used name field in struct extcon_dev
  extcon: Use unique number for the extcon device ID
  extcon: Use sizeof(*pointer) instead of sizeof(type)
  extcon: Drop unneeded assignments

 drivers/extcon/extcon.c         | 48 ++++++++++++++++-----------------
 drivers/extcon/extcon.h         |  9 ++++---
 include/linux/extcon-provider.h |  9 -------
 3 files changed, 30 insertions(+), 36 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

