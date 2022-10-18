Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72DA60271D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJRIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJRIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:37:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F061B0D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666082260; x=1697618260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nvFiXqf6TNu5W6qNejIJGhy4YQBn15VbmGk6jolXYYE=;
  b=AsJQLWIqOWlO54hScj/qoKesGlqiwLCTBBjkBwytrv5/Re6nG+kKRLQo
   gptgpgHp3XbPKBd1VuH3PebboSFAOErKkeBT0YIgIx+XoCB67oxV3jddt
   uh7mMaD6e6AbaIpNKab1mIPa7p0BQxOhDCqqqlxkbI+Jwwb1NqZH53Qv4
   JScOYPiJPFAn2NX5hCy3MXxmBSJjUfGzv1dCqOj5HuuTQbP+e7QNHJSN9
   7YwDf9UNvvFgWQ7GbethJdKfmb9s2Rq+vFFgFgoiBfknkv9l9rqIIzMD3
   1WfpWldTkjzh5F8U0dyD1lzREdzK4uvQAHvaYNGiMFkPxcdnsXeNcMOFV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307125410"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307125410"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:37:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753950970"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="753950970"
Received: from aboyhan-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.26.192])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:37:37 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v4 0/4] vdpa: Add resume operation
Date:   Tue, 18 Oct 2022 10:37:23 +0200
Message-Id: <cover.1666082013.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 +++++++++++++
 drivers/vhost/vdpa.c             | 34 +++++++++++++++++++++++++++++++-
 include/linux/vdpa.h             |  6 +++++-
 include/uapi/linux/vhost.h       |  8 ++++++++
 include/uapi/linux/vhost_types.h |  2 ++
 5 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.34.1

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

