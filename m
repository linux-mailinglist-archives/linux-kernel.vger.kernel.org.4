Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0AB62BCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiKPMCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiKPMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:01:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42DD17591;
        Wed, 16 Nov 2022 03:54:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so1283553wmi.3;
        Wed, 16 Nov 2022 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wEkV2c3AfMucGlumus3cVjWRFFJNhVHrUv2f8wN7nw=;
        b=grgLt3sVh7wjmdJbHY/NRs3ddxoX97jlWnK/a7aKZJ/UAyVoz1fjYCGnIunNcjaqF/
         z6G/Ek8IwLPoJNEC8ODeU0I3/CHbRerA4YWs/PJkEcFciv7LS/KXfqa3f9LOhr5CjVSm
         dSlG/WbS901ud0Sq1ZmBwfkqzKKcaZ0rqaDj7xag14hVP9XENprCLPGs/3FTo2pfLCsM
         ZvRSlNxtNvzegfLzmHx4oMdMHnldjn8abMmelVcvk1QHyOk2yJFFKG+B5sU4vH1a7qb2
         tapChOVKtfIueChWVw8V9bzp6Bp94wVVgMi/xJle0BpxINy8ijlteNhvfJTm5kkZERfX
         ULiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wEkV2c3AfMucGlumus3cVjWRFFJNhVHrUv2f8wN7nw=;
        b=YE03+4Z479ZGahhpHquLc/9xidNXy5DUhQLV1ftejWKzcuKlppMw0o/JnGSXg7Z/1i
         tpu+JH8E4z0sLvCd7E5S9AC0CLmC76BSOqzWnhU9n6P5PAXMYRKTLXvXXqeKzu9fTPND
         MBkYizzslW7XFBZeeKqM06eg9q5/xYWeWwjhhLkuWXK8IRrVUBo+esGEQv7MgI0/Kh5J
         KjkjCelWsU0dZxS7HF6DIE0BGtsE6ia17/FDpp/m3OjyK39zQWcSbdVROVSTGqn7tUwH
         mU+hVnxN9RCXk8eu7sgLcsUwSYrdct0n8KDZr3Apyv9qSTj4+Rz08z5bJFoRO7ezCVxB
         zdPQ==
X-Gm-Message-State: ANoB5pmmJDk1jJ2KqUwLPaVVt7lYCF4bxPusNI/xQSf/9MzHC8LreDaJ
        k5b7Imvm/tqx8s+NpLUjG18=
X-Google-Smtp-Source: AA0mqf7tDkB72ajHvvjpyiY0tN+GQDsl7h9BnPwo5djqndGf+647IY0mPyIrBH6UMTljX67Pkt/0RQ==
X-Received: by 2002:a05:600c:42d2:b0:3cf:c907:a05a with SMTP id j18-20020a05600c42d200b003cfc907a05amr1823902wme.177.1668599647192;
        Wed, 16 Nov 2022 03:54:07 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b002417e7f0685sm14576047wrb.9.2022.11.16.03.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:54:06 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Misc SOQuartz Enablement
Date:   Wed, 16 Nov 2022 12:53:33 +0100
Message-Id: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This series adds the following:
 * SOQuartz Blade bindings (patch 1)
 * SOQuartz Blade device tree (patch 2)
 * SOQuartz Model A bindings (patch 3)
 * SOQuartz Model A device tree (patch 4)

The name of this patch series is a bit inaccurate as it has
evolved, now entirely consisting of new baseboards for the
SOQuartz. Nevertheless I chose to keep it as to make it easier
for maintainers to track what this is a follow-up to.

In V3, we add another official PINE64 baseboard (I'm sorry),
as it depended on the now merged patches, and I didn't want
to needlessly cause conflicts with the blade patches, so it
goes in the same series. The added baseboard is the SOQuartz
"Model A", which is not to be confused with the Quartz64 Model A.

This will be the last new board added through this series as I
don't want to keep expanding it. Any prospective v4 will only
contain fixes in response to reviews.

For anyone fancying a deeper dive during a review, the schematics
for Blade[1] and Model A[2] are publicly available. The SoM
schematics are also officially released[3].

[1]: https://files.pine64.org/doc/quartz64/SOQuartz-BLADE-Baseboard-Schematic-20220522.pdf
[2]: https://files.pine64.org/doc/quartz64/SOQuartz-Model-A-Baseboard-Schematic-20220522.pdf
[3]: https://files.pine64.org/doc/quartz64/SOQuartz_SOM_schematic_v1.1_20210816.pdf

Changes to v2:
 - alphabetically sort blade binding
 - add git commit message to blade binding
 - add SOQuartz Model A bindings
 - add SOQuartz Model A device tree
 - drop patches that have been applied by Heiko
Changes to v1:
 - added pcie-clkreq-h to soquartz pinctrl
 - added blade base board (by Andrew "neggles" Powers-Holmes)

Andrew Powers-Holmes (2):
  arm64: dts: rockchip: Add SOQuartz blade board
  arm64: dts: rockchip: rk3566: Add SOQuartz Model A baseboard

Nicolas Frattaroli (2):
  dt-bindings: arm: rockchip: Add SOQuartz Blade
  dt-bindings: arm: rockchip: Add SOQuartz Model A

 .../devicetree/bindings/arm/rockchip.yaml     |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3566-soquartz-blade.dts    | 194 +++++++++++++++
 .../dts/rockchip/rk3566-soquartz-model-a.dts  | 232 ++++++++++++++++++
 4 files changed, 430 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts

-- 
2.38.1

