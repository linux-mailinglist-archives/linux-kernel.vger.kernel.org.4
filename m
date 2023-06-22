Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3373AD4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFVXnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjFVXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2542121;
        Thu, 22 Jun 2023 16:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 650D661710;
        Thu, 22 Jun 2023 23:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7A8C433C8;
        Thu, 22 Jun 2023 23:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687477381;
        bh=XiHdQW2COChuhdW8/pHNZiGOCWZC/cyIHQHJxwAaX/w=;
        h=Date:From:To:Cc:Subject:From;
        b=XPuPi2nRjJ1ZKqb8yiXgAFJRBNAh6RfTKlUPPDka5LPaOpshTka603rNJuU+b4y2m
         ljolB9PryWxis7ZnW5nFJaw1HMfbgeSkAwDA3Sa0K6OO8pXiGYyrsq5zsJRcGPc4Vn
         6h6aPvzWpPKlfR7i50bq7i9w4l0//9U0t1ROgvG/91lJQ8UwSe+TvN/oUVesRG9lHN
         0lcoLWBGCaqJi+DQ1Cd7F/I8UL4pOvv8pI/1rllpFNr5UHMHmlk5x78DUkVtiioOix
         OyJK4eEnRv3RVNEyD2V08kzKG//OH42lrGCImJxknwqypnT75CzHyECwtT+aFYDaOl
         rpGcJXJg2iKVw==
Date:   Thu, 22 Jun 2023 17:43:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] MIPS: dec: prom: Address -Warray-bounds warning
Message-ID: <ZJTcvfpvhvF+OLjc@work>
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

Zero-length arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace zero-length array with flexible-array
member in struct memmap.

Address the following warning found after building (with GCC-13) mips64
with decstation_64_defconfig:
In function 'rex_setup_memory_region',
    inlined from 'prom_meminit' at arch/mips/dec/prom/memory.c:91:3:
arch/mips/dec/prom/memory.c:72:31: error: array subscript i is outside array bounds of 'unsigned char[0]' [-Werror=array-bounds=]
   72 |                 if (bm->bitmap[i] == 0xff)
      |                     ~~~~~~~~~~^~~
In file included from arch/mips/dec/prom/memory.c:16:
./arch/mips/include/asm/dec/prom.h: In function 'prom_meminit':
./arch/mips/include/asm/dec/prom.h:73:23: note: while referencing 'bitmap'
   73 |         unsigned char bitmap[0];

This helps with the ongoing efforts to globally enable -Warray-bounds.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/323
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/mips/include/asm/dec/prom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index 1e1247add1cf..908e96e3a311 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -70,7 +70,7 @@ static inline bool prom_is_rex(u32 magic)
  */
 typedef struct {
 	int pagesize;
-	unsigned char bitmap[0];
+	unsigned char bitmap[];
 } memmap;
 
 
-- 
2.34.1

