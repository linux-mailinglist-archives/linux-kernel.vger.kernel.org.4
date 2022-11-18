Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C6F62EC30
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiKRC4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbiKRCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:55:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47FA8E2A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668740147; x=1700276147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ewq6eAdnNoMnZKMRbGQiXD5EkArZxytL7hT/pN2Emlw=;
  b=I4U8NQ2MBH59vs9SYZc8FFpUGH9MzcRC6dHH6VWhVvQ5F3uzTf0deKLG
   QMjQTv50jx4oM757J7ZW7T3v3MIomBgioJnne8FrtoHf0ZMeQI7iiGxzJ
   CjTlYsPdIuBINTcgjJakYLaFTmuAoGnmAW1/D3uJ0FLF38lAQPhpKW2lk
   3lt6fo/JmcjbObG+NN9LEL3C5/muN+g/L35XZWUzd4GdUZdc/IzqyC7kz
   BjYl674dcq4PjLbGZczRbOSnZU+yoXDBreWBWGb+4c4Tt1c2+cEVH74A7
   U1Js/gbP7rhfnl2Ve86ULLW/9b3VUhstv1O6esMXiJKLHtOvP8NgenqUF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296400625"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="296400625"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:55:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642347880"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="642347880"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:55:42 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org, bard.liao@intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ASoC/soundwire: revisit support for clock registers
Date:   Fri, 18 Nov 2022 10:58:05 +0800
Message-Id: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire clock base and scale registers are only supported for SDCA
devices. That's fine, but that leaves SoundWire 1.2 with optional
registers not supported. This is a corner case that needs to be supported.

The change is mainly on soundwire. But rt1318-sdw.c was applied to
ASoC tree recently and not in SoundWire tree yet. @Vinod, Are you good
if we go throutgh ASoC tree? Or @Mark can provide a tag and we can go
through SoundWire tree?

changes:
v2:
 - remove is_sdca flag from rt1318-sdw codec driver, too.

Pierre-Louis Bossart (2):
  ASoC/soundwire: remove is_sdca boolean property
  soundwire: enable optional clock registers for SoundWire 1.2 devices

 drivers/soundwire/bus.c           | 11 ++++++-----
 include/linux/soundwire/sdw.h     |  6 ++++--
 sound/soc/codecs/rt1316-sdw.c     |  1 -
 sound/soc/codecs/rt1318-sdw.c     |  1 -
 sound/soc/codecs/rt711-sdca-sdw.c |  1 -
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.25.1

