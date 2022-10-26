Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5725460E129
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiJZMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiJZMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19959EC1DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B436F61EBB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864BBC433D6;
        Wed, 26 Oct 2022 12:48:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dEDEe5QN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666788489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=apwIszUizVMqaQYmtTXHJT75dZsnVikCkj6h7QCdmtQ=;
        b=dEDEe5QN4HqTBzqHy+Lkz6FfzySBMPFoWEa29Uaymp4O0TeF4RdZUTEXNVDrNB3UHMJmET
        qChIZfAC+m8aZR2pBPR5cL53PRVHAdzWhgXllwhQfR99OQjHohMUs3Lt5exop/86w0N6Dz
        CmZZGcDn1GqoMg7NdVAS4WcuZvmg5oM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c4ded515 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 26 Oct 2022 12:48:08 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: mac_via: use explicitly signed char
Date:   Wed, 26 Oct 2022 14:48:01 +0200
Message-Id: <20221026124801.1576326-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `val` variable is set to -1 and compared against < 0, which means
it's assumed to be signed. However, soon char is to become unsigned
tree-wide. So explicitly mark `val` as signed to that it keeps working
the same way.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Geert - Linus asked me to consolidate all of the unsigned-char fixups in
one tree. So, unless you plan on taking this for 6.1, I'll queue it up
in that tree for 6.2, following your ack. -Jason

 arch/m68k/include/asm/mac_via.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/mac_via.h b/arch/m68k/include/asm/mac_via.h
index 1149251ea58d..e37fcbf47926 100644
--- a/arch/m68k/include/asm/mac_via.h
+++ b/arch/m68k/include/asm/mac_via.h
@@ -269,7 +269,7 @@ extern int via2_scsi_drq_pending(void);
 
 static inline int rbv_set_video_bpp(int bpp)
 {
-	char val = (bpp==1)?0:(bpp==2)?1:(bpp==4)?2:(bpp==8)?3:-1;
+	signed char val = (bpp==1)?0:(bpp==2)?1:(bpp==4)?2:(bpp==8)?3:-1;
 	if (!rbv_present || val<0) return -1;
 	via2[rMonP] = (via2[rMonP] & ~RBV_DEPTH) | val;
 	return 0;
-- 
2.38.1

