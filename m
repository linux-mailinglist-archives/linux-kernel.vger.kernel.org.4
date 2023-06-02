Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0A7209FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjFBTmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjFBTl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D9E40;
        Fri,  2 Jun 2023 12:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A7061070;
        Fri,  2 Jun 2023 19:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCBFC433EF;
        Fri,  2 Jun 2023 19:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685734916;
        bh=Pg9bfYuqnxQUKFcQcN4GaPtYdl08E/HIAub3ENBrWGc=;
        h=Date:From:To:Cc:Subject:From;
        b=GJNeBrnkVnERGcK4FVpVlecvQosDzKqGVO9hDYAe8lqZNJzYLXb1szRj+t8pe5MUI
         7RqLwipnz8qsKkuq8qKtp/3VWOTivyeYGSYS1oIgNDhBd94ZV0fa/xFeR/GyH095zF
         Myk5l+y61plOkgt/vPGTHloNZnhUvANtX9FMiOBs1Fhfzdm4oob5171c/DOuBXIoEv
         J3WGkdq2ZYTUqS7gCnUUx3x0vngGavfsJLxJCu1V1sY+DZAtWuWUrCAIaVWorZdzNJ
         lR7w/04uvITch+CvSEajMBb2/YQqRqVhaNjBgocfNTa1v7OSe2sFP677PPaQlKZivS
         udofzhDnKVl+g==
Date:   Fri, 2 Jun 2023 13:42:47 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] wifi: iwlwifi: mvm: Fix -Warray-bounds bug in
 iwl_mvm_wait_d3_notif()
Message-ID: <ZHpGN555FwAKGduH@work>
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

This also fixes the following -Warray-bounds issues:
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
Changes in v2:
 - Use sizeof(*notif), instead of sizeof(struct iwl_wowlan_info_notif).
 - Fix typo in the changelog text s/bouds/bounds.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZHpEjTmBys5cCOGZ@work/

 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 37aa4676dc94..6d1007f24b4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2732,17 +2732,13 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		if (wowlan_info_ver < 2) {
 			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
 
-			notif = kmemdup(notif_v1,
-					offsetofend(struct iwl_wowlan_info_notif,
-						    received_beacons),
-					GFP_ATOMIC);
-
+			notif = kmemdup(notif_v1, sizeof(*notif), GFP_ATOMIC);
 			if (!notif)
 				return false;
 
 			notif->tid_tear_down = notif_v1->tid_tear_down;
 			notif->station_id = notif_v1->station_id;
-
+			memset_after(notif, 0, station_id);
 		} else {
 			notif = (void *)pkt->data;
 		}
-- 
2.34.1

