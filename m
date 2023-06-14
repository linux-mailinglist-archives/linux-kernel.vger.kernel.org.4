Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C7672FB94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbjFNKsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjFNKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:48:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1D2E41;
        Wed, 14 Jun 2023 03:48:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso3903595e9.3;
        Wed, 14 Jun 2023 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686739685; x=1689331685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJaQfZH5klVZ+UsbJ+KX7G2hR7Ab0l6J5mOqBdKcW9k=;
        b=n5w8Va0n+nyCFXsVC0zkVOUgZr+2F3h9VXFV4pczcK2fT1Kcm8QencSnIb/VAtt8an
         avJgH7XRWFnJpaL36SorUN7DaMG85kGxjuu2+Hw41D3lMWvFVk8vZ7d4XzyNtkdxGCzf
         i6vP1C06wdh8cFH8D4bNQUWzNCdi+sbAtcpHGWZW7p59LhbMqTZzYIJ6il2ZXcvWK03I
         HZGKkybRD2KdwTqKH81AmxwZh3RdRhhCxooeNqFA2NiBkGEjcU/BaE35Gw3BWRFLkmwx
         yi2ACtaPUFJzi7QZl5F8xulQf/0ITC79Sf5xIPRgVBPjUaI2VLMP7u0XcDKX9y3/W28R
         Ib+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739685; x=1689331685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJaQfZH5klVZ+UsbJ+KX7G2hR7Ab0l6J5mOqBdKcW9k=;
        b=KqYui7cBxXsDyQs1taAH8TcU7R7dNhAEV9rZJoPu6QdcjwAGqZoWvLWs07z0/v5LbV
         MUf6ReQFPqOBmONnJ6NpsXCoOvexvkhZ/krzN1SmxLnidTX1ygvbdiXJ+oHV88zpmZ3U
         IITSmjEyCYu9TQkeCnMo3nsLNeB9M0E5lfmL1dXcKTfrExAyeIGM4SiD2rCGaLnztnvf
         z/vr+mOLDMlG/xvVRTC6S3M0wM/6J1IoPsn/XCg5gKj5+MC8X7tslr92QaWbyyYU+BHV
         evGT3h1m7/dmN45epI/50ML73I/zy21YaBKEYVqrYGJa5ypHdFn5gyIECHt4eAo/m730
         wGGA==
X-Gm-Message-State: AC+VfDwxsAmcemcMUBmYk1652q6cjTdFzDSX5Aj/622wKGbu7bqLwVYZ
        2m3wT/2p6V+RWl8C/yoqZV4=
X-Google-Smtp-Source: ACHHUZ45HkEYYAoQdp7hra7yjIvLJvzZvA32DSEBsIu3jc+3RXv3/cMGbB9dt+2+h2Teih1HhiSKNA==
X-Received: by 2002:a05:600c:c2:b0:3f7:30c0:c6a with SMTP id u2-20020a05600c00c200b003f730c00c6amr9747793wmm.25.1686739684957;
        Wed, 14 Jun 2023 03:48:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm17154904wma.24.2023.06.14.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:48:04 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v9 1/6] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Wed, 14 Jun 2023 11:47:54 +0100
Message-Id: <20230614104759.228372-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add Andes Technology to the vendors list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v8 -> v9
* Included RB tag from Geert

v7 -> v8
* No change

v6 -> v7
* No change

v5 -> v6
* No change

v4 -> v5
* Included RB tags

RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/vendorid_list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index cb89af3f0704..e55407ace0c3 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -5,6 +5,7 @@
 #ifndef ASM_VENDOR_LIST_H
 #define ASM_VENDOR_LIST_H
 
+#define ANDESTECH_VENDOR_ID	0x31e
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
-- 
2.25.1

