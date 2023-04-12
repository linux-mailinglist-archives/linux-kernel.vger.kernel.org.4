Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD36DFE20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjDLS4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDLS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:56:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5E7A88;
        Wed, 12 Apr 2023 11:56:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l16so6693601wms.1;
        Wed, 12 Apr 2023 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325788; x=1683917788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx4nd0Yo7fKfA1q3yw7nuQeOJtjuzCbWsWENU+02X/U=;
        b=j3e4rNR+ZcZLjp5tAqcuaxLtcjtd0cVx+9n8KNjeZfsJ+Un38teWu5H7Wj7UM3UzH7
         pNADw8ykTWJjrkYkEMZnnAWIBo17q2oNMwAtsJlpXYWMQpoqOyg7SM3qlnHqWrtVTKbU
         9myEI+8ivCstaNQ0EfZaGGRQUGw/U0+iPT+tSLc1rcz/dsFISlqxyoYovIzLl6t80zGi
         QGtlo/bTsGZH7HgOa0mNPafQcVagroJbAJ+Af+E1+tEPflKu+CEr6UvmpIilwsWPLnuH
         ZZ5z3d/hcV0HiiSD+0Wol5fn6l4rwiJYqmgL7k0Xg1kfaPidYtsdRmnx/OsBdAVLTXgV
         GZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325788; x=1683917788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx4nd0Yo7fKfA1q3yw7nuQeOJtjuzCbWsWENU+02X/U=;
        b=T/OQA5+35Q6N/sPXcCvAsVZWCfBY/UcYK/Eac9YtlOIlOtmrvOtSl21ThHytKjUpjx
         ECaSupSIioYPVGp9veY+7Q+5xxP1JtW2IwCARwxmkSGJo3kxompToRIk5WDQZLnAutrK
         2qC7yy+6QbwN3BJxqIetXodSAPe4wjNtHbxhSBneaOu8r1k+Wvv4ZmUJ42ka6e7kwXyT
         MgK8zxEnezbZ75BimlQ36eOl0YSXslfMNRjdCvKqqJlqVIgIhVqIS/V67VcAvS+eqsX2
         PY+AE2eCQTaZ17ha0oSpG47BHKAZeZNDATTgpatUva3Y3QokO59LQDoI/gkGMzjg1XGn
         8/wQ==
X-Gm-Message-State: AAQBX9cENnqTQcezxfeNGcHcZLns0MalhufZoAxrVfLrpbbaOkykpbcq
        lkFdfOBy6DZThQBWAUsax3w=
X-Google-Smtp-Source: AKy350a+FLNsanDgQUnmS909b2/SbHMG0vJ/IXppHzYuIIUpkVQ1uIQRMFeA/k6axvDo1afVpPUhjQ==
X-Received: by 2002:a7b:ce10:0:b0:3ee:7d95:a39f with SMTP id m16-20020a7bce10000000b003ee7d95a39fmr19381wmc.33.1681325788223;
        Wed, 12 Apr 2023 11:56:28 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:a00d:9fa0:9d0c:b9db])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003ede03e4369sm3362705wmq.33.2023.04.12.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:56:26 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] arm64: dts: renesas: rzv2l-smarc: Enable CRU, CSI support
Date:   Wed, 12 Apr 2023 19:56:08 +0100
Message-Id: <20230412185608.64628-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable CRU, CSI on RZ/V2L SMARC EVK and tie the CSI to the OV5645 sensor
using Device Tree overlay. RZ/G2L SMARC EVK and RZ/V2L SMARC EVK have the
same connections for connecting the CSI to OV5645 sensor so just reuse
the existing r9a07g044l2-smarc-cru-csi-ov5645.dtso and create a symbolic
link to this file for RZ/V2L SMARC EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile                            | 1 +
 .../boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso      | 2 +-
 .../boot/dts/renesas/r9a07g054l2-smarc-cru-csi-ov5645.dtso      | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)
 create mode 120000 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc-cru-csi-ov5645.dtso

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index f130165577a8..ebcbd66ba816 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc-cru-csi-ov5645.dtbo
 
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc-cru-csi-ov5645.dtbo
 
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
index d834bff9bda2..736c1e688cc8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree overlay for the RZ/G2L SMARC EVK with OV5645 camera
+ * Device Tree overlay for the RZ/{G2L, V2L} SMARC EVK with OV5645 camera
  * connected to CSI and CRU enabled.
  *
  * Copyright (C) 2023 Renesas Electronics Corp.
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc-cru-csi-ov5645.dtso b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc-cru-csi-ov5645.dtso
new file mode 120000
index 000000000000..0f175341d3ed
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc-cru-csi-ov5645.dtso
@@ -0,0 +1 @@
+r9a07g044l2-smarc-cru-csi-ov5645.dtso
\ No newline at end of file
-- 
2.25.1

