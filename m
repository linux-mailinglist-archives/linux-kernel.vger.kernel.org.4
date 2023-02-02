Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E751687724
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjBBITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBBITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:19:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67A383957
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:19:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l4-20020a17090a850400b0023013402671so4817076pjn.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0eQ8wM8+rAZjPTLSsCnuo+7UfI1u5sRbrCqEezFtYk=;
        b=dNwpUXIi12PQHpKG5fST8G0QU3jiIL5bzgKDoZJfGPAOXJuu3E+kAB1GW2maKz0Gbt
         NoSOK9oGmKYYlxjcf4ABKUHpznxB+2JQl8TprBxEBOTe/Aakhnys7+v3z81StLLgn1gC
         Nq++vzoeC4oJClfZVJp8L22mCtUA0wF5OXPU84ccubL7LIV0fLtggRTcRkvX7GuvNQtW
         vDVSpbOWlX/TGJq05KvGBC+Xvh+Gn8HNoToTQLmJ+eGB8xGFhF5pECB+FpSRPXJDcC5d
         3L1GpklJXv3q3GQG5mXlj8EyoFoSVxUDBn++Z7sRtE6SNfU8z34gDbEP3Z4FptgRys/M
         cLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0eQ8wM8+rAZjPTLSsCnuo+7UfI1u5sRbrCqEezFtYk=;
        b=d4jG5poV78H9ygKiMUq/9NZBV3eT157IN/lIjcBiTnCOqb+zIj9pYUcOSzmPnuzPDr
         IZy82NSoGxJl9ALE3TWqnfj5cEjNNlG2wOPuwd+PXV+sMNhCCjRgrdZRqg4CoJMn5xpO
         JYL6BL4INMuP7dNdguFzRSaxLwCz5CbohOotoIx00j5d3VIMdVSCR+DGQuC4a/j/UvUv
         xpWc/Os1flUqTeVAXEbve9sBxtvjl0KOa91MSTrLj4pxFztykDTnUky23Dtlp+fggtD3
         sHxwJDoYvhuS3HCqd8sDsAcm6rCwO9k5wbpH1bWsyCfqikmGbphUPpxewEIeNiMtVjPn
         26Uw==
X-Gm-Message-State: AO0yUKV72KyMfIMvOHPnPjE0aHRjfRURGKBI5QTapHT0/vE2E3IzbHc7
        5RPgf6TSUZnbctVjjjlHxrEZaQ==
X-Google-Smtp-Source: AK7set8nXuWqsdd7n7JrP2KsPRsnFhVxDvWtJLiWeNlR2xALUpfnOMFhA/1IZ/WRfBq1eOyy0F6+sg==
X-Received: by 2002:a17:902:c412:b0:196:82a0:4187 with SMTP id k18-20020a170902c41200b0019682a04187mr7120337plk.36.1675325958392;
        Thu, 02 Feb 2023 00:19:18 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709029b8900b0019324fbec59sm13187552plp.41.2023.02.02.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 00:19:18 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v2 2/3] dt-bindings: arm: aspeed: document Ufispace NCPLite BMC
Date:   Thu,  2 Feb 2023 16:18:42 +0800
Message-Id: <20230202081843.2358-3-jordan.chang@ufispace.com>
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

