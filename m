Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1543B732B07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjFPJGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjFPJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71521BE3;
        Fri, 16 Jun 2023 02:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E66260C5E;
        Fri, 16 Jun 2023 09:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6C5C433C0;
        Fri, 16 Jun 2023 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906228;
        bh=bhE+0A/OQIrRGA/14kkswPkAR/ndWpXFLbO2JGK/4v4=;
        h=From:To:Cc:Subject:Date:From;
        b=p/288pR+J8bm9d+aQU3rQISNwuWPc6m1kc94uuz63DfMzJEmOh+SjrWc80HC+m8FN
         VCRXCaB8VCpDeVOi6P9XFKaiNAcUEDug6NYRmDPHr/drHzNri9ogRAAOFRVwkbylac
         CG6P61TvyPw039Qb4j1beTWgM+c4f2ni4W+Fw7BDP3Ar/jqcElLF88kWM7ewyKc85E
         fQeM1WlCJhtjcyFkLB1XklJIjJKtn8EkvkzT/iNQaDE0BrdjRhVc2uac1X7+q4MbRw
         QJpWVC9sSCz/cqbP8Z5sDFuqkpzTGpQzwlyrI7P4QqAgStRtMEEup1N4ysSzHjyS12
         yS7W58uSSno7A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: dbg_ini: fix structure packing
Date:   Fri, 16 Jun 2023 11:03:34 +0200
Message-Id: <20230616090343.2454061-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The iwl_fw_ini_error_dump_range structure has conflicting alignment
requirements for the inner union and the outer struct:

In file included from drivers/net/wireless/intel/iwlwifi/fw/dbg.c:9:
drivers/net/wireless/intel/iwlwifi/fw/error-dump.h:312:2: error: field  within 'struct iwl_fw_ini_error_dump_range' is less aligned than 'union iwl_fw_ini_error_dump_range::(anonymous at drivers/net/wireless/intel/iwlwifi/fw/error-dump.h:312:2)' and is usually due to 'struct iwl_fw_ini_error_dump_range' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        union {

As the original intention was apparently to make the entire structure
unaligned, mark the innermost members the same way so the union
becomes packed as well.

Fixes: 973193554cae6 ("iwlwifi: dbg_ini: dump headers cleanup")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index f5e08988dc7bf..06d6f7f664308 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -310,9 +310,9 @@ struct iwl_fw_ini_fifo_hdr {
 struct iwl_fw_ini_error_dump_range {
 	__le32 range_data_size;
 	union {
-		__le32 internal_base_addr;
-		__le64 dram_base_addr;
-		__le32 page_num;
+		__le32 internal_base_addr __packed;
+		__le64 dram_base_addr __packed;
+		__le32 page_num __packed;
 		struct iwl_fw_ini_fifo_hdr fifo_hdr;
 		struct iwl_cmd_header fw_pkt_hdr;
 	};
-- 
2.39.2

