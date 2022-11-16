Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC662B457
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiKPH5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKPH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:57:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361D23154;
        Tue, 15 Nov 2022 23:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668585469; x=1700121469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O9Hb/seFZgmAzrbGw37aYXMPN6dUPFoKLlp7bI7fqcs=;
  b=Gryle1FRQHiwzW0IilMGp5ohGldJcDQ7xy73p1PdMgq6MGzr42S/tzWZ
   kcrdU/tHhx+iC5bT4OPhpwyxEjK3KiMDKJyAXnFk1YqvyFg5kDW+CF9+e
   feF/AJiFSr5gCCJ8jx2ZD3P31BJ4iLzK9kPej3u1bVGoAmBZcv2caROBX
   p4Ozai135sKcs4P/cbIX2T/UJnARYXYaQ7BQ9ccH2/FfpBh+lVWQJRAU4
   oSJ8Be4AVBMaL9WaCsPjLtqQ2pktNWO4rslYBKY9KPxy7sMc/IhIZ854M
   p8fnro2ypX6nl75ZpJs2+xXtaup6kH4BgKIRxzLPRtn93qUjlIav8rKN7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398767157"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398767157"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 23:57:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702769361"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702769361"
Received: from ake-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.189.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 23:57:48 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-acpi@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, liushixin2@huawei.com,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/2] ACPI: HMAT: fix single-initiator target registrations
Date:   Wed, 16 Nov 2022 00:57:34 -0700
Message-Id: <20221116075736.1909690-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=533; h=from:subject; bh=O9Hb/seFZgmAzrbGw37aYXMPN6dUPFoKLlp7bI7fqcs=; b=owGbwMvMwCXGf25diOft7jLG02pJDMkl0z+0n5Rd0mUS/a/ilf0+P0HJpMJrP207rmsxaLvuPHGD z+p9RykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACZyXJbhv9P3fVOdRRa3cmeFOSg+Su wWzL0vtdZ9IndjUOGh/dY3UxgZ5n16MNvp2M3vFafNj5+K5toReiJau3+yqJ/f7c0BWcVl/AA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is an obvious cleanup found while fixing this problem.

Patch 2 Fixes a bug with initiator registration for single-initiator
systems. More details on this in its commit message.


Vishal Verma (2):
  ACPI: HMAT: remove unnecessary variable initialization
  ACPI: HMAT: Fix initiator registration for single-initiator systems

 drivers/acpi/numa/hmat.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.1

