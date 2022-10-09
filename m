Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2E5F9388
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJIXeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiJIXdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:33:40 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC786FA7;
        Sun,  9 Oct 2022 16:03:48 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id b4so14683672wrs.1;
        Sun, 09 Oct 2022 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntYc1AkFq41YXwR0c67KJmXrmIK2VgnpBL6L+QNUEAo=;
        b=gDSZJq4WKYiPUbHWtXys8bDocFRBw3yOGuyOsXXgv0Bvhd0nOK+VY5SepfTuLIfI64
         jeeBzawyDaRt05Fub/Pu/nFdIol7jYsGMy52BW6JsKqIRFaScuWjgV6UAKPvFGhYUgB0
         g3OJNmdfW+/YED+f+MF8Y2h1JIrHLtuPtl7kZesRFL50afLLhfi4mVem2Z4LoKtAlUlm
         qM20NtXqCeEmPIMoeaDVBGCo3wRJeVFxau0EqNxO3sKiYsOt8lClN6Zuvt/kaz7oYG7s
         +PAjAjFAS3zsDt4+u+pRH9r/9v0faf8dkUee6ujGn9kHFGDCTrP8LuM82y6lgE9uvy6r
         kdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntYc1AkFq41YXwR0c67KJmXrmIK2VgnpBL6L+QNUEAo=;
        b=a3hw5zK1ucAIoailSxySXqEPNaMNmD7TFWAl2f7Tz26Wa/qCsFMrUd91iqNLYkWAUl
         7urhmad6efZzV+E96IB2u6h0fWNlln5mftcoAkjVe/PdmCZ+bLMURbhp1YG8nnG+FwIY
         05qpY+AvCVP+kCH16TgbaN52+rIU3DbNIYEp9I3oNkoWjS9EfcmeNR9MfkOY5QZf3OvO
         LhUh1osKNifB3HkDr/8eCZwKzx4pQtMmwdC8CziVcwz2MmlDULdci5M1m1puHEJXQWYH
         jpNw6KZmHJUcf3Pozu0d7jHz7qe1EG158EQKYkFwasNAqXA/TXFJThHA1NWrBJepzfGt
         WjcQ==
X-Gm-Message-State: ACrzQf0wquhphg6LgWJp+7vImBqR2bbtJmcl9lE023biGYTusap+SquC
        iQO3bNvuoc+vHgtjam8txc/xCIbu4R5BCg==
X-Google-Smtp-Source: AMsMyM5E2pn0j6nx1UKQDQdPis08K0nejWGf8xUEEguMvxKZB/pYIAhc+YaOrlE/0CyG6A1xzh1fkw==
X-Received: by 2002:adf:d1ec:0:b0:22e:3341:a8cb with SMTP id g12-20020adfd1ec000000b0022e3341a8cbmr9422466wrd.151.1665356458447;
        Sun, 09 Oct 2022 16:00:58 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id r16-20020adff710000000b0022afbd02c69sm7239689wrp.56.2022.10.09.16.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:00:57 -0700 (PDT)
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
Subject: [PATCH 0/5] arm64: dts: renesas: rzg2l/rzg2lc/rzg2ul/rzv2l: Drop WDT2
Date:   Mon, 10 Oct 2022 00:00:39 +0100
Message-Id: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series aims to drop WDT CH2 from SoC DTSIs and enabling of it
from board DTSs as WDT CH2 is specifically to check the operation of
Cortex-M33 CPU.

Cheers,
Prabhakar

Lad Prabhakar (5):
  arm64: dts: renesas: rzg2l-smarc-som: Drop enabling WDT2
  arm64: dts: renesas: rzg2lc-smarc-som: Drop enabling WDT2
  arm64: dts: renesas: r9a07g044: Drop WDT2 node
  arm64: dts: renesas: r9a07g054: Drop WDT2 node
  arm64: dts: renesas: r9a07g043: Drop WDT2 node

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi  |  5 -----
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi |  5 -----
 5 files changed, 55 deletions(-)


base-commit: f621040b30c93b1a054c0d12b6e310eecbb1a58b
-- 
2.25.1

