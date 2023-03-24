Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488056C7EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCXN2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58798234E0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679664417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rqu3TJ9Us4tjFNY0o3zPlo/dxstIWcHIOGlWftNzUnQ=;
        b=OiKQd7pbQIV5MERaKo6pkXoM8TnMI1TYI0orW5kfUHIWzoQSB7oiLZlz1N7wZUtWXSOYoB
        WDnK6/qUr1eS9P9eaqOWsw7RuVliLIPUrk7fKgSwqKLpn/boTRqzJwmP1nGbdIoiLoZ56D
        4f+TNjtilPnRmMTaPk8+suKnvnTYcTw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-wykLUkjgPha-VzOQ9K-JLg-1; Fri, 24 Mar 2023 09:26:56 -0400
X-MC-Unique: wykLUkjgPha-VzOQ9K-JLg-1
Received: by mail-qk1-f198.google.com with SMTP id ou5-20020a05620a620500b007423e532628so764141qkn.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679664415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqu3TJ9Us4tjFNY0o3zPlo/dxstIWcHIOGlWftNzUnQ=;
        b=d+gJQMvQDUN9EZCBsKmgjvSCPFPsU0PeWQUenNFLA3Zx05adMvbeS4s/zqyhXGHW9V
         YLEYHCNI9ZbMtiS8ByjeArrrzP2xM+z1fREQCm3p3/6QaOYI2G5OzLecyVxKi4CV5M+k
         DETebzYA5R0gVDJvNc+19mo1t3WhA808xutHHB9XnGyjY2SuqBdKlkt3chCK5lzr9ci0
         1tm3d1uREzu4mQOWK/C+F/RVJmkumkMqpC3v19EoqTTFB2WTz7eUIv9cYcWeJrcypNa2
         6qkWMuoNLb+bdVtIXuXS9JSqSNeQzOtI1J6LQ6EIgc9jp2EZigBHgItij+qy9L2f312+
         UqLg==
X-Gm-Message-State: AAQBX9c0B9rnojUDB8ZoF5MJtUwzd63OG1hvgdd56MAXDoXmxovqOh6c
        x3mKpQQ+SV2N1hkTTeKjjoQo5UqE5Sj2nkv/sMBkeYuRNqKCeFqVeG268ua0Dmi7PuO2moBvonG
        5DGBzYtY1DmXpd63Y1/ShxdRHKj9t93gA
X-Received: by 2002:a05:6214:d07:b0:5ad:1a83:8021 with SMTP id 7-20020a0562140d0700b005ad1a838021mr3926027qvh.49.1679664415746;
        Fri, 24 Mar 2023 06:26:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350bWyV7OYeyD9u0w6iNh0EYkkwfo17tJz1C8lhIiQ8oaWqvEFwUsQXfvyFHVNhZAkqBx+PZ4Og==
X-Received: by 2002:a05:6214:d07:b0:5ad:1a83:8021 with SMTP id 7-20020a0562140d0700b005ad1a838021mr3926002qvh.49.1679664415511;
        Fri, 24 Mar 2023 06:26:55 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 123-20020a370381000000b00746a7945d87sm5095680qkd.52.2023.03.24.06.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 06:26:55 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     vkoul@kernel.org, kishon@kernel.org, heiko@sntech.de,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] phy: rockchip: remove unused hw_to_inno function
Date:   Fri, 24 Mar 2023 09:26:49 -0400
Message-Id: <20230324132649.2649166-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c:284:36: error:
  unused function 'hw_to_inno' [-Werror,-Wunused-function]
static inline struct inno_dsidphy *hw_to_inno(struct clk_hw *hw)
                                   ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
index 726928ff1273..401b0aabb159 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -281,11 +281,6 @@ struct inno_mipi_dphy_timing inno_mipi_dphy_timing_table_max_2_5ghz[] = {
 	{2500000000, 0x15, 0x54, 0x7f, 0x15, 0x6a},
 };
 
-static inline struct inno_dsidphy *hw_to_inno(struct clk_hw *hw)
-{
-	return container_of(hw, struct inno_dsidphy, pll.hw);
-}
-
 static void phy_update_bits(struct inno_dsidphy *inno,
 			    u8 first, u8 second, u8 mask, u8 val)
 {
-- 
2.27.0

