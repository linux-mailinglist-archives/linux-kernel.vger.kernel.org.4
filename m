Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE516FDD31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbjEJLwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjEJLvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049A7ABA;
        Wed, 10 May 2023 04:51:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so7299595e9.0;
        Wed, 10 May 2023 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719510; x=1686311510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytZ68tiM2bcXYJ2+O2GzY517mWAuTLJSh4tOV0KVU9I=;
        b=ijsTzZaAqckKfvhgTUMbkkTQpxnD4u2W9Cz8veW+Gr9jmU/jrxUmlq8raZiBy4nFCM
         3aow/CgynVKCibGthN6xjpUjdusD/Ig9UjBh8L7kLKNR/86bIJIMCQNyR2me6qx82d9y
         q2mEulNjQHMGjXPNfdHVptEckRrwQu4wSjxqQMccuHAibAGRuGdqsOHScATE+6k6xLyt
         big9awMJzVzofMOVj6DRl9qGVgFCtDqFgsC50bUm1UJycr+jxDggXtVZCPPnVHIsTIzq
         p0YlGWtufsS++XMr4QUyZaiFIo8OOBGFPJWW5W/J4GEOSWF70v8gso8XpMBzSOypTZRQ
         5C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719510; x=1686311510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytZ68tiM2bcXYJ2+O2GzY517mWAuTLJSh4tOV0KVU9I=;
        b=isFIeX972H1cCuBH0VbvU7tGyauC4Kwv7IRZR043EX8EV8LmBGUeWp9upQAqbrnEmJ
         3yCEZz6CcqvsY8GfJmDSRVDrktN4bWUojZfImhtLKayOeU4fRSbSU6gDp9HBCJNECIMc
         0SY3SkneSeIRZKYaW5I9a6dQl8942qe1kRhvcUH7w7GjkG1lHgAePl8FRcEtPK7tUqrL
         UPGdwgl7MGDOK/+0PjRdFVnGjOBm5v3YNAxCe06uXkYWd/KbvQmaECbxxq/enKAu26Zl
         ZWWK2JfC5AnpGx8ts2eeVZ+CV/74fFK+K9GNAwaG48iBPqHnQGZAVGowuFUQa5ZTg4Go
         xMcw==
X-Gm-Message-State: AC+VfDydgbJIsTvH2lhJSPudKidchOWthK5JLIqZq7tYvIM+nwYfpq1Y
        k9jYXU2rmk6/ADzLad05lVc=
X-Google-Smtp-Source: ACHHUZ6vcbM76LKXsjFGd0HyW6zIsdRoJTDdn3zGzmZXAZ52hNkwLHW/umvPRaaOSWIk/jogehugzg==
X-Received: by 2002:a1c:7406:0:b0:3f4:2e01:83fa with SMTP id p6-20020a1c7406000000b003f42e0183famr2868935wmc.26.1683719510520;
        Wed, 10 May 2023 04:51:50 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003f42461ac75sm9560047wml.12.2023.05.10.04.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:50 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/7] dt-bindings: power: supply: axp20x: Add AXP192 compatible
Date:   Wed, 10 May 2023 12:50:46 +0100
Message-Id: <20230510115046.963432-8-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
References: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 is most similar to the AXP202, but the current
limits are different and the USB OTG status register has
a different address (0x04 instead of 0x02).

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 3ce648dd91bd..34b7959d6772 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - x-powers,axp192-usb-power-supply
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
-- 
2.39.2

