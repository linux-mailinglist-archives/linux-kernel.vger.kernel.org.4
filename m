Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D474AC70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjGGIDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGIDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:03:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219A10F5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688717001; x=1720253001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NhpaMvrGZ88hT0IQeDSciWmgaq3CRcYsQQIzgl3HcaU=;
  b=BxHvRWl+YssVIS8y0Pywa2xNCo9JsUzcWpL4RCZsPqVaQG96fPYzPqSZ
   M6qRF3KlqC3TFy2/Vv2o8ajJTITI3ja6VuPl+fNqOI8HjTv1Hz5AiNj2v
   N79gb+3iq2ApFHdUwtisji1DhCSyJXb3mQXjv066ukE6Pa6ECY1D3xBt7
   zgHh74a5c8OiHpyxP6QjuhQtQ7ScwuCUlAgmWuYMw6z1cgEXXrBI3oYwu
   sqLPqOv0t5JXhJ7Ne9tPViF3wCf4x7bWSSg09Ehy9Nafrht8aWbGqFVBD
   hNLOsnGz3xp8GhVQN+PacKechEvUyw1PFXyCZBXhfZDYfGtN7FvIfA0W3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363869954"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="363869954"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="670073868"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="670073868"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2023 01:03:18 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 0/2] Query the RSU SPT table offset to determine RSU page size
Date:   Fri,  7 Jul 2023 16:01:14 +0800
Message-Id: <20230707080112.1722827-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Hi,
This patchset is to add the generic mailbox command in the svc driver
to enable the rsu driver to query spt address.
SPT0 address - lower range & SPT1 address - upper range address will be
queried in order to determine the page size of RSU, whether it is
32kB or 64kB that is supported.

Thanks,
KJ

Radu Bacrau (1):
  firmware: stratix10-rsu: query spt addresses

Teh Wen Ping (1):
  firmware: stratix10-svc: Generic Mailbox Command

 drivers/firmware/stratix10-rsu.c              | 100 +++++++++++++++++-
 drivers/firmware/stratix10-svc.c              |  18 ++++
 include/linux/firmware/intel/stratix10-smc.h  |  25 +++++
 .../firmware/intel/stratix10-svc-client.h     |   5 +
 4 files changed, 147 insertions(+), 1 deletion(-)


base-commit: 5133c9e51de41bfa902153888e11add3342ede18
-- 
2.25.1

