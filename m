Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E3749381
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGFCIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFCIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:08:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA512A;
        Wed,  5 Jul 2023 19:08:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8b2b60731so327335ad.2;
        Wed, 05 Jul 2023 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688609321; x=1691201321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77anvOT5bLFxXQVZM5kxPamh8S2PE+VxEcnJtsBp0Yw=;
        b=DdwvclS4+IsQyx7gSXs22HDf3DYQKzCDm4AhPkr7/avsHxfL1WZTNH4QIrpevymPwJ
         QszRUR9DtLmf12Pnnw1Ac6+OubQ66P1cg58OSj+/M9whCBOYyKIO1/cT3GnYFPOHUsDI
         /yn4lbHwZDG9n+HmvjMYBqG/riVjd+qpPvY8rGw0p61d34XqS8JZiPZd/3fOQWM6QxNZ
         c806E3mdNBSltZWPXTUJ1mSC+Sg10jUmYN1HFhjMk8m58f33oFhIj/nQnktKeJp+gWc/
         vjbAemxLiNCC0yws2r3+oDuzjMkzkN0Gd2f7aZ71G+XVVFN+xFLS7oMATpaIOa53FHeK
         pJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688609321; x=1691201321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77anvOT5bLFxXQVZM5kxPamh8S2PE+VxEcnJtsBp0Yw=;
        b=XhsWwhCF8QXOJeIYfzNgw8enG1b9iXTRXyRy1ejSDA/ytnDpT4OKd60+22SP3Db0s2
         +6YeU0FWlSJ6mx1IlxkpCzivJUPPLBW1zgk3ZXCl/CcWd3sqJrGAy0XZaFVUQxIRijcN
         k4h7PFozJZbi1gi5fgGeJiJN2bruJqQlphKa6KR/VaUoU9v1YetAWekmjqrYKNT2NUdN
         tRizqOs1uLxa0hvF7Ql5G/JhbI5leASdFJAYZCtT70iwBWZSBe0Wa0um8De6AgKrUlLP
         i/oCOag85FVkLm/qVwktAydqfUWQ5IsXOGEccqvrP8ktHopg2oW6ykQB7C+pmyxCKv4P
         9XYQ==
X-Gm-Message-State: ABy/qLZiocB3g2RoVh8poug2QzwMmcEpKYZw/3uHwy6EjmQenPZaxYCN
        Tu5B4tJ4ORf08kaZHH+rTgIiovF+NFYP8yjGPB8=
X-Google-Smtp-Source: APBJJlFowzTvNO8nzHMinESmJbMA0aaUBd+8+a3lJjli2/rpAhRAhpiL/LaEBbMdVHD2LNBkJK3ARQ==
X-Received: by 2002:a17:902:d4c7:b0:1b6:a99b:ceb1 with SMTP id o7-20020a170902d4c700b001b6a99bceb1mr554825plg.50.1688609320976;
        Wed, 05 Jul 2023 19:08:40 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001b87bedcc6fsm144023plr.93.2023.07.05.19.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 19:08:40 -0700 (PDT)
From:   pinkperfect <pinkperfect2021@gmail.com>
To:     amitkarwar@gmail.com, kvalo@kernel.org, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pinkperfect <pinkperfect2021@gmail.com>
Subject: [PATCH] wifi: mwifiex: Security: Fix memcpy oobs in mwifiex_set_encode
Date:   Thu,  6 Jul 2023 02:07:51 +0000
Message-Id: <20230706020751.859773-1-pinkperfect2021@gmail.com>
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

In cfg80211 flow, when handling userspace netlink messages
if input cipher mode is WLAN_CIPHER_SUITE_SMS4
will make cfg80211_validate_key_settings not check key_len and seq_len
which will cause controllable memcpy overwrite
So needs to check them in mwifiex_set_encode.

Signed-off-by: pinkperfect <pinkperfect2021@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index a2ad2b53f016..bddc11eac8a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -1099,6 +1099,11 @@ int mwifiex_set_encode(struct mwifiex_private *priv, struct key_params *kp,
 {
 	struct mwifiex_ds_encrypt_key encrypt_key;
 
+	if (key_len > WLAN_MAX_KEY_LEN || (kp && kp->seq_len > PN_LEN)) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid parameters");
+		return -1;
+	}
+
 	memset(&encrypt_key, 0, sizeof(encrypt_key));
 	encrypt_key.key_len = key_len;
 	encrypt_key.key_index = key_index;
-- 
2.25.1

