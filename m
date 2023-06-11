Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AC72B0BA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFKIQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjFKIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 04:16:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053B30CB;
        Sun, 11 Jun 2023 01:16:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7f4819256so23887925e9.1;
        Sun, 11 Jun 2023 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686471375; x=1689063375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBp71EpjbBFFfBTbE6StpwPfHx+ioBBfY02xa9s3Mk8=;
        b=HTAA5G6Z9E/VB73DHO4rxeAG1KAOC1C45MY5RXkHifPQt7FGNuWFvjdVs5m0bne+lk
         3BCWrTHY9yy7USuha4gY3tEjvNAnim+d6kKHvOL/XIQpv0IXDMzLEFfWlijpbswHPAsh
         RKEa/QF5dlzFQlsF/ZLH1lwPA6F5gewpZaHvRgEMub4iw5/sfjsKUFCF+3aXnNK4NEG7
         xsvAmXF+jCmnUFzYBs9oz6fvy948T7na2FEi7zlczXwFmdlhieRn+rt1Bg6EUYapMHVc
         Pg5UTkssCyteoY05EJWkD440ZcdgzpzhWb3Zno14TGc45jVJj1zIi1cn55gkXBWuEU3j
         z2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686471375; x=1689063375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBp71EpjbBFFfBTbE6StpwPfHx+ioBBfY02xa9s3Mk8=;
        b=U4G8vM7ookhuFT0LpPvbbFLc4xJvSfuCjp+mtQXtMlO0YIfOy+xzVNn8fn9XfDDZXc
         J2jqDp/+ewavrDjDhvbRuLSr9uMZi/ZYrw7lRO9t9d6BuSBu70vZtvbv+jWqmjNYiQDl
         dk/KOXdneYzePFNJwH7vCG8VhI/5ikiwJv5uo4fNEiSAmfx7fkzARPDKXCLpKIQlP406
         sKcqYDK/AmTDOyYsjCfbwjbyvX1lQaQTrYd9vvMl2MjfVYLF81b6iae1mVMewT+uq8cP
         NPk9hLaFDVd+6V7zcd6jPWPF+cym1RzWRnCM3m+y5MKqRGEmSnFFfvqAeVer6u/tqxCu
         A90w==
X-Gm-Message-State: AC+VfDyDgnjztRfS+gKqA6AeDcPsf7vqcrMa3UdtaMu79XOyzgezR0aR
        645pej0InEN4ui5iPRk7MWQ=
X-Google-Smtp-Source: ACHHUZ4XULCaMtPSLP8E4rYYaX9aegzwRLkL2t9oCD5nApWgBEev2pWc/9iS09hK11hMr3BqiHyR8g==
X-Received: by 2002:a7b:cb90:0:b0:3f5:878:c0c2 with SMTP id m16-20020a7bcb90000000b003f50878c0c2mr4382412wmi.3.1686471374902;
        Sun, 11 Jun 2023 01:16:14 -0700 (PDT)
Received: from arinc9-Xeront.lan (178-147-169-233.haap.dm.cosmote.net. [178.147.169.233])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003f6132f95e6sm7748979wmj.35.2023.06.11.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 01:16:14 -0700 (PDT)
From:   "=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?=" <arinc9.unal@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Landen Chao <landen.chao@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 4/7] net: dsa: mt7530: fix handling of BPDUs on MT7530 switch
Date:   Sun, 11 Jun 2023 11:15:44 +0300
Message-Id: <20230611081547.26747-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230611081547.26747-1-arinc.unal@arinc9.com>
References: <20230611081547.26747-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

BPDUs are link-local frames, therefore they must be trapped to the CPU
port. Currently, the MT7530 switch treats BPDUs as regular multicast
frames, therefore flooding them to user ports. To fix this, set BPDUs to be
trapped to the CPU port.

BPDUs received from a user port will be trapped to the numerically smallest
CPU port which is affine to the DSA conduit interface that is up.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---

v2: Add this patch.

---
 drivers/net/dsa/mt7530.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index df2626f72367..c2af23f2bc5d 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2259,6 +2259,10 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	/* Trap BPDUs to the CPU port */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_BPDU_CPU_ONLY);
+
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
 
-- 
2.39.2

