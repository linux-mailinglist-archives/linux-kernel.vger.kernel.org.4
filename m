Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3DB693031
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBKLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBKLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:10:06 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35B20057;
        Sat, 11 Feb 2023 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676113794; bh=5yApPz7ebuShtxrTuVWINA4sOPX+XYKVeOohcbcuehk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ZGzOiTTqV4La4J5DQSAtgRFeWjt0e52Q3jNl0ztbPToIl0sHOpl3Wsnl3j+aaON95
         KYLzJDwwygq9Fpfx4R95gdsCSVG4o9U8E2fH6SBZHqTX/pH9j3Y5JZPhjCM/gmN4et
         3vMXwCuhXC+56uPZnftbWtaPwQCCIX9Ix91w8ecA=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 11 Feb 2023 12:09:54 +0100 (CET)
X-EA-Auth: +b2O3JVJUDbTIbrBSTNVB6zRG+uUfXCvDhDTmkEoMe3IMbabFQNeu7b99bIpT+wXnTRI+9dz+M00r4LxxZQH+pA4Vr7R4788
Date:   Sat, 11 Feb 2023 16:39:50 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] media: platform: mtk-mdp3: release node reference before
 returning
Message-ID: <Y+d3fqRG1OoYKpLB@ubun2204.myguest.virtualbox.org>
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

The iterator for_each_child_of_node() increments the refcount of the
child node it is processing. Release such a reference when the loop
needs to break due to an error during its execution.
Issue identified using for_each_child.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The proposed change is compile tested only. I do not have the
necessary hardware to perform additional testing. Please suggest if there is an
alternate means available to further test this change.


 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c  | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 7bc05f42a23c..2c50a73bbf23 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -898,6 +898,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 {
 	struct device *dev = &mdp->pdev->dev;
 	struct device_node *node, *parent;
+	int ret = 0;
 
 	parent = dev->of_node->parent;
 
@@ -923,16 +924,22 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 			dev_err(dev,
 				"Fail to get sub comp. id: type %d alias %d\n",
 				type, alias_id);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_free_node;
 		}
 		mdp_comp_alias_id[type]++;
 
 		comp = mdp_comp_create(mdp, node, id);
-		if (IS_ERR(comp))
-			return PTR_ERR(comp);
+		if (IS_ERR(comp)) {
+			ret = PTR_ERR(comp);
+			goto err_free_node;
+		}
 	}
+	return ret;
 
-	return 0;
+err_free_node:
+	of_node_put(node);
+	return ret;
 }
 
 void mdp_comp_destroy(struct mdp_dev *mdp)
-- 
2.34.1



