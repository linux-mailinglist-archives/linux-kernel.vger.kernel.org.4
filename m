Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90140732B82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbjFPJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344164AbjFPJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA549DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFCE6147F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05596C433C0;
        Fri, 16 Jun 2023 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686907611;
        bh=tARQMYG/aYeqmMUAJH7cbPA26P2Il2Rzs/1oa9c9qgk=;
        h=From:To:Cc:Subject:Date:From;
        b=CCgVGKytISv+fj1viUpOXb/VC4Og1rkCvfO1nGrZGtrr1hcPuZ0OGg72pWvzllRMt
         B2i720ZfbsqDU3GVRmN6t7ig12mjc3aT0Fo+p3oR10Nv3yAlD4LtPlTSLUYfYeeg3B
         bGj3FAUqVSldEwRGDSkJ7bujvfySd2/5hftnxzPLC8DhikYfFUna16dmx7UZzUNM4/
         4pn4P/OsmywmiZ6cw+2KCP0P1V1hlCn42pdDJ//LUDJiUgy0ZD3nx8MtrDgqG2SO48
         fmE0/zJZ8CLWyI8+9UTPddpKhqr8Ht40TYTI9yS8Kv/T85fISnMtqW5qcGxic477Hd
         hB3qSJirhs9bQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] net: atlantic: fix ring buffer alignment
Date:   Fri, 16 Jun 2023 11:26:32 +0200
Message-Id: <20230616092645.3384103-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang warns about conflicting packing annotations:

drivers/net/ethernet/aquantia/atlantic/aq_ring.h:72:2: error: field  within 'struct aq_ring_buff_s' is less aligned than 'union aq_ring_buff_s::(anonymous at drivers/net/ethernet/aquantia/atlantic/aq_ring.h:72:2)' and is usually due to 'struct aq_ring_buff_s' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]

This was originally intended to ensure the structure fits exactly into
32 bytes on 64-bit architectures, but apparently never did, and instead
just produced misaligned pointers as well as forcing byte-wise access
on hardware without unaligned load/store instructions.

Update the comment to more closely reflect the layout and remove the
broken __packed annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../net/ethernet/aquantia/atlantic/aq_ring.h  | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 0a6c34438c1d0..a9cc5a1c4c479 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -26,19 +26,23 @@ struct aq_rxpage {
 	unsigned int pg_off;
 };
 
-/*           TxC       SOP        DX         EOP
- *         +----------+----------+----------+-----------
- *   8bytes|len l3,l4 | pa       | pa       | pa
- *         +----------+----------+----------+-----------
- * 4/8bytes|len pkt   |len pkt   |          | skb
- *         +----------+----------+----------+-----------
- * 4/8bytes|is_gso    |len,flags |len       |len,is_eop
- *         +----------+----------+----------+-----------
+/*           TxC       SOP        DX         EOP	RX
+ *         +----------+----------+----------+----------+-------
+ *   8bytes|len l3,l4 | pa       | pa       | pa       | hash
+ *         +----------+----------+----------+----------+-------
+ * 4/8bytes|len pkt   |len pkt   |          | skb      | page
+ *         +----------+----------+----------+----------+-------
+ * 4/8bytes|is_gso    |len,flags |len       |len,is_eop| daddr
+ *         +----------+----------+----------+----------+-------
+ * 4/8bytes|          |          |          |          | order,pgoff
+ *         +----------+----------+----------+----------+-------
+ * 2bytes  |          |          |          |          | vlan_rx_tag
+ *         +----------+----------+----------+----------+-------
+ * 8bytes  +                   flags
+ *         +----------+----------+----------+----------+-------
  *
- *  This aq_ring_buff_s doesn't have endianness dependency.
- *  It is __packed for cache line optimizations.
  */
-struct __packed aq_ring_buff_s {
+struct aq_ring_buff_s {
 	union {
 		/* RX/TX */
 		dma_addr_t pa;
-- 
2.39.2

