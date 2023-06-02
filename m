Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B316A71FD0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjFBJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjFBJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:04:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4110C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:03:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-973f78329e3so269473566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1685696624; x=1688288624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmqqRgiUwINg0zM6iswD1JyF/sKo+vBLZEf0BZFnUDQ=;
        b=PsUDUxexLrW3qJIJMMeH0z/bQvrHVeGXXEVIg6jC84q5cZT/2pA22ihuOt5kr8K32z
         Ce58wDcU3/NbbC6NfAn2EtyPPHo5Zn7rxiAZX5lGNOfrP4b5fjYvUvWXikGAVAM3G/Dm
         GNMbfO1VysCFDsZ4p7szujfKrewggNF76QAes8VQrtNFYr6KnXSoSBepumy6jmSiMVaY
         a/R3IGl5ZLeyrxQ1HmZXYhyxaWsgMa5S33yJBUxJ8gfb8HVSISXiTYJvDkBIZlaMA2OL
         3vzdxjXtcJCM66l8HcBeqsGP4fLMSsjDFKJqgXQwwfUVMzPNMcq18/KSFndgrgThlS89
         pMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696624; x=1688288624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmqqRgiUwINg0zM6iswD1JyF/sKo+vBLZEf0BZFnUDQ=;
        b=YR6cqwPHZOj5RnFNV26npycDThf4THGtG1e4wfTWpLV+uwGmHytTWgqGKSTqzsoPeB
         4R6d9palTuu0IrADSIOL/k0ch596zwEBt3XNLXyFGVzld0nZYCCTVMNE536Oq+MACz5M
         Jj48hsSE9JmogJhl6VV2wIedqfPoClAoT4lrOiAG665+0mk9mbmIrY4vo2RbJuJ7FgqR
         9kr196ugUO18hYGBhFvC2t/uZU53AwSuD7TxSD4tLjgFIQMyqyOJxfDEsBa/c1KpNB+P
         RLtixs19mZnTSBjnB8AnLcbnt+4JpzMbVVmB4xQO5OqFVyVw6DQpCekKSVMb6Dr8ZWbV
         c8Nw==
X-Gm-Message-State: AC+VfDwkacSTXzsPvVeWJNpE+MLhSSKpVaFv8Btqa5sjMoFGC3FoLk7s
        hYO0XOnyM8EyrMIV8gd2xbVWCg==
X-Google-Smtp-Source: ACHHUZ6FkgH9Pi4zxcCao3h6bU7K54MDeWgSQbT7iAsMjpkVsc6amBOT7zaP+p1lvup38fs0YdmhYw==
X-Received: by 2002:a17:907:9618:b0:953:8249:1834 with SMTP id gb24-20020a170907961800b0095382491834mr12522628ejc.16.1685696624649;
        Fri, 02 Jun 2023 02:03:44 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906385700b009707fa1c316sm488031ejc.213.2023.06.02.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:03:44 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role flag
Date:   Fri,  2 Jun 2023 11:03:18 +0200
Message-Id: <20230602090322.1876359-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230602090322.1876359-1-alvin@pqrs.dk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The new flag specifies that both ends of the dai-link have the same
clock consumer/provider role. This should be used to describe hardware
where e.g. the CPU and codec both receive their bit- and frame-clocks
from an external source.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 .../devicetree/bindings/sound/simple-card.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index b05e05c81cc4..ce738d1a394d 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -27,6 +27,11 @@ definitions:
     description: dai-link uses bit clock inversion
     $ref: /schemas/types.yaml#/definitions/flag
 
+  symmetric-clock-roles:
+    description: |
+    dai-link uses same clock consumer/provider role for both CPU and Codec
+    $ref: /schemas/types.yaml#/definitions/flag
+
   dai-tdm-slot-num:
     description: see tdm-slot.txt.
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -128,6 +133,8 @@ definitions:
         $ref: "#/definitions/frame-inversion"
       bitclock-inversion:
         $ref: "#/definitions/bitclock-inversion"
+      symmetric-clock-roles:
+        $ref: "#/definitions/symmetric-clock-roles"
       frame-master:
         $ref: /schemas/types.yaml#/definitions/flag
       bitclock-master:
@@ -181,6 +188,8 @@ properties:
     $ref: "#/definitions/frame-inversion"
   simple-audio-card,bitclock-inversion:
     $ref: "#/definitions/bitclock-inversion"
+  simple-audio-card,symmetric-clock-roles:
+    $ref: "#/definitions/symmetric-clock-roles"
   simple-audio-card,format:
     $ref: "#/definitions/format"
   simple-audio-card,mclk-fs:
@@ -230,6 +239,8 @@ patternProperties:
         $ref: "#/definitions/frame-inversion"
       bitclock-inversion:
         $ref: "#/definitions/bitclock-inversion"
+      symmetric-clock-roles:
+        $ref: "#/definitions/symmetric-clock-roles"
       format:
         $ref: "#/definitions/format"
       mclk-fs:
-- 
2.40.0

