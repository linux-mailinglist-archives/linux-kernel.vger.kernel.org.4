Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9166483E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiLIOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiLIOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:38:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D8B23E96;
        Fri,  9 Dec 2022 06:38:02 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4886wmh.0;
        Fri, 09 Dec 2022 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvV3cPG3K4cvqvxBtqhjbOYVyBlWZ69Pt9FKlRh4MCo=;
        b=kywWHMjsf352aulDMz8ameENfk8HAdU0LBgrbSYTRbEy9OePwULQYuig1MGCQUdQoY
         kM4F//k/FLWqG7h1CPgbVcsLIzPPq5OyTfj1QfIJ8vSJ6rFQrFgIPMh7SQsBmKYQQP54
         vIVxpIQNZvMEIlifFb5GKvEG+f4rLH4GO04ta6hj16oudphHh/RhAFzl7xrybBEelQih
         KAOd6DpzckpBQYS7D1+EtUF9L23eqZmxMGTZSlL+k2qGuhXSVa/8/OKTEh5X9m/qUNmh
         N+3tgTN8sP7v7JCWc6bqzstGrU/HaHUXvOfSh9qaCVyl7bQHes95qTE1kKUBhOIAkXB0
         Qz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvV3cPG3K4cvqvxBtqhjbOYVyBlWZ69Pt9FKlRh4MCo=;
        b=W3dEujUxUZm4Ar0km9po9+mMUZXwwZZTEIBxUFzNDXvwYMI4QM4Nkz8+/00q0oAQU3
         ITjs2V8deBaUzHqmIufwzw/pfLIdRIHhifzqw08hpRWnkZ6OBvIRClpardb50lKOCEU9
         XS1Naax0445dgDdYzkrPlj3q0jMk3v9u/aUXftbu+6zi7DEW/xM99HZNlVPkpqyKDVC0
         2qmQPhTrKG43h2qFrjodXoAyRSEXH0i5a6iSx6RqSqnISDzxlMwhHW4LkQsSCPc+TDUP
         VhUBZONCbztJ9yNhFd2bjVa+Xm6C5TlTRdCJBbjRXh0h8Ne/ELA1cWlNl6iAmAmBxZfP
         Pwpg==
X-Gm-Message-State: ANoB5pnfH5caLSqOE4J0X4ItPR6jKgm6vX3U2li1Ky1Z6OPdV92upGl/
        CbvuMJz3gZ0Llcxrb5BLB7Y=
X-Google-Smtp-Source: AA0mqf49j8Q7ZiY1pgY8rxBItA9I0v9X3cjt3il4DRy65yTQdOP/Jil0t02r2c0IS8PRrOnkF7inPQ==
X-Received: by 2002:a05:600c:654e:b0:3d0:6a57:66a5 with SMTP id dn14-20020a05600c654e00b003d06a5766a5mr5345486wmb.0.1670596680751;
        Fri, 09 Dec 2022 06:38:00 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003d1e3b1624dsm9645517wms.2.2022.12.09.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:38:00 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Lee Jackson <info@arducam.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] media: dt-bindings: ak7375: Add supplies
Date:   Fri,  9 Dec 2022 17:37:40 +0300
Message-Id: <20221209143741.214242-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209143741.214242-1-y.oudjana@protonmail.com>
References: <20221209143741.214242-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add supply properties to describe regulators needed to power
the AK7375 VCM.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bindings/media/i2c/asahi-kasei,ak7375.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
index 22b1251b16ee..22a810fc7222 100644
--- a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
@@ -20,9 +20,17 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: VDD supply
+
+  vio-supply:
+    description: I/O pull-up supply
+
 required:
   - compatible
   - reg
+  - vdd-supply
+  - vio-supply
 
 additionalProperties: false
 
@@ -35,6 +43,9 @@ examples:
         ak7375: camera-lens@c {
             compatible = "asahi-kasei,ak7375";
             reg = <0x0c>;
+
+            vdd-supply = <&vreg_l23a_2p8>;
+            vio-supply = <&vreg_lvs1a_1p8>;
         };
     };
 
-- 
2.38.1

