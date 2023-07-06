Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7674A4F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGFUeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:34:18 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052A1996;
        Thu,  6 Jul 2023 13:34:16 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso4163865ab.2;
        Thu, 06 Jul 2023 13:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688675656; x=1691267656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPLnrtb9vVYRhiX44rTIUzejdIjGYams6CY+6rwusFE=;
        b=EDvWbNt+ur6ETHu0KtxV5Y7xBn1zUgsm9GTbfnaP+ga6JWjLPaDa9QTV+pIbpG8bf3
         upyVfh3Mbq0PAYcg85L8CJaIiUGbnHCkCBbMdMyo7cNOhdU6v1DDxAgewC5m8bg1O3vT
         1jiZQ4F2PsnY5k3+m/JMHpkfUH6iE3eUh6b5dvvTa4S+P07M81ZLm2Lc5QmBaJMTrh1v
         30zT8ynt++atAJzQw3yhTeoHI0ulAD0SW9uET6O8x14rYntJbQjqeRRAhsjOFbdwyb2j
         kLXYBIRNO1DC2xMxjykqJejoXGSBYlknD5lvjV5YSEmeDvfMMJMapHAlJz814/jLLfYV
         xaFA==
X-Gm-Message-State: ABy/qLaNgK+9yjTzD8pTWv2JcNA+/XXz5jlXJeHDFMw83LJNAI2YfaS5
        xe9RCzhgKn/eZncxo3Gh0XWnMdr9Uw==
X-Google-Smtp-Source: APBJJlFT99xu0+S0IT1zbIlbNL4RCBUlPE08TQaLXsZvHplzGLsbw6d+wNUF3uJPY3O+LVmatqt4Dw==
X-Received: by 2002:a05:6e02:601:b0:345:8373:bf68 with SMTP id t1-20020a056e02060100b003458373bf68mr3115513ils.25.1688675656194;
        Thu, 06 Jul 2023 13:34:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p4-20020a92c604000000b003317ebbc426sm758048ilm.47.2023.07.06.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:34:15 -0700 (PDT)
Received: (nullmailer pid 281442 invoked by uid 1000);
        Thu, 06 Jul 2023 20:34:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: errata: Group all Cortex-A510 errata together
Date:   Thu,  6 Jul 2023 14:30:31 -0600
Message-Id: <20230706203030.276437-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 sections of Cortex-A510 errata. As the ordering within
vendors is in order by CPU/IP name, move the 2nd section up to the 1st
section of A510 errata.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that ordering is still not completely consistent with this change. 
We have A510 before A53, but A77 is before A710. 

 Documentation/arch/arm64/silicon-errata.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 496cdca5cb99..e3e4450c1c98 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -63,6 +63,14 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #1902691        | ARM64_ERRATUM_1902691       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2051678        | ARM64_ERRATUM_2051678       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2077057        | ARM64_ERRATUM_2077057       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2441009        | ARM64_ERRATUM_2441009       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
@@ -109,14 +117,6 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2051678        | ARM64_ERRATUM_2051678       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2077057        | ARM64_ERRATUM_2077057       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2441009        | ARM64_ERRATUM_2441009       |
-+----------------+-----------------+-----------------+-----------------------------+
-| ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
-+----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
-- 
2.40.1

