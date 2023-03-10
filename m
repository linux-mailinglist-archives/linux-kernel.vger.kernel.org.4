Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E476B37C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCJHwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCJHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:51:59 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FF4C6E3;
        Thu,  9 Mar 2023 23:51:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id i28so5552138lfv.0;
        Thu, 09 Mar 2023 23:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678434715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+Y+kKVSplNK0Q0iu8ToDogpEQGUULDqafcR05uVFhw=;
        b=PKPmN7tigMaSTERU9kl3Nw/xNPhwNY3xRmsF2OIwXvnDcrnpthOVUzn6QfgdnFyoYa
         kWIn7KtiyHxzNJI4tGaX255pUv+iE4BPJ58LhDDELRCXHQb7cHVfYem4XnhKK41JEKN4
         TsvPX6ypZMETQQhqOmyL+JWnJnv6EZOlQAYPV+GdKeBCjxDKW32KwJcv9/M3gI1Ye54e
         Mianq+tw11lZ9xA3Ac/CB8MD1R3YJMJHNPLfZXzyToJGwWpyucHUjI5648r1O8xThITj
         CNlolzng5n/SWQNpRI/JjyJAedknADJV/Oe6DQPavBu8OouwYilP+wIK4nmHaxmzUV4M
         +5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678434715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+Y+kKVSplNK0Q0iu8ToDogpEQGUULDqafcR05uVFhw=;
        b=gHB/ktyj3cOzGK4shiS30RI9uGiZiDak6efIczVKOtEZx8RrIeB6q8TBl1rYGI/rEW
         B2yEybAmeOS8weE5c4iRIz2B8b923wDoxYmkqauPlT0iyTOH53EdMzLzPtyaYjtIlvSY
         GtGugzlit8ZsUpmhDnYnjVnDBNq0LcOsYRCwwrFWiV2Eqw2cpr4mmpjASGsyLSMF1ojf
         /exof4JvtPZjsE8sghw9b1BheTel+hQHDnYevRIyorrRMJ/jkGQrMy1+WHxgS4XiV9GP
         Nj2vuO8xDKRG/WOwz0k1xRzjK0HpXYfz/bPl3T5KTZGjxmZmXGiWr3vSszCqFtfVHElH
         qp+A==
X-Gm-Message-State: AO0yUKX6abjPW8AcjNVbb+zqS/CI+8MdGmWXH7N9lTofX8nhSnOSOTYV
        7o1vUkZiynsFOBwwDBYbiko=
X-Google-Smtp-Source: AK7set9lFaO+GI43rwCWMX3vPETcw+/BfJYV2h4F9s49cJEVAGIPFI9IjGhH1prD6C2lwdK29zIBNQ==
X-Received: by 2002:ac2:5dc8:0:b0:4b5:3621:7ecb with SMTP id x8-20020ac25dc8000000b004b536217ecbmr6781518lfq.63.1678434714674;
        Thu, 09 Mar 2023 23:51:54 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id l27-20020ac2555b000000b004b5480edf67sm162066lfk.36.2023.03.09.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 23:51:54 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3] dt-bindings: nvmem: convert base example to use "nvmem-layout" node
Date:   Fri, 10 Mar 2023 08:51:45 +0100
Message-Id: <20230310075145.3996-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310075145.3996-1-zajec5@gmail.com>
References: <20230310075145.3996-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With support for "fixed-layout" binding we can use now "nvmem-layout"
even for fixed NVMEM cells. Use that in the base example as it should be
preferred over placing cells directly in the device node.

New and other bindings should follow as old binding will get deprecated
at some point.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 732162e9d13e..c77be1c20e47 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -67,24 +67,30 @@ examples:
 
           /* ... */
 
-          /* Data cells */
-          tsens_calibration: calib@404 {
-              reg = <0x404 0x10>;
-          };
-
-          tsens_calibration_bckp: calib_bckp@504 {
-              reg = <0x504 0x11>;
-              bits = <6 128>;
-          };
-
-          pvs_version: pvs-version@6 {
-              reg = <0x6 0x2>;
-              bits = <7 2>;
-          };
-
-          speed_bin: speed-bin@c{
-              reg = <0xc 0x1>;
-              bits = <2 3>;
+          nvmem-layout {
+              compatible = "fixed-layout";
+              #address-cells = <1>;
+              #size-cells = <1>;
+
+              /* Data cells */
+              tsens_calibration: calib@404 {
+                  reg = <0x404 0x10>;
+              };
+
+              tsens_calibration_bckp: calib_bckp@504 {
+                  reg = <0x504 0x11>;
+                  bits = <6 128>;
+              };
+
+              pvs_version: pvs-version@6 {
+                  reg = <0x6 0x2>;
+                  bits = <7 2>;
+              };
+
+              speed_bin: speed-bin@c{
+                  reg = <0xc 0x1>;
+                  bits = <2 3>;
+              };
           };
       };
 
-- 
2.34.1

