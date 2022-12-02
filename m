Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542CD63FF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiLBDnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiLBDnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:43:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA367BC09;
        Thu,  1 Dec 2022 19:43:12 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so3388788pgc.2;
        Thu, 01 Dec 2022 19:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/B476Yo3I1Iy8ujmIlJ4x8L02T6sXbrTl7idaba7To=;
        b=cTCMDZ3+nplFRZTAytMDb4GKY5yBolf9QWvgCYnlc0fxTUSIJG6AW8n000E+SGXyvW
         dxkUG7GBDlK/zTwshc37VvyztvzjsXFenbNcOpYlLolMVFMMXTijw7FETcDUbouhtBBN
         qPMT6r6zIZ45/7gDVJ4JbgPncJedFtki0j5sSAbUOoW149iRx9jK/iEIGWxZr36S5KqU
         aKp7rjkEoec46lgTCwPcAQPsI58SHfCtSR5xVkZNOT2jydJEbAc4+lpG+96ibph02U1y
         bnZlE06mKA+WtAkwd4H+WiLWn7AOEsKufMqddj02MjS4XknSWTzo6zPRlOMeyB1dc1Wx
         US6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/B476Yo3I1Iy8ujmIlJ4x8L02T6sXbrTl7idaba7To=;
        b=NQ6NL918vGsv5zJKgqLdQLKdSmsS+JSKBOAbmQOIp533eWRwcTzZRmu9rasf/6Llou
         unoJUKuAxv9LsTb47PRfJre8uIRj/Rx7QT8VHWCuC0ARTxP16I63zNn0iG/ua9xUZcj/
         iev51+4l0z+JvIziRBGGnpK/ztpAF7L71sLmMuv92cT659+3jMYVGolL3AWIXu8Nw8tk
         bW268D464bM8DmITNF7YSmvSNuT5erKl67VjJkUlhwvtILkJ9U/uTXystqEaaYaf3PBC
         Nc5tP9FZ5Xv59PusVN9E+4OMpm4Cz5NhOQBhHJjwpE3a6ucp3ZWg26fn67/BPVbCoHIq
         yREg==
X-Gm-Message-State: ANoB5pmkWn5gYMfzAZkXq+UIWn92PnAho8U2KcrLGBjmTUM9BC0WYeVv
        Uzv0i4pkPh6TmwcJTrR2Omg/OiaC89M=
X-Google-Smtp-Source: AA0mqf7x+da07zHJaYEQlkiDUbhcOJEMJ9c4izkfqNbTmZg7otIvtC3EjzzGjnMgYOoBYZ4Qyv51fw==
X-Received: by 2002:a63:4649:0:b0:477:f449:1e88 with SMTP id v9-20020a634649000000b00477f4491e88mr28246372pgk.2.1669952591917;
        Thu, 01 Dec 2022 19:43:11 -0800 (PST)
Received: from guoguo-omen.scut.edu.cn ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b0017f59ebafe7sm4370636plg.212.2022.12.01.19.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:43:11 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add an entry for WorldSemi
Date:   Fri,  2 Dec 2022 11:42:38 +0800
Message-Id: <20221202034240.455831-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202034240.455831-1-gch981213@gmail.com>
References: <20221202034240.455831-1-gch981213@gmail.com>
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

Add vendor prefix for WorldSemi that makes WS2812B
individually-addressable RGB LEDs.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
--
Change since v1:
reword commit message

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 10c178d97b02..32274d894664 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1462,6 +1462,8 @@ patternProperties:
     description: Wondermedia Technologies, Inc.
   "^wobo,.*":
     description: Wobo
+  "^worldsemi,.*":
+    description: WorldSemi Co., Limited
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^x-powers,.*":
-- 
2.38.1

