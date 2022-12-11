Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21506649271
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 06:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLKFRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 00:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLKFRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 00:17:30 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7513E3F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:17:29 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w26so463322pfj.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5kiwn5okie3cYkwLwnJvTGi40F+wMTuMjX2LuHOS+A=;
        b=WM+yFLRXJy6JnBZbZOpn5+t8atNOLnueKar48v96qp2NwU/8Ik1wwnuxmytttty2z9
         ITUmFGcOh29D6O6PlCO0PlhB2szHk7iTkSdA0gLqBptODhfUF520Gbgw7MZBVwLwLiTw
         0CSCnOHilk+hhVw4IuvHirujaQAZXrBuPE4ZmouZYqe2dHTtICsf6+0xz/CW8OWjOcpj
         JOCFkmrSinl+xQUfrSMRl/7MyercuXij7RIG389zwGUekxyDAo63H1HbdgfXDq4JFyI8
         2HRfGSO+Go17DonBkq5ok61YEIAdu2j4o7pvrlOMtTlhWZV7F0tGbfILJBgZ/rE6SGs2
         p8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5kiwn5okie3cYkwLwnJvTGi40F+wMTuMjX2LuHOS+A=;
        b=cBSBT0KbJgGS/k1xAE5K93uhgkrcPHUDwiMNJiWicSV5VMB74/v3aHJR4WCqnEmbwg
         LBvmoY2nC0aAaqxe5zqrZyEDneSkyf1YS4uDNNGVUlb+tzi5VVbhXEuQZVFmgio9xw17
         Zp7+tobsXbrAgb9r37Yul9Tvng6JHnSzPfsmPWuO1ens3bR3lcTyQfDFT+h0jPX5se+j
         icJP/gSFvjsBRXGm3ab+HwnfUYhWI4lDsZUekDgzg9ifvZaZid5tsU5fFpNUVSrfB5mi
         l+e9mF1OMzIOBP5RdJ0NJXnrbPLQrA5il2iQWmTwdHMdlpqRXmzstxMn/7AOg/30DgCk
         xC9Q==
X-Gm-Message-State: ANoB5pnvAjeCuopsKZKTqS+BrUavOCNKePilughZPMRqUot4OMRPp2/O
        uh4fsv8F/sMgRRZ5bfgEkSSDjQ==
X-Google-Smtp-Source: AA0mqf4MODz3PRgxNZCX+N8VP2CyAydeEtYzkGUUPBV3KsYk9uUNpuHV9OrohMyN3dXkAHtnQP7GRQ==
X-Received: by 2002:a05:6a00:1c81:b0:577:8bae:29a7 with SMTP id y1-20020a056a001c8100b005778bae29a7mr10830364pfw.33.1670735849244;
        Sat, 10 Dec 2022 21:17:29 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id f125-20020a623883000000b00575d90636dcsm3463684pfa.6.2022.12.10.21.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 21:17:28 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH 1/3] arm64/sysreg: Add CCSIDR2_EL1
Date:   Sun, 11 Dec 2022 14:16:58 +0900
Message-Id: <20221211051700.275761-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211051700.275761-1-akihiko.odaki@daynix.com>
References: <20221211051700.275761-1-akihiko.odaki@daynix.com>
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

CCSIDR2_EL1 was added with FEAT_CCIDX.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/tools/sysreg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 384757a7eda9..0fb08c53fcdb 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -887,6 +887,11 @@ Field	5:3	Ctype2
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

