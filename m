Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6D6E7840
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjDSLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjDSLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F513F8D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a5197f00e9so30403785ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902629; x=1684494629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCr/XD0oj4/oPWH13NzthrUuXXX/7UUm/KiUydqd3Cw=;
        b=aAPwq8SLoEojqf4NHO3Fq0Ic/0+QaSA4EA9zAFf3kHDUX2voaRramQ8jdGtKzVoPbx
         hLWXAYGn/it0j+rhFp9uZZ8mKg2OcYP8EQFbNmn4OdAxK5bYiLFwjMg5GpBppnG96Z/4
         pNSb46QlwFQuO/D8WH9DGcEuODlqBKQPMlFseu2hz+salHNUZ8p1Wy5D60h3JSb5edS1
         VFmN/9xzQeyAcRFhvLLY5YCg0Y4bhZYIQjTCfrdFsQC27BhhP5IURYfb9Jf+MTOY59ZN
         vfNaXPcls+Qfcukd38Dfzi82cAxdVPVUshQpCQMfJPVDkJzVDZZOyiOrDa0CxTekRJC/
         XS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902629; x=1684494629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCr/XD0oj4/oPWH13NzthrUuXXX/7UUm/KiUydqd3Cw=;
        b=GpH84uQvT+fH4rucGfJDxEc0QYbMSY5oqpWuXbsXWBxoXVj/VflwrSZS+A8qeUUDMO
         /FWGe3aWP2NaswdlsQUyi233xU3x+m0nxMkhJsqbFPdYsQmHGvHiFPGxDe3uWEAbFZq6
         fRITxvP6IldTtexKUdSFHcNjbGY2qHTgo1u7b5rRAYtgnn7d0U0b47kG/t15Lzg4+m+L
         kipeLufmk4dXoUZThbD8vBCvnmF0/OAkVhPPcEvIdaWSvpWjbL9+iTgeUd/NE8qpYLWC
         pppNQAmB3m/f+5St1rPlrswJjhMHtDGqTlw//I3RKlLyx3aovFD/zGPCwlodCGNphfpd
         tw2w==
X-Gm-Message-State: AAQBX9eKtspw2E+VLdWz+KTmSEEVMAUA+N/j0cx4pAT+6decVdiNU+5J
        3eWoq4JOlP5j9ZMCJHv0GMQazg==
X-Google-Smtp-Source: AKy350YvL1e3iKZvub4t9UQbFZ9Y8KdT0xLTr/OSwyPVoBE0WDLhmou6jM+HdDHR/Nje7IH58BiY8w==
X-Received: by 2002:a17:903:1c5:b0:19e:ecaf:c4b4 with SMTP id e5-20020a17090301c500b0019eecafc4b4mr6514342plh.4.1681902629140;
        Wed, 19 Apr 2023 04:10:29 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:28 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 13/21] DO_NOT_MERGE dt-bindings: add foobar vendor-prefix
Date:   Wed, 19 Apr 2023 04:11:03 -0700
Message-Id: <20230419111111.477118-14-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for an example SoC vendor whose designs include controllers
that implement CBQRI.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..426f4eef06eb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -470,6 +470,8 @@ patternProperties:
     description: Shenzhen Fly Young Technology Co.,LTD.
   "^fii,.*":
     description: Foxconn Industrial Internet
+  "^foobar,.*":
+    description: Foobar Systems
   "^firefly,.*":
     description: Firefly
   "^focaltech,.*":
-- 
2.34.1

