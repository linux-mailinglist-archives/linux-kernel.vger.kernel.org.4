Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52046739E53
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjFVKUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjFVKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:19:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A787107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687429192; x=1718965192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9jam3CMoVZ6A/N5nfAjGK/fytBzu9GaWl/y16AysgMI=;
  b=lxHkArxdyc21ZZ9jDAQWNMIBctSBlGPDYa1WiqLWmR9E4Oxlju36Fqqm
   +eZMRfpSdlkKWjurImF3NDEfboMNhyOIBIiHT/qrtxXcmZugxpIbgp+S3
   C0Bocdx8QiPG01oyagly5SWzsQzR/CY7Zrxn3I378Q6nUDeWW+A+y0DX0
   uvWhRttYxQTw2akSa+Y5sAn7/zcCUwtUMoHDPlDT17XuxSOdmp4ALqNUt
   /6sITLAMfYVJDMtN9Y/gKgEBxWg/RerETCXsHGQzYpvCXYNhPeW3n1Xu4
   FN0JAyDYiWnXMFhNYCBhdDgiMT8uVsgd1HKVfTrm2B5dbWedIlwG2wPoT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="345181950"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="345181950"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 03:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="692193726"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="692193726"
Received: from shari19x-mobl1.gar.corp.intel.com (HELO thellstr-mobl1.intel.com) ([10.249.254.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 03:14:29 -0700
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 0/4] drm/ttm: Fixes around resources and bulk moves
Date:   Thu, 22 Jun 2023 12:14:08 +0200
Message-Id: <20230622101412.78426-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A couple of ttm fixes for issues that either were hit while developing the
xe driver or, for the resource leak patches, discovered during code
inspection.

Thomas Hellström (4):
  drm/ttm: Fix ttm_lru_bulk_move_pos_tail()
  drm/ttm: Don't shadow the operation context
  drm/ttm: Don't leak a resource on eviction error
  drm/ttm: Don't leak a resource on swapout move error

 drivers/gpu/drm/ttm/ttm_bo.c       | 20 ++++++++++----------
 drivers/gpu/drm/ttm/ttm_resource.c |  2 ++
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.40.1

