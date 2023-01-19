Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F9674097
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjASSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjASSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:12:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EA126B4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674151953; x=1705687953;
  h=resent-from:resent-date:resent-message-id:resent-to:from:
   to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZQv7ckOWXUugQsn2n86dUai3CBZCoAI9JjoSBknnenY=;
  b=G40gK9LgIlaBkD6wHTWDyIcejY762FAzLUh3F0kh9DXW/m5dG3+vSTk5
   Fb6kI4shOS7j5ICPsJhPNCLLlCxAgmhwIUHxGzlTMZe/wbuZIcJ4hB/n/
   XnFNF2WN61m9Qxk0NxQ5td7ZXZO/PWrZrHFi+qwofB4cZZvzLm7hJW5/s
   tjwHuWEszPLfLtrUV2gYGpJd7I47HaJ6CPpE4a2MTaa1y3wON8+ld4mYC
   hQVhluLeMi7KYB2o7/vV3igpbgulr2GSh8RV0lbSOagAxkRFyIbcYQAeo
   qOafpdLnHxsdE4k2e+1r3ExbhZzIDyqbwhftr2/XagYuyHBsSbbSYO80V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305736630"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305736630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:12:33 -0800
X-ExtLoopCount2: 2 from 10.237.72.184
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802737551"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="802737551"
Received: from ubik.fi.intel.com (HELO ubik) ([10.237.72.184])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 10:12:32 -0800
Received: from ash by ubik with local (Exim 4.96)
        (envelope-from <alexander.shishkin@intel.com>)
        id 1pIZOX-00EPGt-1H
        for linux-kernel@vger.kernel.org;
        Thu, 19 Jan 2023 20:12:13 +0200
X-Original-To: alexander.shishkin@linux.intel.com
Received: from linux.intel.com [10.54.29.200]
        by ubik.fi.intel.com with IMAP (fetchmail-6.4.29)
        for <ash@localhost> (single-drop); Thu, 19 Jan 2023 15:59:02 +0200 (EET)
Received: from fmsmga005.fm.intel.com (fmsmga005.fm.intel.com [10.253.24.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 77D81580AE0;
        Thu, 19 Jan 2023 05:57:03 -0800 (PST)
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
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

