Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF971274E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbjEZNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbjEZNOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:14:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A513A;
        Fri, 26 May 2023 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685106873; x=1716642873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P3aDrbgWsczzMF6L7QMUDAva/xddidPwaE1GdyMC7Bk=;
  b=Qgim3uNW1dZ4pBgLuymhmrlE9DdrSZj5xSLr7T1XTGCiyWfFBfihC5Ri
   t8l4ecrTmNMcFYjFhFQvS46XfOq7kUJgImbR3c9heJMh4SxqtsosW0ujt
   ggB9bbefuQHOfsi4jG8pVLXbeB2ohkloiv/N8MR5LcXsu7WxKtMRv5jkM
   YMkeKxxT2znhlj0tbk6K6l5ooUheAmw9gvQhfZ0Myd/hDIdnWuFVGZxdc
   YJsyTc9jXJ0FW8kOcuANyZzVrfACLzJ25yqeF2vF+JU+axA0ZCnelif2o
   eTNyzTW3xv3pIqm9lEB3lloqvRczUbK+Hz2ifMhSfdyKbc9EQO6yGVqLn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="419955091"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="419955091"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 06:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="849555262"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="849555262"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2023 06:14:30 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] usb: typec: mux: Remove the "svid" device property checks
Date:   Fri, 26 May 2023 16:14:32 +0300
Message-Id: <20230526131434.46920-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The comment in the first patch is now fixed as requested by Bjorn. No
other changes compared to v1.

Original message:

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

