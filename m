Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1D618C78
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiKCXFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKCXFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:05:34 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026701EEEF;
        Thu,  3 Nov 2022 16:05:20 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l6so1853675ilq.3;
        Thu, 03 Nov 2022 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akr74WzhT+2lGDGVllEO7CxN1d/TLLqV1PqBhKW+nrU=;
        b=FR1QC9f0jpbaKPLzfki6+Vf6gdQJJRAxhdljlxpkQL3aaBAhqHCruE942TwSD91oo+
         TD7uPsMEu+nubutNThEMEHaVh1kcb7VDOkiTn6BaycKgGOoK4Yz5wGRV4DVIRZPDdlfK
         9U2u0MDYJynBl7PiMPHfnbfl4Z8AId2jEfcBaMbTXH6OCiO9yrWOhbDGcqAImZrurnal
         BHxEnJ21YvMRdi7R0VhckdaGVbUZPDKqEZdubssHZWaOAE3SXkewxBQHddw14ojj4FiR
         oKiPQ7zacyeyJHFQR0jz6iXsFffrPogQxxNZqavGP3vxKN9VoOJNXdAHjLYTyEANqaX8
         yIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akr74WzhT+2lGDGVllEO7CxN1d/TLLqV1PqBhKW+nrU=;
        b=s7ySNyIxY9C/bq93q84rUmJ3RqamUmAu00IzWWdkhjV+4fZMXS8uqsTZNhFLIq8nhT
         ZZXjDOShK+bi2iEHzR7hM47Y29fxhQVnqX8NdKZ8d7wUtBWMyGMFMveHpIpwjMMZEHAp
         zuRnMnBbEkMaUSxhSCm9wmoS9y0g3gqoRXLFeBNCUUAo4sR6bHm+2TxxMo8sciJzbeDc
         zvsV3xbfYUEN5jdzLtgfYNwO0neI/Z3FOfr2YwU3aSfgGKD8yknrHuL3YmAvvnd095ou
         OHoFSyoI4MjfFeCwnXmzd9HQQnZ5k5hUjyXhL9KWBYX2SmZhmarbb/zaZd4o1SE4nNKQ
         TugQ==
X-Gm-Message-State: ACrzQf3ADzWYrNxrVlKnDbMqzWf9kPe8K5qEBl+8nDNYfzZc51Y524H0
        BoUrloiHl8HohF/C5nGUFNw=
X-Google-Smtp-Source: AMsMyM5xep2IHZdFBuxNoB016ysg5Sy5d2bBp9B2VV/61FR+BVCsch25cEGwahjiyEWm/YuW8ix26g==
X-Received: by 2002:a92:cdaf:0:b0:2fa:27e1:727a with SMTP id g15-20020a92cdaf000000b002fa27e1727amr19243062ild.135.1667516719365;
        Thu, 03 Nov 2022 16:05:19 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id g100-20020a02856d000000b00365c378e991sm636860jai.124.2022.11.03.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:05:19 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: cpus: add qcom kryo 360 compatible
Date:   Thu,  3 Nov 2022 19:03:48 -0400
Message-Id: <20221103230349.212861-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103230349.212861-1-mailingradian@gmail.com>
References: <20221103230349.212861-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses CPUs named Kryo 360 silver and Kryo 360 gold.
Add the compatible string in the documentation.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5c13b73e4d57..1247e9a975c9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -178,6 +178,7 @@ properties:
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
+      - qcom,kryo360
       - qcom,kryo385
       - qcom,kryo468
       - qcom,kryo485
-- 
2.38.1

