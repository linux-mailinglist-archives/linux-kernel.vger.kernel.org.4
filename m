Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C338B63EDCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiLAKbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiLAKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:31:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20234E699;
        Thu,  1 Dec 2022 02:30:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id o13so3157166ejm.1;
        Thu, 01 Dec 2022 02:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIHeFovEuwjGuythdoubrFT/SXANkAJoc/lUtd9ZW10=;
        b=hApD77a5zfBe5o/b53t+6gn9V8ZyjpGnCPRoe5Id1ypg4cyDfhXbyTUgeWaWip6xQe
         ny0buVuVbIazaDDKYvph3+bQBQdXjdOoT/Bkbi1jqv9ATA/2NFRxdjydRWczM3S3M0C6
         F2PO+ye5Jj5VxURs41Ip0So0q5BWqvc6IL2G5hLtWo4lQQvn66h5WHsJ77DkL8jZ1805
         Z9N7fw8CMXjuhNogHKtg8opMaH+gr4EFjeGfxiEH7gMK0Svj0fo9wnnex+AOOp1hUxwv
         3YTW/aT32G/hUtOZF6SlURhD637ZQETa9HcDK9L3t85XLUFlXRdCweD7uLZg/zJcqgEd
         wDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IIHeFovEuwjGuythdoubrFT/SXANkAJoc/lUtd9ZW10=;
        b=raXB0c7qLHPoFbkx8PQAR6YnJxJJV104bQrS/pWRP9/1pVCirObFN1CAvhvjnFsM9J
         WJBArES2PpK5j5xIg9q5LBTaTLutD7TlN68mHtKc1iXPPNHS33OGNYyaY5mbTqjGkhf+
         kjL33BiyqBUMPnKaj2/QAvh9F27UHyasYN3g2ql2Vz1fVYbPyaxKRaWQ4wCTAw9/W/XG
         51s6y6FkgQtAzGzYBPYr00OboK9MTd/NZSaCv/dQgq3kcoQhssAumd47WL2deTPyy4fu
         7dYb41IQ5Y3oGOBJAdC2viYrzoZMcZp4+f+JntIggVRMhB309KpNEgZiRxHvDJupw6Hr
         T2QQ==
X-Gm-Message-State: ANoB5pl1MqJD/UfMXGbt8iQQHWQ9F8P63WT6kGjiBlTYO570g8ztlNzJ
        iHyP48y5eKUK64S9kt30Fwc=
X-Google-Smtp-Source: AA0mqf5bobEV7idrIfWAF3puiMHvXHwes6lSDep2bUEG0MxsOcJSRPbn6WpLKgj9Ih/p31j9JEkJcA==
X-Received: by 2002:a17:906:4756:b0:7b8:6a66:4b7c with SMTP id j22-20020a170906475600b007b86a664b7cmr37811689ejs.663.1669890657532;
        Thu, 01 Dec 2022 02:30:57 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b007c07b23a79bsm1592400eja.213.2022.12.01.02.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:30:57 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/7] dt-bindings: power: Add G12A NNA power domain
Date:   Thu,  1 Dec 2022 11:30:18 +0100
Message-Id: <20221201103026.53234-3-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add define for the NNA power domain for the NPU in the G12A.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/power/meson-g12a-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index bb5e67a842de..93b03bdd60b7 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -9,5 +9,6 @@
 
 #define PWRC_G12A_VPU_ID		0
 #define PWRC_G12A_ETH_ID		1
+#define PWRC_G12A_NNA_ID		2
 
 #endif
-- 
2.38.1

