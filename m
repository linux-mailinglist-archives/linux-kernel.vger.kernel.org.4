Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E974A73F0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjF0C1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjF0C1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:27:16 -0400
Received: from out-28.mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB09173B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:27:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687832833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NiLCSG+J8TFDNfzSLNUB+HE+7XY7CA+7w0Zb1WNocDM=;
        b=IhqNKXxGVHAbv02ycD8gt4pXO7ev48kyVUIt/6qCLWeiBDI1Puem2akmTJkVtW85kXxD2v
        Dz6OdsIobdamjjipKw3k7iAt5SY9kitKkaE3qJdHabDP9eT8QLHB2BoUz6V9Y0QM8kwTDq
        qXggTMDRHehcW7QeX0CEM/ecZlOf+Kw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        jacob.e.keller@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>,
        stable@vger.kernel.org
Subject: [PATCH] i40e: fix the wrong PTP frequency calculation
Date:   Tue, 27 Jun 2023 10:26:58 +0800
Message-Id: <20230627022658.1876747-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new adjustment should be based on the base frequency, not the
I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().

This issue was introduced in commit 3626a690b717 ("i40e: use
mul_u64_u64_div_u64 for PTP frequency calculation"), and was fixed in
commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
parts per million"). However the latter is a new feature and hasn't been
backported to the stable releases.

This issue affects both v6.0 and v6.1 versions, and the v6.1 version is
an LTS version.

Fixes: 3626a690b717 ("i40e: use mul_u64_u64_div_u64 for PTP frequency calculation")
Cc: <stable@vger.kernel.org> # 6.1
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index ffea0c9c82f1..97a9efe7b713 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -361,9 +361,9 @@ static int i40e_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 				   1000000ULL << 16);
 
 	if (neg_adj)
-		adj = I40E_PTP_40GB_INCVAL - diff;
+		adj = freq - diff;
 	else
-		adj = I40E_PTP_40GB_INCVAL + diff;
+		adj = freq + diff;
 
 	wr32(hw, I40E_PRTTSYN_INC_L, adj & 0xFFFFFFFF);
 	wr32(hw, I40E_PRTTSYN_INC_H, adj >> 32);
-- 
2.25.1

