Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E263C716387
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjE3OR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjE3ORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:17:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA86124;
        Tue, 30 May 2023 07:17:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af2db78b38so48954121fa.3;
        Tue, 30 May 2023 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456235; x=1688048235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HSi9nI0Vdoo7olldvTKRpyWvo8hGHic3PEr2+B6W30=;
        b=ltDqhRBveyw/EF1tLF7LZRS/IWofme45zpSF886nrWhcBvS56zQ9cQBcAPoUT58Jfv
         YM/B8SpfN4eruHZoJm2BbuallseW2hdE9bDLLdTrBKMDY4TrtHd4k80eY6l7sxy0gKpi
         WHnrAe+3wtqryf0a+gSe6CY/5KBgNngiAeBNlRUcuOSmU44eLyxhMXsyLoyHdM/AhbUB
         DyEG1dGqsjUP/xkDeyCh6sHrL+wyAFUaRZWC5ERhpmQSlKb80pLzwxPzPJ1oFnwWfFZq
         KF/KqCR7tMnP/bo9bbuXtzJDlfHY+m7yJ1NFXG0yFCsGSldRorF0IhGJIW/lhoxI09bk
         eHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456235; x=1688048235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HSi9nI0Vdoo7olldvTKRpyWvo8hGHic3PEr2+B6W30=;
        b=OAtO+qMPBuoRGEDUzRI5KgCrg/gsYV4U7nZ0wNCqo0qYfUap3RV9Rsotp33bygf36h
         oP+qId2g5kpOBr91KwGrFB8BEjwOdIYc6deOF4ceVgHagFDrXIO2qHYvVp3xqwJtNL7x
         HmsyZQ9/nCTBoPg/MFuwLGOJpE9zwItZt+dTReKsUrB7lYCcLVy/o+QnBbMi0XkagJ9y
         ox34Q0k8eMMScpYpeRlajt8yCt4+PSEgVc/FRcwAKx5dMYVqrOFxtJLXQ5v66VxcdjQb
         BHaJPJoEBendwD8eOmB2q4sthkCwCQunmsgwo/E7wSIkiH6MpLj6zuA/L0aYzRYxAP38
         96vA==
X-Gm-Message-State: AC+VfDzOsy6bphLJJqFhjvBMy7wpq1JhvC1hA0gHoSqph2kQr6cpkTZk
        iISz5a2z7R5k2MBwiPUWQjs=
X-Google-Smtp-Source: ACHHUZ5Cjn1bADI/1qcpCHx8HvBTkKyKco13kkw3Vhg90td0i0uKaQZQ6o2bMYL52Qn1JuRfpJzOpA==
X-Received: by 2002:a2e:8715:0:b0:2ad:cd36:3379 with SMTP id m21-20020a2e8715000000b002adcd363379mr930403lji.39.1685456234368;
        Tue, 30 May 2023 07:17:14 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900796a998533c043af.dip0.t-ipconnect.de. [2003:c7:8700:c900:796a:9985:33c0:43af])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906089400b0094e96e46cc0sm7354359eje.69.2023.05.30.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:17:13 -0700 (PDT)
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
Subject: [PATCH v7 1/5] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Tue, 30 May 2023 16:16:37 +0200
Message-Id: <20230530141641.1155691-2-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
References: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
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
2.40.1

