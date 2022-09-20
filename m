Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C175BED0E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiITSuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiITSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536F5EDEB;
        Tue, 20 Sep 2022 11:50:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b5so5952617wrr.5;
        Tue, 20 Sep 2022 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=saqg8LuTfnsZJ3d3nMOzIGbEOHySgN+QOr+Fyh+oGvU=;
        b=E3ktKEw2bONyUNtQQWmOeDI6X3m1DixFawO1GiepuTNO1sXDthzgQ4AfspuniNn9H1
         LHTX9UQb6zogKWmaABU39Kpspu4ctnn0hXltY7kKL7cPiEY83A3kDuDGgkZqbn4jZvO/
         44N0+1ubbByGRJ3Ej1Tipf9PaqXb2cVxt87fsVSOpnRGAyiKHDcMmSnj31l/1hlAPYQ6
         nadc89sfcsm/iB0jgHlJR7V4pA/F2+2XgdQIjaGZdQibzb3+GwxCz17v5XSIRv4n5I0Q
         GNXQdG56mDvGmi2DoJMrmzWccRPX7HY6s7OVR0qxGEnern3sM0erXCz7/Yygi018sGnL
         8teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=saqg8LuTfnsZJ3d3nMOzIGbEOHySgN+QOr+Fyh+oGvU=;
        b=kbBp1OipMm1R6SjXE1/6DUhanCIlX8v5Z9c2NvWpx8yFzWgbXtJH9/ZNyne9FQGdxZ
         P/Vin4eIrJjXLCUxN/D78TiWYO/qc9DBJLIlyxd4M2SwxWiF1xo5YNsYCIreeJLuZRIb
         CrszwwBqbkqph8Z0rNfwbw5WoFhbFGs+4G7weS36KoM5K2qfJxNBchyD3vciVy/zLcJs
         nPeCDuUGl2+HZjNxVwGEp778M8/DzKBysV1RQURYDBO3pFlLgUmMwFrGYh8YPunkheP5
         1EFz09GSlH7gG1udqMuABo1M0RjIAuz4bR2tJBap4eQqaXwjl9nOlKz1/XQg/1qptzhc
         4wIg==
X-Gm-Message-State: ACrzQf3jUB/cjLgXYDfiQ2Ow2uTW808dkMFW7iP0E4G4+eq9bUDUw2hU
        xfb4rIeLDNOYndL+2GoQ0WQ=
X-Google-Smtp-Source: AMsMyM6YSYr7WZq5t409SBpqy6SEPOcUNamgNdIAG/hLQ1jI52bmu+/GKkSkUtkbhOGNxb4SJmqqrg==
X-Received: by 2002:adf:e10f:0:b0:22a:43e8:969f with SMTP id t15-20020adfe10f000000b0022a43e8969fmr15964281wrz.292.1663699809541;
        Tue, 20 Sep 2022 11:50:09 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:08 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 01/10] dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
Date:   Tue, 20 Sep 2022 19:48:55 +0100
Message-Id: <20220920184904.90495-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
to the soc/renesas folder instead. This is in preparation for adding a new
SoC (RZ/Five) from Renesas which is based on RISC-V.

While at it drop the old entry for renesas.yaml from MAINTAINERS file and
there is no need to update the new file path of renesas.yaml as we already
have an entry for Documentation/devicetree/bindings/soc/renesas/ folder.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3 -> v4
* Updated the path in the DT binding
* Included RB tag from Geert

v3:
* New patch along with this series previously posted as a standalone
patch [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 .../devicetree/bindings/{arm => soc/renesas}/renesas.yaml       | 2 +-
 MAINTAINERS                                                     | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{arm => soc/renesas}/renesas.yaml (99%)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/arm/renesas.yaml
rename to Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index f51464a08aff..07c5e6ebd5a0 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/renesas.yaml#
+$id: http://devicetree.org/schemas/soc/renesas/renesas.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas SH-Mobile, R-Mobile, and R-Car Platform
diff --git a/MAINTAINERS b/MAINTAINERS
index d71b20527224..48c5a152f743 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2679,7 +2679,6 @@ S:	Supported
 Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
-F:	Documentation/devicetree/bindings/arm/renesas.yaml
 F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
 F:	Documentation/devicetree/bindings/soc/renesas/
 F:	arch/arm/boot/dts/emev2*
-- 
2.25.1

