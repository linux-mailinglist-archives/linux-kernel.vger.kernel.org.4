Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6734B70F665
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjEXM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjEXM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:29:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33839C;
        Wed, 24 May 2023 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684931340; x=1716467340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3klnhOKosPwBrT++R5pTUO9av0C/hZmrxntxsqOzxiU=;
  b=nje+pa1NGxrkqlS80MrM4SxdlBDPPto0Z2IYecZ3N7etZrbKhquZcj95
   +YX4AeRlN+45UZTRC6lq2jbFlwAsKK6eUoDZwDT8/tskbrci5xNFUrI5D
   0Fi5jT8zYdLMr1GZVMGXqXnPD+JaLUsgSQT+Rkawk8nAeoY1BIj4KNbJI
   nUiQJJ43YuR4Y/OE/VIEY+pDKxfOY17vSuS8DMJ3YAHrFMclNabHPlOJN
   FuA/kzvsBuv0VWYFkYwRvh9yWiLyEQEQVIVaZ5rMjWkRibDlhEx82EDZQ
   IM972nvnwFYawOYt+3urxR6IRVRFh4hQBtp3EISQTfieNsrrsuocUyIAL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="333904880"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="333904880"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 05:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="848731372"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="848731372"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2023 05:28:58 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] usb: typec: mux: Remove the "svid" device property checks
Date:   Wed, 24 May 2023 15:28:59 +0300
Message-Id: <20230524122901.53659-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The background for this change:
https://lore.kernel.org/lkml/20210726231351.655302-1-bjorn.andersson@linaro.org/

The idea with that device property was that it would allow us to
support separate mode specific switches behind a single port if
necessary.

Although, I guess it is still possible that we could have that kind of
separate mode switches, especially now that the mode switch represents
a kind of virtual aggregate device that can be build from multiple
physical muxes (so the modes could need different "combos" of the
muxes), but now no such systems exist.

We can look at how to handle that kind of switches when/if we actually
have them, but for now, keeping the functions as simple as possible.

thanks,

Heikki Krogerus (2):
  usb: typec: mux: Clean up mux_fwnode_match()
  usb: typec: mux: Remove alt mode parameters from the API

 drivers/platform/chrome/cros_ec_typec.c |  2 +-
 drivers/soc/qcom/pmic_glink_altmode.c   |  5 +-
 drivers/usb/typec/class.c               |  4 +-
 drivers/usb/typec/mux.c                 | 61 ++++---------------------
 include/linux/usb/typec_mux.h           | 11 ++---
 5 files changed, 17 insertions(+), 66 deletions(-)

-- 
2.39.2

