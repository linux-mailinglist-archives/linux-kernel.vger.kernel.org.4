Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC46BD085
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCPNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCPNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:15:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A3B8570;
        Thu, 16 Mar 2023 06:15:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F9D41FE03;
        Thu, 16 Mar 2023 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678972511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kHLikiOj78KpDaSRuFeAp2LYuAcgKq6uGmUiwSMAIm8=;
        b=BeXr7QysMw8BmjVaU4Kszk+vYNFQT3TVNmhgUenHWOsLh51L7x5VTSXKDzQ++KRPxY4Oj/
        GTUQPUZfbn0D7RLoq+wLVeCt/HSwxh0tbZuxdd9CUNYMsX5r7Pi3rgv8EYdMieGVWCJVPN
        LRE/Al2HiYo7Bprt//F0sifXqU23X0E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D85A913A2F;
        Thu, 16 Mar 2023 13:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EHvvMl4WE2QGQQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 16 Mar 2023 13:15:10 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] usbtv: usbtv_set_regs: the pipe is output
Date:   Thu, 16 Mar 2023 14:15:07 +0100
Message-Id: <20230316131507.26748-1-oneukum@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are setting a value. That is output and
the pipe has to match that.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/usb/usbtv/usbtv-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/usbtv/usbtv-core.c b/drivers/media/usb/usbtv/usbtv-core.c
index 2308c0b4f5e7..1f7620cd2996 100644
--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -47,7 +47,7 @@
 int usbtv_set_regs(struct usbtv *usbtv, const u16 regs[][2], int size)
 {
 	int ret;
-	int pipe = usb_rcvctrlpipe(usbtv->udev, 0);
+	int pipe = usb_sndctrlpipe(usbtv->udev, 0);
 	int i;
 
 	for (i = 0; i < size; i++) {
-- 
2.39.2

