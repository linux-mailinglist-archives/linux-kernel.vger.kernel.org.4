Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADBA5F599E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJESPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJESPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:15:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596583E765;
        Wed,  5 Oct 2022 11:15:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w18so18384596wro.7;
        Wed, 05 Oct 2022 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+/Q7rcsfvUmW67dI6FY00wmkiMbNJ/gUVedisN8grUo=;
        b=YrqJlXoHx+Z9FCPNh2KVhVo+4iGkiAGiTo+Pd8s8TOTNq+A1XjVJ15t8KRXMuZEQjs
         1Idrf1vwxJqOZvI5vEJaD7Lyt3ssa1ZDizBJlnUT3fWgBT1pNXWndgOhYuR6uKkN2csw
         b0zbZJ9+BrzpEbfYDvdJjavGvZhIrrVn+LsnJ0mUG6CpwnRVl5d5SqXe7/XupPbM7YE/
         92vWetbjjxdckNxjkoAIqMoj5s45qDETeIGvoePZXxWNagCLKIgA2k3cj0wI81VJqY01
         jjFi3hL7QKlSFo7Q00CwsLCgkzXSKHUezmm5gfOgvQO1xbGuo8L3kBrWQQ/sEWnf0EeT
         bZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+/Q7rcsfvUmW67dI6FY00wmkiMbNJ/gUVedisN8grUo=;
        b=a+p1moBhkS6pBlfmK2ESMX4GHzwMui7Kf+4RgyaVxxtTsBRuVnMhSfRIbA9be0QBpy
         wZs/utZrs7HYEGaNpitqu/YoFC++oFsTL9/RBIV+pLtMqqRNOPpHOsLvXKfqCaEF97qE
         cpyovbP94veO1CiyimAIKh4Y13R2J7H/YJ7Lpq00TahHT8iNjJjPlYf9pnqZ7zmbej65
         a+N7LSvUjLMhpUD7BWucjAvWxllOD+W9Zrx0N6RFkC7mvZYW2cLMsv+2PmSwO3VpBhgA
         Fk0nmtSoR8uwi+NvmvqdI8HY7JIdwET0MuBtMAt4W1uyl6gnJNmSen5886HWhaZGgYNW
         t9DQ==
X-Gm-Message-State: ACrzQf1mIQqoepQ20lSi/63cnNSx97gLbvLi387eaSQpa254JavBeHUv
        bhNJh9JjVt7ceZobWqP7KB4XUcbHb1I=
X-Google-Smtp-Source: AMsMyM6I6I1Z2b3qoRY9xTVGSxD/HX1KEa8fBRizI1kUl4QtAxXWMq7yPZlHizsZw/arjp8DEfyILw==
X-Received: by 2002:a05:6000:2c1:b0:226:e816:b6a4 with SMTP id o1-20020a05600002c100b00226e816b6a4mr664382wry.330.1664993742688;
        Wed, 05 Oct 2022 11:15:42 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id g20-20020a05600c4ed400b003b4ac05a8a4sm4176240wmq.27.2022.10.05.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:15:42 -0700 (PDT)
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
Subject: [PATCH v6 1/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Wed,  5 Oct 2022 21:15:27 +0300
Message-Id: <20221005181528.1038629-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221005181528.1038629-1-dsankouski@gmail.com>
References: <20221005181528.1038629-1-dsankouski@gmail.com>
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

