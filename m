Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49FD61433F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKACah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKACaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:30:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA8BCD5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667269835; x=1698805835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+VAcDu8nCS7WGVWXp6e7tdbtl+zUVq+Vu+cNVOMl7/0=;
  b=cCT9HeB3S10H8dWsnUZ14l6wvP2ZLmFRqld5tnLH9ZKjOpv1Z7nuPSOe
   FURIHu2SZ0Mo97oe16GP3TWzyGvYCuYcI0AYZKkWvNyyxLtyp12AxOrey
   xTwKbgtShbYHTeeqmm8L79/cyRol8m8/qV8dBIsWt7GdH4kq9gl8kO7WV
   asRLievFJi1zpMUg9voDt4WQ3zDjqMBmBx48iLyuAS/vBSSwc2opSoGeq
   +/bvdaP/aDFnyaGm55mXKHsz68IVSt3hYtBrdePGP3uBtT2q5JRa/XEo3
   fxVSAxVq4uNF/9CbyOLxIzFBdXwVOBd+pebOmC54HUSjhhk4zMes6Xp3t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="288763719"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="288763719"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:30:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="611709363"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="611709363"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:30:32 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: cadence: remove dma_data
Date:   Tue,  1 Nov 2022 10:35:19 +0800
Message-Id: <20221101023521.2384586-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of dma_data is problematic for two reasons for the Cadence IP.
a) the dai runtime data has nothing to do with DMAs in existing solutions
b) we will use the dma_data for DMA-management in the future. We cannot
share two separate pieces of information with the same dma_data pointer.

Pierre-Louis Bossart (2):
  soundwire: cadence: rename sdw_cdns_dai_dma_data as
    sdw_cdns_dai_runtime
  soundwire: cadence: use dai_runtime_array instead of dma_data

 drivers/soundwire/cadence_master.c |  50 +++++++------
 drivers/soundwire/cadence_master.h |   9 ++-
 drivers/soundwire/intel.c          | 111 ++++++++++++++---------------
 3 files changed, 86 insertions(+), 84 deletions(-)

-- 
2.25.1

