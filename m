Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8263B6F06B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbjD0NeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbjD0Nd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40690E72;
        Thu, 27 Apr 2023 06:33:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB06B1FE34;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fzOUYOYTdUfKOUVVhjGpyqN36+sVZOkD6XplvoiqEIk=;
        b=RfcGL9hVqZn+FTge+Biq/qbpy49KMMeI7c6VcIRV5dE3Umqat1BtbwtRO6kBvqqmV/hatr
        dI/0p3dI1afm9M3FrG7poUIG3dy2Qi/SGPZgXK1y9ji7lHqlK6pejDLPhlCm0f4Jwjc0tB
        DPFAZ22No0hP+TJI9BeXffmuwffYFKA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A92E7138F9;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mGxhJsN5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:55 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 7/8] usb_pcwd: WDIOC_SETTIMEOUT: prevent preemption
Date:   Thu, 27 Apr 2023 15:33:49 +0200
Message-Id: <20230427133350.31064-8-oneukum@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427133350.31064-1-oneukum@suse.com>
References: <20230427133350.31064-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delays between altering the watchdog
and giving the keepalive need to be controlled.
Do not allow preemption.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 50ba88019ed6..09cae7a6ad07 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -459,10 +459,14 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 		if (get_user(new_heartbeat, p))
 			return -EFAULT;
 
-		if (usb_pcwd_set_heartbeat(usb_pcwd_device, new_heartbeat))
+		preempt_disable(); /* we are on a clock now */
+		if (usb_pcwd_set_heartbeat(usb_pcwd_device, new_heartbeat)) {
+			preempt_enable();
 			return -EINVAL;
+		}
 
 		usb_pcwd_keepalive(usb_pcwd_device);
+		preempt_enable();
 	}
 		fallthrough;
 
-- 
2.40.0

