Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1027168F0A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBHOYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:24:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191E11E8A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675866267; x=1707402267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l8OzFhxngZYX4NnqjOn64PeQL+wu2czbjPojmTNtOfQ=;
  b=lp3IMl0YB8fPBq9+MzZ6hj1SjeZHWchHpxMoYl11GEiehYDoUkNLtnNs
   2WzbIqpT/ZuyIz6dBD/6emwjtqMslzzeE71/AvhUQFfOmnIsADpZCBD3O
   g1rycFNf+XS1MB0K9odKDBZITaiqYY+77AxQhpPDTE/7tphkhNrEOsp8C
   wuPp9ashHpB1E9gyoM0GiUZmPnaiM1LXi1v9XrrhTV7KybtLCSRmDmmE9
   oiapKqwImPSwKhDAkVrMLF55V5EkMHVqO93tntzL8QYrVBQrb5NKKTH7w
   D4qtGYpwtljrAW9Spim3P11HaAnpMa8oh8WmotXU+16A85nyfXIrLT1IP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392201352"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="392201352"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 06:24:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="791214071"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="791214071"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 06:24:13 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Ceraolo Spurio Daniele <daniele.ceraolospurio@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v3 0/2] mei: gsc proxy component
Date:   Wed,  8 Feb 2023 16:23:56 +0200
Message-Id: <20230208142358.1401618-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSC Proxy component is used for communication between the
Intel graphics driver and MEI driver.

Daniele, please ack so that drm part can be merged via Greg's tree.

V2:
1. Add missing patch from the series
2. Use device information instead of driver name
   to identify the aggregate device.
V3:
1. Drop MAINTAINERS update
2. Add gfx mailing list and maintanier


Alexander Usyskin (2):
  drm/i915/mtl: Define GSC Proxy component interface
  mei: gsc_proxy: add gsc proxy driver

 drivers/misc/mei/Kconfig                   |   2 +-
 drivers/misc/mei/Makefile                  |   1 +
 drivers/misc/mei/gsc_proxy/Kconfig         |  14 ++
 drivers/misc/mei/gsc_proxy/Makefile        |   7 +
 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 208 +++++++++++++++++++++
 include/drm/i915_component.h               |   3 +-
 include/drm/i915_gsc_proxy_mei_interface.h |  36 ++++
 7 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/mei/gsc_proxy/Kconfig
 create mode 100644 drivers/misc/mei/gsc_proxy/Makefile
 create mode 100644 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
 create mode 100644 include/drm/i915_gsc_proxy_mei_interface.h

-- 
2.39.1

