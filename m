Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8384701C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 09:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjENHsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjENHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 03:48:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E904C26B9
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 00:48:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aad5245632so82321935ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1684050493; x=1686642493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXMOTCbN4pJHC2KQ8XGHSVJ9bZ+JD3sMLsrY84T9zCg=;
        b=azGjwxqhbzeX67GBbt3bcHqoIgoCGl5i80BhgsZq2X3loYVux9ag97RU0oJ8Za63hk
         fxKzsd2u9AlRhI445awheLBaJXtU+lmgGbRU3PqLSQb/xr2c7khgj9GZwe6v3MZ8JvYB
         8cSJhjqywpqVBdsYF/G3JQVrzM/vUYWjns6Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684050493; x=1686642493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXMOTCbN4pJHC2KQ8XGHSVJ9bZ+JD3sMLsrY84T9zCg=;
        b=aOF3SHq7bk4GDU07yZCUOmSAwtghN7v0KQG/KrazBWHTZRWd42IJr8qhHA6Rw9ejDg
         K/McZqyDXeB7X5eviAwCYVwaqXPYj98s9Xcpp16SOOhNW0RcbO+fxJ8FQn/yf2psjgx5
         ITNqUn3KeJ0HZuqQ2xgzg0vRmA100RVcHb2JUkZooGh7FOjYiKUaY5TalcdbbdafN0ZJ
         FnX7utN85al6g8o52oI8gIjNbwzMzrR6fu2XZAkH/zJka5Sz4kUr79kY/J4Rs4Th1COe
         my4fnkGx3sYx/NRZe7tP46ORsoZ6fMoPHFzfGf4NczSZ2JItvhtmWNKB5UTQZfGSEBqM
         S4UQ==
X-Gm-Message-State: AC+VfDypN2WFtplvTFyJ1pE9kKunOcA99EDx0HrKUhfyWwCrFd/NqjwD
        qFF9WnJeD54y2fiGq4MhY5RsLA==
X-Google-Smtp-Source: ACHHUZ7nuNI32aku8He5WevcEmfdir2RB6FIdCP/I07cZYqXxRCmHW80kT4iPbcyjRSz4TjOHJo6Tw==
X-Received: by 2002:a17:902:d2c7:b0:1a9:90bc:c3c6 with SMTP id n7-20020a170902d2c700b001a990bcc3c6mr39582395plc.16.1684050492641;
        Sun, 14 May 2023 00:48:12 -0700 (PDT)
Received: from 8add390ca20e.heitbaum.com ([122.199.31.3])
        by smtp.googlemail.com with ESMTPSA id j4-20020a17090276c400b00194caf3e975sm10903363plt.208.2023.05.14.00.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 00:48:12 -0700 (PDT)
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        anarsoul@gmail.com, alistair@alistair23.me
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH 3/3] arm64: dts: allwinner: h6: tanix-tx6: Add compatible bluetooth
Date:   Sun, 14 May 2023 07:47:31 +0000
Message-Id: <20230514074731.70614-4-rudi@heitbaum.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230514074731.70614-1-rudi@heitbaum.com>
References: <20230514074731.70614-1-rudi@heitbaum.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 comes either with RTL8822BS or RTL8822CS wifi+bt combo module.
Add compatible for RTL8822BS as it uses different firmware.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 9a38ff9b3fc7..9460ccbc247d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -21,7 +21,7 @@ &uart1 {
 	status = "okay";
 
 	bluetooth {
-		compatible = "realtek,rtl8822cs-bt";
+		compatible = "realtek,rtl8822bs-bt", "realtek,rtl8822cs-bt";
 		device-wake-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
 		host-wake-gpios = <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
 		enable-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
-- 
2.25.1

