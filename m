Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6270A581
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjETFHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjETFHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:07:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BFE45
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:07:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae87bde5c9so11469305ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1684559263; x=1687151263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr3+BQp3+2PjwyI+d5nRt/2xB87GampH66jS3gUBxOw=;
        b=tQq8QqCjFnJXUkndLkdBDdM88GCy5IZKOOlXkaOaIr8MBB9T1cEo0bNgo+YhRpvxId
         GKjfaaAnS7PS9YjGBCtDsgIfZDYvs8t2CujkKCKQADpGZutumj3mTZzdyXUD0sUq6ZPa
         I4PWQ8N71cgI97NLd/QVANZOuv53UJFEZuH8WYSbFWvBEyAgsltLNPEY1ErUm0CQ7Irz
         GGk6HANnSbbVhpLPFwuw1cAn/h2+YBgp41soSIulUdFzLysHKNdIuyjnm+9CKhiBzQXX
         BsqQWQzf19VmVWqgzI/A9t6P2+WR3SxZvdferiiLZ0cC8gcu4LP5wE+ujmEfAUKvLtGz
         pUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684559263; x=1687151263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zr3+BQp3+2PjwyI+d5nRt/2xB87GampH66jS3gUBxOw=;
        b=V5yZ3W3AvAdWsJFAQDHKL6jBR+N9IXpI44jBC/a5OQY8ndGQsO/NsOn+1zLRiNa5xk
         aTam6zGM9m1trVjzeVstKry5Kok39bbPxzR+yoWeeJh3rnyCOmdL3rROKgJGZz1m3n1I
         YbSDKI8WSsI7Phd1HlUxivm0CqohMHgVjT34OhDdPZLNJJ3SbpjrpLFvbU1v+b7UvrDu
         n0x2Fkx74mvfqrONfrKGxu/xzz/c6cUDUSw5DOrwOPo45ewEJfNAb8QtMS8uzJwEGLFL
         xFonertQaengcRoKPeUq0K7V7k7euuKd+jLBqrUt0ue3yCdOMhXXbsl9N4uj+fDsNyNm
         eVUQ==
X-Gm-Message-State: AC+VfDxu3g0QIzJ7PreeE78ZArO4PKUmDwBt/9HPFFZvIRT04qIBkDRY
        wbMHGg23zkqiajJkhL5IrIeDbw==
X-Google-Smtp-Source: ACHHUZ7l/uiLFw7b+1H9hfC4+7wi76DzEWM6L9/k2ZR6jjCTwESstBl79wynT9r2LhOfVl+959hYEg==
X-Received: by 2002:a17:902:db03:b0:1ae:6135:a050 with SMTP id m3-20020a170902db0300b001ae6135a050mr6091997plx.19.1684559263554;
        Fri, 19 May 2023 22:07:43 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b0019e60c645b1sm476725plb.305.2023.05.19.22.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:07:43 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@chromium.org
Cc:     benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, yangcong5@huaqin.corp-partner.google.com
Subject: [v2 2/2] dt-bindings: input: touchscreen: Add ilitek 9882T touchscreen chip
Date:   Sat, 20 May 2023 13:06:49 +0800
Message-Id: <20230520050649.2494497-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ilitek touch screen chip ili9882t.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/input/elan,ekth6915.yaml         | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index 05e6f2df604c..29eb63b2360b 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -15,11 +15,16 @@ description:
 
 properties:
   compatible:
-    items:
+    oneOf:
       - const: elan,ekth6915
+      - items:
+          - const: elan,ekth6915
+          - const: ilitek,ili9882t
 
   reg:
-    const: 0x10
+    enum:
+      - 0x10
+      - 0x41
 
   interrupts:
     maxItems: 1
-- 
2.25.1

