Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E765170A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiLTAFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLTAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:05:46 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421602A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:43 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id 128so10316049vsz.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x550/OsiWnsnhCUH29zWgidKchxtQqaOBRoxd0yhd7E=;
        b=GPj+5IMRq85Ho5NoEcvHo8LtajbZsJ8dG9i7MTd85YImxaRBB9aIQq4hcxc7u2Tsl5
         tcbkTr/hO7d0u5DKnxFhxpd5R1inx8+cbEcDnTG30hIGAU7zmmOJA8cFNXcZv3T7jUD/
         p8OwhospT1ni8Y5B4jX6AGJ3DI/bHVaDthDgexvKds2CBJ30AhagUJOlt9y8Jwi8EVVr
         mtqVYCLFgObGhUCwYtNaK1218e5khIWj46SQ2IHsDTfsUT05yG75qXYjj6Ahu8gb6YSL
         +Bnv8Vv3UO71PjYB7jlNhyJ+Me8xEhwBO+DvayhrZydv7+c+9Lg+/39aUgSHApbel9M6
         J6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x550/OsiWnsnhCUH29zWgidKchxtQqaOBRoxd0yhd7E=;
        b=hct4vV5J0EFQ1mmnjq1RhJYMaRoq27Zvcl7lXG4kBJurA34q8y86VRWeMjpyMNega3
         b4ryUgtdsf/ooK8fjHm1hpgVHntcWn6nGG1ScJLV1Qp/9MPJ8xf1Xe/TvNez5P58nMYl
         xNGyZ9RMbHFbExaW7fyfYER1fEKLBkS9SNtmGB39KlRmoIoBR07lgW8ms8n+QZX8mIUq
         JXml/p245PrNsIUqADXYgNxx1Rf9ns3hD8NpZfpla2pJKHFAUkLLYIrZeokZPXVmDwCc
         KLqa9C5LrMr+SV2A8yCjGVrgEUYS7MNRXnfDDIMxWAk9O7dlDZWEEaVcN2/PomCFNqyw
         ZPOg==
X-Gm-Message-State: AFqh2krF4IsgF0bZmFmxi0KcCHk+zCjIlqn2BCuPKbXBd5gbBIDiMAQy
        Mte7Qc9dYtrZqZSreBvTZbaTsQ==
X-Google-Smtp-Source: AMrXdXtxeE+xv5Ro1p1xozvtIVG8oryRUQqJ43vEvCn0SHdJtiWMLmXV4nqIUbrxWF9bWawfoWGDyg==
X-Received: by 2002:a67:af1a:0:b0:3ac:df02:e954 with SMTP id v26-20020a67af1a000000b003acdf02e954mr3720164vsl.10.1671494742304;
        Mon, 19 Dec 2022 16:05:42 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id o70-20020a374149000000b006e702033b15sm7721430qka.66.2022.12.19.16.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:05:41 -0800 (PST)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     "Cormier, Jonathan" <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH v2 0/2] hwmon: ltc2945: Add binding and shunt resistor support
Date:   Mon, 19 Dec 2022 19:04:53 -0500
Message-Id: <20221220000457.1163446-1-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221214220727.1350784-1-jcormier@criticallink.com>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the ability to specify the value of the shunt resistor in the
device tree instead of assuming it is 1 milliOhm.

Would be good to backport as well

Changes since v1:
- Add devicetree match table
- Add kerneldoc for the ltc2945_data struct
- Cleanup excesive comments about the shunt resistor
- Switch to device_property_read_u32()

Cormier, Jonathan (1):
  dt-bindings: hwmon: adi,ltc2945: Add binding

John Pruitt (1):
  hwmon: ltc2945: Allow setting shunt resistor

 .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++
 drivers/hwmon/ltc2945.c                       | 86 ++++++++++++++-----
 2 files changed, 115 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml

--
2.25.1
