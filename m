Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282CE6712B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAREom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAREok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:44:40 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8405140B;
        Tue, 17 Jan 2023 20:44:40 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 200so19081947pfx.7;
        Tue, 17 Jan 2023 20:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0lxoOUkcJ/KOLZdzC6xz5CbicZbR5gNovvjCwKsceY=;
        b=FlNH3KI/EFjf8IyzwPj+igW93Y54628YVdmx3JyIHJYM1z+hoiIughWE8487BLc0VY
         LaoGu1ukTP5MqqXtUNtGgyvgUjtDxOXaDOeAxDiEu4XI4Buyaa4dANpe8I0X4DDckE3x
         DX2YxL129EW71ig7VuDmKLBFAwqbg3zFqaf5bUEKk1d7noYuk9wJwcHbFeqaKopbpM8f
         n7HDnt9fZF01dx+G+QT6Dp6JMrpj0orQd15Hadu8rdodgyWbjrAyT2Wl5kGm+WlHFVei
         HL1qYXq8pNVCsGSvrAtF5zXu26BLNFmzTjleFxu7I3DktoMagyOht/6OTBRdeM1/MWet
         bfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0lxoOUkcJ/KOLZdzC6xz5CbicZbR5gNovvjCwKsceY=;
        b=BHWEX46fYZfi8dYBiz07zwx/1AXiOT2MVYb5JAgpAQ59/esUl6bRo92E0bNizaUbxV
         To76+Cxi2fB6Cd9q9CFwoYfQ/Rtg2TxjgQ2hcJg6OnGZud8L9xO1e13NPJGeTQfFq4Kb
         4DAMLtO7yUaCBc6pW9OfegVXMEdh9sJFubHzJpwuPtjgY9L/cknQwMdqAIpuTBn7MfVn
         gRS2KmeLwyemgaJiKKEHNOj3ieaMqMVirh9At88NmEVWdcYCQVPiojJ7vU2OyXbQqiil
         COBwl74JgiKTn7UJJ9qMZ0s5IijgAo7albeWPTykpoW+8JN7acNEov2vvKLfqMwXGcWX
         AUbg==
X-Gm-Message-State: AFqh2koMAjIGHO7sSLa0kMFdGdsXm/tb1R3ly0I0RpAdTUTEARW7JSUx
        bVmj0nCbHfKYUs9rnr7Nqak=
X-Google-Smtp-Source: AMrXdXvOoNZdQWYRFluUn/i5J9UWfSkZ+dDlHuOWGVCAiPsCvv3B6oS9bmvepzllVx8YzzuiuTp0Ew==
X-Received: by 2002:a62:3684:0:b0:574:3cde:385a with SMTP id d126-20020a623684000000b005743cde385amr5917372pfa.32.1674017079488;
        Tue, 17 Jan 2023 20:44:39 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:44:39 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: usb: Add device id for Genesys Logic hub controller
Date:   Wed, 18 Jan 2023 04:44:09 +0000
Message-Id: <20230118044418.875-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118044418.875-1-linux.amoon@gmail.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb hub device id for Genesys Logic, Inc. GL852G Hub USB 2.0
root hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: - drop the vendor name from compatible string.
    - drop the -OTG and -QFN76 suffix from commit message.
    - drop the GL3523 USB 3.1 root hub device id.
---
 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index a9f831448cca..cc4cf92b70d1 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - usb5e3,608
+      - usb5e3,610
 
   reg: true
 
-- 
2.38.1

