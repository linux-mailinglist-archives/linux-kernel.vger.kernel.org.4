Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ACD673562
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjASKVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjASKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:21:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D95EF8A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:21:21 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 127so1117888pfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=alvox7oxfs/Dz7IeYeOMp2DW95Yg30i+3OxcsGjnsts=;
        b=Lew2hLC5rAjWlTDceaQ8Z0YjpKn70BiBqXx+39OplEwgAxrtff+ArmI96+LX5jRBGn
         cDZAGdjz1ioaeqQ6Zqh1eQ64/+m9gl8NK88Xleh1WFqMhUMrtcHjKN40nQVdV4j8Qm+2
         AaNN+aGqqZqXAolyDbq5Qm9eiBC4dHnNJqb3iQclUgk+Zpn0JGlvZ8yEY0rJZiVttPez
         +qva9/4XUiKYRWRi8YQTIPx8Kee43uhFb5O/a1LaBIIZup8zXNBw3J1pX9pknxPyewQ2
         oba7CHyTqGkSi9P/eDBlGiE8/M1piUzqCawxz8uFU22E419KeQsuTFKjsR1S86qqlVk+
         qb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alvox7oxfs/Dz7IeYeOMp2DW95Yg30i+3OxcsGjnsts=;
        b=kIl0fArjqGy3EpGzgff/U++vUMKnsan+21Rb9mpPsNeTCex6cJGMfaaYSarh4b6CZj
         SKfKMglJUqTczLcAViDOsa75zcxJjnSO15IZWgpoJJFf1jgpeu/rGU9RCxNcf+jvB4Pb
         p5CysQL3+mHqf/VoMg8UeSUSlgl5qKTKJIeOj9igi2FRFSa2PbBbxLaQONKGBZ8vs3OK
         VOWQ6XjrATSn3d3k/kJIq0fsro/ww1JxdoQdP64C/sx5E/oXkI0MBHLISI02aDQRPJY2
         hIvgZ8KlNWbuFSYTx0D8SKueVeAX3FVq4eVX4omOA3n0UFXohTHtobk30AbjFrSDgEJj
         apBw==
X-Gm-Message-State: AFqh2ko/GD90WX0FPINvvRy2ZnIYlPQqnSZAyINfwtIuSOQDzfJNy+Ym
        hloD6d4PQ959MEZejZ8ut+qiJhqoboqo06B2BjKfykUUQwJ6sV5G+pnn85ddpX+sMtw61cnzyuf
        TXPRpWUYbZqcHuwuGmg==
X-Google-Smtp-Source: AMrXdXt1ImXcPaKYIdueoj4iH9mAMmluwaoNwNRy3gfTgU4Bqmc3+X9CwSe7KcmSJFrllefWY0Hoyg==
X-Received: by 2002:a62:148d:0:b0:58b:ca43:9c05 with SMTP id 135-20020a62148d000000b0058bca439c05mr10211079pfu.16.1674123680834;
        Thu, 19 Jan 2023 02:21:20 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b00580d25a2bb2sm19152964pfb.108.2023.01.19.02.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:21:20 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH 2/3] dt-bindings: arm: aspeed: document Ufispace NCPLite BMC
Date:   Thu, 19 Jan 2023 18:21:01 +0800
Message-Id: <20230119102102.73414-3-jordan.chang@ufispace.com>
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

Document Ufispace NCPLite board compatible.

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 272626937ecd..0f180aad3a09 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -85,6 +85,7 @@ properties:
               - jabil,rbp-bmc
               - nuvia,dc-scm-bmc
               - quanta,s6q-bmc
+              - ufispace,ncplite-bmc
           - const: aspeed,ast2600
 
 additionalProperties: true
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
