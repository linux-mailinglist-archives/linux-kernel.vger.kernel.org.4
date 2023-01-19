Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602CC674ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjATEgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjATEgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:36:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A1B27BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189238; x=1705725238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZQv7ckOWXUugQsn2n86dUai3CBZCoAI9JjoSBknnenY=;
  b=MRSG+j0d0Xe18lKarcdce4Sboq3bLElIZhQnp96mSnAY7DyDSXo23rVG
   FCN5cDgq4Wql1+RGOcAbc4o5VG5FRRRXrfr2Mpjqn75vDS97HIG9GL91e
   t0RSEAFCOQANPv35jNN6G2fgKxCHG/l4YU+T22XJ5Yv5QBYYRqeqnPPvw
   SRP2dYVmks2gdzeAK3WluFf529pNE3SPg/PcbH5sw0Y+YP3QXls46vLF3
   qFSVAvURWPnrPqPKc+syQ48aPqM6fHa1R1+JPL9FklVIwk3vOhnjHj+Jw
   BJSpDkK8FVKbvSXA2qw79tKKQ000Ns4Oey8pGuriLct4IESDsF0uSQfKc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411526078"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="411526078"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 05:57:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988993903"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="988993903"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 05:57:01 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 0/6] Harden a few virtio bits
Date:   Thu, 19 Jan 2023 15:57:15 +0200
Message-Id: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 6 patches that harden console, net and 9p drivers against
various malicious host input as well as close a bounds check bypass
in the split virtio ring.

Changes since previous version:
 * Added Christian's R-B to 3/6
 * Added a speculation fix per Michael's comment on the cover letter
 * CC'ing lkml

Alexander Shishkin (3):
  virtio console: Harden control message handling
  virtio_net: Guard against buffer length overflow in
    xdp_linearize_page()
  virtio_ring: Prevent bounds check bypass on descriptor index

Andi Kleen (3):
  virtio console: Harden multiport against invalid host input
  virtio console: Harden port adding
  virtio 9p: Fix an overflow

 drivers/char/virtio_console.c | 19 ++++++++++++-------
 drivers/net/virtio_net.c      |  4 +++-
 drivers/virtio/virtio_ring.c  |  3 +++
 net/9p/trans_virtio.c         |  2 +-
 4 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.39.0

