Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA314691EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjBJMRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjBJMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:17:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CC2595D;
        Fri, 10 Feb 2023 04:17:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z13so3697204wmp.2;
        Fri, 10 Feb 2023 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dxleiWgtxlgcGySHoGsINCTVEVOCZFH0ndRwgqvbJw=;
        b=WnDjBwWztshSFL6gZfGUAjtyHcbNgWciDJls3TQfbMe9fe1ZOlImrD+8VqDckH/7dZ
         HCfzkqOYQU2q9vvrDHL4PAJtEI3CT4yQ1pzOhqa7ygHkfyUOCdd1KGzyAmdeNnvmauf6
         Oh2O0dtIubhbg6UnSajTYtFWlNPLihc/DAQ0gC7Hv/XPvds7q8Xq82qkg9YqH7WxzN7F
         Pw2exOoLBy34jsIPY8NnN2dTjtgh0JvO4M0BbDpwn0XcvmpLVJgNu5gYK541lDwJ9wWS
         rUB1FIuEivi8Tv40wE5jjN1pi/jyrcgI9yCVEFdvDqOVjoqRRDsREO4V5QcelDKPC/R3
         tKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dxleiWgtxlgcGySHoGsINCTVEVOCZFH0ndRwgqvbJw=;
        b=KY/GYYqVGzA6mHkQWh1+bJd9D6uXFC7sEPElWYPwPwr+I/NHVutEOmls3hIA+hXbco
         MglXNvqGGKnBlplT6vtlGNFli9nSVKBWvzajMYGfHIbj7IVm/ZqF0NCddZR2+JOopO6A
         f+NZC6npRiJsx3uvPIW3JbJLk22x7QCo2iXxKDttucu4r/8wv76QUo26TAIpjbMsrY4x
         C4j51YzT7ADchhTnpo3GauiDx8/yFaA+AoTLbnLX0fzkcpzUTTYxZ/rbPMCazrTwqZVB
         D1TXG6bv7iShnpmWHzU9+/FdGGRvWJ+Dl3cxt967A6uj/MC+Tq1MQAQVG/d0HD1Wr2hx
         t1yg==
X-Gm-Message-State: AO0yUKWSP5hCT2fF6bLRV6QTd1eQ6QkLClzIMrTUWTivydfM8scWrjnv
        S7KWZ08jMgqIqogSiIagxSiW/Xv9fyk=
X-Google-Smtp-Source: AK7set9+rtgGHxmuw36z3r4F2dbl5bRVtNH0uYL8B5IWGLs+WxPJpKe6f+Bkg06yo/IPeHtfR28yrw==
X-Received: by 2002:a05:600c:4383:b0:3df:f7f1:4fbe with SMTP id e3-20020a05600c438300b003dff7f14fbemr12787127wmn.1.1676031460433;
        Fri, 10 Feb 2023 04:17:40 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm5359820wmo.2.2023.02.10.04.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:17:39 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 2/4] mips: dts: ralink: mt7621: add phandle to system controller node for watchdog
Date:   Fri, 10 Feb 2023 13:17:33 +0100
Message-Id: <20230210121735.639089-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
References: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
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

To allow to access system controller registers from watchdog driver code
add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
operations in driver code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 5ca40fd21..1a1c017d7 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -73,6 +73,7 @@ sysc: syscon@0 {
 		wdt: wdt@100 {
 			compatible = "mediatek,mt7621-wdt";
 			reg = <0x100 0x100>;
+			ralink,sysctl = <&sysc>;
 		};
 
 		gpio: gpio@600 {
-- 
2.25.1

