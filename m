Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B936D7474
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbjDEGfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjDEGfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:35:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537A30FF;
        Tue,  4 Apr 2023 23:35:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11C5521FD6;
        Wed,  5 Apr 2023 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680676549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/n2GEZAzpXyAoutRpcOwMS4F5u8r4LfoSAsc7aqPWJA=;
        b=M5Pkl+CCUW+bxpqgnim/dMWnCIiQpc2e/yC7phOtS5BZHLA/dt5sKPMiAHulL89CnN2GSD
        DNWHsTep+UbpnIpPQZHCpct6reYLN56o1jbavDaoP7hXffmT34B4nPbSMmdTT/QVZHcT9K
        F/4Gt2CVt+1+uFkA/uaDbE9zo/3qt20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680676549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/n2GEZAzpXyAoutRpcOwMS4F5u8r4LfoSAsc7aqPWJA=;
        b=GR9l6t6S5u/RF0rULHo7faOJMvxW6nKSZDbVPa3b+EYiHwrZ+zEdLDJYUCv0rBZdUBP36X
        Ky5Mg2/p/wb1YzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDCCE13A10;
        Wed,  5 Apr 2023 06:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 54OEM8QWLWRlBQAAMHmgww
        (envelope-from <tiwai@suse.de>); Wed, 05 Apr 2023 06:35:48 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: cfg: Add missing MODULE_FIRMWARE() for *.pnvm
Date:   Wed,  5 Apr 2023 08:35:46 +0200
Message-Id: <20230405063546.12439-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few models require *.pnvm files while we don't declare them via
MODULE_FIRMWARE().  This resulted in the breakage of WiFi on the
system that relies on the information from modinfo (e.g. openSUSE
installer image).

This patch adds those missing MODULE_FIRMWARE() entries for *.pnvm
files.

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1207553
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

The fix is obviously ad hoc.

Here I added the lines with the explicit string since *_PRE definition
contains the tailing dash and can't be used for *.pnvm file.

Alternatively, we may put a single line
 MODULE_FIRMWARE("iwlwifi-*.pnvm");
to catch all, too.

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 3bdd6774716d..3c6dc3601784 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -1065,3 +1065,7 @@ MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+
+MODULE_FIRMWARE("iwlwifi-so-a0-gf4-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-so-a0-gf-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-ty-a0-gf-a0.pnvm");
-- 
2.35.3

