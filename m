Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7566692F04
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBKHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBKHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:34:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FBE1D906;
        Fri, 10 Feb 2023 23:34:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z13so5384785wmp.2;
        Fri, 10 Feb 2023 23:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnXrkD6mC1X9wvYtsECorUK6F5CsiEFkvfTGl5Os3Dw=;
        b=g8wJsbloOWG7ZeCFfvDC4383nh4NdFa3ZV7kJJmeo+jb051yTKZP7+54FvsEucq023
         tYHL6cVpiS+GN/i1dQnXVZu7jsrKME9xAgRIsBDW+NM4nHzTO4RQVSxewGuKwHcqetaq
         FQUjW1nFdE6sTG+vzoR2OFJkfY4ng+7KGwtqfp2oUHeLnUcrQgr31ea14fv4iXv8AS4L
         KBHcKiEIqN5eAMAngE+whyYbLLmS0a3HRWJokWg5Yq1XiCVhX1UKRpANjwu5wbdC3Ggo
         vhaHAB95WoXzUFtnLX4VENts0NuyIEpvWaKXIpDo3QixfMJmDT6Oc9glwBK33B9KJ7HP
         pMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnXrkD6mC1X9wvYtsECorUK6F5CsiEFkvfTGl5Os3Dw=;
        b=HPFbxsvIPyD0l5pN67Xgk+tLT9Fk5hq13EVs/x+PLqZNgbccA79jijrwo3rlu3ZUAn
         5lrko5Y9fIuiLOnK+3XNjlh3413NQ9n1rZSKoBU3i+KwVSczl271ViEY4is1b2aw7GVL
         k3OOeiiEel0iayZOXqHCMHo/6sr5JASsYj7bt1ZKy8lzM+ZUa28MPI38wexSyC0n5La6
         WR8LQJW2truZktOE61KiKMb9zwJWffNAriBFXCL2RFV5tX5iMe9UNEi36PV5fpaZcqKg
         9cspFupduFN7pJNzrK1GrBYvlgHOAcZhvW4FHNMqYVWWhXw+YrMgaj/mUo09BU7jdEZa
         j6dQ==
X-Gm-Message-State: AO0yUKWfP17kZmml/ZyY2k+u0wEklx8i5HRGTTACyLNHJMaQiqPRuPI3
        +Iej17IGW2QBIWui8FvMI76va3Hn+rQ=
X-Google-Smtp-Source: AK7set/gpMxYCx7vqUG0H8KOtvNcQ3NU29c0Qq0mZR3KNRxKfk3P5iNzmqK7Pzsu/AomWOqbzCFabw==
X-Received: by 2002:a05:600c:44c9:b0:3df:f9e9:7600 with SMTP id f9-20020a05600c44c900b003dff9e97600mr14775977wmo.25.1676100841458;
        Fri, 10 Feb 2023 23:34:01 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm7917829wms.26.2023.02.10.23.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 23:34:01 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to access system controller registers
Date:   Sat, 11 Feb 2023 08:33:53 +0100
Message-Id: <20230211073357.755893-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
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

MT7621 SoC provides a system controller node for accessing to some registers.
Add a phandle in this node to avoid using MIPS related arch operations and
includes in watchdog driver code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
index b2b17fdf4..a668d0c2f 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
@@ -19,6 +19,12 @@ properties:
   reg:
     maxItems: 1
 
+  mediatek,sysctl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to system controller 'sysc' syscon node which
+      controls system registers
+
 required:
   - compatible
   - reg
@@ -30,4 +36,5 @@ examples:
     watchdog@100 {
       compatible = "mediatek,mt7621-wdt";
       reg = <0x100 0x100>;
+      mediatek,sysctl = <&sysc>;
     };
-- 
2.25.1

