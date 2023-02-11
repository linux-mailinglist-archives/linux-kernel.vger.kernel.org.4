Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E4693013
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBKKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBKKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:42:35 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700B311D6;
        Sat, 11 Feb 2023 02:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676112134; bh=YWNKXJsGcCGSx3BeuPJ+DwSelvQ5DLVpRbP15fVAw0U=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=brMK4e3yl6tT6M4P6Jq1Jjx5RoM0dOgNE2WNL3D6+Fkto4hauTKf8hC829y4Z8k/3
         qTnma4bpWzlQXaMwM7o1e5wYm0IPpVdLYZj63L6w8OUKTwXN/+Det6r1iNUFQ1alpz
         7rR6yJdyiFIjQfRnNHUybEOHQZzmsstO1iJjLveQ=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 11 Feb 2023 11:42:14 +0100 (CET)
X-EA-Auth: KWivLFusfe4M1FPFEQqJeQo8HsYkZIK5ja/R4WdeOuBADd0RqXt/X9wMN3obLuKKdS3duyFYHD6akLmUX/+DPU2MGNdvswLc
Date:   Sat, 11 Feb 2023 16:12:07 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] leds: qcom-lpg: Release node reference before returning
Message-ID: <Y+dw/0DA+j6xFiHR@ubun2204.myguest.virtualbox.org>
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

The iterator for_each_available_child_of_node() increments the refcount
of the child node it is processing. Release such a reference when the
loop needs to breaks due to en error during its execution.
Issue identified using for_each_child.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The proposed change is compile tested only. I do not have the
necessary hardware to perform additional testing. Please suggest if there is an
alternate means available to further test this change.

 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 67f48f222109..993fb9cf0204 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1112,8 +1112,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		i = 0;
 		for_each_available_child_of_node(np, child) {
 			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child);
 				return ret;
+			}
 
 			info[i].color_index = led->channels[i]->color;
 			info[i].intensity = 0;
@@ -1291,8 +1293,10 @@ static int lpg_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		ret = lpg_add_led(lpg, np);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	for (i = 0; i < lpg->num_channels; i++)
-- 
2.34.1



