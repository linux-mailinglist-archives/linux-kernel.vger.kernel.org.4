Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB296606DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjAFS6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbjAFS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:58:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE687DE39;
        Fri,  6 Jan 2023 10:58:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1743729wmb.0;
        Fri, 06 Jan 2023 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k528IELIXTS1zkKswkp21dC+h35tpXB2itDfqYYLy1k=;
        b=LROitF8jx4/M/Vkxg+QMTTkNFGTgnlIBIrA7IpU9FxetFA1RKTibJgltFXQd9kTS5U
         f+kQOb2EEkxlbBc3JnpxlN+9yWOj7vl6Rm6RNx83/reT6pf7U3xHF8HYGN9mh2/wfeLr
         35tefnK85dHNOE5VFdvGX4NVcjm94Ma5woN2c2oxak9mo1EaFClIatsTbEBAJru8eGBJ
         qfUxZZ8XwiSxtxLEOWcj8GBxK+6eUCoCOjA8MPNhHzH/V7LNlzfbulHNFjyS3EG+UDqZ
         +vPmwL6KiiGGZdaUU4+zkjLVUEDCo8S4trCpkyUckye5Ynqz6Sj+MVyFymhzAJYd9ojU
         6gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k528IELIXTS1zkKswkp21dC+h35tpXB2itDfqYYLy1k=;
        b=jPfe2rckzjSDr8t+FfMS9uQfolFx9ofF5ammLUdLFdjfZYyPyJDfgm1tR8dBi/DvUM
         32fyzV0ZGGnHbdEHf+Tm7JDcipFEtt+urURvQnsJ+BG4FK6mRSFHJeOd8FKn/03csKom
         btMSv+0T7WqEUub6HZ8jwCr7QQ6zxI4wmGUVkuZbALJpCh5xDAQVUT4uy9I0ZCF2edSs
         hJTdeFKS1zdYg5AtIb3BDpVlbQsi+soicT0YQdVXbqMe03vhJVUKghBC6INYDP8ng5Uz
         hWfalInoMspXRcqVUujLYX6+CCCJNGJW7sfkf13R11tRjLtj5m51zIIqQQZL5Sr3oIrX
         dlTQ==
X-Gm-Message-State: AFqh2kqRHi78BEBBM0UqrQd4PoRficUiIJM2+8SgiB9dQQCwsLM1aPZ0
        CoKieQsSdHCiXNVGcxzkPXE=
X-Google-Smtp-Source: AMrXdXsatcmSQQUNmXGj79RbRnO+X2B5VntDftI61gKjB4eh5QmXCplrKdVt9YwZp/CVFCNHHoaDFA==
X-Received: by 2002:a05:600c:3b82:b0:3cf:900c:de6b with SMTP id n2-20020a05600c3b8200b003cf900cde6bmr40252998wms.15.1673031487884;
        Fri, 06 Jan 2023 10:58:07 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:79e8:5b4e:615a:91cd])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003c5571c27a1sm3162773wmq.32.2023.01.06.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:58:07 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org (open list:ARM/RISC-V/RENESAS
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 6/6] soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
Date:   Fri,  6 Jan 2023 18:55:26 +0000
Message-Id: <20230106185526.260163-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Explicitly select the required Cache management and Errata configs
required for the RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v5->v6
* New patch
---
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 660498252ec5..c3475c084685 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -340,6 +340,10 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	select ARCH_RZG2L
+	select AX45MP_L2_CACHE
+	select DMA_GLOBAL_POOL
+	select ERRATA_ANDES
+	select ERRATA_ANDES_CMO
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
-- 
2.25.1

