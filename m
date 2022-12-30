Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7077659702
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiL3JzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiL3JzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:55:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA571A809
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so18203005pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmk4xq5A3rzrlj2+ophiAaZi/UXmP/mo3GRVdbl+68c=;
        b=Py7rXdCdc1eVMHulbXcV8b2D30+WKztQa1e3UdcsdZbHvk8LLaAIAibEUYKPI2V7JR
         sG9B/ORoWEj4W0i0BeLlazoWnrqNYtYol0+LB0wlf65z6fXbH/v9gUFwCoPaiMWM+vxm
         Fyk0uZQqBNNuW9d6fMRIlZ04tBtlQ1LGbmbn6mrVurOhMxCNA3w0MoNr4sEYapB1XfjC
         eypkwVx6LMNFF18BygGQ9+S3WYsvtdHs5L5oU4vMYEQOg+9ouBSBeFJB2yElIUjUjD8X
         y+yTFUJI5X8k+JTQx/PaO0dak79rTD3RLA2uTYXySlr58FH4yLRNFNFnH0Pd7/piZcGn
         hcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmk4xq5A3rzrlj2+ophiAaZi/UXmP/mo3GRVdbl+68c=;
        b=hBx340XnZDWtye4G3gGe08yfSIoUsMgGYwF6Ju5jvqrdBDlCwnoaUAGWtoBQEIknzO
         UoFZ/JrOCUxHNk8Mo6wZqCuo3AuEtUpg8vhA4mjmzY/vUiwtMM8fmiq+ywpOrBzCd54f
         ZTAAQRa4IBQGuCpbLIitFsJ/Q3krjy+nkaJoyqHvpEUyDeheTOgFMkfmwYC+I4oFqtBY
         V2pjbj3BqO2ynivnjPi/ihO5yjzJF9QHZPtLFmWupvryf4nfnXmMNVGbXT7ZWqwyB7i5
         FwrE99KUHKhVVSkCDo9BOxDHZuORJwO2bVS7IXRI6pCyeoN9BovUb4z8Poftiztek5Gh
         goGQ==
X-Gm-Message-State: AFqh2krBPKRRVbRgfwvqgaWgW6oPk3QWVHYo09rICXnxIT05HhBbPu7C
        fIBBVjz2BPUTVChXKyKTKtdb7Q==
X-Google-Smtp-Source: AMrXdXtSRFfO2p1wbW3ViQzM9RIF7nl9dbVTX5rM/MOJJVKgQugKaChiS3aO1Z4gX+n1jZDeTh6hIQ==
X-Received: by 2002:a17:902:e34c:b0:185:441e:4cfa with SMTP id p12-20020a170902e34c00b00185441e4cfamr31132628plc.42.1672394112244;
        Fri, 30 Dec 2022 01:55:12 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm14487719plk.148.2022.12.30.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 01:55:11 -0800 (PST)
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
Subject: [PATCH v5 3/7] arm64/sysreg: Add CCSIDR2_EL1
Date:   Fri, 30 Dec 2022 18:54:48 +0900
Message-Id: <20221230095452.181764-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230095452.181764-1-akihiko.odaki@daynix.com>
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
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

