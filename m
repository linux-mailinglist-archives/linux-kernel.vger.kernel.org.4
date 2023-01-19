Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B9673561
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjASKVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjASKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:21:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081AE659A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:21:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 20so1083520pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rL2zoNqn7rKJXBUdA7n2h+JOSB03tHyVIMK1O+/+XBA=;
        b=tJRmZW258uFABdbVGNx65PAgSM+mFHemClFfBw7mnvRyxokBeXAz6iIXUsj+pNSsK9
         nibKFk0Hd46wAuOxsHoCP9yZRh4zOlrRjmJB018rhd7zRx264EXSVYJeDkGu78/Bnl8d
         o8VxffqBQOJk7DROKTJ/svVjweCM9oV/18+lIwGyC5invq/IzzfzaUGhUm0AYDWAgXkw
         ldNm4Mq2QhfnYJMq9F/1n43H/epbMpCEO88P5zORZ+alULcUoI+LzQeQqB5eHRaZt5K5
         X08j8+8nIhjHY4gd64/pIxN5ySAmXrPylhfYkeGtxCkXE6vM1zdRbVTKOLn11DcxMgbo
         c7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL2zoNqn7rKJXBUdA7n2h+JOSB03tHyVIMK1O+/+XBA=;
        b=be+BfZJtGg3JlMCWD94NEqlcAyUN4kkg+7QtEEbo3kI8vP+YcZSVULrDnhwmAW+rFt
         I/FpuDJzzsNsfQ/GEYBED811Mr7AKPEDSh3iNhr805X3LFpKOrbULULNvL+imlAN1o9c
         gWyYtOF3ITdF/KnnHHSDlwFeIGvkGH4UjpReucWGQ82AsEdbrz437L2C6hPVvcCsp+Tg
         aVYLRFEdeZXIKlq4qdyvfoFyLHqzF9StrTqUU8X8bsZ68sz93Crae3AgXTGDtzENK0ld
         bKNw93JTCyXWMJAAz1MlxYoWZtZeu/IB+3O2/VWB2T9LIGMJePwYZJyjXDlWMPp1rteZ
         D9Yg==
X-Gm-Message-State: AFqh2kou9OZt+yF73nfHgEbxJH9y8PBuj3qi4I2hCC+eVYtZ2F/hZky1
        YZzkxAv63mSOZdNv77qKLd3VfrDD7vGia9hqnP+u/TzTe5pNNPskAacD3ZuraVlzIkF0KduDl/V
        rvm518KAFe2jBxool0pByXwzxQgbFQGs=
X-Google-Smtp-Source: AMrXdXvoEJVMsJVwWlxtJdUyWwzIN0910blx4t0nBLIMLicnFjHDxkZvxZ6+qurrrAl7cim/GPpeNw==
X-Received: by 2002:a05:6a00:181f:b0:58b:d244:b525 with SMTP id y31-20020a056a00181f00b0058bd244b525mr15630841pfa.17.1674123677598;
        Thu, 19 Jan 2023 02:21:17 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b00580d25a2bb2sm19152964pfb.108.2023.01.19.02.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:21:17 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi Space
Date:   Thu, 19 Jan 2023 18:21:00 +0800
Message-Id: <20230119102102.73414-2-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119102102.73414-1-jordan.chang@ufispace.com>
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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


-- 
******************************
This e-mail is confidential. If you are not 
the intended recipient, you must not disclose, distribute or use the 
information in it as this could be a breach of confidentiality.If you have 
received this message in error, please advise us immediately by return 
e-mail and delete the document. The address from which this message has 
been sent is strictly for business mail only and the company reserves the 
right to monitor the contents of communications and take action where and 
when it is deemed necessary.
Thank you for your co-operation.
