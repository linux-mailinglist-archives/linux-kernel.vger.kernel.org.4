Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3FB734F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjFSJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFSJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB7110E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2BA60204
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9ABC433C0;
        Mon, 19 Jun 2023 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687165963;
        bh=qxfUKz7rm5GuWEeyfp0weQ2JFwovXXhOCgww3LgVweQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRznDpGmTl7br3LipdSczF4mjvDiVoU4H2w2jIJzeS2NRj6AyAwmHlptSVRvcDNws
         MS/kogBoz3+GM69Yg/gzsaYVzgbvU3wj1NkYzX41lODZQyu4F9SGzuB+Al1FodFnMU
         /BMOQGUCPcpsjORuvNY6D3TpKkbsaBCWzNHN790KzY37Z4+qrDwsS4ixfn1G74C2qq
         uYVDCLqZQwTRZ2fWWOlQmZ3gf6rzj/tycq0H34Qom908ygXhnbKf/gePAR+LKkVD7p
         vSrcHmoTHx21hnmhZS81Ee1PBuGjDLa1bx/rJkkpJxsV8nIYTUmPxy7d+23reaTtUu
         S5g7ojolXdVnw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sfc: selftest: fix struct packing
Date:   Mon, 19 Jun 2023 11:12:11 +0200
Message-Id: <20230619091215.2731541-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619091215.2731541-1-arnd@kernel.org>
References: <20230619091215.2731541-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Three of the sfc drivers define a packed loopback_payload structure with an
ethernet header followed by an IP header. However, the kernel definition
of iphdr specifies that this is 4-byte aligned, causing a W=1 warning:

net/ethernet/sfc/siena/selftest.c:46:15: error: field ip within 'struct efx_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        struct iphdr ip;

As the iphdr packing is not easily changed without breaking other code,
change the three structures to use a local definition instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/sfc/falcon/selftest.c | 21 ++++++++++++++++++++-
 drivers/net/ethernet/sfc/selftest.c        | 21 ++++++++++++++++++++-
 drivers/net/ethernet/sfc/siena/selftest.c  | 21 ++++++++++++++++++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/selftest.c b/drivers/net/ethernet/sfc/falcon/selftest.c
index 6a454ac6f8763..fb7fcd27a33a5 100644
--- a/drivers/net/ethernet/sfc/falcon/selftest.c
+++ b/drivers/net/ethernet/sfc/falcon/selftest.c
@@ -40,7 +40,26 @@
  */
 struct ef4_loopback_payload {
 	struct ethhdr header;
-	struct iphdr ip;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		__u8	ihl:4,
+			version:4;
+#elif defined (__BIG_ENDIAN_BITFIELD)
+		__u8	version:4,
+			ihl:4;
+#else
+#error	"Please fix <asm/byteorder.h>"
+#endif
+		__u8	tos;
+		__be16	tot_len;
+		__be16	id;
+		__be16	frag_off;
+		__u8	ttl;
+		__u8	protocol;
+		__sum16	check;
+		__be32	saddr;
+		__be32	daddr;
+	} __packed ip; /* unaligned struct iphdr */
 	struct udphdr udp;
 	__be16 iteration;
 	char msg[64];
diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index 3c5227afd4977..440a57953779c 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
@@ -43,7 +43,26 @@
  */
 struct efx_loopback_payload {
 	struct ethhdr header;
-	struct iphdr ip;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		__u8	ihl:4,
+			version:4;
+#elif defined (__BIG_ENDIAN_BITFIELD)
+		__u8	version:4,
+			ihl:4;
+#else
+#error	"Please fix <asm/byteorder.h>"
+#endif
+		__u8	tos;
+		__be16	tot_len;
+		__be16	id;
+		__be16	frag_off;
+		__u8	ttl;
+		__u8	protocol;
+		__sum16	check;
+		__be32	saddr;
+		__be32	daddr;
+	} __packed ip; /* unaligned struct iphdr */
 	struct udphdr udp;
 	__be16 iteration;
 	char msg[64];
diff --git a/drivers/net/ethernet/sfc/siena/selftest.c b/drivers/net/ethernet/sfc/siena/selftest.c
index 07715a3d6beab..b8a8b0495f661 100644
--- a/drivers/net/ethernet/sfc/siena/selftest.c
+++ b/drivers/net/ethernet/sfc/siena/selftest.c
@@ -43,7 +43,26 @@
  */
 struct efx_loopback_payload {
 	struct ethhdr header;
-	struct iphdr ip;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		__u8	ihl:4,
+			version:4;
+#elif defined (__BIG_ENDIAN_BITFIELD)
+		__u8	version:4,
+			ihl:4;
+#else
+#error	"Please fix <asm/byteorder.h>"
+#endif
+		__u8	tos;
+		__be16	tot_len;
+		__be16	id;
+		__be16	frag_off;
+		__u8	ttl;
+		__u8	protocol;
+		__sum16	check;
+		__be32	saddr;
+		__be32	daddr;
+	} __packed ip; /* unaligned struct iphdr */
 	struct udphdr udp;
 	__be16 iteration;
 	char msg[64];
-- 
2.39.2

