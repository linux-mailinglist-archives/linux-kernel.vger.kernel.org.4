Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFFD6767E1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjAUR6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjAUR6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:58:20 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9662F780
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 09:57:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z20so5988113plc.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AxWed3glpCmJJFQzDC2lmsR0X3SYh0baoNWzeGiA8c=;
        b=FHUv3ytZ3dBXrU1hpnFUzfg9Bg6/6D8bJR5hlUGkzuX2Ty1zYInFQ4XzMSszLeUxBr
         hfDSjcZ3gq+VGkxXGfRzNtcEupWnzneu/Ewe6OkVZkI3VEACcyTWzymEaZjjAyZ5bESy
         dvWz0Dc+nzr8u40UWtWQbjwenrCEAgOOcOEbxbTuphleTvpSSUEds5tLMIhdpoJhYorx
         25258R8Hv+UGniVH60wW3eJlqCSkVrHcUss8pxQrJ8ftVNpQhjQXXgK2NvKU3J9jeC/m
         FVOKDZ7AyTjCW0nj4Za7LQCdWBC27LSUF+B0XfBfW9JK9i5WtpXgR1g0PqWhSAgidGWF
         Fesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AxWed3glpCmJJFQzDC2lmsR0X3SYh0baoNWzeGiA8c=;
        b=IP6ubTOYbUqXgisvAt2KAbbqM1CVnfQvwC1AEVEw4g5Q38gdlVzwxZ3g/YyvckYteP
         WXCdUlXOhSbcSalcNFbdG7C3WT56PD/Us24TWx2aSI5KLfAwpq4lnFU7FX7ilx18uIe+
         hybcUDaHQLzcJuA9TvgtEluIDUmSG2MWqHU5/c3edbR7JDLvsdwJmk/25+tAkUGs5in1
         4DugsfrGaPG6hAEf8dYYgc9L6Nb5xsLjNu4Py2NsYVg51p2mu5Wz99bm100W7YprCTI0
         o99DQm3onlWxl1Ia9kGdNJS6DyWUk5K8Tl7YP/gRCGe41Z537hF6+9PoS6A8LF2q8llw
         mT0g==
X-Gm-Message-State: AFqh2kqyQ4erH3389wopgvIgKSrOWyIUHG2DJVxD5sw0xOipS29Vfi+b
        BT5koIPFeJKtOhrKv5aCVI0=
X-Google-Smtp-Source: AMrXdXsf4SVRTT/ubc3h7M/MP255AO6thHeBSiOMtH0zWpbDTLmZcqnmOpTG2PC1+frJKV42uTpzSg==
X-Received: by 2002:a05:6a21:3a48:b0:ad:4be8:5984 with SMTP id zu8-20020a056a213a4800b000ad4be85984mr21508452pzb.27.1674323872673;
        Sat, 21 Jan 2023 09:57:52 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:52 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] arm64: defconfig: Enable USB onboard HUB driver
Date:   Sat, 21 Jan 2023 17:56:37 +0000
Message-Id: <20230121175639.12818-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121175639.12818-1-linux.amoon@gmail.com>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB onboard HUB driver, used on Amlogic boards.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: add rev Neil
v2: none
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..42c3528a2473 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -923,6 +923,7 @@ CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_HSIC_USB3503=y
+CONFIG_USB_ONBOARD_HUB=m
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
-- 
2.38.1

