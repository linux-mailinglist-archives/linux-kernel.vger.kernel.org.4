Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD967D876
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjAZWdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjAZWcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:50 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47516E416
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:28 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id i12so2618459qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SypAcRsRGzHhFPMDy6VkPjsCL8zFvVsNw/XJ5tPEVcY=;
        b=efuaVL0Qm37vcUypEIcgbVoS1Vqqe488UZ8MTte6T0J7ssEwQ7fEY1dkzJIbj8S7E8
         1aUD44gCPB7puYCswzn1ztv8km0VbM53zvi9+uFVtlUmdH2Xo8L2fr5mYKS/m0Obd7E4
         m6ofpouoXgvh74lfLmHDrUYk66up3W/YQEV5RAyERXF2OEGmnHeXGRTUoLlL2mee6Zcn
         WsDucOBTJFm5836z0UAe67+n5M/fpd2evCUpI8rHNsbIiHvPRB47z49nkkUfm46SDKcB
         ll+XD12STjyOaw4Ka0Ne4Jt4gzXgnpOfZoqw/0tX2HJiB2ENPgA0Vu/aW+nk7iN6Z9uA
         dXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SypAcRsRGzHhFPMDy6VkPjsCL8zFvVsNw/XJ5tPEVcY=;
        b=udIVMQ7B2gDw99VfRoBxp2m5DXPLknCnXuzbcytNswZz22SOZ/CEhowl1zv2X7mQNZ
         XJ+8lu3H95Bdf3ijIMdshZ/qIQnNEvMkflV2yyoKAkwNcX+IjyjM4gTPn67nUjKrnbY9
         YLk8gyXsHtpColwwRG46RCMbn8Um5NcrnBRQu3jm5JA1jEMebNhXzJKul0O53Z6FnLzZ
         0LjqW8P+eTot261/Bp9Kj19vw0eq9MuHAs8M/Zkwy3qGuMUpcqO/cIlekS0swwsRtKee
         Ts8fOE9NkBWsd4Kzfu8B5sHwjk6O/RqpZyZGZpGCYVIMb4coinWoKVLaY2k3yVxLzxXC
         x0Uw==
X-Gm-Message-State: AO0yUKWCLuskCVU65opfWwtd1kd4VSOGGohb5Z80cn0fjIdO5VVdD+MG
        gZmT9W2Lpt2ITxsf93pSyoK40Q==
X-Google-Smtp-Source: AK7set8j39WFl26zDOVkE8AB9B9BKmg0mfHSyv5sD9/kg17OgAvML4uOSTenWt/JZjRGg2pSQ4i87g==
X-Received: by 2002:a05:6214:192c:b0:537:708d:3fef with SMTP id es12-20020a056214192c00b00537708d3fefmr12386015qvb.38.1674772347729;
        Thu, 26 Jan 2023 14:32:27 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a220700b006ff8a122a1asm1723091qkh.78.2023.01.26.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:32:27 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Subject: [PATCH v4 0/5] hwmon: ltc2945: Add binding and shunt resistor
 support
