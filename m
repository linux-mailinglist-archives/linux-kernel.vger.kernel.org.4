Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575B67F140
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjA0WjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjA0WjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:39:03 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D317CDC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:38:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a184so4242518pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6iBoXpwgGR/ZVf0A5SekY8NMqe2gKVl+e0DSwe8dcg=;
        b=cQRXyyWhjENY1EiRP7qhQP3wf+6XMReMMAZnfWe2Kur1YO8bKgprzMVIQHTQs2DG82
         bpmy5tKTm5RBWsUwvT6HOsWbJR1SXZaIP93syx0Y1BvqG10wdKJrUXq/iYPkgUmUS6Z6
         m3DmEvmavq2Fh5cIiGPWYfyC54a7ureEExsJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6iBoXpwgGR/ZVf0A5SekY8NMqe2gKVl+e0DSwe8dcg=;
        b=6WMoulIYkXq2aDoejsqHJha6ndKynp3katlWvCc85VTDGyIzZ7sbDPVxVCPKphdxVr
         e3BJwEMl0A/Ys55B7Cw3pynv1Qvf2P7z4GKlFh9FSfi/pWmIInQ0Gz3e4J2UVcUzKt6p
         EbI3x75BzSTYyznM9fQr3zL0cd7FrQkofeudTZ3t9in8IqF0Gpc1At0UgChHNYvMd6E8
         kapjDkHM0TOz+og5yIs22YZkoj1KPjx3r2A/yj2qGzFcOcY0azRTDcwhf8SkpJr1JVY9
         6Cr+IkRL2YwMz1CVDVBcusTKwFj8QV53L1tmHkm8ygcxC23jRQZNaJ848Br1jBlMFjAS
         3hmg==
X-Gm-Message-State: AO0yUKUew6xCRpMao24sHHFjBJqP/J0hLSDg21N22w6dqzPNISB0td+h
        QjWI7BAoW19JJhyEptaLiFwsTw==
X-Google-Smtp-Source: AK7set9nEOp8oJvvITNyqKkOgdNSk+TAokzAcmXTUWbfu3zV7ISgRJfcLKUBqQSOq9XH0hqHE2L/bQ==
X-Received: by 2002:a05:6a00:1d04:b0:592:7341:781f with SMTP id a4-20020a056a001d0400b005927341781fmr35668pfx.31.1674859136095;
        Fri, 27 Jan 2023 14:38:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id br13-20020a056a00440d00b00581ad007a9fsm3088755pfb.153.2023.01.27.14.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:38:55 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kees Cook <keescook@chromium.org>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] net: ethernet: mtk_eth_soc: Avoid truncating allocation
Date:   Fri, 27 Jan 2023 14:38:54 -0800
Message-Id: <20230127223853.never.014-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; h=from:subject:message-id; bh=yfJ1UtZNOwTETD8Al2XTKq5PIE5VchaJolozWYUefHY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FJ9hMXYGB04Nb8fnZvQFD8SaUvBjTtQlF3d5mZ8 JQnQwBqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RSfQAKCRCJcvTf3G3AJuk7D/ 98s7Y81Xj52PumgZDzo42yrLNHSRGuvMRYB0A/Q4Zt7FebJnq8KJmO1UKXey36nsJXuwoxCuFJw6VQ WoGAcBv3Xd6q2yO8GzMzPv/2JSTc8ATaSQaljNkd8bAbGvtpLTMwzLNW/JXYovBqgZzMRVzRvSogMF fA51JTFGlNoiZQjfsVIfnV9yVf0MeOJXx58PbH2hPftHeA63ZMVVgGZCzyWqrXqrPeiYtJ/oybWxhd X++53/jblEmlKNyhcpGxEmMnLtk7whId4NiXn+TECSGFOfGy/uwip6rvRdKSrjufQ0iNCHMQtN4L0Y t7Rrm+ldNKiGr2RfYhfk78//8keWFu7lfOEt7WcSsx+e07aSWGIYFxb3t99JktWxVGztvciwIE5irP bQos//ov2Bi7hRrZjt5mZKfpBlfB5MyparOnAE9nf3Wc4jRi9eYaPNg+9XAFAhO8oNCw5YEHsluu2i sCzLo3iPw7Se47jNfjm5JyIIu1rmL6M6w4E3jDDqyMPGsQ5Q4obMjaZJAuEicR5KpoTlcnLp3CJohC AChj0Z0ugQJ77+9dAAXUzahg5vmgs0HkmTqMtgaV3QmOvsla5A7NR1DYyvl18aAZJo9n4bcscCV850 5Mud8wqUAhE+EHIBq1qNLVa0ksoN2cUcOyVcYwv3IdiqilS9ndN263ArKt8g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There doesn't appear to be a reason to truncate the allocation used for
flow_info, so do a full allocation and remove the unused empty struct.
GCC does not like having a reference to an object that has been
partially allocated, as bounds checking may become impossible when
such an object is passed to other code. Seen with GCC 13:

../drivers/net/ethernet/mediatek/mtk_ppe.c: In function 'mtk_foe_entry_commit_subflow':
../drivers/net/ethernet/mediatek/mtk_ppe.c:623:18: warning: array subscript 'struct mtk_flow_entry[0]' is partly outside array bounds of 'unsigned char[48]' [-Warray-bounds=]
  623 |         flow_info->l2_data.base_flow = entry;
      |                  ^~

Cc: Felix Fietkau <nbd@nbd.name>
Cc: John Crispin <john@phrozen.org>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Mark Lee <Mark-MC.Lee@mediatek.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c | 3 +--
 drivers/net/ethernet/mediatek/mtk_ppe.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 451a87b1bc20..6883eb34cd8b 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -615,8 +615,7 @@ mtk_foe_entry_commit_subflow(struct mtk_ppe *ppe, struct mtk_flow_entry *entry,
 	u32 ib1_mask = mtk_get_ib1_pkt_type_mask(ppe->eth) | MTK_FOE_IB1_UDP;
 	int type;
 
-	flow_info = kzalloc(offsetof(struct mtk_flow_entry, l2_data.end),
-			    GFP_ATOMIC);
+	flow_info = kzalloc(sizeof(*flow_info), GFP_ATOMIC);
 	if (!flow_info)
 		return;
 
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
index 16b02e1d4649..5e8bc48252b1 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
@@ -279,7 +279,6 @@ struct mtk_flow_entry {
 		struct {
 			struct mtk_flow_entry *base_flow;
 			struct hlist_node list;
-			struct {} end;
 		} l2_data;
 	};
 	struct rhash_head node;
-- 
2.34.1

