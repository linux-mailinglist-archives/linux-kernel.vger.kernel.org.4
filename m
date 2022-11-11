Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25203625F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiKKQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiKKQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:17:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54341658C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:17:38 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i21so8243292edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPFK299nWfDr/V9J7p74DjQEhALYVf51OEuCFpbYSbM=;
        b=KBU+AAvwge0Xr3lQE8QmWKlPSunFws73fRLUrfKBI3t0C7DwjZNxz9x1Rs/CD8AOg7
         aACR3Djshp/4SGNH1bl3rM8whcVgrQwz8IpxNGkznbL+XM9X+u05meAx3yOmRGlMyEoe
         bXMuNxJrrrdXPC6j9kBN7+DChSccZwvS1fHmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPFK299nWfDr/V9J7p74DjQEhALYVf51OEuCFpbYSbM=;
        b=sJtv8NM4auKGtdB03/9UPjN62Lmf77oR7d1bPs0nIQW0lKYMB+rkpLwg4ZYqUkS2bb
         xsB9eQhiDFtpJcMsi6Jxz3GW/1N1CGpI+LPJqObm5AT6YI9d5eWUZPeXoS/Q4fxExZ/r
         5ThgCUoesW6lJSd7BuCB5Tt3MChGO4QDiRy1s8gI5+kt56XVNcADr0EasgEkWywyaHDl
         dMgJJAf6uAzlMNo2ob/UnurS1VgYxDeO/uGO9bPSAyiM4XEtNarRjJWNgba52daQan2P
         qpiOKBX9By7leni/ZQEaKesyAoR9sOIqSdJsvUqJgXtcqa0WVyaOPaCxOSqtFkIDQs/d
         3jRQ==
X-Gm-Message-State: ANoB5pnFPzKz75pGHjnpA1ThYjUd3TB3lQqAwPtDKGafyZC327LAkzW1
        bNvAoX8/qn77HH9yBIDrRte2pA==
X-Google-Smtp-Source: AA0mqf7u9SiEuoNGLTdYBPh06DGK3wmN6MkxzOpkOfRUqlwNciq8kr6m4nWPJ2n3bwGG3KfupCj0Mg==
X-Received: by 2002:aa7:d4d3:0:b0:45f:b80f:1fe8 with SMTP id t19-20020aa7d4d3000000b0045fb80f1fe8mr2064057edr.118.1668183456903;
        Fri, 11 Nov 2022 08:17:36 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b007aacfce2a91sm1038990ejd.27.2022.11.11.08.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:17:35 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: use NET_NAME_PREDICTABLE for user ports with name given in DT
Date:   Fri, 11 Nov 2022 17:17:28 +0100
Message-Id: <20221111161729.915233-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user port has a label in device tree, the corresponding
netdevice is "predictably named by the kernel".

Expose that information properly for the benefit of userspace tools
that make decisions based on the name_assign_type attribute,
e.g. a systemd-udev rule with "kernel" in NamePolicy.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 net/dsa/dsa2.c  |  3 ---
 net/dsa/slave.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index e504a18fc125..522fc1b6e8c6 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -1364,9 +1364,6 @@ static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
 
 static int dsa_port_parse_user(struct dsa_port *dp, const char *name)
 {
-	if (!name)
-		name = "eth%d";
-
 	dp->type = DSA_PORT_TYPE_USER;
 	dp->name = name;
 
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index a9fde48cffd4..dfefcc4a9ccf 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2374,16 +2374,25 @@ int dsa_slave_create(struct dsa_port *port)
 {
 	struct net_device *master = dsa_port_to_master(port);
 	struct dsa_switch *ds = port->ds;
-	const char *name = port->name;
 	struct net_device *slave_dev;
 	struct dsa_slave_priv *p;
+	const char *name;
+	int assign_type;
 	int ret;
 
 	if (!ds->num_tx_queues)
 		ds->num_tx_queues = 1;
 
+	if (port->name) {
+		name = port->name;
+		assign_type = NET_NAME_PREDICTABLE;
+	} else {
+		name = "eth%d";
+		assign_type = NET_NAME_UNKNOWN;
+	}
+
 	slave_dev = alloc_netdev_mqs(sizeof(struct dsa_slave_priv), name,
-				     NET_NAME_UNKNOWN, ether_setup,
+				     assign_type, ether_setup,
 				     ds->num_tx_queues, 1);
 	if (slave_dev == NULL)
 		return -ENOMEM;
-- 
2.37.2

