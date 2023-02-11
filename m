Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D660692FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjBKJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBKJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:46:22 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D4D76AD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 01:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676108761; bh=Ydgu5g4WlyVn36Jz32lHZYcOHiMZLtAy7QIgF1AAXs0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=WfW8CTI2mD5aSk3n719ujDSox1IjJ/RCUVjx4PkizvmhFTmHevNphNQMH+aOK9WBu
         j85wmLxgwAntoZF21US6Q+drc/RJDxi6nlG+ImTtZvA7Se1taD0Oq043Cj6/MFnmsS
         ZiG+kf/07kpNges2apRpMw5G3OofAfb1NL0KD/ec=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 11 Feb 2023 10:46:00 +0100 (CET)
X-EA-Auth: 987LuaOKYgBLfh74yLd3cGsLvIMGcPDBhggO2IBqTNsNs0v/KybJmpHUNlZBAJSOmtIDgx64JjqKmLlNvw8RpgWQUpko0Io0
Date:   Sat, 11 Feb 2023 15:15:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] octeontx2-pf: Remove repeating variable in test
Message-ID: <Y+djy4R7Z/e5noRX@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to & a variable with itself. Remove extra variable from the
expression. Change allows to realign code and improve readability.
Issue identified using doublebitand.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 684cb8ec9f21..66a27ee5ca56 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -792,8 +792,7 @@ static int otx2_prepare_ipv6_flow(struct ethtool_rx_flow_spec *fsp,
 		}
 
 		/* NPC profile doesn't extract AH/ESP header fields */
-		if ((ah_esp_mask->spi & ah_esp_hdr->spi) ||
-		    (ah_esp_mask->tclass & ah_esp_mask->tclass))
+		if ((ah_esp_mask->spi & ah_esp_hdr->spi) || ah_esp_mask->tclass)
 			return -EOPNOTSUPP;
 
 		if (flow_type == AH_V6_FLOW)
-- 
2.34.1



