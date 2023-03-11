Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C8C6B574A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCKBOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCKBO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:14:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E45612DC27;
        Fri, 10 Mar 2023 17:14:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y11so7468179plg.1;
        Fri, 10 Mar 2023 17:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678497265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rh7oDZ2wH8OxNXYeRmxDps+pFhJvkYtrO5SAgqEl724=;
        b=iLXJ+8i7ZJHN+1fIKRoEzbeDSCB6SFWr0rbtzFMRW63cEG8sjqOjReUSSOTyVbkrrh
         s/feFZkpMwQGwF/e3T1CxKOKtMwxKd/gdqPBO16gDrdGNMspugRV4e+InoZ+cypr2REg
         DATA+01g+kPwenAiWdZbb49TuDRopFh+AIIWqiHaOzrTsZniZ87xgh+LH7Bl031qCTSd
         7IjTvMq5d2Es9NGmjPp40ZAIy2bfJgMkX4JSXfajPhlTNEqPQyX4CPDhipaM0gzi/RDA
         Zd81epkX7Kg23H2MsYEJNVpAzYL67iJBOS/HiSpo82/CDp4BmpqBxuO0VLLymwyFuy3L
         IgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh7oDZ2wH8OxNXYeRmxDps+pFhJvkYtrO5SAgqEl724=;
        b=f0GmcImSVmdgMQvMQiP7JW2INJLIaIceNrBbDgR+6Pn+sR28GBAhVqUG/SEJvnxEC2
         rPtnbYYi/gbxElrZtT17VlpVoUApcu/A0dMHOK+0bs4lbdF57SyI9Yibezj0lDpSD3At
         fe09s0uRZI0W5CTizK3xwxTqwcsqeIP03UOIp52nivTil8LTx3Kprnfb35OVwLzUgT9O
         epNG7tCjJiVwNTLsHlrKXCErcQcXn7gOwjJ0CGzdxR6MBjkiv2UcsspNWcg62zmCZon7
         wDHPYxhrKNPcoOO5ImaX3PGpadx7mF/qH0v+1WZUNW+TPhNokNdhzcNV8dxtQpnXtoEc
         1YBA==
X-Gm-Message-State: AO0yUKUwFcH1XaT+zcd6AzCZIZpE6HLMDzWqtCLP2NgB6kY91UI0yB5C
        SMWfJZeekir75LxepHIjWjg=
X-Google-Smtp-Source: AK7set+9UTvGbB9wlgUIPHEmDL2PHFkebYxlGCjJD3HnunYUU257fn+NuaCmmdq9Dzvnt4hGugeLkg==
X-Received: by 2002:a17:90a:ae83:b0:237:ae98:a484 with SMTP id u3-20020a17090aae8300b00237ae98a484mr4150329pjq.7.1678497264677;
        Fri, 10 Mar 2023 17:14:24 -0800 (PST)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id r20-20020a17090b051400b002376d85844dsm475323pjz.51.2023.03.10.17.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:14:24 -0800 (PST)
From:   =?UTF-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, krzysztof.kozlowski@linaro.org,
        rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
Subject: [PATCH V2 2/2] ASoC: dt-bindings: max98363: add soundwire amplifier
Date:   Fri, 10 Mar 2023 17:14:09 -0800
Message-Id: <20230311011409.210014-2-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
References: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lee <ryans.lee@analog.com>

This patch adds dt-bindings information for Analog Devices MAX98363
SoundWire Amplifier.

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
Changes from v1:
  Fixed a syntax error for the 'dt_binding_check' build.
  Removed unnecessary properties.
  Added description about SoundWire device ID of MAX98363

 .../bindings/sound/adi,max98363.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
new file mode 100644
index 000000000000..0e71b6c84007
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,max98363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX98363 SoundWire Amplifier
+
+maintainers:
+  - Ryan Lee <ryans.lee@analog.com>
+
+description:
+  The MAX98363 is a SoundWire input Class D mono amplifier that
+  supports MIPI SoundWire v1.2-compatible digital interface for
+  audio and control data.
+  SoundWire peripheral device ID of MAX98363 is 0x3X019F836300
+  where X is the peripheral device unique ID decoded from pin.
+  It supports up to 10 peripheral devices(0x0 to 0x9).
+
+properties:
+  compatible:
+    enum:
+      - adi,max98363
+  reg:
+    maxItems: 1
+    description: Peripheral-device unique ID decoded from pin.
+
+required:
+  - compatible
+  - reg
+additionalProperties: false
+
+examples:
+  - |
+    soundwire {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        amplifier@3 {
+            compatible = "adi,max98363";
+            reg = <0x3>;
+        };
+    };
-- 
2.34.1

