Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CEB73AD27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFVXYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjFVXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F331992;
        Thu, 22 Jun 2023 16:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E647D61710;
        Thu, 22 Jun 2023 23:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1527C433C0;
        Thu, 22 Jun 2023 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687476258;
        bh=9l3yT4c7WDuIVAHRSLpHtSAsORZMZ/UnIYSe9gs3Uow=;
        h=Date:From:To:Cc:Subject:From;
        b=W3NOkPNsCMY+YwGljyypyg75v94Gd2jlwQfDRAS9jcgmYQQlUoUeVbWsmlPGOZ3UQ
         Vb9jtdUeL+kCqJ3pZYs+8KHmTNU2OlvmwZvYUbv4cZicZUlfFhn7FV/e5m4BxzHzWg
         OT/Klv8LrZSZ9Gum4BtI6hwSyAUcrL3Ik94sPqBRigmjRTVKrOnOnz8Vc1AnNKYskR
         KhoemsdFBkaQpFjUmjTFb1QHdlMfjgf0fjmgR5x/I2RUJoRgS1gomvl74z6NJ/Ok3e
         TsjCVhJenROERDFCwPkBYqfubrI5ePd6yHpF0eKp6CTsQL/S1pYG73GXByeI9sRESq
         sMNwO3i9iDXRg==
Date:   Thu, 22 Jun 2023 17:25:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] openprom: Use struct_size() helper
Message-ID: <ZJTYWQ5NA726baWK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size() over open-coded versions.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/sbus/char/openprom.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 30b9751aad30..de56c8fec373 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -76,7 +76,9 @@ static int copyin(struct openpromio __user *info, struct openpromio **opp_p)
 	if (bufsize > OPROMMAXPARAM)
 		bufsize = OPROMMAXPARAM;
 
-	if (!(*opp_p = kzalloc(sizeof(int) + bufsize + 1, GFP_KERNEL)))
+	*opp_p = kzalloc(struct_size(*opp_p, oprom_array, bufsize + 1),
+			 GFP_KERNEL);
+	if (!*opp_p)
 		return -ENOMEM;
 
 	if (copy_from_user(&(*opp_p)->oprom_array,
@@ -95,7 +97,9 @@ static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)
 	if (!info || !opp_p)
 		return -EFAULT;
 
-	if (!(*opp_p = kzalloc(sizeof(int) + OPROMMAXPARAM + 1, GFP_KERNEL)))
+	*opp_p = kzalloc(struct_size(*opp_p, oprom_array, OPROMMAXPARAM + 1),
+			 GFP_KERNEL);
+	if (!*opp_p)
 		return -ENOMEM;
 
 	(*opp_p)->oprom_size = 0;
-- 
2.34.1

