Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB23732252
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbjFOWBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjFOWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:01:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE362967;
        Thu, 15 Jun 2023 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866464; x=1718402464;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=lZ52Uyzr79J6u7Q25jSEHwxvL9rBOICrMhEJ+YQMfOE=;
  b=N9VtrrL0zRoOUeDRhRE1UREOet2gs/QbM8zuszkIMQGsTx8idUjkQBJO
   2TSxTauzVBbtgRXIoWdQTKmG5zyjcNRqxDWnd0WAlXnizp7Y+y5RlH2ph
   kO7IjJMnhgEmbYkm17TC85OINmvX0ApH4fVadBqW5V5fhllPDRkNNWMqH
   +bXquAzSilYGDVp34P7eI67d37EYLl0jx0x5r05tfNmOdaZeLUZsTMBEN
   EJOrVcm6KJ6BJaMWDU5kQ8ZiHNqedLpm80xss5CDGrDsBczE1VGFMjfS2
   goiJeRAuwJqvPspNUPaJudRTYTen0UpV7bPawUkCY8kiNaw600FX+ksfL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343791121"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343791121"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715770085"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715770085"
Received: from smaurice-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.120.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:00 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
Date:   Thu, 15 Jun 2023 16:00:22 -0600
Message-Id: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPaJi2QC/x2NQQqDMBBFryKzdiAmVq1XKaXEOOpQEyWhQRDv7
 tDFX7wPj3dCosiUoC9OiJQ58RYEqrIAt9gwE/IoDFppo5rKYM749eQ/Mm93fNSdcd2oat0+QaT
 BJsIh2uAW0cJvXeXcI018/Cuv93XdGOiP7nUAAAA=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=lZ52Uyzr79J6u7Q25jSEHwxvL9rBOICrMhEJ+YQMfOE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCndXXwTsly/77OW2O/flsjQd6vDyiTYSTTdw7JrgQJnk
 u7tqAkdpSwMYlwMsmKKLH/3fGQ8Jrc9nycwwRFmDisTyBAGLk4BmMiirYwM94uWCrD/T7tUVyQu
 /Z/rbMmOF5+f8nw51Lr5VmvUz2c2lQz/DI1u2T1KWqE1rY7z7stD/zPc3oVZTq58l/v2SgTHrpN
 JfAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dax/kmem driver can potentially hot-add large amounts of memory
originating from CXL memory expanders, or NVDIMMs, or other 'device
memories'. There is a chance there isn't enough regular system memory
available to fit ythe memmap for this new memory. It's therefore
desirable, if all other conditions are met, for the kmem managed memory
to place its memmap on the newly added memory itself.

Arrange for this by first allowing for a module parameter override for
the mhp_supports_memmap_on_memory() test using a flag, adjusting the
only other caller of this interface in dirvers/acpi/acpi_memoryhotplug.c,
exporting the symbol so it can be called by kmem.c, and finally changing
the kmem driver to add_memory() in chunks of memory_block_size_bytes().

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Vishal Verma (3):
      mm/memory_hotplug: Allow an override for the memmap_on_memory param
      mm/memory_hotplug: Export symbol mhp_supports_memmap_on_memory()
      dax/kmem: Always enroll hotplugged memory for memmap_on_memory

 include/linux/memory_hotplug.h |  2 +-
 drivers/acpi/acpi_memhotplug.c |  2 +-
 drivers/dax/kmem.c             | 49 +++++++++++++++++++++++++++++++-----------
 mm/memory_hotplug.c            | 25 ++++++++++++++-------
 4 files changed, 55 insertions(+), 23 deletions(-)
---
base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
change-id: 20230613-vv-kmem_memmap-5483c8d04279

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

