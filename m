Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2C64988B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 05:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiLLE47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 23:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiLLE4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 23:56:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709C2BC17;
        Sun, 11 Dec 2022 20:56:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id js9so9732621pjb.2;
        Sun, 11 Dec 2022 20:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i76cNidMb9uGC4CAwhKLtXNE3wI2QcxYpZEpD1u1Q1s=;
        b=qac+05DFi2Ki19n7r2dcNZcKBe60yE6MB1fgho5H/VTvRfru72SZyfQkM5nLq/HTp7
         kB719c3wQfDfZUY1s/Xl3gGz0O/u05D0jzdameu5/g3NVWLNGPRKHjyBaczNppFtpLGF
         ek8J0dXjXkIJp86aNVfZTIuQT1Az5WOm2Jn3U2umMNVgjQy3DC4n2AV+RwLXl7YGqQp9
         nuZrp+H46RlIBvXrSR8ZxGKmcc5He8QIHnCHaydndejt3TZENjxhhni1g82WyA9eVpMZ
         aUvKm/uwEs+nQx64sNUGl17BPULc5hJpOhM7EQM/Li31MhAh1daXqSe3YUJ6VRZfCE1U
         ohcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i76cNidMb9uGC4CAwhKLtXNE3wI2QcxYpZEpD1u1Q1s=;
        b=q63GU2aLU1QUs9kYumj9JU5mbBPyuavnXGNjmimup246Oe/SDvYFbTqyY1uTNszTqQ
         WOFv0Ew3mHj7AiYo6f4HqOpHymOSJlE99Grwhk0uRQ2+NcewvAAthJChWiqMDSXfYuKS
         K9gqotrSfsjlkA5+YJ0anaZek3z7mTsabrHbSe/0ppPy6jKJgd366u6SRdfdP++gv87l
         hMmfhO5922GDFUFYXi78od6LWZGhraz/E6BnDK/QKs9uqriOtlATGYMsl0mtjduVhjB2
         MZWq82uKueYbP1DAxPx7uKugm+pY1XBtvQP6xE53J7Z3zwFboEPRm2YjDc0/OAGqOJ3h
         cyYw==
X-Gm-Message-State: ANoB5pkCFeaS7F/CQoDV5M6r/hBDP23Ttp0E53hsXKqgRIByzz3OOnYG
        hd4g+QCbqR5M7QU9p2/BME5+3lsdVGk=
X-Google-Smtp-Source: AA0mqf5SUFdVmA47z95v8dKeSyiKB6sIYOD0qipM9OzBReFZuEh3wghXpmkJr979yZeIQuUv5MiB/w==
X-Received: by 2002:a17:90a:f2d0:b0:21e:a1d1:509f with SMTP id gt16-20020a17090af2d000b0021ea1d1509fmr11621796pjb.5.1670820977250;
        Sun, 11 Dec 2022 20:56:17 -0800 (PST)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id s20-20020a639254000000b00478eb777d18sm4217674pgn.72.2022.12.11.20.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 20:56:16 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add an entry for WorldSemi
Date:   Mon, 12 Dec 2022 12:55:56 +0800
Message-Id: <20221212045558.69602-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212045558.69602-1-gch981213@gmail.com>
References: <20221212045558.69602-1-gch981213@gmail.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Change since v1:
reword commit message
Change since v2: none

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