Date:   Thu, 26 Jan 2023 17:32:22 -0500
Message-Id: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHb/0mMC/y2Nyw6CMBQFf8V0bUnpA4Mr/8MQUmqxV0trbgvRE
 P7dSlzOJOfMSpJFsImcDytBu0CCGArI44EYp8PdUrgVJpxxwWre0EFSnw1vpeqTm0Pu0SZIOSI
 dG9kqxaQUjSJlP+hk6YA6GFcewux9kS+0I7z34LUr7PbtZ+8v4mf/KdZyIZSQVd0KLk6M1vRhI
 k5g8WIQMhjtPYRnZeJEum3bvnnfqJbLAAAA
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=V0FNKX9YAVgdV6qQtndh4lVLUCURCHYt+xc2qtMk9AU=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0v96YYBjH5bl7+oD5yN3Mu+4Qfb2R9YVuyoeBN+Y
 Od/xXU6JAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9L/egAKCRDc1/0uCzbrqgKyD/
 0anhM64UpBpa8TtU69DKDW0uL3AU4HuKH2i3UEaV85FS3f2PFwWpk+Oq41YDikbRb6sF+ugr+/uq4U
 j5rpdJvtfXQxVZjrmIaqn2BBYqBnD563Kejkkuf8bqmaCELW4GetrUODdj2QNlm4RtRixFASRn67GB
 RyBlssv12Jk8Twvfp2ORa/z8iStY9QesiB37n9ii89ye5gXDmbH+owGjN9OQNcf810aRgFn74iZnqB
 /lKLFfI44cn/vNt6qTtPrkYpugwSuPeElX8wXqUAfze7kPd42stfkPaCjU4bfmyhrCec65PpodIrN+
 nFYzQ7NfRKx0I+OQzEq8RQj+Rq1LJNQnd7Q245eOCWqdAIjtPNwguLXIHPfLOtMXRrMpqS/IppUAJJ
 YNmw/Azd1om/RmRM14/QsSB/sS1S5uqczNmZKBzQ2VaX5LRifE5uQVBkoSoFJmAekDHb0yub3HTZnT
 MCq/BjBvN4O3J7goK0e8RFFW3HNxlE2nJjYsvIdZl/AXz3lf4kYpsQd2rHzFW82BgZbXf/kLQskvyj
 Y1+0p15b5OZhkxg9dZJVmQqE1CQa9L6IHllMtjORyWCXoR1r9WKkZtldp+CGPl/9eI3eBC/512z/kR
 N5d7Cb9bsMmi8vHrjNyR4FLIqhZVPMAo5jF85hpLAOnSPHFKpZnKfi3Lp1CQ==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the ability to specify the value of the shunt resistor in the
device tree instead of assuming it is 1 milliOhm.

Would be good to backport as well

Changes since v3:
- Remove shunt-resistor-micro-ohms in binding commit message
- Simplify ltc2945_value_store fix
- Validate overflow
- ltc2945_value_store accept only 32-bit uint from user to avoid overflow
- Link to v3: https://lore.kernel.org/r/20230109233534.1932370-1-jcormier@criticallink.com
Changes since v2:
- Remove newline
- Combined overflow fix with "Allow setting shunt resistor" commit
- Add description to "Add devicetree match table"
- Add fix for unhandled error case in ltc2945_value_store
- Use imperative in descriptions
- Remove unneeded overflow check from ltc2945_reg_to_val
- Fix up DIV_ROUND_CLOSEST_ULL calls, per docs divisor should be 32-bit
- Split one DIV_ROUND_CLOSEST_ULL change into separate commit per
 Guenter Roeck's comment
Changes since v1:
- Add devicetree match table
- Add kerneldoc for the ltc2945_data struct
- Cleanup excesive comments about the shunt resistor
- Switch to device_property_read_u32()

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
John Pruitt (1):
      hwmon: ltc2945: Allow setting shunt resistor

Jonathan Cormier (4):
      dt-bindings: hwmon: adi,ltc2945: Add binding
      hwmon: ltc2945: Add devicetree match table
      hwmon: ltc2945: Handle error case in ltc2945_value_store
      hwmon: ltc2945: Convert division to DIV_ROUND_CLOSEST_ULL

 .../devicetree/bindings/hwmon/adi,ltc2945.yaml     |  49 ++++++++
 drivers/hwmon/ltc2945.c                            | 132 ++++++++++++++-------
 2 files changed, 136 insertions(+), 45 deletions(-)
---
base-commit: 93f875a8526a291005e7f38478079526c843cbec
change-id: 20230126-b4-ltc2945_shunt_resistor-f64955044365

Best regards,
-- 
Jonathan Cormier <jcormier@criticallink.com>

