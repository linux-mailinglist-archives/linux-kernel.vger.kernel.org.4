Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAAD747C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 06:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjGEEoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 00:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGEEoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 00:44:12 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841210F5;
        Tue,  4 Jul 2023 21:44:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3942c6584f0so4302094b6e.3;
        Tue, 04 Jul 2023 21:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688532251; x=1691124251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVpUkwBOZbsHjLpV6C1yBDf7y/jZ7ZCX4vzlKONMbpw=;
        b=bw2EEG2EWPLX8H0PDe07GtNDB0m3VDp0Gkl4DaHdzS2hiN2F1mqVi/pBvO6ExjTIJe
         GScsTGrpghp2WmCB3RZdnKDN9EJhZEK98LGSZFppGG9X4nl2pPXtY2pL8RbTKp+YcyXq
         hTqZAYSsmWhDD17GNyS/xgHFOt2TbCzVnwnWq6USIk1cC4yAVBp9rIIvVmGoWk18ESb+
         ntwk0jrAIirEsSnF1NLZ98sNA/gg6Ji9JElnKxswv/pWbMoZo2U1D378Aivb9mSn8Wv2
         l4uAX4m0mF8fXq2ZD2fyxbYRnCTM17crm799/nLJXujUjx48a6+ymuBRX9lWclNAQyuH
         F23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688532251; x=1691124251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVpUkwBOZbsHjLpV6C1yBDf7y/jZ7ZCX4vzlKONMbpw=;
        b=CjmfiWwM8+z/vTD1FqZG91u1NUmJVfdlzfXF/pJUdfl3RfF6pbwiA9pWHgNB4aZ737
         Rr0cQ0147j09AY/alf910mlmQbbhafGdGaSd7cb/7lJ0BaAZINf5dGWxiU0Uzv027HsC
         LjtOHUTMo+4SpiAJ9/IbSeUwt4fZ2o9uAjCqH0c30GkZ2TDEw70GTLWJRTd/U+TE+E7I
         +Vy1ELo8s1oJVYHLZLWjeZAsI9L0AbF92rjkI2MIqOiZzdGAjFKJTO9WTKhp0f2iNYRw
         XBR8OMpBame/H7IqzvWStKvPAm2UWfNguV0z4wlMUDPJIIOhNdJ3KWJ0p+bWhIUpQEn+
         bWzw==
X-Gm-Message-State: AC+VfDxxjnR6aNjCQxNkMbiusn9IUd+2SOcPAp6fpqePjsPYruzc61f9
        BTWDlw7H4lcqPxTzEHdHYLPSUWVBGyObBwor
X-Google-Smtp-Source: ACHHUZ73F8CzX548+D8Z3+69mZfwuRybsCI6bbdS0inLDiEdakzhvInHm+9WcyeBDW0JxWM5KsIOsA==
X-Received: by 2002:a54:4199:0:b0:3a2:572a:eaa6 with SMTP id 25-20020a544199000000b003a2572aeaa6mr14706399oiy.5.1688532251268;
        Tue, 04 Jul 2023 21:44:11 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b0026309d57724sm451911pjb.39.2023.07.04.21.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 21:44:10 -0700 (PDT)
From:   pinkperfect <pinkperfect2021@gmail.com>
To:     amitkarwar@gmail.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pinkperfect <pinkperfect2021@gmail.com>
Subject: [PATCH] wifi: mwifiex: Fix integer underflow in mwifiex_process_mgmt_packet
Date:   Wed,  5 Jul 2023 04:43:50 +0000
Message-Id: <20230705044350.838428-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In outside functions have checked upper limit of rx_pkt_length,
in mwifiex_process_mgmt_packet should make sure rx_pkt_length not underflow
to avoid OOB access.

Signed-off-by: pinkperfect <pinkperfect2021@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/util.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 94c2d219835d..4291252e06ea 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 
 	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
 
+	if (pkt_len < sizeof(struct ieee80211_hdr)) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
+		return -1;
+	}
+
 	ieee_hdr = (void *)skb->data;
 	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
 		if (mwifiex_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
-- 
2.25.1

