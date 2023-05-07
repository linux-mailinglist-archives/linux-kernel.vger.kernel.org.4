Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B96F9594
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjEGAex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEGAeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C618FC7;
        Sat,  6 May 2023 17:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CF0611B6;
        Sun,  7 May 2023 00:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEF8C4339E;
        Sun,  7 May 2023 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419620;
        bh=IVzfOwZ7QIXc91Rakl7Vd2n7qhxihifkzDH5KNvh3kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvK8IbxR4VHNEy5FlBuVkeSMEgkyo5HOQ9JyAKmn6eCp9FdKUmLh8YjPINU3+ANf5
         HGENTnlifa7VeP2wSa+p+It88bDOsOaJQDWFbw23brIgFckP1qmGao7pMa9zuEo3UQ
         fxFAPDMJXjElDtpG22ASqS9pixfnozS1p3SDM/zieexevb7KQQLu+fe+F+T9ebAO5B
         msjgN0G73lG5U14ToLG+pc0PQJYgn4iClnmn3/gXyKUgUbYyXi5YTbMz1bZgMR7frU
         dZwqXtULNKep1gtKn6Ys1FkL3n45iiqNO0B65IuL9ByY6mhOWxsVUKHoh/T4/DABMd
         S0PH8kshesSMA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frank Wang <frank.wang@rock-chips.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux@roeck-us.net,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 18/20] usb: typec: tcpm: fix multiple times discover svids error
Date:   Sat,  6 May 2023 20:32:33 -0400
Message-Id: <20230507003237.4074305-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003237.4074305-1-sashal@kernel.org>
References: <20230507003237.4074305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wang <frank.wang@rock-chips.com>

[ Upstream commit dac3b192107b978198e89ec0f77375738352e0c8 ]

PD3.0 Spec 6.4.4.3.2 say that only Responder supports 12 or more SVIDs,
the Discover SVIDs Command Shall be executed multiple times until a
Discover SVIDs VDO is returned ending either with a SVID value of
0x0000 in the last part of the last VDO or with a VDO containing two
SVIDs with values of 0x0000.

In the current implementation, if the last VDO does not find that the
Discover SVIDs Command would be executed multiple times even if the
Responder SVIDs are less than 12, and we found some odd dockers just
meet this case. So fix it.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Link: https://lore.kernel.org/r/20230316081149.24519-1-frank.wang@rock-chips.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 032d21a967799..524099634a1d4 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1514,7 +1514,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
 		pmdata->svids[pmdata->nsvids++] = svid;
 		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
 	}
-	return true;
+
+	/*
+	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
+	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
+	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
+	 * SVIDs Command Shall be executed multiple times until a Discover
+	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
+	 * the last part of the last VDO or with a VDO containing two SVIDs
+	 * with values of 0x0000.
+	 *
+	 * However, some odd dockers support SVIDs less than 12 but without
+	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
+	 * request and return false here.
+	 */
+	return cnt == 7;
 abort:
 	tcpm_log(port, "SVID_DISCOVERY_MAX(%d) too low!", SVID_DISCOVERY_MAX);
 	return false;
-- 
2.39.2

