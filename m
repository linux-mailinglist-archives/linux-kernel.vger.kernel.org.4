Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132D86EFB14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbjDZTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbjDZTYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:24:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215A358A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:24:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f19323259dso63727765e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682537073; x=1685129073;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=623I+b9sj9JQHMoE8gUBonB4YWYfafGdl6RvYOXiA9s=;
        b=txkwhL2liSvbgv2V/br5OZELzu6PxeKpE67gU/OpfSZOLRPr0Q4IV/1S3HnN8lZxEB
         ULpXoOzuVoXSeHCYF68J/dRTwZmz+IVYElEolOaUDHtcxkLXqj6+IvkayBKFSIAFU4Cp
         Cj5tlC/+5zaEq08fnKxONhIGkLIlq+eUak7jnRM0QfKTF3Q521FOP1ObWWn8JWtjgHZT
         5YcQnB8aF+8t67t/8ISkHQy+Wb2BIvnvRly7vLpGjbQg82slREEwpsVsnd0eS6Bg6v2u
         XynQPcxW3uibdKTUncqjLaGbT6tgNC7YGI8ux5ZLDPpwboRld+QuiKDSuGlsw8iWee/9
         BaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537073; x=1685129073;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=623I+b9sj9JQHMoE8gUBonB4YWYfafGdl6RvYOXiA9s=;
        b=Mu2thnHSd4rEMFV0BLKM72lr+mcm99KV7/2cI2sz4vfJjHUgV4PCvZ9cjholBYv4b4
         MjrGgjDEHuUci8J2ZWEEhoJBkRJ1VgIlmc+kZ1O12QOp9wTKr1wLVDQJJRlh19ptjiBP
         OZjwad0sv8XU8AOFhFQBv1l4etQXxZHKvNr18nfXydFKBGMq4tel4dJu53V0c4Qobt83
         kGx+A1OM19s0cJy7d/XGFPl2Wj+2uWODq2WEQ9c4EQJjzL3r/drlNGdKug7+0zVGKikk
         aTao5RPL5awOSf8bI4LsXiGBekQz4aliF4/LF11K/TCAauzEoBcrrYzBiCsGTJe+tCDC
         dRbw==
X-Gm-Message-State: AAQBX9chqQpyFISTdmSucmFSKx1s8TbaqiIAhCMspDe8bODTpMxXJ+7l
        Jt1r0jowukIHY3K2hqRdVlpN3A==
X-Google-Smtp-Source: AKy350b61s1hT/fGboWfJrsEyVqrqX9zy/B/kQ0qe65IuuQ1Z++YEaoBMpkDWIvqEtn+zzLVEq47Sw==
X-Received: by 2002:a7b:cb47:0:b0:3f0:967e:2cfb with SMTP id v7-20020a7bcb47000000b003f0967e2cfbmr14555881wmj.36.1682537072613;
        Wed, 26 Apr 2023 12:24:32 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c4f4600b003ee5fa61f45sm22482137wmq.3.2023.04.26.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 12:24:31 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Wed, 26 Apr 2023 21:24:20 +0200
Subject: [PATCH] usb: mtu3: Don't check the USB3 status bits if the max
 speed is USB2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-usb-mtu3-improvement-v1-1-1cf02434b478@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGN6SWQC/23OSw6CMBSF4a2Qjr0WqFJwK8ZBHxe5gz7SlsaEs
 HfBscN/8J2cjWVMhJk9mo0lrJQp+CO6S8PMovwbgezRrG970d76AdaswZVVALmYQkWHvoCUdhq
 lxXmakR1Uq4ygk/JmOfEaeR2uApLpeAmRDHdlFMOd/xs7fUw40+d36/na9y9zOhGspgAAAA==
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=lnjx8kcqUDfgilr0fGyRB+NAq/rLS5pv35XuHVTlGDc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSXpvI7p5QNlCaGzZG7dVJB/7HfFq9BIZoExjwmkv
 080ExUCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEl6bwAKCRArRkmdfjHURY+HD/
 4hwG+Mdt3GhTLAJLObbayoktgbVLjxIFDSoY/xq48qazZ9BPkPhY2Qte2zfBbTjYjy8rJ2mBsSiRB0
 eZ1CCWQSwaCsiT//hW2xlKAjSPb4k5ceRUF0HssuEtBokGnZMK95x5J+FcEiS5OwRnd/BDc/Xx/cHE
 0UoYi5hMJUiUtJA0yQzSRmwL1k7c7mTZrM3v60qAU2/EV1V04OdQUOifGw2d2BaY4WGRhEyiu2C8gM
 NyiCGqXNsvHTLKdQsNQ1YXFi8g8NIT3NNzAmLAd8W8RjnRCP8i3icnvygNKzm6mDY5JEtgbdSt3u9L
 NUKgxtJ6UF7TQNEb8BjY1aAS0aGyKRJ5O936nOq0HY0oIMKqWqSD4vk3GTugAIkWGSjtFKp3qS/gp2
 9imZjJlZtyK8jMF0N1frygUANSKcqd/1oIS0qSB7YgR6yPv99JJEqzxHyr1QfPLbZPfklU1lRbAASZ
 I1v1/PZROhA8SSc5FRGiceKuOJ+v25kBk92Jjs0oPwraLRVxDPqCTBd8nFyslj+Hc4QocqgNpCi7I+
 /unp2jqRGVoo9iEh3kZp/AJ2CNPySp9rCsfeZo1xX2c4PBb1eBvrCnv9eXhl+VUTadHPpgipqHFcHU
 PvCjX56Zf08oS7nE6mMbS0m1gESio5CeRG0Ps3FhjWsOBc4c1KvLuT1kjIDA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

If the IP is U3, the driver will check some USB3 status bits.
This could fail if only USB2 is used.
This only check these bits if USB operate at USB3 speed.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
This patch is ported from downstream. Without this fix, USB doesn't
work if USB2 protocol is used first.
---
 drivers/usb/mtu3/mtu3_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index a3a6282893d0..00dba871aff8 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -100,7 +100,7 @@ static int mtu3_device_enable(struct mtu3 *mtu)
 
 	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 
-	if (mtu->u3_capable) {
+	if (mtu->u3_capable && mtu->max_speed >= USB_SPEED_SUPER) {
 		check_clk = SSUSB_U3_MAC_RST_B_STS;
 		mtu3_clrbits(ibase, SSUSB_U3_CTRL(0),
 			(SSUSB_U3_PORT_DIS | SSUSB_U3_PORT_PDN |

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230426-usb-mtu3-improvement-77d987def9fe

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

