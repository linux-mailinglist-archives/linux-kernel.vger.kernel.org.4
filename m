Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E96537A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiLUUkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiLUUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:40:38 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248825E92
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:40:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 21so11518671pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmk4xq5A3rzrlj2+ophiAaZi/UXmP/mo3GRVdbl+68c=;
        b=rBZZZQ+6jmJ0L8kt2AAAyWKDYURGWgg2jYIvzhfsZvZvEtJZOEgaefc6924ldak9C4
         bGIi/87uhR4CkdUNv1Y9HrDcs8qRvip5lwN+kTe6HxiJSTKRPaovQ74xU513HQJ7wu7o
         DlowDD5mS9cCTp4yxhmu5/vCAZTJNw43eJjxbHD4DLmXp9oZYLJNY0QVLUcO2DHQ6uWv
         wHqRsl/XD2RLPWzKnNegucX6kUSMsfIQ67qE4GDKweu2IX1UQY2CSR53j7q6XnjAloNt
         3exq48ddIwSK7doMeHFKrwOlWhTnOgAD5nuGqynto1ETtEPVFhDmV/oIeKa3IBb91CIG
         eyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmk4xq5A3rzrlj2+ophiAaZi/UXmP/mo3GRVdbl+68c=;
        b=pDIcsP4V/CDIA/UGh/8e80fndLZ+3oXRsCvlzlVDvQdwVuVg0Bimd+zF4gZ41+zFIA
         acOsNvY7NLO9D9sO8giLyZ9ZZphzOAJ4R4tjdUPlrR1xm2gGGrzBJZ/N60DMOzB0AxcP
         NNMXJbTGEPnMSlUZOI1yyCv/b5lo4YhFPtUrQVYunGnlTuTMuRqE7pbqx/hTqs4YmQdL
         2CoKqdN6UDV2w/3kbmYvbbSCoWH9QdO7qCvhxhtmo1uA63eSe8reNgjXAJ+byw4l/toR
         Q6s85ZpkS9bLWG8eQdtGMTn2EI7t8aqdnWCCFu47V+QodOb29YqjoEL9PEkToIqu5Lcl
         h3Iw==
X-Gm-Message-State: AFqh2kqrA08ASRkhxV2Zk+q2Z7h+vel7li87u4RriuoXnPHy8wJ3/0r1
        10ky1YN4HZ2t1ZLaNWIQ86IZ7g==
X-Google-Smtp-Source: AMrXdXsax/iqZklqdXP5/90X5ExMF635ed0bL4vX13zR5gG19L2ERgmig6NZK0frHLvyHdzzrJLAXA==
X-Received: by 2002:aa7:9514:0:b0:57f:1da7:a781 with SMTP id b20-20020aa79514000000b0057f1da7a781mr3809463pfp.25.1671655237614;
        Wed, 21 Dec 2022 12:40:37 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id r4-20020aa79884000000b005763c22ea07sm11017784pfl.74.2022.12.21.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:40:37 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 3/7] arm64/sysreg: Add CCSIDR2_EL1
Date:   Thu, 22 Dec 2022 05:40:12 +0900
Message-Id: <20221221204016.658874-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221204016.658874-1-akihiko.odaki@daynix.com>
References: <20221221204016.658874-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCSIDR2_EL1 is available if FEAT_CCIDX is implemented as per
DDI0487I.a.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 097d6faafc87..01d592cbc0ba 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -899,6 +899,11 @@ Field	5:3	Ctype2
 Field	2:0	Ctype1
 EndSysreg
 
+Sysreg	CCSIDR2_EL1	3	1	0	0	2
+Res0	63:24
+Field	23:0	NumSets
+EndSysreg
+
 Sysreg	GMID_EL1	3	1	0	0	4
 Res0	63:4
 Field	3:0	BS
-- 
2.38.1

