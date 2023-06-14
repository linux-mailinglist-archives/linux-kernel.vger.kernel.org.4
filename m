Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA773012F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245360AbjFNOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjFNOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:07:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA0CD;
        Wed, 14 Jun 2023 07:07:28 -0700 (PDT)
From:   Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686751646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EJvyE/C3PvQNTvDv0SaWnfKcEUXisJIN7Dyyhzdk0bk=;
        b=3Q9xpOFUIfL7l3ShdTyCf/oPmQEtVietstpFXDZcC2uxcw2CO16I3QM1SI6PtPAihPoEdQ
        WcSY4OWzi3pUEZylPYJ8dVld3HCtDHwoOV3yl4D+vBbq+xI1RlCBolQYjfUDGggqz64bxO
        /gYjusYOQcHiRgqTxI5dVqmGtvNIN0P4DfFkYjNhS7irCxcug1B5XRZElKy1oWg5j0HNIh
        Y84YDnr/bGYpHetH/WTZUIfR4o5AkGyL2toHMPM/xdd+Wr6wKl/1+3IBku/S5XXgT5xj4h
        a64dKSYV7/3Bp5Krjy5xGcMKjhNQwFDD8/S62mU0/W0H37Chyh79dDKNwyoQ8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686751646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EJvyE/C3PvQNTvDv0SaWnfKcEUXisJIN7Dyyhzdk0bk=;
        b=mJ5bM/swMdWLiQBPI6q6TyY9ppPwCbZ9rstTumP66sDYj9b1FTLJZEarsSRivBST0aS3Wm
        YNFRVGe+ccxH+WBw==
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Tan Tee Min <tee.min.tan@linux.intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
        Malli C <mallikarjuna.chilakala@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurt@linutronix.de,
        florian.kauer@linutronix.de
Subject: [PATCH net-next 0/6] igc: Fix corner cases for TSN offload
Date:   Wed, 14 Jun 2023 16:07:08 +0200
Message-Id: <20230614140714.14443-1-florian.kauer@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The igc driver supports several different offloading capabilities
relevant in the TSN context. Recent patches in this area introduced
regressions for certain corner cases that are fixed in this series.

Each of the patches (except the first one) addresses a different
regression that can be separately reproduced. Still, they have
overlapping code changes so they should not be separately applied.

Especially #4 and #6 address the same observation,
but both need to be applied to avoid TX hang occurrences in
the scenario described in the patches.

Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

Florian Kauer (6):
  igc: Rename qbv_enable to taprio_offload_enable
  igc: Do not enable taprio offload for invalid arguments
  igc: Handle already enabled taprio offload for basetime 0
  igc: No strict mode in pure launchtime/CBS offload
  igc: Fix launchtime before start of cycle
  igc: Fix inserting of empty frame for launchtime

 drivers/net/ethernet/intel/igc/igc.h      |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 24 ++++++++-------------
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 26 ++++++++++++++++++++---
 3 files changed, 33 insertions(+), 19 deletions(-)

-- 
2.39.2

