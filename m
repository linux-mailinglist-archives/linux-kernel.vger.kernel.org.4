Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F0732B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjFPJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjFPJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2AF35AA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157BD61199
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2457C433C9;
        Fri, 16 Jun 2023 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906578;
        bh=2YXvEte0tHvF2Un7MoBdoKftmOVsekrDTNUHt5cOEDI=;
        h=From:To:Cc:Subject:Date:From;
        b=YYX3cJ4ianisLazJgdikgP155Wib9XYqSbKA2QwXMR7ujm8QXtx7Favmp76BalGzh
         up411kYjoZn7deAEgja1U0Q80VurO5KBOm433islAMN8gbElUJbxwlTDMo4Ah3Hovz
         KHsVggBR5LThQvatMUAVD0FUCQOSaUsqwJt1qfmsvbkVCjFG/WKlx9MiKo4kDOJnI5
         4wouy+SJgmpM3u54ID5lTz+I6w+DjHOGQLszNQFdPCQOGy0IAKN7MuAujk9kxJzOcm
         TgyqxIwvIpwpk1zSh0hEKRl5M60EuRlZdSaEhP7IJ4xrVtCKjtzxLAEMHFFPdZ3f7H
         XNYGbDcwfG8kQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: intel_ace2x: fix SND_SOC_SOF_HDA_MLINK dependency
Date:   Fri, 16 Jun 2023 11:09:24 +0200
Message-Id: <20230616090932.2714714-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ace2x driver can be build with or without mlink support, but
when SND_SOC_SOF_HDA_MLINK is set to =m and soundwire is built-in,
it fails with a link error:

ld.lld: error: undefined symbol: hdac_bus_eml_sdw_wait_syncpu_unlocked
>>> referenced by intel_ace2x.c
>>>               drivers/soundwire/intel_ace2x.o:(intel_link_power_up) in archive vmlinux.a

ld.lld: error: undefined symbol: hdac_bus_eml_sdw_sync_arm_unlocked
>>> referenced by intel_ace2x.c
>>>               drivers/soundwire/intel_ace2x.o:(intel_sync_arm) in archive vmlinux.a

Add a Kconfig dependency that prevents that broken configuration but
still allows soundwire to be a loadable module instead.

Fixes: 4d1e2464a1104 ("soundwire: intel_ace2x: add sync_arm/sync_go helpers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soundwire/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index fa71c9a36df7a..4d8f3b7024ae5 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -37,6 +37,7 @@ config SOUNDWIRE_INTEL
 	select SOUNDWIRE_GENERIC_ALLOCATION
 	select AUXILIARY_BUS
 	depends on ACPI && SND_SOC
+	depends on SND_SOC_SOF_HDA_MLINK || !SND_SOC_SOF_HDA_MLINK
 	help
 	  SoundWire Intel Master driver.
 	  If you have an Intel platform which has a SoundWire Master then
-- 
2.39.2

