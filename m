Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D12C6C4B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCVM5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCVM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:57:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19E5CED3;
        Wed, 22 Mar 2023 05:56:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d17so8528636wrb.11;
        Wed, 22 Mar 2023 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679489818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSRlYGo0pPcSAVgS67EoMsT59xgrjRi2k0K32u13uaY=;
        b=guZ97IEno8l8ZelrNhTuy6yi42yar0tsz0RzlqQIRGxvLpAFmQjuIJmHprdXDaGv9X
         0MnIb0rpWfLoirD6/d+oL+kuqub8TuWb6tT/saNHuBGm72r5VhGeoezYF4os6VmJmnLp
         Km4aE1nP8HreRfzC8lx724Z8Qzbym2KSOyYp6jOb7hTXhtCN2dKJnrTUBiB0euwYAUqs
         lcZU0D0okrrjRk8oRegenHVuq3CZnuKCeUd58QmsC9MIelu72rW1VL5fCX6netMxKjWA
         m5CA3yUEhS1W6e5vIYpXFwukAGc8I6vtptZbYZkXP8Z5ssNg4S8/76chvsmBQKBhLMLM
         52Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSRlYGo0pPcSAVgS67EoMsT59xgrjRi2k0K32u13uaY=;
        b=snXC4t3A0SDHpSYVGT371S8adjEWuHZevq/x2ozw39jyd8Oz1RJyf4N8+iOh6DPsD8
         R2UZdt72HyC6Ojwn/i9Kos/nCucILc74iyBejHksbDl0TlzPc1iERwHWvJ4iSEmeKpec
         HxJfKlS6vqWVsvnXpegaSLs4qYY+xzipo9XhF+vQh8c231OBlOM5YVWw+0/Sr+OuRADS
         qT9vg5NICIOnbWsslMfGLhfqEY+9ql0IgMu8K+FkCFm/wD+lN0zA57Okw4TDKJ0IiA/C
         DBJVAXporqK4EEofp8NqeCJ+AsniHvkslFY4XDFlDYQGZFoedQZBmwghypj//SgauQSu
         CSqA==
X-Gm-Message-State: AO0yUKWCua4Fl2fgtCUP0dreetLUlLY4McJy+EvKOdrvnGyUTmtLkZNn
        hAxtZFJUioVE07Bch1xydDE=
X-Google-Smtp-Source: AK7set9zP8cNlKfIrSdrWFsgEj5gXMKRt0PoJOE1e1uUHf1gubdKAZucMrQnkZ3tEDV3ZDx4WvlgyA==
X-Received: by 2002:a5d:554a:0:b0:2d8:5df8:4566 with SMTP id g10-20020a5d554a000000b002d85df84566mr4548191wrw.8.1679489817678;
        Wed, 22 Mar 2023 05:56:57 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c35:3f3f:458c:5fef])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm13707167wrh.21.2023.03.22.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:56:57 -0700 (PDT)
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
Subject: [PATCH v3 0/2] RZ/G2L: Add CRU, CSI support
Date:   Wed, 22 Mar 2023 12:56:46 +0000
Message-Id: <20230322125648.24948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds support for CRU and CSI support to RZ/G2L SoC
and enables it on the RZ/G2L SMARC EVK. Also ov5645 node is added which
connects to the CSI2 node. The CRU, CSI and ov5645 nodes are added as an
overlay.

v2->v3
* Moved the include headers to r9a07g044l2-smarc-cru-csi-ov5645.dtso

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
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 79 ++++++++++++++++++
 .../r9a07g044l2-smarc-cru-csi-ov5645.dtso     | 21 +++++
 .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  | 80 +++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi

-- 
2.25.1

