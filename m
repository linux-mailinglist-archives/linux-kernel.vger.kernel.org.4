Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148273DB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFZJTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:19:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E5297A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687770987; x=1719306987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oI+iy54Hh6AlX2ttyHvrxT6tZDNwd+hp/2whYhQ4P/w=;
  b=dUO274w+RHVHbSrvBKpcP9NweEvKoiemESoOLY0czBa6rzeYumB4h9gR
   wQVb9VXZhA5vToYdyrkQ7/AtEj3xPUIuAkTrp8zqCt9zIkbZxepKapmH+
   WzIV7bAkoMnVlZGcMC5eTpDSdC5h3wf4vuLTvThV3euXrO75ptu5HcW6C
   obugMU6RV7XwRT8l+o6WWsiO4qDfGeIsR3gTFP6p3ZMbZEU8B5QLrFyXK
   SiXbIVYYAz0/lD3JPrfopYnWEmwsx+Nm+EpAPuw+JMtOTk7tOtiCGr/Qh
   FaXPtXQO6za84aGygQmw20VePvV8+/j6IcELKEArJ/+NrRaaJlp4CjlIj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="345974058"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="345974058"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="781357702"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="781357702"
Received: from ettammin-mobl1.ger.corp.intel.com (HELO thellstr-mobl1.intel.com) ([10.249.254.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:00 -0700
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "Andi Shyti" <andi.shyti@linux.intel.com>
Subject: [PATCH v2 0/4] drm/ttm: Fixes around resources and bulk moves
Date:   Mon, 26 Jun 2023 11:14:46 +0200
Message-Id: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
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

v2:
- Avoid a goto in patch 3 (Andi Shyti)
- Add some RB's

Thomas Hellström (4):
  drm/ttm: Fix ttm_lru_bulk_move_pos_tail()
  drm/ttm: Don't shadow the operation context
  drm/ttm: Don't leak a resource on eviction error
  drm/ttm: Don't leak a resource on swapout move error

 drivers/gpu/drm/ttm/ttm_bo.c       | 26 +++++++++++++-------------
 drivers/gpu/drm/ttm/ttm_resource.c |  2 ++
 2 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.40.1

