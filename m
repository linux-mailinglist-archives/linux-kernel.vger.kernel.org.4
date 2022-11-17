Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0762E652
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiKQVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbiKQVEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:04:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F78E2BC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f7so4387561edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVFv0ZYWJm+czwpapzS3FVHb5/n9bwLJ9LGCNHM7+Zw=;
        b=i7k0OLXj2/WWwaBXCA/cEiGc9ExFDBEUZCK2EArBa6y/X36LkcG3I9Pp2OEeoGKUUB
         y+weSlCuEkx8c9+P3wA3a4zu1cBbaYKF6AsN/41zKTEnkHfQlWf3xDYUMiObfXxzj3Ey
         T/PRWyug4oTopCC4glQuRXcf/diBrM3aqYD1VZz80rg4PBQCC1xOO2KuN2TKQ8Kke5ET
         258pau0TJJsnT9IEyNSymedZDyG2ttkhAChnxzSZWft1549fFuvAyAky3qhptR26ydTv
         QhjYB4/ZXLm7ST0DsOD2SqBMntgWQvvztR0a08GLjNb+4WiMqJEUBGMH35SrRH0ZtEnz
         SZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVFv0ZYWJm+czwpapzS3FVHb5/n9bwLJ9LGCNHM7+Zw=;
        b=BXwCVX/8y+Qs8Hg0Q5Je3dXUy5gi/loQUXLaG747XscLB+pBWDFcfKlegRLhf8klg9
         TKLuQ981bfu/4pNmNuGhISw0in7d7Zz8//KrX8JFHCDrwXUiMkG2JTxp6DXEOL11lJMl
         lMgtOj1u4SCi2C6xVlEUVgDrRPYcfCVTo0YCj8aJGWRx8M234dagIXWXGzgrzQSzgeNW
         2JeaciM17HO34oOxGcMO0lGP4yU4vP/fuzfLq7+nwCBZYP1L94A7AQr6/kzITipUBzWJ
         cXy+HLZXtJerVFkVQq8fNpGLe5jjjXWk7KJwa70hIE0j0fNdSOT6EINOFR2z+Yl86XR6
         A8HA==
X-Gm-Message-State: ANoB5pmr5ffUNP0Wzk8Sj80DWTAV24kgth9eaJ/32OXyGnCTvVh6v65p
        eI1I6ESTXfHxAvTH5QQINZmQQg==
X-Google-Smtp-Source: AA0mqf5oFKvTzcnfw4MfXoII8BHLgmW+ZXKWvoseTaXfRamunlD79P0LrSuKRP+9Vq4JUoFdXfqfwg==
X-Received: by 2002:a50:ed0a:0:b0:468:ff2d:def8 with SMTP id j10-20020a50ed0a000000b00468ff2ddef8mr1330945eds.399.1668719046388;
        Thu, 17 Nov 2022 13:04:06 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b00461c6e8453dsm970807edt.23.2022.11.17.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:04:06 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
Subject: [PATCH v3 3/7] dt-bindings: mfd: syscon: Add mt8365-syscfg
Date:   Thu, 17 Nov 2022 22:03:52 +0100
Message-Id: <20221117210356.3178578-4-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117210356.3178578-1-bero@baylibre.com>
References: <20221117210356.3178578-1-bero@baylibre.com>
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

Document Mediatek mt8365-syscfg

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd0104316..7beeb0abc4db0 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -50,6 +50,7 @@ properties:
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
+              - mediatek,mt8365-syscfg
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
-- 
2.38.1

