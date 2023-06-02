Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330BE7209E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjFBTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbjFBTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6319B;
        Fri,  2 Jun 2023 12:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3826171E;
        Fri,  2 Jun 2023 19:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93820C433D2;
        Fri,  2 Jun 2023 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685734489;
        bh=pVlZKSK7V60KmCp33dUk7C5+KElh0XQCV1KKRWbcQK0=;
        h=Date:From:To:Cc:Subject:From;
        b=fHmUyu5c/sVACqPy0gfGn2fBV9FLEDuhZPl3nFcTKs9nXSLp41oJ9HM4l69qFmbiY
         XPlw6rznp83fjpwBCPoMgtMojFuMDLlD4V9+OiG9lHK9uoRILBDGkADD+k5IMiWMaF
         IFHN7mtSt1WBWN+zeO+w5QqT6hPog9LsPpx4XQtQ40cvu3Aq25BbadPvEJtm+Lb5+k
         nyGEIOrXIaHT16sRWebf2QbtKBEPS8P0WxoDiZuTvOIHTX+oZVj+lBdGQ+g6QI/3k+
         tpJv14XAihBmEiu+x4YE4AFzUxbQTZzR5S5fnKe1ZnTvZyQ33lDUDyNYExeAQZRyfk
         9chjeT1n3iAvA==
Date:   Fri, 2 Jun 2023 13:35:41 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mvm: Fix -Warray-bounds bug in
 iwl_mvm_wait_d3_notif()
Message-ID: <ZHpEjTmBys5cCOGZ@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup() at line 2735 is not duplicating enough memory for
notif->tid_tear_down and notif->station_id. As it only duplicates
612 bytes: up to offsetofend(struct iwl_wowlan_info_notif,
received_beacons), this is the range of [0, 612) bytes.

2735	notif = kmemdup(notif_v1,
2736			offsetofend(struct iwl_wowlan_info_notif,
2737				    received_beacons),
2738			GFP_ATOMIC);

which evidently does not cover bytes 612 and 613 for members
tid_tear_down and station_id in struct iwl_wowlan_info_notif.
See below:

$ pahole -C iwl_wowlan_info_notif drivers/net/wireless/intel/iwlwifi/mvm/d3.o
struct iwl_wowlan_info_notif {
	struct iwl_wowlan_gtk_status_v3 gtk[2];          /*     0   488 */
	/* --- cacheline 7 boundary (448 bytes) was 40 bytes ago --- */
	struct iwl_wowlan_igtk_status igtk[2];           /*   488    80 */
	/* --- cacheline 8 boundary (512 bytes) was 56 bytes ago --- */
	__le64                     replay_ctr;           /*   568     8 */
	/* --- cacheline 9 boundary (576 bytes) --- */
	__le16                     pattern_number;       /*   576     2 */
	__le16                     reserved1;            /*   578     2 */
	__le16                     qos_seq_ctr[8];       /*   580    16 */
	__le32                     wakeup_reasons;       /*   596     4 */
	__le32                     num_of_gtk_rekeys;    /*   600     4 */
	__le32                     transmitted_ndps;     /*   604     4 */
	__le32                     received_beacons;     /*   608     4 */
	u8                         tid_tear_down;        /*   612     1 */
	u8                         station_id;           /*   613     1 */
	u8                         reserved2[2];         /*   614     2 */

	/* size: 616, cachelines: 10, members: 13 */
	/* last cacheline: 40 bytes */
};

Therefore, when the following assignments take place, actually no memory
has been allocated for those objects:

2743	notif->tid_tear_down = notif_v1->tid_tear_down;
2744	notif->station_id = notif_v1->station_id;

Fix this by allocating space for the whole notif object and zero out the
remaining space in memory after member station_id.

This also fixes the following -Warray-bouds issues:
 CC      drivers/net/wireless/intel/iwlwifi/mvm/d3.o
drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function ‘iwl_mvm_wait_d3_notif’:
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2743:30: warning: array subscript ‘struct iwl_wowlan_info_notif[0]’ is partly outside array bounds of ‘unsigned char[612]’ [-Warray-bounds=]
 2743 |                         notif->tid_tear_down = notif_v1->tid_tear_down;
      |
                 from drivers/net/wireless/intel/iwlwifi/mvm/d3.c:7:
In function ‘kmemdup’,
    inlined from ‘iwl_mvm_wait_d3_notif’ at drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2735:12:
include/linux/fortify-string.h:765:16: note: object of size 612 allocated by ‘__real_kmemdup’
  765 |         return __real_kmemdup(p, size, gfp);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function ‘iwl_mvm_wait_d3_notif’:
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2744:30: warning: array subscript ‘struct iwl_wowlan_info_notif[0]’ is partly outside array bounds of ‘unsigned char[612]’ [-Warray-bounds=]
 2744 |                         notif->station_id = notif_v1->station_id;
      |                              ^~
In function ‘kmemdup’,
    inlined from ‘iwl_mvm_wait_d3_notif’ at drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2735:12:
include/linux/fortify-string.h:765:16: note: object of size 612 allocated by ‘__real_kmemdup’
  765 |         return __real_kmemdup(p, size, gfp);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Link: https://github.com/KSPP/linux/issues/306
Fixes: 905d50ddbc83 ("wifi: iwlwifi: mvm: support wowlan info notification version 2")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 37aa4676dc94..1f8658a5ef28 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2733,8 +2733,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
 
 			notif = kmemdup(notif_v1,
-					offsetofend(struct iwl_wowlan_info_notif,
-						    received_beacons),
+					sizeof(struct iwl_wowlan_info_notif),
 					GFP_ATOMIC);
 
 			if (!notif)
@@ -2742,7 +2741,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 
 			notif->tid_tear_down = notif_v1->tid_tear_down;
 			notif->station_id = notif_v1->station_id;
-
+			memset_after(notif, 0, station_id);
 		} else {
 			notif = (void *)pkt->data;
 		}
-- 
2.34.1

