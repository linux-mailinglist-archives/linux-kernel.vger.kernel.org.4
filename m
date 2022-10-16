Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD58F5FFFE1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJPOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJPOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:40:08 -0400
X-Greylist: delayed 1221 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 07:40:05 PDT
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D831376
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1665929957; bh=eGiDjkHU2H18+UPJbCBnMLwPn0ooEAda11HpwCTW7NE=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Jr7gAm6Ms40j66UKi9lALGQDZMf4kYHTU3PElDk+o5p3llOSr+G5X5a+Ubi6+7Y2v
         wb0sLR1w7WpmjPJdZxHX2Ov+Wcpb8mgAcUK0BqGOaFe0mxx8coqzEgfLiLaQFFtyFI
         h7fFNPbqcSX5sDcs8XHR4BMkGSYnFvnSCFT9/RLM=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Sun, 16 Oct 2022 16:19:16 +0200 (CEST)
X-EA-Auth: ZlYqw7q+n9bWm0E6M2C4cko2RDVMvIgADjfKHRVLOR30Cm/e+LuD7Xdw2nHPPvVfc+puoJzaiDklCQrDpRBLDd7molkJY2vr
Date:   Sun, 16 Oct 2022 10:19:12 -0400
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
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

Include multiple statements of macro definition inside do-while{0} loop
to avoid possible partial program execution. Issue reported by
checkpatch script:

ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/greybus/loopback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 1a61fce98056..37214cb43937 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -163,9 +163,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
 static DEVICE_ATTR_RO(name##_avg)

 #define gb_loopback_stats_attrs(field)				\
+do {								\
 	gb_loopback_ro_stats_attr(field, min, u);		\
 	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+	gb_loopback_ro_avg_attr(field);				\
+} while (0)

 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
--
2.30.2



