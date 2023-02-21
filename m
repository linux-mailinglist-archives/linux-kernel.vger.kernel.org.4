Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936D969DCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjBUJYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjBUJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:24:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDD51A495;
        Tue, 21 Feb 2023 01:24:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l1so3358298wry.10;
        Tue, 21 Feb 2023 01:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JLu8BAlgI+WIHMoE24yhy4uizQcXzvZPeYYNkmurpEY=;
        b=jo7F1ZZBWvqv8QLrf5wk7dhFktSC9S8/P/W1hifkRtCX+oPAfT0HQ2+dms6OlYM21g
         rOgBa0tra7S9tj+MvFG2DNLLSJJFV+c3RpOf0oiAUcFohM2RK6/bvhEsPYGD/EKPxCuY
         fdKXEANJmTA38ICI3sYfbIWoDwHKF8tLShTL/CVYJWCXuuCqZ3sVtgb+VnTSXZpZw0jh
         9s3JCCXOCFaJDYpoX8/WMBpKiXZmD/q9/CUGRbgeVFN2s3RBWsd4zFhxCMOSrx5jX4mt
         69LwdDZz4yHPmdjBEw1XyHd3Wx69pI3f3XgyXe8oDB0ZCY2HRI89/OCYlqrnYWHNQDN3
         VmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLu8BAlgI+WIHMoE24yhy4uizQcXzvZPeYYNkmurpEY=;
        b=l5/qjMXt9GzwkJC2GMCDMsQC5cki0mMg1SLpKeNCC0I3uZjWJCioz0iP55WOPdQVJQ
         w7j8OmcjD3ipxSmJ7cmI2j3xJ2QBGZy/E28DmkRxQfolo/PNpzrjuJQl30/4oZ5yRW1X
         cUBSuX2UsQ2YaOaq1wn96OGxPr3aYliAaTCVaoz28QFVah3p8kzDJ4E0l/DAcn5tGp6W
         h+8xiSL8s6vbT8X2IYNSt0j3IVzUKWSLFCc5zixZTc+uJ/m8/Eo6DVAYkrExpw7Ujrjs
         yjlxM3MtX5OUFFgKcK/j8P7Bt54RW9bjgI5mg5g54yEkCG31JxsHBbClypVDNPj7Vqdu
         bGTA==
X-Gm-Message-State: AO0yUKUcgAbageYrdyirWG5pY4MrtanLydAinRYFrLhw8YMYnzlJCWt+
        hayv9ooy0tbpyAR1oZzzOAsDbnlSQwl9n606
X-Google-Smtp-Source: AK7set/6t+7Br79GBudhEtbOxGJOEHMxW+14bTe+NLfFGJglW223EOybF9tkF/XntutQdUoAjj2syA==
X-Received: by 2002:a05:6000:1252:b0:2c5:505d:9078 with SMTP id j18-20020a056000125200b002c5505d9078mr2164411wrx.31.1676971479469;
        Tue, 21 Feb 2023 01:24:39 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id i18-20020adfe492000000b002c56287bd2csm4272573wrm.114.2023.02.21.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:24:38 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        erkin.bozoglu@xeront.com
Subject: [PATCH 1/2] mips: remove SYS_HAS_CPU_MIPS32_R1 from RALINK
Date:   Tue, 21 Feb 2023 12:24:34 +0300
Message-Id: <20230221092435.22069-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

All MIPS processors on the Ralink SoCs implement the MIPS32 Release 2
Architecture. Remove SYS_HAS_CPU_MIPS32_R1.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---

The RT2880 SoC is MIPS 4KEc, the remaining SoCs are MIPS 24KEc. All of
which implement the MIPS32 Release 2 Architecture, if I understand
correctly. My incentive for this is to automatically have MIPS32R2 selected
as the CPU type.

---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 37072e15b263..0e8dab9a57de 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -610,7 +610,6 @@ config RALINK
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
 	select USE_OF
-	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-- 
2.37.2

