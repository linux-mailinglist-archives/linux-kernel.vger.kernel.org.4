Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D42687723
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBBITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBBITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:19:16 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0684B79
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:19:15 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k13so1144486plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYQEim1aMd1zzuJMmA4e6AobcW8EG99vfBVaZv6UaOI=;
        b=0kR63NHO0bLqMO7x5f84eHCV8ztqxsEFVaUb1CzThkMCQ5grIfQEcq2AZusm6xl7qW
         mUsf6YIHGE80/pLWp5Gz0wJTFYJ6C1vxx6D7/Xxv4wkcFNEc6CHVBY8QG4BlapBQzcU3
         xiBc8x1aOVWxjWijQ+tJPfJzxc9PIhV2uI0g5smrtn4SnN/otn9p/zgd7beiEPoVdLT/
         XmD3PceJcPJGjT5NCRdRsv7O4bjFpTyBWjpK4RDdL6oQoETWOREQE4hYA1Tye4J6zLqD
         3JbYQxQJUxf89NPyjE/h5qhsmvjchNg9KznJhcNBVjM27uKd9j3+4/NkQ/hH6GQjjwwQ
         Cmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYQEim1aMd1zzuJMmA4e6AobcW8EG99vfBVaZv6UaOI=;
        b=w2e+kkRL3tUClt6Vi7IqPXHWiLiKHl/FXCr5G5furmxd3wrTFKYatPpDm/d6QRLjHD
         4gGrR766aJfF8PX/jXEnx2WAr+PWvdDSaB6CTH0Y1xtWi1pVQ3Q+TH0sgK8EV4NPSEf3
         HSXA0Wjuz2oeIlvQghNixD8xso0h2XtU/6tOevhxQ1GK/v9rkkrgf86FtlAuYK46wzh2
         BG1a5sZwGS1emS59qbF2r3YS2OjgYYc2c3DJ8cew8RqNjgJL7dwjVv6SIbe0rjZHJ1Aw
         gd/ExZuXC48G15sIEBt+RaS1un2bNnZLYE64zBoOQqM3j4z9D6qSIQXX/MQXb6OTUFE7
         xYww==
X-Gm-Message-State: AO0yUKU62PGpD++WxCGyotUakbtsATsoNGxVo4TAjrw9IljklwBAb8xx
        aCvL3BlC79yRznxCwrKwn1gpyw==
X-Google-Smtp-Source: AK7set/ZVmhVHWKUZUM7FcTZVNEEzrtV4rjOjDXDVGcvHPkD8SzdYteHtyGI+iHyr8Zovw42x1EQ/w==
X-Received: by 2002:a17:902:c3c5:b0:196:433e:2384 with SMTP id j5-20020a170902c3c500b00196433e2384mr5472705plj.57.1675325955317;
        Thu, 02 Feb 2023 00:19:15 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709029b8900b0019324fbec59sm13187552plp.41.2023.02.02.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 00:19:14 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi Space
Date:   Thu,  2 Feb 2023 16:18:41 +0800
Message-Id: <20230202081843.2358-2-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202081843.2358-1-jordan.chang@ufispace.com>
References: <20230202081843.2358-1-jordan.chang@ufispace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix for Ufi Space (https://www.ufispace.com).

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2f0151e9f6be..ab0dd1cb5ede 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1344,6 +1344,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ufispace,.*":
+    description: Ufi Space Co., Ltd.
   "^ugoos,.*":
     description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
-- 
2.39.0

