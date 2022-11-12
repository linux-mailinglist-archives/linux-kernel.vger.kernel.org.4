Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36C862693B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiKLLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKLLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:42:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7301A3AB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:42:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d20so6232053plr.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnom-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUJur4eVPzA0iY2JL1ZbCoGq1dKojqTulWseoldi6uA=;
        b=WhOUwIfGsxKfkHoG7tRINJX7dicX7/Tvb4xl7lUAkj37SLilDOnia9YuXBHa54zqaT
         Vi14P7KPX0Kgm28u+a48bfS2LPxa3H5Yp/eSxv9HuHcRzLG2k2y9WsSmLANx1AXqnxpA
         wBT1AU2y+KuBKnzsUlz4zOskgBxsiUWT+QC37GvEhT/BI7sFkZBiaLspmWbJCN+dIpH/
         RTO9OPQUujoyMgXwbGlspCh8KtfNA43SbODn94XTlpindNd5mi5nRtmzv4CMD4qZq/s8
         q85FJIwyxQZ+oSJPJ76vNuvOlwRSYEnKfga8kA0PxT3ij7p/k//QAZHsmRclExCaKwBE
         8WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUJur4eVPzA0iY2JL1ZbCoGq1dKojqTulWseoldi6uA=;
        b=yjHO4iDnkzJA8o7eUo6Y/BpQXhtvlnyTsA8cY4kScGmT/dbt2r9Sxw1bRABbQHgIbx
         oXJsEdC+MoRStJBbRMtOfvMjjQaOZONH47NQOQxLPeoaCXlGUkCRKipPpwdIs8fgNYxw
         CERVON0viqbBoFCZLMUjnZwiYObyxu0MtSScOpNUFou4KUFrxF7CuQPKrlixz4p8XQNw
         J3iaGlKnQyYEXom++ztXDgl18qUeG5ULgwGVSTmzFQu9OvVa3R35dg9/PND9M87Ce2Ta
         sIrxMxA29EN3x/9NAwTG2TcegBCTGAgfuwPWha/nHvLxdfiUkTXCyogDAQwHOUL5wR/K
         NT1g==
X-Gm-Message-State: ANoB5plaZknzEIRYOQ7WobKpK0p9W1NL88qSIZe6zozAq+jsCxR3J0NW
        emK6T54nWe28JbIZu/zGXQN3rA==
X-Google-Smtp-Source: AA0mqf5cl6ADcjWvHGgt9BQptQBABfkSpoLRYCxk+AcKUl0ZOQmJHdAjXaha43C6ssnesABN2xaTRw==
X-Received: by 2002:a17:902:f7d1:b0:17f:8544:e0dd with SMTP id h17-20020a170902f7d100b0017f8544e0ddmr6543348plw.34.1668253322831;
        Sat, 12 Nov 2022 03:42:02 -0800 (PST)
Received: from astraea-lnx.home.neggl.es (119-18-16-128.771210.mel.static.aussiebb.net. [119.18.16.128])
        by smtp.gmail.com with ESMTPSA id e2-20020aa79802000000b0056e8ce106d1sm3132091pfl.132.2022.11.12.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 03:42:02 -0800 (PST)
From:   Andrew Powers-Holmes <aholmes@omnom.net>
To:     linux-rockchip@lists.infradead.org
Cc:     =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] arm64: dts: rockchip: rk356x: Fix PCIe register and range mappings
Date:   Sat, 12 Nov 2022 22:41:25 +1100
Message-Id: <20221112114125.1637543-1-aholmes@omnom.net>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip RK356x SoCs currently have incorrect, or at least sub-optimal,`reg`
and `ranges` values in their DTS files' PCIe nodes. Ondřej Jirman sent a patch
in [1] to resolve this, but it was not merged due to some issues discovered
during testing (it fixed his issues with devices behind a switch, but broke
directly connected NVMe drives, amongst others - see [2]).

This patch is a reworked of that patch, using the same mappings the Rockchip BSP
kernel uses. Peter sent these up during the discussion in [3] and they've been
tested on his boards as well as Ondřej's, mine, and those of a few others.

Ondřej also sent a patch in [4] with these fixed ranges, but without the fix
for RK3568 as he was not able to test on that SoC. I've included the fixes for
both SoCs as he's happy with that and the patch has not yet been merged.

I have tested these ranges against devices which only map 32-bit ranges, devices
which only map 64-bit, and devices which require both. An Intel i350-T4 NIC does
not enumerate at all with the existing or previous patch's addresses, but works
quite happily with these, as do NVMe drives and every other device I've been
able to test.

MSI/MSI-X has also been tested as working, but does not currently work upstream
due to a workaround needed in the GIC driver which Rockchip are still yet to
issue an erratum for.

Thanks,
Andrew

[1] https://lore.kernel.org/linux-rockchip/20221005085439.740992-1-megi@xff.cz/
[2] https://lore.kernel.org/linux-rockchip/CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com/
[3] https://lore.kernel.org/linux-rockchip/CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com/
[4] https://lore.kernel.org/all/20221107130157.1425882-1-megi@xff.cz/

Andrew Powers-Holmes (1):
  arm64: dts: rockchip: rk356x: Fix PCIe register and range mappings

 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 ++++++++------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi |  7 ++++---
 2 files changed, 12 insertions(+), 9 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
--
2.38.0

