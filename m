Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767AC61E0DB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKFI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKFI0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:26:30 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609CCB1C0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667723169; bh=yX2+265rR785M95fcHNy467AL5AwbELaJnp6X7G2qZA=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=np7fFDM1XDP0KCPeEjakvsHzqo7RO/2yRlvxCCCNQ/6NLWYt/yv+kgZMJQoY/xfpZ
         aEmI+KvXRRYiuU+D/2wT3OWEiW/aTxiC2WhhczVn5eQSNkLa2sxvjthojgCDsCoA1Z
         g2eYVoeZTXjS5hhn74r7fJ5PDPfrGjo+qfCXcD+w=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  6 Nov 2022 09:26:09 +0100 (CET)
X-EA-Auth: XktWBgDFtHub354BC+dxxKliuilwtqXGDLzjuFBXbch+6Vu+T4PKfcqK1yl3KXCjd08T7ttmQsZpXyjbsVWn622SMiCd1gX+
Date:   Sun, 6 Nov 2022 13:56:01 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: simplify complex pointer casting
Message-ID: <Y2dvmdGxQfmK4O6F@qemulion>
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

Pointers to structures udphdr and dhcpMessage are derived by casting
adjacent pointers with size_t. Such typecast of pointer using size_t
is not preferred. The code looks complex and delicate. Simplify such
casting by utilizing generic "void *" casting.
While at this change, remove the unnecessary __be32 casting for member
variable "cookie".

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index a23f7df373ed..e9b0906d0d74 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -610,13 +610,15 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 			struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);

 			if (iph->protocol == IPPROTO_UDP) { /*  UDP */
-				struct udphdr *udph = (struct udphdr *)((size_t)iph + (iph->ihl << 2));
+				struct udphdr *udph = (void *)iph + (iph->ihl << 2);

 				if ((udph->source == htons(CLIENT_PORT)) &&
 				    (udph->dest == htons(SERVER_PORT))) { /*  DHCP request */
-					struct dhcpMessage *dhcph =
-						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
-					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
+					u32 cookie;
+					struct dhcpMessage *dhcph;
+
+					dhcph = (void *)udph + sizeof(struct udphdr);
+					cookie = be32_to_cpu(dhcph->cookie);

 					if (cookie == DHCP_MAGIC) { /*  match magic word */
 						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
--
2.34.1



