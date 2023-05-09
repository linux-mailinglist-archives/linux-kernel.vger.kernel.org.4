Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF056FC510
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEILfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjEILfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:35:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184922D62;
        Tue,  9 May 2023 04:35:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f24cfb8539so2872364e87.3;
        Tue, 09 May 2023 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683632121; x=1686224121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zWM9Ku4QEF1MXGuje7rt5LFZjeiu0mnfAywbxjklTg=;
        b=GsClSg+96jqtWjYLPTKM5pAJI4Eo2Ah8uaXlBAjQknewgiD5RpDgLbDOeUHrrdfrQj
         WuJ0Y6pxTynTReP5smOZrhhjFAN7AVjy0gOR/IKJNhvNZClw6ASSuIfokJ9+WvofxOfM
         9aiSdbQK+suvq1C0Pe2xoy/YOi1G5c2WKReuwgQnwIZzkeM7IQe3cyRksKtFDaOGZUtP
         8DIdgFxhvFepNFy7jRPo+Ql7m1jw76sq13DjFpna9nCCeyHhYRiio1PUxHCQV5R1mK0y
         BKnop1iVJlY7vVgXY4M91QeAEczd+kz22dym4iKCDv7/g5OAC4QJ0cZ1hyOiQUyv/PPn
         emdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683632121; x=1686224121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zWM9Ku4QEF1MXGuje7rt5LFZjeiu0mnfAywbxjklTg=;
        b=RMKOH9b99MAbRuR1Jtt11HX7oB1/jl14YpVE610gw2hHDWqic3havwTbznUiO4Qkum
         xepGieogzkqQuaDwBj+j7Kc4vp1Bi9ffy/39mktLhx1QgYN9voKWd/ly7cQKtyVLQUu4
         iR7kn0ivenuA6c0p5rXxvwh2AEovLMjIXr0M5EgfXYGWFCBmZpUmeE496QSlt99vsrSF
         1OJZPiJaAgzoE3mndM7qdFDUEiGWQ5B6xuSWubRPGrx59tYdWl+8onON0K0z2F8ETiQn
         LEbmIhvqZhWB+5rnhWXKtfzc1omCSEAwVChgDIUcz3KS19f/H9l2JIoQFzQOazH189SO
         Rnrw==
X-Gm-Message-State: AC+VfDw9jZSvHMFDiyCuKj3OH2IvIAZw5xypEeCKLS6rWP8quHYQUTWl
        HcWdG7T/OGjJ+n/gr1JWRG8=
X-Google-Smtp-Source: ACHHUZ4rSmlvz0jORkDZiqRrHk7JyLuRrDC5VraFbgQQXsHmS+H1SxrFJ8w8Mx2ICmrN1/BOlrRVRQ==
X-Received: by 2002:ac2:46f8:0:b0:4ef:fe49:e14f with SMTP id q24-20020ac246f8000000b004effe49e14fmr647454lfo.20.1683632121311;
        Tue, 09 May 2023 04:35:21 -0700 (PDT)
Received: from localhost.localdomain (93-80-66-133.broadband.corbina.ru. [93.80.66.133])
        by smtp.googlemail.com with ESMTPSA id k16-20020ac24570000000b004f25ccac240sm108940lfm.74.2023.05.09.04.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:35:21 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v2 4/5] net/ncsi: add shift MAC address property
Date:   Tue,  9 May 2023 14:35:03 +0000
Message-Id: <20230509143504.30382-5-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509143504.30382-1-fr0st61te@gmail.com>
References: <20230509143504.30382-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the shift MAC address property for GMA command which provides which
shift should be used but keep old one values for backward compatability.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 069c2659074b..1f108db34d85 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -9,6 +9,8 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <net/ncsi.h>
 #include <net/net_namespace.h>
@@ -616,9 +618,12 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
+	struct platform_device *pdev;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
+	s32 shift_mac_addr = 0;
+	u64 mac_addr;
 	int ret = 0;
 
 	/* Get the response header */
@@ -635,7 +640,17 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 
 	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
-		eth_addr_inc((u8 *)saddr.sa_data);
+		shift_mac_addr = 1;
+
+	pdev = to_platform_device(ndev->dev.parent);
+	if (pdev)
+		of_property_read_s32(pdev->dev.of_node,
+				     "mac-address-increment", &shift_mac_addr);
+
+	/* Increase mac address by shift value for BMC's address */
+	mac_addr = ether_addr_to_u64((u8 *)saddr.sa_data);
+	mac_addr += shift_mac_addr;
+	u64_to_ether_addr(mac_addr, (u8 *)saddr.sa_data);
 	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
 		return -ENXIO;
 
-- 
2.40.1

