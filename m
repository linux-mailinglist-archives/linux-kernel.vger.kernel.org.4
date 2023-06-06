Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F23724565
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbjFFOMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjFFOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:12:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47219107;
        Tue,  6 Jun 2023 07:12:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso61426625e9.1;
        Tue, 06 Jun 2023 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686060730; x=1688652730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8VaZ858WGTztv9OyCXzp4p0rlgykAZTm6ZPkmQwQoQ=;
        b=PJrWvg+7yLEkuxQcPa7D4RMCK89IfL/gJOfMvRycs4Qgky0SQXPslBXwTvjsPBZjnZ
         OshfLDhQVzZAf0kKwXqlbn1pUminA8vv7Ih2l/0e8SLdlF7mOPfVbCc035BPY45V3MM2
         oORGsM+1XSWgZL/amlp2huSS+tR052kG7gSXdqbxcbDrcejFdgtOMXlQECOH0B+0vumB
         Sg8wqsI13m9aP0GxzXgsszWGhlyTLMDepYduYIYL2P906pS1I0YYNh3ebzNJoi1H/RfI
         5z1kCUc/VcapiVPMDMuJxpMJoOkK5duLjBEBM/Je7OBPAuf8SS4dDpJUobWTFcwRgXE+
         OSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060730; x=1688652730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8VaZ858WGTztv9OyCXzp4p0rlgykAZTm6ZPkmQwQoQ=;
        b=NnP79b4tX3yTqT7NLBy3d9Q4Zr9kNAY4suQJkU+Fava3jnRDisO1XHKD/jEiIj1b4G
         qgYiCXwA06SgpBllpQ/fKt4l6v0HI2Jqb7phpTJTeGNo+OYBo3rDa41iBwbg71+HTN/w
         uDUFpXBuTK3VV2gFI0FH8I9xaclZ2s9BQ2L3Vgy2Tra55TgU2HNNtqwOEEL8YpdkozWk
         scD5Lsj8uWrZIbezL2idpYDU9UTg7XQQ6NimjgxHwn4yKEsrf0ca2WyyBCaWKbYVhPVF
         hf3uyiyrfxeaPNnNq1JOsCqhE640i/BbYeYP+Mz/ynBpx8WkgSmRAIw2j8wzJhZJf5Pa
         MjxQ==
X-Gm-Message-State: AC+VfDxlHO9UuuyNber+5L+Q6rL5bHNs2h+nnUuZTjuD141qHA3SBHy8
        2QY7I4m+2Dq7pdjXK6ww9Fo=
X-Google-Smtp-Source: ACHHUZ7kXhUfSKsOLk232B5A4piHFS4OhzgcPjlrkjl50WY8ohBAQ+PjbqGx4YX4kqE22/mxxJVfGA==
X-Received: by 2002:a5d:4d45:0:b0:30a:e5ba:170d with SMTP id a5-20020a5d4d45000000b0030ae5ba170dmr2082349wru.32.1686060729450;
        Tue, 06 Jun 2023 07:12:09 -0700 (PDT)
Received: from fedora.. ([212.15.177.3])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b0030903371ef9sm12694315wrv.22.2023.06.06.07.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:11:54 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: add fannal vendor prefix
Date:   Tue,  6 Jun 2023 16:07:55 +0200
Message-Id: <20230606140757.818705-2-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606140757.818705-1-pavacic.p@gmail.com>
References: <20230606140757.818705-1-pavacic.p@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

