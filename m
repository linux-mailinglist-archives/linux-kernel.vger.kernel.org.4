Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F660E162
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiJZNBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiJZNBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D4937A3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A9461CFF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEB6C433C1;
        Wed, 26 Oct 2022 13:00:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a2kNVQCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666789258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wn4rcCGJFzWSShxphOuVmw9FoB5ua99RsPnKX/sTS9I=;
        b=a2kNVQCuGdenyXAEEn+jmBuDNkHLJE1Lzf2k71RDhwbb8kubUbpqi/6Ufb4eV7ucJ2YH6A
        8sfZAx9se/eoYlvVUPlmx4h0IM/70+RnYiFWsE9q4r3Nt48Q6l+69MGUOBp7ZinaQtmwLu
        E+zbkiThiJDNu8FhEJfh6arN7KPOyj8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5399f345 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 26 Oct 2022 13:00:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: mac_via: remove unused rbv_set_video_bpp()
Date:   Wed, 26 Oct 2022 15:00:51 +0200
Message-Id: <20221026130051.1577286-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In examining rbv_set_video_bpp()'s improper usage of a non-explictly
signed char type, it turns out that the function is actually unused. So
remove it.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/include/asm/mac_via.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/m68k/include/asm/mac_via.h b/arch/m68k/include/asm/mac_via.h
index 1149251ea58d..a9ef1e9ba6c4 100644
--- a/arch/m68k/include/asm/mac_via.h
+++ b/arch/m68k/include/asm/mac_via.h
@@ -267,14 +267,6 @@ extern void via1_irq(struct irq_desc *desc);
 extern void via1_set_head(int);
 extern int via2_scsi_drq_pending(void);
 
-static inline int rbv_set_video_bpp(int bpp)
-{
-	char val = (bpp==1)?0:(bpp==2)?1:(bpp==4)?2:(bpp==8)?3:-1;
-	if (!rbv_present || val<0) return -1;
-	via2[rMonP] = (via2[rMonP] & ~RBV_DEPTH) | val;
-	return 0;
-}
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_MAC_VIA_H_ */
-- 
2.38.1

