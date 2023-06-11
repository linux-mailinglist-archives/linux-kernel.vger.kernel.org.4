Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91DC72B3FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 22:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjFKUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 16:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:44:22 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A9E53
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 13:44:19 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 8Rv5qwjzfZnIG8Rv5qdCzN; Sun, 11 Jun 2023 22:44:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686516257;
        bh=UiEF+Yax2f7tK9mHB7IIdxWz2jAlp2s9xTkNsdxvvkw=;
        h=From:To:Cc:Subject:Date;
        b=OUYbcJz4qYNl/rvRcj8m+xkYnIYgYw5GQYzEjeohGePg5f/NCQ8hwaP+KA2NayJR9
         9wo1V+vywBUF/RBzAz2/5PuBFXnj/0Pumv0YzR/p0GHPoa8tBx76xKE/EEB4WV7TIy
         RyeSIE2ybOJ2nDKb/sSutIi5Gk+NTRKPv+sOcgvJOe89LUM8dsLItS05cgRvcGguI8
         XtgUsQBFlGN/AqyLmN7CtnL3gCdjewsqhU16bNZpQhctYekQU1iorp9X7RZD038Z8n
         /DGcOik+Xj5t5duaZZ3W3HuTPTCqjC+UPykoE5W1Reir3MyjLEIhDLR2sEM8iMMTgB
         S7YmbF3ZWGfQg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Jun 2023 22:44:17 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH net-next] ice: Remove managed memory usage in ice_get_fw_log_cfg()
Date:   Sun, 11 Jun 2023 22:44:13 +0200
Message-Id: <e86a1ab7b450462a1e92264dccb5a5855546e384.1686516193.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use managed memory allocation here. The memory is
released at the end of the function.

You kzalloc()/kfree() to simplify the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index eb2dc0983776..4b799a5d378a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -834,7 +834,7 @@ static int ice_get_fw_log_cfg(struct ice_hw *hw)
 	u16 size;
 
 	size = sizeof(*config) * ICE_AQC_FW_LOG_ID_MAX;
-	config = devm_kzalloc(ice_hw_to_dev(hw), size, GFP_KERNEL);
+	config = kzalloc(size, GFP_KERNEL);
 	if (!config)
 		return -ENOMEM;
 
@@ -857,7 +857,7 @@ static int ice_get_fw_log_cfg(struct ice_hw *hw)
 		}
 	}
 
-	devm_kfree(ice_hw_to_dev(hw), config);
+	kfree(config);
 
 	return status;
 }
-- 
2.34.1

