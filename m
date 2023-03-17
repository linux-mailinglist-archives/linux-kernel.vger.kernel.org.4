Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8B6BE956
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCQMek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQMei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:34:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C7AD31;
        Fri, 17 Mar 2023 05:33:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i9so4281524wrp.3;
        Fri, 17 Mar 2023 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679056409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Wy1AwTsLh6VX8OVUHCexjXRtBHIjRzVBkQ4ezpP1E=;
        b=jMpD+KdfbZTIQ73dkfe3Llm4sRYdiQUUJyKsjmjLB6F3sY3MXKTmlm586mT4ISBbpQ
         EQ+/QbiQbyM4qE7teB+rpAYVYWht1G94AMjV5rQa0MLfWi/ZovIlfKJhbsFD+zPvV1eL
         xMxKe8Rqk6WDxHY7fKZ2mCP/2AbSNJ2iaO6geBoxUBguToMAkGfrPCcxa6JfLlNDovTV
         QQ0i2YDgQNdbJCPfVPIiu4p+E3YvrHJVKt2NAWvJSKcWyZfZwznaPpo8yWUMdBz1wPJD
         zFEhzAOmMCj0AgCb1dZToqdrfDVoY1TzyfmSY3Z2cJ3837yvyNFxf/SP8tZnPMO4YipK
         Iu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/Wy1AwTsLh6VX8OVUHCexjXRtBHIjRzVBkQ4ezpP1E=;
        b=HDuUsEnUb5NyKj1XIdjrYdRDiadswqDo8lP7SCcje8WqHYMaYwc/IIo5NKbTkLA1tO
         diD0zTYOCfZ+NTXYCjEdcVl7APJlOw0GkoKHYwtTImGzdKiWcTHJNe9hBFjwNywHPdom
         TBJi2wwwAtj3UiVjaHvXVCunQERJNCicvgHq4sA0BDStyCLHZQeUxJ7ezxYU4BEFHHKP
         SblxjNJ5C8eM2O9MgQWxWCKbxpvOme942AE7UODMDYKC2Bboflcc96GC4+nTs4/bSm5V
         N8gF9IVYKGTtk1ytoeRTZqXg8ric9MOUIdv7Mq4PFzi0SaKolKGTkofcmybwY1Cow5Gf
         e2ww==
X-Gm-Message-State: AO0yUKUc/Lj3vQIUm5MdkBw8juUyTGtaeIC63BNZoefw3KT1C/kMYbcB
        lw8wO6OwcEr2mlcybts/TOc=
X-Google-Smtp-Source: AK7set/30dngfeeDzKQ+QTuk8xOPIdlr4/4bPmXxw19Uy+Rt7exKXaCjOkbocIePzfVBKXogZ3Svtw==
X-Received: by 2002:adf:dd92:0:b0:2cf:e3c7:596e with SMTP id x18-20020adfdd92000000b002cfe3c7596emr7354228wrl.35.1679056408550;
        Fri, 17 Mar 2023 05:33:28 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc60:8c15:c868:fa91])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d464a000000b002cea8f07813sm1876515wrs.81.2023.03.17.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 05:33:27 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] RZ/G2L: Add CRU, CSI support
Date:   Fri, 17 Mar 2023 12:33:12 +0000
Message-Id: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

Hi All,

This patch series adds support for CRU and CSI support to RZ/G2L SoC
and enables it on the RZ/G2L SMARC EVK. Also ov5645 node is added which
connects to the CSI2 node.

Note, this patch series applies on top of [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

v1->v2
* Dropped using SOC_PREFIX() macro in patch #1
* Included RB tag from Geert for patch #1
* Used overlay to enable CRU, CSI and ov5645 sensor

v1:
https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
  arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support

 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 79 +++++++++++++++++
 .../r9a07g044l2-smarc-cru-csi-ov5645.dtso     | 18 ++++
 .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  | 87 +++++++++++++++++++
 4 files changed, 185 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi

-- 
2.25.1

