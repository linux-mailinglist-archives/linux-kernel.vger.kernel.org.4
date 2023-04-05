Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E86D7A47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjDEKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbjDEKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:48:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ADD5590
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:48:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o20so33914513ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680691717;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG2HCtNxlgwN2tmS23WngsoPcjjiHvvoCCuFSy8KcdU=;
        b=tMb0fkkc8uT0wd4kgaghM5StLPoEDgwCBmUZ70raGVJ3a1NkpO1ZTe6kPry7hLpv5P
         GFOlCWOi8d/QIzAVUDiDuKvcmmn7ZFz7n4K55wAogNZNred2qCX0Pq2LuaLa4MAuxu4N
         ogjT5XozqnKc1EXwbOtkvT22DqHbkDjnJDIqfUyYlK018/lQvmN0Hd39aQwI8MWEty6h
         3CkDaW+6mZqLEDdbodG8ojkKjeQkXe2A09YoshyDeD004VZ+LOlal19utadAqfGp+8r7
         dnLJhuYeQdUn0iRCzRufvY3cbSHO03lIT7dWQaQ45Qm7WLbhNGHaHedYnXRdLa/EVaiv
         +PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691717;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZG2HCtNxlgwN2tmS23WngsoPcjjiHvvoCCuFSy8KcdU=;
        b=62fDoUB5blq99VeW67KBPO8Z04TKn9gYxsK+056CNVh+BrZNCUfQzq+zoSwbXo/LL/
         XbxCqSw/wYBh52QWfQQKQ5OdhIc0wBPXnE8OeOPAxH6WWzpDTY9VRNx/4pz6wIR+aBbo
         5TPoD3mYsrOfvMiIwwR/f7PBPVBq30ZB2U3lB8UUGU94T3hDUce0AKo7TrkrmyKcx5f9
         5siLDiJgnlbpAhnA1fl2ME9GuBhmtCSjrVS6Ye+bLJutltbNIR5Z90w5WfCBeoad3zix
         qaihBBGhv0zjFE47DFDWTBwEiHSTr9NS9aWqXyY5Ybgu7vMAMpLgqMHljHly0bxZ1G7B
         85mQ==
X-Gm-Message-State: AAQBX9d2Bc8uUkvFH5IXMrPIcD0sptfjjMGUC8TpMoPW7dCq0SuMElks
        kQ+2plw9lJnLK80ZslJhe9JcoQ==
X-Google-Smtp-Source: AKy350YKyZEdK7pLHgd5YB2Bd5YC6pZqq+CkwOXKtrhPPd0UKP4XdNNIoXlNEXBxtxBLHqLsj+wEJw==
X-Received: by 2002:a2e:9d83:0:b0:298:9fb5:9f20 with SMTP id c3-20020a2e9d83000000b002989fb59f20mr1957018ljj.26.1680691716773;
        Wed, 05 Apr 2023 03:48:36 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e9b04000000b00295a3a64816sm2777299lji.2.2023.04.05.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:48:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] Resolve MPM register space situation
Date:   Wed, 05 Apr 2023 12:48:33 +0200
Message-Id: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFSLWQC/32NQQ6CMBAAv0L2bA20opWT/zDEbGuBTWhLtkg0h
 L9beYDHmWQyKyTH5BI0xQrsFkoUQwZ5KMAOGHon6JkZZClVqaQWc5zICp96Rv/wkxf2rLVxylh
 5PUHODCYnDGOwQw7DaxyznNh19N4/9zbzQGmO/Nm3S/Wzfw5LJUpRmYvWWHc1KnUbKSDHY+Qe2
 m3bviyDJTHGAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680691715; l=2181;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PGToSdNHkfoH7oxxoFUu9HnlKuR8i20PGmrHfAvQgnY=;
 b=5Av9gDhmhgmJn0VA+nRwiin3TUmgFd55mTdHow3w2FRnEPpBNUjRrUGoQ3AZ4JnM6WWhwflaydmZ
 qa819xQ5BkSWsagI1LVXmxQ1PU1LOBzlgrxI9YNDg2Xd/EUUZIzK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- deprecate 'reg', make qcom,rpm-msg-ram required [1/2]
- Use devm_ioremap() [2/2]

Link to v1: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org

Depends on resolution of https://github.com/devicetree-org/dt-schema/issues/104

The MPM (and some other things, irrelevant to this patchset) resides
(as far as the ARM cores are concerned, anyway) in a MMIO-mapped region
that's a portion of the RPM (low-power management core)'s RAM, known
as the RPM Message RAM. Representing this relation in the Device Tree
creates some challenges, as one would either have to treat a memory
region as a bus, map nodes in a way such that their reg-s would be
overlapping, or supply the nodes with a slice of that region.

This series implements the third option, by adding a qcom,rpm-msg-ram
property, which has been used for some drivers poking into this region
before. Bindings ABI compatibility is preserved through keeping the
"normal" (a.k.a read the reg property and map that region) way of
passing the register space.

Example representation with this patchset:

/ {
	[...]

	mpm: interrupt-controller {
		compatible = "qcom,mpm";
		qcom,rpm-msg-ram = <&apss_mpm>;
		[...]
	};

	[...]

	soc: soc@0 {
		[...]

		rpm_msg_ram: sram@45f0000 {
			compatible = "qcom,rpm-msg-ram", "mmio-sram";
			reg = <0 0x045f0000 0 0x7000>;
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x0 0x045f0000 0x7000>;

			apss_mpm: sram@1b8 {
				reg = <0x1b8 0x48>;
			};
		};
	};
};

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: interrupt-controller: mpm: Pass MSG RAM slice through phandle
      irqchip: irq-qcom-mpm: Support passing a slice of SRAM as reg space

 .../bindings/interrupt-controller/qcom,mpm.yaml     | 12 +++++++++---
 drivers/irqchip/irq-qcom-mpm.c                      | 21 ++++++++++++++++++---
 2 files changed, 27 insertions(+), 6 deletions(-)
---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230328-topic-msgram_mpm-c688be3bc294

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

