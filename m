Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC966A643C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCAA1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCAA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:27:03 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83215880;
        Tue, 28 Feb 2023 16:27:02 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cf14so12593100qtb.10;
        Tue, 28 Feb 2023 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677630422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah2e83PDoe/U6Gf57zepbByTh0n9RNpGO3gN23MY0Ho=;
        b=Cjy/nNRu165SghzyRoqBtp+mon81oWgIkg4ZrARfae2E9Rsz8v/brGam+WmHVCrGm2
         EJUFWKIkQnPjCIaJhSD3M9cWgX4rHCi9bdnX22p2poLAQyjNF6ayxZHO2a6bWB+6/uL9
         vFcUd1bOjeoR07sXMzjbVsONZDxMQSC6t8rI7qaKrXNulpyuyU0TWec4hlrhRB7TF12X
         NA/FZ+SvEA4uc1PklvT1POYrJ7bHPsBVAbfMsX2JkVP1tX8YwzePyfLbkuPpcZCb02f2
         DvBphTVSgrLmolfoO4XAwdZ2o1VW68ULKkmOaSTw2Eyu8Qr5h5v8m4Qeus2AE10sERpl
         m3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677630422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah2e83PDoe/U6Gf57zepbByTh0n9RNpGO3gN23MY0Ho=;
        b=uPXH0BWrIbiLUGrktn5XSBOjj57LTWHhxXWL5OpzLKPCBD0HpNmW9upe8Im0x5eV/Y
         WWSmJi1O8q+yku7Q6dxd27CZJEdpjZ7HGsyVMDTrhxpN3pSLa3wom9r+EhfqfRUtOyln
         Ia18QO9y/dpng40/vlUtE9vbG/NEPNngsBgmKd6Y+71zBC+PVoA7tNIbb7ZY9QsJHFfq
         jEJLVM6LF0Ert+tt4JB5s5PD0xfckSFCdNUt3NsVzm38ROHQ9mY+nuxBlPCtUfbqoT/y
         7rci5q+XtW+j9tY/mpjfrWxJTgW9ETxMP/6AaMqmi+WWTYGJA2xhccVlgXd4+muhJ2gT
         pGiA==
X-Gm-Message-State: AO0yUKWcy8Klct20XLlV7y5Y3x3f5S2H23bNUk0lnyenlHZ2sPfp1Y4X
        hKc8rh5JNxOEbDERhEyEVDM=
X-Google-Smtp-Source: AK7set9iiLqJtrwPOOeLikPIZrT4VRpY2Bg6vQXeyHliiddZ31/ha/5MTwNUlgvr+61QjoyKXtwnIw==
X-Received: by 2002:a05:622a:2c9:b0:3bd:155c:3ac8 with SMTP id a9-20020a05622a02c900b003bd155c3ac8mr8147019qtx.67.1677630422226;
        Tue, 28 Feb 2023 16:27:02 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id t8-20020ac85888000000b003bb8c60cdf1sm7576698qta.78.2023.02.28.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:27:01 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v3 3/3] riscv: configs: Add nommu PHONY defconfig for RV32
Date:   Tue, 28 Feb 2023 19:26:57 -0500
Message-Id: <20230301002657.352637-4-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32bit risc-v can be configured to run without MMU. Introduce
rv32_nommu_virt_defconfig .PHONY target, that is based on
nommu_virt_defconfig. This is similar to how rv32_defconfig
is based on "defconfig".

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Cc: Yimin Gu <ustcymgu@gmail.com>
---
V1->V2:
 - Fix typo in commit title
V2->V3:
 - Change from defconfig file to a PHONY config
---
 arch/riscv/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6203c3378922..1b276f62f22b 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -174,3 +174,7 @@ rv64_randconfig:
 PHONY += rv32_defconfig
 rv32_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 32-bit.config
+
+PHONY += rv32_nommu_virt_defconfig
+rv32_nommu_virt_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
-- 
2.39.0

