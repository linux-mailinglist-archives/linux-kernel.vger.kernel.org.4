Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD467E6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjA0Njo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjA0Njm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:39:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6B7C30B;
        Fri, 27 Jan 2023 05:39:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m15so3460666wms.4;
        Fri, 27 Jan 2023 05:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja33JLi143pU/WYqLvfnqUFPaRVYHTyrZwn3llYvgzU=;
        b=bajN5PPKpcgj8U1WtslH3HTfCsD8cryfKe0bVSifN+MDSPT3oqePElwoejd0orsanQ
         5r7/d0keCTMuRUQdG9QI8mqHI0FhCVt//C2dJxXAIopAJOTfV7B7bE7q2gGV5o1z2EsB
         QOtDsTASxGjRPasUI/qFlNr93WEUlVG4BXnU7IGxAHp39YKP46UaNa6tFp9ZETCGbGnP
         ETWOA9Fu67wriRw6K6li/bsD8Su8KbUSPeQLcnaE6ZUsFZeWjiQYay0kvTn5KyG52AfV
         cyFjOzd7ipzhogfvjt0Rb0pBIJrqYmtsAdj4kN1WakjGVwaJZhfAh4Zz285B2TOxDqjS
         BNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ja33JLi143pU/WYqLvfnqUFPaRVYHTyrZwn3llYvgzU=;
        b=IQh3ASInfEcuLTtb/7sQ00XZsRVsOyHnsv6CIHQhiQ1T6mvacAE75fAofmlK6YXpSO
         jQ9VUWAZjxOKxpknIuFevfDgLEONBXESXDFBZKZ4vt+C4Vj0R5w8R4epbEsR7ET5bbPk
         8EXBugNz+GUs5Gg1dPQC88tZbdl8hFWspQprn41o+wR0dJENhLfM/F9g/gRQz86yiUPo
         iIPiwMS452tNANcjbZhWJFMkrE12TqI8iUdSWXdZAg801Ky9sjtsrWFWraYIUO0vvtmp
         MDSjK0cyC+myEpCzqUt0SqaoVM2xXeebDSIE8Xsv+TWKU0KLegbm0BjaRvGWSShRzbuq
         O/DQ==
X-Gm-Message-State: AFqh2korddUFcTKwZSuXvU9cWjalEE6vjU2JjGD8SgWG9kFJ+7NUPyFA
        iK0JdAYKzZLX2E7swCcTDNE=
X-Google-Smtp-Source: AMrXdXsRbb5oLWB1Ua2+jj5GBf7OjD+ACyWMTlSduVtfV1Ca7lgR5tdPxHlkeyDphLlDYgbG15bMWg==
X-Received: by 2002:a05:600c:d2:b0:3da:f475:6480 with SMTP id u18-20020a05600c00d200b003daf4756480mr39760650wmm.7.1674826779152;
        Fri, 27 Jan 2023 05:39:39 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:ca6:cb06:c6e7:59f6])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003dc22ee5a2bsm5752918wmo.39.2023.01.27.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:39:38 -0800 (PST)
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
Subject: [PATCH 0/2] Share RZ/G2L SoC DTSI with RZ/V2L SoC
Date:   Fri, 27 Jan 2023 13:39:07 +0000
Message-Id: <20230127133909.144774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

