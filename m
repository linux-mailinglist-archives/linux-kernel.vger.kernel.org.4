Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D35FA149
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJJPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJJPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:40:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E34AD7A;
        Mon, 10 Oct 2022 08:40:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bv10so14060028wrb.4;
        Mon, 10 Oct 2022 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfYSeq7mk0aa6DIC+WOPWwGXsS0aXTt21Yphq40vvew=;
        b=e7nMXlbfcg387gF44JodlGQK0JnwrcvIzv4O8dCWGg7mfwOWZBKLcCJEkjDwpGQj5s
         Q5N3WHSoPhUCLLvs2CmBLb1dMStisxWvzcB9kzRXfnDR20OTqNozqb5V6RGatCCEwuX/
         1624CZ93+CrEU2CucPpY8Yg+fDOFNc2015ExX8yPLZ600xxYhYPwLCFnVgHj2Rc8F55n
         exMEheZnYA+wNGEXFgdRbIx3zomXi+Lx+zdVwNLGMCVIKORXvykJqDKa73WVy7DnoccK
         WpwvrLim29SBQWP5BY8ixQ7pWEOeRbSN6SlNexV1af4xIZ4VuFhOYbM/EUAVRgwsLWPp
         OAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfYSeq7mk0aa6DIC+WOPWwGXsS0aXTt21Yphq40vvew=;
        b=goG2jnpoBfuPWU8lPFTZyQgQP9udCl7247/jJFIcyxCinz+JalGOdQly3y4S7RDBC8
         ZFIP4fXqs0XbWCeAo+cTxJ2IlZThTLg2tVzr6IVhuR/HuvOoaQlxTJqIVQ5dR0gMSu7S
         lr+EFkHLkF6qVOVjXSDEeIGurDRiq+mW1dhdabsh7b2iS5RDhF/MqI8Vhwfx7KWZQq4s
         M0Uo7+LTMX7jZew+F3pLzwOqYql9RGi5jZyC39qzbYQjec3gXHsi63UpL41Wcny9O545
         YzPj80CgUuCvtkEtPBvwOVo+E9Wsvo0x4zMxcaSYsteSFCP+SgxoZ9FIkRoAz1Em/MJc
         SCCA==
X-Gm-Message-State: ACrzQf3RdDuG7ZPX9ACoL80CWYPiiZYoKKJZTWxq03YevHEW3uojt2Iv
        vsF3lRt9eUVddfL0RLlvspeQvDj6DuA=
X-Google-Smtp-Source: AMsMyM7qy6MGTR0nMI7FzQqdWzNp0CGVR8oY5DLtCCRh1RGqs+M+ejKbsfxM9JeEY34wMxh2KkDLrQ==
X-Received: by 2002:a05:6000:15c8:b0:22f:c428:2493 with SMTP id y8-20020a05600015c800b0022fc4282493mr6188702wry.83.1665416444354;
        Mon, 10 Oct 2022 08:40:44 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id b2-20020adff902000000b0022e66749437sm9068321wrr.93.2022.10.10.08.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:40:44 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v8 1/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Mon, 10 Oct 2022 18:40:38 +0300
Message-Id: <20221010154039.1144605-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221010154039.1144605-1-dsankouski@gmail.com>
References: <20221010154039.1144605-1-dsankouski@gmail.com>
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

Add xiaomi,sagit board (Xiaomi Mi 6) binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v2:none
Changes for v3:
- remove unused 'sagit' compatible line
Changes for v4: none
Changes for v5: none
Changes for v6: Start with capital letter and finish with full-stop
Changes for v7: none
Changes for v8: none

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..294075bafb97 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -239,6 +239,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

