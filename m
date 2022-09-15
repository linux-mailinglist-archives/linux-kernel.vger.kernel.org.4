Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529815BA0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIOSRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355E98051F;
        Thu, 15 Sep 2022 11:17:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e16so32109221wrx.7;
        Thu, 15 Sep 2022 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1kMaGOYyU6bj/tvC0QnNHtm9kk+nLvr6d2aRk6glIRs=;
        b=QQ02RwhHzFVjmu0CTMvsqR4LNpGw08oPc7Vv9eCr/WGRACQPmttZU6QybB1rGNtYb7
         jCXHS+o+6IB6HhQYuzpWvrizRX7IvpxizaGkEY4cgGdaLgLK3CAfHXe2+1aUQBB3DbCI
         vfB5FuHOAYooEGf2xag3Hk8K96CwSk/QEs5P2LSPGD5PZbRPWk+/7gPPPvHiBXNlO294
         lCWryhApUMmYLeBOqDJFjXcEeomnrVRrErvRACENER9maugY2Yn3Eu/FbH6odtxrgsQ2
         QRx1QKGHZCuPK0FzEg1pIiKSCwzsfKERg6UgmmuKRvF58TS+xlG2vXyG76nyw67avwsW
         59xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1kMaGOYyU6bj/tvC0QnNHtm9kk+nLvr6d2aRk6glIRs=;
        b=2OQKdu4I+lW0pvhm6HTn4+bgL72w5htYPNJZvFw2AX3qKMNdrvE5tcQWZQ6LiSIIW1
         fS6vflomt/X9pSvIjd5o9TniF5+D5mN5fMme+GywFLXgyj4watFVd2KUXt3lwBaYS4eG
         a9qomCjqnyQUxZwCrz0s0AkAXo0zJL6MpNvSIGkxHhbVPhC7w/LH8g+X1vWFlW3XV+oD
         GqJC0Ec/qlmp6UjEVICzVC6nwSo++hvPwdVguc0wByFcN20Ww4cYSDZLVqFd/tXRV6E3
         YkdpyrstH6faRR4dhj8fDDfMIPJBUvkCjHpH/3vQPm9VvIRq6z2DFPEoXGOl+RT9x++L
         71SQ==
X-Gm-Message-State: ACrzQf3s7p9Q2LccK/iibUlvJOTMYo2VhE6+yf87Bii6VOjzV7mdbdae
        y/IbfsrHU3cRargFX1rNabA=
X-Google-Smtp-Source: AMsMyM5pSwquDv6Z9TOe/3EQTCmIcBKd4kDwDnrHZ4I8sBfN2WGkB7fNfmNXrOljyfGoNCbfKNTyXw==
X-Received: by 2002:a05:6000:1548:b0:22a:c113:c9d0 with SMTP id 8-20020a056000154800b0022ac113c9d0mr610513wry.653.1663265845601;
        Thu, 15 Sep 2022 11:17:25 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:24 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 01/10] dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
Date:   Thu, 15 Sep 2022 19:15:49 +0100
Message-Id: <20220915181558.354737-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
v3:
* New patch along with this series previously posted as a standalone
patch [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 .../devicetree/bindings/{arm => soc/renesas}/renesas.yaml        | 0
 MAINTAINERS                                                      | 1 -
 2 files changed, 1 deletion(-)
 rename Documentation/devicetree/bindings/{arm => soc/renesas}/renesas.yaml (100%)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/arm/renesas.yaml
rename to Documentation/devicetree/bindings/soc/renesas/renesas.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index c26a5c573a5d..f5f17c50dac3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2673,7 +2673,6 @@ S:	Supported
 Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
-F:	Documentation/devicetree/bindings/arm/renesas.yaml
 F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
 F:	Documentation/devicetree/bindings/soc/renesas/
 F:	arch/arm/boot/dts/emev2*
-- 
2.25.1

