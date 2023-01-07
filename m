Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEF660D58
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAGJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjAGJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:46:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA67D1C2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:46:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id dw9so2458251pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiIDHLmR6Z3DLA7ZmBUtEJMzeUne5nEPIKyDcmHBzVw=;
        b=yJu2zPLq+s3FH5mEbGHQnaCOt/fA1bkJ9uAuTdCgzCGYTMFL+vOE4qNDxb8QaYyqTT
         SmSc46YwBbIloQzijwBeh/41wdk9+x746aDufVmzZgqNxrXtG5ex4N37BM6umBV1A01X
         YNHNAMgbrMalLioaSGoV6M7TWVlAUjJ/FlPCJ1kndfbS4VpAEi/5RS9tXJvApoOLWpIM
         GWFqJxy+Ol7XHPIbWNO5RZydcFUH2Ur6+4RJPELKzDnoKNjVXYaAdJqdBJ7WDysSbxN2
         Ysl+pE29yF5jM8zHPA9XPrevwOOh5Dh/068nECqwqSvwROBS+8X0Z0lsEgYI3X85o3KE
         vnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiIDHLmR6Z3DLA7ZmBUtEJMzeUne5nEPIKyDcmHBzVw=;
        b=GlSkoJjnGT/AofpqU7e6Sw1eXQGFjKWj7NoFS2VXZKmrnWUNTpumuwOCSkGZDmYVA1
         PcUspbstQEjKL8XqyDVuTDPBFafX+BIO9yKx+CWgE0oaJelj1KKVGM/9yrqRciSB9TKU
         5vLnCM4EDVSB115YZyLlO82wibyXRrWSy6JE0r34I6Q3FF2J2JHgYPAJeVNeBJY5hNQu
         sMDLQwccU+3ORQg8zCADYNk+7vFR9IuQDQ4XqRIFT+n4hSt1leMbbvSa31+ID8GgUJbn
         /Hyyf2Mt/Hfez1hkfljI+2heFvRAGR2qKows8VXjq5No2npTbfI9nYDFK+HS6uTqtNdo
         srDg==
X-Gm-Message-State: AFqh2kphnedYcRfChMHhzf2CbSgJus+1uM/Wj7NbzN7+KkJh6RXy9xl7
        S6yahrcpBHO2ImTsH2lZtQvLXA==
X-Google-Smtp-Source: AMrXdXtmYw6MgSdZBfTMXKijPPEzf8bJIA2VpXjIRChc0KKR72/kDm2z6Pxza0jgOTVy14a/H48EyA==
X-Received: by 2002:a17:903:181:b0:191:1b93:e391 with SMTP id z1-20020a170903018100b001911b93e391mr79420228plg.63.1673084811969;
        Sat, 07 Jan 2023 01:46:51 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm2263449plc.291.2023.01.07.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 01:46:51 -0800 (PST)
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
Subject: [PATCH v6 3/7] arm64/sysreg: Add CCSIDR2_EL1
Date:   Sat,  7 Jan 2023 18:46:25 +0900
Message-Id: <20230107094629.181236-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107094629.181236-1-akihiko.odaki@daynix.com>
References: <20230107094629.181236-1-akihiko.odaki@daynix.com>
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
index 45648fa89be8..90b64697345f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1663,6 +1663,11 @@ Field	5:3	Ctype2
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

