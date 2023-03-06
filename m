Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927BB6AC72D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjCFQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjCFQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402102E813;
        Mon,  6 Mar 2023 08:00:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F17472242C;
        Mon,  6 Mar 2023 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHsw9G40HD12yWMfW+3kaONrrrxFvi6OorhBwRazvNw=;
        b=jaLHBd2ZnCEawg3As+bdVniBuW//6UdlJDPreseZw6KPB5jjYCo604b2XU3tfyAff5vpfN
        8ukpj6sTWj8zQN/fDtjdBHUBt4Vku22YPBNa/wlRkSLqpGeqevGiB+3EbCbR+pn/DI7n1+
        lXD4UbfcWIw0ppSmyiXrmep2077pRDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHsw9G40HD12yWMfW+3kaONrrrxFvi6OorhBwRazvNw=;
        b=KoS8rLuFGGdDvRtgrX+jMTdBEh8GGfYNXVX0wj4gReGH1MfoyEZflEAyErznczRPIxhS+N
        eVvjme4RGvyY9RAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C20913A6A;
        Mon,  6 Mar 2023 16:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KIVfJTMOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:51 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@HansenPartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 72/99] fbdev/sisfb: Constify mode string
Date:   Mon,  6 Mar 2023 16:59:49 +0100
Message-Id: <20230306160016.4459-73-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306160016.4459-1-tzimmermann@suse.de>
References: <20230306160016.4459-1-tzimmermann@suse.de>
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

Constify the intenal video-mode string that is passed around among
functions. The caller owns the memory and callees do not modify its
content. This change will later allow to constify the option string.
No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/sis/sis_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index cfba776afcea..c16493d3ac4f 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -73,7 +73,7 @@ static int	sisfb_blank(int blank,
 static void sisfb_handle_command(struct sis_video_info *ivideo,
 				 struct sisfb_cmd *sisfb_command);
 
-static void	sisfb_search_mode(char *name, bool quiet);
+static void	sisfb_search_mode(const char *name, bool quiet);
 static int	sisfb_validate_mode(struct sis_video_info *ivideo, int modeindex, u32 vbflags);
 static u8	sisfb_search_refresh_rate(struct sis_video_info *ivideo, unsigned int rate,
 				int index);
@@ -180,12 +180,12 @@ static void sisfb_search_vesamode(unsigned int vesamode, bool quiet)
 		printk(KERN_ERR "sisfb: Invalid VESA mode 0x%x'\n", vesamode);
 }
 
-static void sisfb_search_mode(char *name, bool quiet)
+static void sisfb_search_mode(const char *name, bool quiet)
 {
 	unsigned int j = 0, xres = 0, yres = 0, depth = 0, rate = 0;
 	int i = 0;
 	char strbuf[16], strbuf1[20];
-	char *nameptr = name;
+	const char *nameptr = name;
 
 	/* We don't know the hardware specs yet and there is no ivideo */
 
-- 
2.39.2

