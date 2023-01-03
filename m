Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F465BE6F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbjACKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjACKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:51:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566C2EB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672743088; x=1704279088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wZIzAnD2Xss5kwfCgAar7pXr1H0VlnByMy323xYAXro=;
  b=WJsjIH2WiNpXNMCucqncfJd7WgkiJIJ6FdT8okx53lhfJbayz5aWMZW+
   oVZ9Rxqyp3ZU4KTmES05IN508MX3Hj381+ApbMhALm5mNZgn3qbKd6S5x
   jssJr12lE70MsC1UrqL9111q2OvDXJzPigbSvnZ1A2j6fTwHGsl7WKv7J
   YCzDIZAUyFR71eBc4mPXvNkne8DHUOBGSMpLHfIcPadLifqVBENMw0LZT
   LpKyiRk3G9hhLTqrZ9eQ/TU9Rk6+uuZdNM7AkzMVM3CLiHWrRRaPPvVMu
   MCZpZTjxX3yLcaKDU22mooNsKTNW6EZ8/KA0D3FbWjdQaELlRw8Lvk9Zy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301318421"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="301318421"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604772632"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="604772632"
Received: from isobansk-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.24.246])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:25 -0800
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v6 0/4] vdpa: Add resume operation
Date:   Tue,  3 Jan 2023 11:51:04 +0100
Message-Id: <cover.1672742878.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

This series introduces a new operation for vdpa devices. It allows them
to be resumed after they have been suspended. A new feature bit is
introduced for devices to advertise their ability to be resumed after
they have been suspended. This feature bit is different from the one
advertising the ability to be suspended, meaning a device that can be
suspended might not have the ability to be resumed.

Even if it is already possible to restore a device that has been
suspended, which is very convenient for live migrating virtual machines,
there is a major drawback as the device must be fully reset. There is no
way to resume a device that has been suspended without having to
configure the device again and without having to recreate the IOMMU
mappings. This new operation aims at filling this gap by allowing the
device to resume processing the virtqueue descriptors without having to
reset it. This is particularly useful for performing virtual machine
offline migration, also called snapshot/restore, as it allows a virtual
machine to resume to a running state after it was paused and a snapshot
of the entire system was taken.

Sebastien Boeuf (4):
  vdpa: Add resume operation
  vhost-vdpa: Introduce RESUME backend feature bit
  vhost-vdpa: uAPI to resume the device
  vdpa_sim: Implement resume vdpa op

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 +++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
 drivers/vhost/vdpa.c             | 34 +++++++++++++++++++++++++++++++-
 include/linux/vdpa.h             |  6 +++++-
 include/uapi/linux/vhost.h       |  8 ++++++++
 include/uapi/linux/vhost_types.h |  2 ++
 6 files changed, 78 insertions(+), 2 deletions(-)

-- 
2.37.2

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 5 208 026.16 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

