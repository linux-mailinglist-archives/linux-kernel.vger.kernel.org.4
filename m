Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1119B683969
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjAaWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjAaWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:35:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F6D4A225;
        Tue, 31 Jan 2023 14:35:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t7so7276246wrp.5;
        Tue, 31 Jan 2023 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgvTrWdaR1wFP4Qt+TRaT9Oxh1HlaUCAyz5MCGBFBUc=;
        b=a6IC79eKpmFaXocj8mnhIzUn62Zwotkvt+Xyp3OxKqjFlDckSue0BU2dYlgpgvKsyn
         AIjmPhg++xS3gbjw+ak1ON3F1ZYBKWHB9D/ybjEXU6+JDaoaI+2CQHd7jW012TUFxws6
         PH8WUC8e59UcPlW3747xsU6ZTbevuWrtp1bkNVbhxs/6hGY9eYF/TnJ9ZJfTxSFBFOUw
         Rv3Qf3vnaskY8e6RJcdEp65JxCUP1JN2XmdSrOUyYeTEMJ1oUtwggNjjNboZYYF2HRCN
         tB/vqVPI5Pwgc+ZJkbnCCydyQAKfGxm4lZcWLtWB+cQIhhadFEFOUk1iRHzZmlq3/kq9
         kVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgvTrWdaR1wFP4Qt+TRaT9Oxh1HlaUCAyz5MCGBFBUc=;
        b=RjR9JFTp/guYiXDUt/9eDi53SkyPqf8Y+WS5dG4hYR3/LQqFmCeBUVtYwxbfaOpqNd
         zIS12M/cfoGRXFwVyWAsgX+jaDromjfSH8EfEHsXB6ff1eFMlFMu1EpfIm83Wp63HHwY
         jaU+EuGgrPrhZCpqWqQiqmg4vnfEA/ednUC8rqCdWVmB/8x87r5+7wX24mHOhYML0LWX
         M7IlvaYdiJ0Zfx4GXp6SoZ7SONoconf2DiEZiKgbJmtq0T4nv/PgwOTbEAyuMprA/1TP
         j0TI78V2PG/+IYJlZxUPCbZKAxUvSFaNBR0Rv6zSM8VGrn02QfHf128aQef9uoFRVcLI
         dQWQ==
X-Gm-Message-State: AO0yUKXtGlcyqzUPfh6/BRwVs2rVHLoBozzwdx+I34kAoA77/tcZRu9B
        aUV/beN71oF7V9LjNz9xDpU=
X-Google-Smtp-Source: AK7set83+rRVZD9VosLRbSWGdBN+c+/hML6cqra0yXon9vKVUJy3hvXXkkfw/wyTlDIalOg74MJLLA==
X-Received: by 2002:a5d:65c9:0:b0:2bd:e87c:e831 with SMTP id e9-20020a5d65c9000000b002bde87ce831mr566478wrw.69.1675204540528;
        Tue, 31 Jan 2023 14:35:40 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:a572:ff5:a6d8:66bc])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b002be0b1e556esm15523184wrt.59.2023.01.31.14.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:35:39 -0800 (PST)
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
Subject: [PATCH v2 0/2] Share RZ/G2L SoC DTSI with RZ/V2L SoC
Date:   Tue, 31 Jan 2023 22:35:27 +0000
Message-Id: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This series aims to reuse RZ/G2L SoC DTSI with RZ/V2L as both the SoCs are
almost identical.

v1 -> v2
* Patch 1/2 unchanged, for patch 2/2 sorted the nodes based on the names.

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230127133909.144774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: r9a07g044: Use SoC specific macro for CPG and
    RESET
  arm64: dts: renesas: r9a07g054: Reuse RZ/G2L SoC DTSI

 arch/arm64/boot/dts/renesas/r9a07g044.dtsi |  254 ++---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 1149 +++-----------------
 2 files changed, 256 insertions(+), 1147 deletions(-)

-- 
2.25.1

