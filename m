Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89C722B33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjFEPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjFEPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:35:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E1AF;
        Mon,  5 Jun 2023 08:35:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f60e536250so43846575e9.1;
        Mon, 05 Jun 2023 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685979355; x=1688571355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8VaZ858WGTztv9OyCXzp4p0rlgykAZTm6ZPkmQwQoQ=;
        b=Ig604a9q9Z49rU8shBVGVHdxumqDNFzpGaq9ADNd1Hi0+LJKnUCcjak88DsuRZhFZ5
         CC+Q+IEKQt28X1hdjwlFVIHoyMvKChf0HJui2D24AT3s+b6PFHoiSMtiPvRYuaaERawT
         +6DK8U6+FS0CRUPUduNFuRiXdsnOmp6+3IZmXNgCw8hFDRFe9xyarcjIqguNa8fhq3le
         1SqfAOruedLvMAURQGH+xZ7L0il8z/fKcgBhLe2nKUasfi0pea8SBFyPKT/QpQ4Vxez4
         YTvogruLnA/kbrY70MTdUaJlEZL03CNPTKZX+zV6dvClANaCs6GRIMlRVdekkrx6kEWE
         M/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979355; x=1688571355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8VaZ858WGTztv9OyCXzp4p0rlgykAZTm6ZPkmQwQoQ=;
        b=YcUkdhhuTcJDfFzNJJVW3Ruq4bT42+h7CKMImtxoaZO6VFrgkQ+Z7FvW5FEeJ2p0O1
         r4MHlbSnoHSAA4SXoAIOkcFP/AL+0EC4WknwN31MmYmkP+usyWHT3jvCDttU8bVuRV6h
         bNwzwd8OnjKR2g2zMxuzSZmMVOcV/ueXQ+mjXmuX2nUFrOrkNIIQo4+8uoBVuz9M19ZK
         rr069SZKSwPnC8mBaJL+19UJ0gbbBz+++fbyPBmdOYr5EWkQXgkPAguVUP/qgzTQ0icf
         5BWuTKvbdl7QOXJNUA/mi+olXmP/+grjWwmhZBbhInM84mBvSJA1bbRJ/tW9dcz4SXui
         qX2Q==
X-Gm-Message-State: AC+VfDweudbp3pdt0XbGaLuFR2DUlX5gyzUAc4vfCiI3FiP4sRwU35Jh
        6cabFSq4h+A/PdoKIO0UfDw=
X-Google-Smtp-Source: ACHHUZ6S2Rl1SW8Qv9aPJ1WgwuSiwYk0NFonaN17KfpBpEjkfwk+S4Eyc8eYs6b+KMqaExMNUFhRrQ==
X-Received: by 2002:a05:600c:220f:b0:3f7:395d:6585 with SMTP id z15-20020a05600c220f00b003f7395d6585mr3617671wml.15.1685979355325;
        Mon, 05 Jun 2023 08:35:55 -0700 (PDT)
Received: from fedora.. ([95.168.107.36])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003f7298a32ccsm9741165wma.41.2023.06.05.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:35:54 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: add fannal vendor prefix
Date:   Mon,  5 Jun 2023 17:35:37 +0200
Message-Id: <20230605153539.497602-2-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605153539.497602-1-pavacic.p@gmail.com>
References: <20230605153539.497602-1-pavacic.p@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fannal is a one-stop-solution provider for touch displays in industrial
application, committed to delivering a variety of professional high-quality
products and technical services globally.

Website: www.fannal.com

Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..f962750f630a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -462,6 +462,8 @@ patternProperties:
     description: Facebook
   "^fairphone,.*":
     description: Fairphone B.V.
+  "^fannal,.*":
+    description: Fannal Electronics Co., Ltd
   "^faraday,.*":
     description: Faraday Technology Corporation
   "^fastrax,.*":
-- 
2.40.1

