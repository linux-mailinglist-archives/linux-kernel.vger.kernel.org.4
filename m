Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276DF6937F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBLP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBLP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:29:19 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98CB7EE8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676215756; bh=dPUMsgqR29ABs8e2run37C3ERVUnBw1c2pLvg81OOHg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=nJ8hp41yNBG92dISTJ4UvJAu82w9D03rmvyeeSeUaQ/01YBT5bBB4PfKNcO0MllPt
         vLA3wuYNvcqI1VW4ZBIPz21gbs0ma6P+FVLTwrUiK9lLKCvgzqyLXI8x6cCa91KupO
         ZD4sBVKrdyiGonDRA6vrIV2LV2wOGQ43PiYQwyuA=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 12 Feb 2023 16:29:16 +0100 (CET)
X-EA-Auth: H1Q8A0ov/kkUeRXY7osnEJ9nyK8Oy9KBvib/acfOppXaJMMDA5iHVdu1/+BXf7YCSNAkP/szIa4PUCCdFWuq3Q4gBz5qUEmh
Date:   Sun, 12 Feb 2023 20:59:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] bus: arm-cci: release node before breaking child_of_node loop
Message-ID: <Y+kFyUVMkfuugwit@ubun2204.myguest.virtualbox.org>
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
loop needs to break due to an error during its execution.
Issue identified using for_each_child.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The proposed change is compile tested only. I do not have the
necessary hardware to perform additional testing. Please suggest if there is an
alternate means available to further test this change.

 drivers/bus/arm-cci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..1f84a5528073 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
-- 
2.34.1



