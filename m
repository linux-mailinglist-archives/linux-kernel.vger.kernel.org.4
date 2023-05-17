Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF0707438
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEQV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:28:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A45B4;
        Wed, 17 May 2023 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684358902; x=1715894902;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=XFuPVNP8lz9ZwYdOOWjkCdcTZ0eGcHJibAcwLj5frpU=;
  b=UgRRqm3Wn8eGk/0aurm0Dy9oRMeFiCFT3BgTNwJ4Ny6kiG65Qgd1mZVs
   SLLblluO6H0B54Ov+XF5aZiCZ4oPDK3opXw27DNFsEhgeuHjB8On5df5X
   moSFOQd60Ton4nr+F6bYX26jbG9nc09Y0g0PvphCT+eYcM1oWQrR3jNs4
   3vc508gUlZXhdCFB+EqPQBSWkroytw60xmzpTNRB4lks6bV2Vq7X3XxTn
   rbsDnAlQemAxeu6pEtBnFNc/mtfMBVplEuiEMZnxbZ5KS3I1wdynu9uSU
   72ftNegie7m87c/Ri4SWtzosOn4Rk9yA36ItowCpXS//20XBG88ugK6/w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="341274704"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="341274704"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826098039"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="826098039"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/3] cxl: Random clean ups
Date:   Wed, 17 May 2023 14:28:09 -0700
Message-Id: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlGZWQC/x2L0QqDMBAEf0XuuQcx1SD9ldKHJG7rgaSSKxIQ/
 72Jj7M7c5AiC5Qe3UEZu6h8U4X+1lFcfPqAZa5M1ti7GazjWFZ+S4HyNAbnwuzMCEPVD17BIfs
 Ul1Y0MaH82rVlXE3dn6/z/AMCZiO0dgAAAA==
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358895; l=642;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=XFuPVNP8lz9ZwYdOOWjkCdcTZ0eGcHJibAcwLj5frpU=;
 b=vf4WutSMvXBCUbYgHrsdichGgi03m07anRtez8CTjBpedTthixrQbo/wZDDUzEgWeBi9jGq8x
 W5ce+Xe8M8zAdTNnFxkbT18YaWaXjXYnjJ3wYBYRsX551budVg5Zr/x
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 3 clean ups were found while working on other code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (3):
      MAINTAINERS: Add additional reviewers for CXL
      cxl/pci: Update comment
      tools/testing/cxl: Document test configurations

 MAINTAINERS                  |  2 ++
 drivers/cxl/pci.c            |  5 ++-
 tools/testing/cxl/test/cxl.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 3 deletions(-)
---
base-commit: bfe58458fd2557c9a81b89bc0ff10eb03d6c0745
change-id: 20230426-cxl-fixes-85b66bd605e0

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

