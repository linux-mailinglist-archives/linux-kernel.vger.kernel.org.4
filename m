Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05E72484A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbjFFPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbjFFPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:54:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C01310D2;
        Tue,  6 Jun 2023 08:54:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so9705076a12.2;
        Tue, 06 Jun 2023 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686066879; x=1688658879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzZcPHNlrNA1JZMXS01/jg5luvCwOgWRpYFGV8XYtZU=;
        b=id1kT42d1ilEc0MurMr+vaa6JFyFfZZ4sWvYCM5/QWvrLgekKMALl0+hPIb0lBXtJX
         PefVF6OnxWK27HMRFohc0gRoqFRmqmO9pQasuHIASdHhjYK2TH1IEYjpafRHtmR81Qod
         FrjiAi42XSKeYgolvXMLURp+05uEBuTAk8/QTsAcD8w3hGm27lz9723Oo3e+WPdkLz6+
         b8Yakw/oxxSakIFNil8dXBiLzl0ZiKiW/fcCRn1VrtnoW+VHKKxdOcraXObZ6uM1MQ7b
         VLzzetSJYOSKlD1YSfPiA8BhCdJUuM1Z8m1abISiTvzcMzbALW9/AxGxcl4ZpMcVBjsE
         jmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066879; x=1688658879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzZcPHNlrNA1JZMXS01/jg5luvCwOgWRpYFGV8XYtZU=;
        b=F+tE8GeaIYn4yCzXWXynk7Hspe8sKXUi1JO4TkLkBTP5nPsXg7df3L2U1Qey1revQN
         k4jAeY5YMjHntq7BREA6x9uktyh5bBQUs0HOeHs2SdxaViKA2ypuwb8XUUzKkk5af8Mg
         r9YxkAQJKvlPnuyqMDTI/QN2LgnnVPXQHMeqGqMsVWzPpuGEEPY0HfvpUsSNvyWL5g3l
         fYwWtC+ZG0PR8RYF4VC8Xi87INmDzy+gPwGSauax/TxbTwsP8KOi/+t2y7U3WtiPBAIT
         a6gcG5JXaPxQYfKB9XXRTt2b4dKUukWz/NR+eck8ItJuYuBHVOKqBjama+lYOfxnDaKo
         42JQ==
X-Gm-Message-State: AC+VfDzKv5b3VW3ifg+59wvU8lIuRVGjk0SFw1930dbHnd4kjQND1YZk
        2RRLse9+UCyfX4BU/CbMimI=
X-Google-Smtp-Source: ACHHUZ4mV0bDaR5Ugx7rWzqdNe/RIqilyKjENjmUyGlNewGXzhr8E5Y5ZWhaRTAOz4f1zxuqU+jaow==
X-Received: by 2002:a17:907:7e97:b0:96f:98f1:6512 with SMTP id qb23-20020a1709077e9700b0096f98f16512mr2883696ejc.41.1686066878807;
        Tue, 06 Jun 2023 08:54:38 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906710d00b0096f694609f3sm5800412ejj.31.2023.06.06.08.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:54:38 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Tue,  6 Jun 2023 17:54:02 +0200
Message-Id: <20230606155416.260941-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606155416.260941-1-tomm.merciai@gmail.com>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for Allied Vision Inc.
(https://www.alliedvision.com)

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..7bd678956b3d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -77,6 +77,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^allegro,.*":
     description: Allegro DVT
+  "^alliedvision,.*":
+    description: Allied Vision Inc.
   "^allo,.*":
     description: Allo.com
   "^allwinner,.*":
-- 
2.34.1

