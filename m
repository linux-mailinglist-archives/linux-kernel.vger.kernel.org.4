Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9960E427
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiJZPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiJZPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:09:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B9C127BF0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666796945; x=1698332945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=62EEeHFIFvNePFRXuLw6f58S0gqeX4x3gcIuZ+jLCDc=;
  b=N46JMxr3FqlcDpHAE/M8oHToYw9pUKuV02mGHpIK5Rk2nsKYTXM5jqcT
   dTl3MFcxC1hJLVX2UopVHiFARzlwh/bZT7tzdEWrKIyWClVYNYOfpvm/e
   5TeQkuPEgB31bGpgRizNk6+TfDaCk6nEBTtdLNykEyLEzYcM29HkS+saY
   DaZkT3hU8XsQPPynqQBCkPSo6HU8NQIN+dwxAc+0ZVq9BimFDdhzX7kyj
   jfcOQsyE0wH2N2050tOmmtBQWPYP5J8P73Q45K3/P31XnzzQeLaue7UuP
   5N7aRSw5FfmVU7jpiAjYwmxOGRXk336WHGEdVM7shs1DhHu3qASlZb/2k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="307963182"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="307963182"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:08:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961252418"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="961252418"
Received: from briansim-mobl.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.29.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:08:44 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v5 0/4] vdpa: Add resume operation
Date:   Wed, 26 Oct 2022 17:08:34 +0200
Message-Id: <cover.1666796792.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
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

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 ++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
 drivers/vhost/vdpa.c             | 34 +++++++++++++++++++++++++++++++-
 include/linux/vdpa.h             |  6 +++++-
 include/uapi/linux/vhost.h       |  8 ++++++++
 include/uapi/linux/vhost_types.h |  2 ++
 6 files changed, 77 insertions(+), 2 deletions(-)

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

