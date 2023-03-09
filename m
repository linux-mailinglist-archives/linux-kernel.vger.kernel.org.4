Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BFC6B3228
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCIXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCIXoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60567008
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678405401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=suVYwY+GLAgBE8RKgc91wO3frwS02s2uzBYIie8ENpk=;
        b=QjF5S0M4GrUm6JfmyQY+PiJxmhmPoyyAv3YGzeQ8uIrbEUHrSUcdh7Z1pOF+TvDdODy89F
        Cmll2CW7Agw91lIFzErkm3vABZxbSqbmMh7vEWMvM6UBTHEfeOAoAJR1UR4q4I8SGeok4E
        2mrlqh5atCT5i/3JYgPIZR6vOK3IXsA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-RSBwgAI_MnCtHAeYzDGsPg-1; Thu, 09 Mar 2023 18:43:19 -0500
X-MC-Unique: RSBwgAI_MnCtHAeYzDGsPg-1
Received: by mail-qt1-f197.google.com with SMTP id o10-20020a05622a138a00b003bfdabf3b89so2004622qtk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suVYwY+GLAgBE8RKgc91wO3frwS02s2uzBYIie8ENpk=;
        b=kOtLye9J3BZs8u8sfP/1aHKSwFAtSP2YcEJJk8f7frhwlfsh7NhSBRsYKgUA8j8p87
         G596I6VzNooMPAm3zUaTYRwStl5XhEmJW2O2In4WcPpctbFw2/tso9ern58aDtKp3KDX
         WonPH3+V+XiYVgeXPDx+ZPhCVUJqZqzY3zNOEEEMLViPUakq9h44Cb0DAFbD6aMtGcKC
         2yFEykXHjERju0EzMqJbogy2ASnTwuXkevTqbK6OTdH5nA1V1JteKt3ZzQP6+7et47TN
         pF5SCkbyeczl5R0BQpH3pcdTKPkCf8eKP7L1qaq5l4RJyV3fUo1ItMHnA2J6oKU7/q5U
         +Quw==
X-Gm-Message-State: AO0yUKWXQ2Eh19DCForGDG4w0+6JdGF6MM7Cg9n1JgUs4CizDviw25BB
        3mSkJo/it/VtRf1BFr3PxwPUxWxPKQjwZuGU9kXO7GUo39vu3R/gUGWeCKyKUzlkEYHOQDUKhaf
        NZXzNzlz64lWhBa9BH0UObIiX
X-Received: by 2002:a05:622a:154:b0:3bd:1728:8886 with SMTP id v20-20020a05622a015400b003bd17288886mr748740qtw.9.1678405399455;
        Thu, 09 Mar 2023 15:43:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/uu7J7MQWeYdrYBK1fDWserIzrfXuEWu5uLRWyUvVyFCL7N4gUzEjM3Np1nsOGAGcxkSmh/w==
X-Received: by 2002:a05:622a:154:b0:3bd:1728:8886 with SMTP id v20-20020a05622a015400b003bd17288886mr748722qtw.9.1678405399228;
        Thu, 09 Mar 2023 15:43:19 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8008f000000b003ba19e53e43sm299396qtg.25.2023.03.09.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 15:43:18 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
Subject: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
Date:   Thu,  9 Mar 2023 18:39:48 -0500
Message-Id: <20230309233945.1199358-1-echanude@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABL uses the __symbols__ section to process the DTB before passing it
forward. Without it, the bootstrap is interrupted.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Depends on initial sa8775p-ride.dts:
https://lore.kernel.org/all/20230214092713.211054-3-brgl@bgdev.pl/

 arch/arm64/boot/dts/qcom/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b63cd1861e68..72e85ab31d74 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Enable support for device-tree overlays required on sa8775p-ride.
+DTC_FLAGS_sa8775p-ride := -@
+
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
-- 
2.39.1

