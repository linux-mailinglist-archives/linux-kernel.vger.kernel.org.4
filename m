Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F324E6E7835
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjDSLLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjDSLLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D471446D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a6715ee82fso35063405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902622; x=1684494622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl6ZZPHDkI9/+UU2TcDaa7qsesK/iY8UwQlFo2pnRGU=;
        b=teXl9sZA/vikfdnyID3OxKrmidpT4xgl6Dzon/dM8dfFMedyiwryINMJF1Ivem0Ntw
         9eg4qqI0ib3racb7edyRvjU0vYn7vHgSUpIDQeg8WtOLg5oElpv+znRGFB0uo1y3FaE5
         8DSuROEgor7W6zjph2142OtZ9pV5uYq83FEvjYsly8hshW1K5QBY1HsOIpvv1LQ1zFQU
         y9mwCdPTo37EzbUCFWZsZ0vqtVaFDqjPYdj/gKjiYkwJgCDWMN8t3LMTNLRnkrUzTTVu
         v9TDsLX6+Yz2HkWVQqGwpd7PpXFdpgq+TaHrzHWnlfXSYvptMWnaKAyv6Mxbehoj4Rxt
         LqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902622; x=1684494622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl6ZZPHDkI9/+UU2TcDaa7qsesK/iY8UwQlFo2pnRGU=;
        b=ce2pCg5jmUOiNDAFl6ca1ObMADhrzjwC3Z5HvPQ/ZLX/pAm4XKHtofZRxZGYsF0ZsO
         QVN47R/63Qjj8euVmPuHZAGkiyGCn52Tpzy2LtnnNXukctc4yeo/mkUSNNSGqAuHSz+R
         KvVCE4x6DsE6Q67MNR461NSnO1c1hAUt7JxTjcBdXtKWHPnvP4i9y9Eg3R2SwetkFtWZ
         zC9GR1EhCGkPUJ/CjgTeEYji1pv3bg8o7QivGPYdkPRbHztAiw8b/6pI66sNQkijvFnq
         ZqtsqJ2kffWQEON/Nhd+ohjituZfGzlkv2GL1OGHEZkXsR1fT6+qJoUXq7+SNFpARjUU
         kYBw==
X-Gm-Message-State: AAQBX9d4imEz+XwDG1LJdKDlwl3rurI97b1Uw1NcsM6JLdLP++ajgND7
        tttuZjwXBhl536AYFDXT+c8AvC4hkBdsV6XDPSY=
X-Google-Smtp-Source: AKy350bNAAjh2WZPLBif71YYYSuewAeEIsbLtcoFmPJ/ErtgNLYslU7rMW2Oz+4DNRkcioOfHCCkiA==
X-Received: by 2002:a17:903:22d0:b0:1a6:74ce:9bed with SMTP id y16-20020a17090322d000b001a674ce9bedmr5688908plg.46.1681902621989;
        Wed, 19 Apr 2023 04:10:21 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:21 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 08/21] RISC-V: QoS: expose implementation to resctrl
Date:   Wed, 19 Apr 2023 04:10:58 -0700
Message-Id: <20230419111111.477118-9-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic resctrl header include/linux/resctrl.h includes
asm/resctrl.h when CONFIG_ARCH_HAS_CPU_RESCTRL is set.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/include/asm/resctrl.h | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/riscv/include/asm/resctrl.h

diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
new file mode 100644
index 000000000000..7d247d87dab9
--- /dev/null
+++ b/arch/riscv/include/asm/resctrl.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/riscv_qos.h>
-- 
2.34.1

