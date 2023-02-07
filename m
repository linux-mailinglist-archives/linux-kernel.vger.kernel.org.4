Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DA68DFB7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjBGSQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjBGSQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:16:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4D3BDBD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:16:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so3524294wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oRI/8f4x1/QMBaZh6y3RspGVRS7CNQfcVSPIlmfTuKk=;
        b=CEHDaKlFnjq8eOJ7jtg6rh8X1kLNTaq4jOzDRjY7pMD9YLrZzZLETWcVbasFEIYNW+
         L50fI+ldxT5HOZoDJtuiN3igNjiWmxJx5AaxyeV/s9xgvZ7/6NjtYFueV8q6iW8YjeeH
         cu1Qu+fAMZ9Sv6+6WIMoZEYlU7/qPXs6FsCi9LqqGzGN9VeBY4g2gdo9foAyzBQI50dG
         8+4lvw6R0dPITSGRzJgPLegkQ8eir6GXNVRcvOArfWkZWMZY/Cda5W4l6qRGFzFb/KoM
         PsLbrLUclqnGvpv3wdjMsnomwPSYNNuTtlfLx7bvwBXyO4xEJFLJ1gGLbe+jtLTN/jDu
         SEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRI/8f4x1/QMBaZh6y3RspGVRS7CNQfcVSPIlmfTuKk=;
        b=zSBsfK4yATBFwdI9upSuGzepENgHq8eOmpBSsWu+cPLEKp45akoaar+86s/wHrAjzp
         LDVuNtos/Vcqc0AIitBndAwyvX+zsetPQIzZ0zsgwVS/vjc67XMGoUOBaGhxiiE2vZtC
         pKW49Xksxyy2/EWiqwYTa7h/himIAB22cB89WiKTCS4c6r/tEBD+NmG/VDsYZCrxB3i5
         4f7y7cShR0c9meNMxU12x6BWXEhYQ0/dhbXrwDAD6urG2wxVN1+pR/MIIDoy8IE+eeBt
         kFVehloJuzzgoV7/HQF/Kz6e9mizWufkeri3bIvDc6g3UcubsE5mwCURKqqNmC9YflfK
         W5oQ==
X-Gm-Message-State: AO0yUKXmWuT4LtsOItmFDXx4kKdDJLPE9ULlFRK2kpcxYm1SfwWQBplB
        2XDzG4dNpMn1ShDsEtet7okKJIM1I3Q=
X-Google-Smtp-Source: AK7set+B67Bh1dRfeNspsTlJQnRrz9pcEn3pM31L9206j4TGSDjPGmt8U8EHphPWUTTF8vtMoA5vzQ==
X-Received: by 2002:a05:600c:35c5:b0:3d2:231a:cb30 with SMTP id r5-20020a05600c35c500b003d2231acb30mr5182214wmq.3.1675793778171;
        Tue, 07 Feb 2023 10:16:18 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05600c538f00b003df7b40f99fsm17363729wmb.11.2023.02.07.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:16:17 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:16:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Rename AcmHw_ViqEn, AcmHw_VoqEn and
 ANAPAR_FOR_8192PciE
Message-ID: <ecdb350dcd9b1860496c1835980d34c5bca0d39e.1675792435.git.philipp.g.hortmann@gmail.com>
References: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constants AcmHw_ViqEn to ACM_HW_VIQ_EN and AcmHw_VoqEn to
ACM_HW_VOQ_EN and ANAPAR_FOR_8192PciE to ANAPAR_FOR_8192PCIE to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index dc6e694840af..cb455969f5dc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -225,11 +225,11 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 				break;
 
 			case AC2_VI:
-				AcmCtrl |= AcmHw_ViqEn;
+				AcmCtrl |= ACM_HW_VIQ_EN;
 				break;
 
 			case AC3_VO:
-				AcmCtrl |= AcmHw_VoqEn;
+				AcmCtrl |= ACM_HW_VOQ_EN;
 				break;
 			}
 		} else {
@@ -239,7 +239,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 				break;
 
 			case AC2_VI:
-				AcmCtrl &= (~AcmHw_ViqEn);
+				AcmCtrl &= (~ACM_HW_VIQ_EN);
 				break;
 
 			case AC3_VO:
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index c3b573090d39..1546bb575293 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -144,8 +144,8 @@ enum _RTL8192PCI_HW {
 #define CPU_GEN_NO_LOOPBACK_SET	0x00080000
 	ACM_HW_CTRL		= 0x171,
 #define	ACM_HW_BEQ_EN		BIT1
-#define	AcmHw_ViqEn		BIT2
-#define	AcmHw_VoqEn		BIT3
+#define	ACM_HW_VIQ_EN		BIT2
+#define	ACM_HW_VOQ_EN		BIT3
 	RQPN1			= 0x180,
 	RQPN2			= 0x184,
 	RQPN3			= 0x188,
@@ -250,6 +250,6 @@ enum _RTL8192PCI_HW {
 
 #define GPI 0x108
 
-#define	ANAPAR_FOR_8192PciE				0x17
+#define	ANAPAR_FOR_8192PCIE	0x17
 
 #endif
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index cbda027656dc..c6cbdea6d5b2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1273,7 +1273,7 @@ void rtl92e_set_rf_off(struct net_device *dev)
 	rtl92e_set_bb_reg(dev, rOFDM1_TRxPathEnable, 0xf, 0x0);
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, 0x60, 0x0);
 	rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, 0x4, 0x0);
-	rtl92e_writeb(dev, ANAPAR_FOR_8192PciE, 0x07);
+	rtl92e_writeb(dev, ANAPAR_FOR_8192PCIE, 0x07);
 
 }
 
-- 
2.39.1

