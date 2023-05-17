Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1C706542
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjEQKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjEQKar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:30:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6396F3C30;
        Wed, 17 May 2023 03:30:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so5350034a12.0;
        Wed, 17 May 2023 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684319445; x=1686911445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Prd49snigix6d9LdTUvvFg72tuSsEwzo0jpnKwNXRk=;
        b=HywP0zbgay4cg4mxORoYrmaGv4C/3y72Z0Pbsy8KBYJwwp5cgkaTqpICbcRrGdZwuy
         qj8i0Wq3tm6XhJYg8swdd0/XufEy17x2ensngDJA4KvCxxbNBmXCnfT8u2W4KWro1vI/
         Sp6OpXQNdWPoe2Zgtss/aoRUeMpG5vx6NOpRJRGYln3CtmCPVI6vdaZXIixxUzRUex/x
         4NiTJEeTo5Zjl6EQkYP+13eis6/9hUGvZ+tQJpdvoLmk7g2tUn0N6Zs3P486E6RJgxT4
         vIEKPqPIGvqB+IKP1T1c2wgFKboPHGHMGIu8dL0DrEupc/ezhtB+xDni2QNotUXjCZWc
         sg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319445; x=1686911445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Prd49snigix6d9LdTUvvFg72tuSsEwzo0jpnKwNXRk=;
        b=mIEz10suotWPYTdPqyeqCBzUnXQ03EZN5DBlZtPtCfXPCSl666bkABH26ujs6LA8ii
         31mUTYwwdDUratv6PdGwtzKS04rRXlzV0q2bNkpQRXxVJGYBDQ1Lf0ndYMnPVa6ViLfp
         B+VIgGwvFtjyArQUJqgUKMcX4xOvsM94bx7tgJ7odai42GzsiF99eLJZz8ei8+O9LFwc
         Cj6Ha8MYUeuAz/+8RLf9BR7XITcOVOVJmLvmU/j6X02a/13240tI0BT0kIUxkBirViuE
         50WMBlAVhFCZx996c8DAe5abi+xonv+8X/uX5FufatBXjRR6xsNpg4zRaik/GlWXY/7i
         aqig==
X-Gm-Message-State: AC+VfDwVF/PEySJuDHK+xlbOVeDHO0H/yHhgkUBq2EKixbpVmpoghO0n
        cwdnBGjkn3qZhQvX6Wnucmb7lWU6NyVepsvZ
X-Google-Smtp-Source: ACHHUZ7jof1crDpMo1bbefAPH1Qr/iEut2c1Eu+Xb1yf+6IIXvEzXJHsU0MP7dWVWCB6HrLTFemQwA==
X-Received: by 2002:a17:907:869f:b0:966:4669:7e8d with SMTP id qa31-20020a170907869f00b0096646697e8dmr1688616ejc.16.1684319444582;
        Wed, 17 May 2023 03:30:44 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900d536eaeb32769819.dip0.t-ipconnect.de. [2003:c7:8700:c900:d536:eaeb:3276:9819])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b0096654fdbe34sm12235758ejb.142.2023.05.17.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:30:44 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Wed, 17 May 2023 12:30:05 +0200
Message-Id: <20230517103007.26287-1-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some spi controller switch the mosi line to high, whenever they are
idle. This may not be desired in all use cases. For example neopixel
leds can get confused and flicker due to misinterpreting the idle state.
Therefore, we introduce a new spi-mode bit, with which the idle behaviour
can be overwritten on a per device basis.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 include/uapi/linux/spi/spi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 9d5f58059703..ca56e477d161 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -28,6 +28,7 @@
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
+#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -37,6 +38,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(17) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.25.1

