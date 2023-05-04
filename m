Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50B6F65DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjEDHfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjEDHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:35:11 -0400
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579D3AA0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:34:57 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197]) by mx-outbound15-205.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 04 May 2023 07:34:41 +0000
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-63b3bc3e431so119382b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1683185680; x=1685777680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5QPvRlSaFZpq8dsJQg8Pjpg4+B8+aDABDgDSRo7qR4=;
        b=JdLfn7kU3QK/3RX5y+KBt3I0QKaUnqPcYTgx5cw67DLHB+AOPHlaDDmGoGqJ5zggrE
         aIvLXoGxpsyadRRyO04EY3Jnot50vViiRZ3A4PLKZamyQ6yMiG1PTodpaG6NFyNmMrTz
         tpuBEcfJATvcsnyIeJE4o0XFLijpaOcnVsuUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683185680; x=1685777680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5QPvRlSaFZpq8dsJQg8Pjpg4+B8+aDABDgDSRo7qR4=;
        b=ZQJTooN9U1FZpsJ2d/XgQXUko+kj+TyucB269lwv/f8eaAFW50XJ/6I7wGf1Qze7JA
         AQOBVULU3ZUqqlJPkRBGYzSuNoarpO6iExN1vd63MajAe4WApqpN0KEskFDcccHAX7S4
         1PGE/N9xKs6IBCRigGnruHhiMvFWUFVgWkL0E1eEcmgDuo2pfhvJzybxd4cvqR+JUiiw
         /QoC1cQBhSlqZGsLtAojubQ7h2B5MFSlSHI/2oYlF2AS/+ZoFGWtl9rro+vMWHj2SdVX
         1r567LxmCmsamrDrjdclG8SjDEtCzRZnhQ/kaFdsa7CjL43ow1xzDa2wfSj4XMSRlH8d
         JDsw==
X-Gm-Message-State: AC+VfDznAyV7p5RWfi0Rzf99tfACP3+4zx7DuD8nrsxl3In87kwrUiNe
        TracTxkVBRVePJqaHNrzCvlssYwFUeVzkGzbT6eiCCqTGF4VZjI6CpIFBKjkYZXyzn2UDOJlmlU
        IPsZ8EhwIXkXvbJs85R7RvPVILIDRWoePIbfVrHy3jUhz/NyiuT0YNBnHP1+H
X-Received: by 2002:a05:6a00:190e:b0:63b:1708:10aa with SMTP id y14-20020a056a00190e00b0063b170810aamr1383217pfi.34.1683185680230;
        Thu, 04 May 2023 00:34:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qbA5uyhVOaMDXNOKjomYelB3nrcUugzFaaQbM+ufkEim9p5f2sOkHsHZ5zWiu2+vZql3wOg==
X-Received: by 2002:a05:6a00:190e:b0:63b:1708:10aa with SMTP id y14-20020a056a00190e00b0063b170810aamr1383202pfi.34.1683185679851;
        Thu, 04 May 2023 00:34:39 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id q22-20020aa79616000000b0063f1a1e3003sm22884865pfg.166.2023.05.04.00.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:34:39 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V5 0/2] Fix WKUP domain IO PADCONFIG issue and add RPi header support 
Date:   Thu,  4 May 2023 13:04:30 +0530
Message-Id: <20230504073432.6438-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1683185680-304045-5471-1614-1
X-BESS-VER: 2019.1_20230502.2000
X-BESS-Apparent-Source-IP: 209.85.210.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNDY1B7IygIJJJknJySmGZq
        lGFiamiSkmFmmWKcYm5okGZgbGZmaGiUq1sQCpDIF8QQAAAA==
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.247924 [from 
        cloudscan19-39.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
This patch series fix the incorrect IO PADCONFIG offset size of the
wakeup domain for J721S2 SoC and add RPi expansion header support 
for the AM68 SK.

---
Changes in V5:
-Remove main padconfig split patch which is not required.

Changes in V4:
- Address review comments
  * Update main and wakeup domain IO padconfig
  * Correct the pinctrl node offsets as per the newly split wkup_pmx*
    and main_pmx* nodes.

Changes in V3:
- Add Fixes tag.

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 as 0x190 is the last register of the
  IO PADCONFIG register set.

V1: https://lore.kernel.org/all/20230123135831.4184-1-sinthu.raja@ti.com/
V2: https://lore.kernel.org/lkml/20230124120311.7323-1-sinthu.raja@ti.com/T/
V3: https://lore.kernel.org/linux-arm-kernel/20230316114102.3602-2-sinthu.raja@ti.com/T/
V4: https://lore.kernel.org/lkml/20230424081536.12123-1-sinthu.raja@ti.com/

Sinthu Raja (2):
  arm64: dts: ti: k3-j721s2: fix wkup pinmux range
  arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 119 ++++++++++++++----
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  76 +++++------
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  29 ++++-
 3 files changed, 163 insertions(+), 61 deletions(-)

-- 
2.36.1

