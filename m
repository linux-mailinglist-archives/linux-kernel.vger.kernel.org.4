Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82096F876E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEERUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjEERUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:20:08 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D45B13851
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:20:04 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6a604259983so1545545a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307203; x=1685899203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Qa9OZAQgfgrF0AORp9COWiiNHbXv3g/2zjtQ3FLsEs=;
        b=efbCnRGl6AtQ+Gi10CP0Ds2yqQSke7IbKkT1LzNx2CeC3aEwVz98HeCToLaSvh7mRM
         l9keH8/jOHBVQnxzgPuoBWsDD1dSLB07OvwH/o0J3C+UD+hVcYvavYv6G+2rPhj7ltkf
         bI0s4ehYJupfVmWp5WIjK/osSC7CbOBBwp5a19Jvd0hOiX6YyLYuecFrjjKfFtebsHns
         OMZN+jgeUIqez4czTxC40aSSpmDXjAgpKu416Zrze66dMKxQeGUyrjba0PBhF/zB9EX6
         3K/qmp1R8yB+HMK3WBRnIdMsWNCfNPmSL2BoNr4ZNsbNJ/FAEVQ7C1DBaKsVMYHL22yy
         p0kg==
X-Gm-Message-State: AC+VfDxjk33ZCjUODAQmZ6CMRWe8rgCKT3H1xziWM73tUlqAHOg3bcGj
        0Ymgng7KZEl8I38brigWZg==
X-Google-Smtp-Source: ACHHUZ5pvS/Z3eL7BWB4DTJuNRmLTdwPq58YMXwTrxcSm1Eyh05yc4HP4ULsyM94dkn9IPv5BmWjag==
X-Received: by 2002:a05:6808:5d9:b0:390:7f21:5dd6 with SMTP id d25-20020a05680805d900b003907f215dd6mr898107oij.32.1683307203565;
        Fri, 05 May 2023 10:20:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b5-20020aca2205000000b0038c06ae307asm2904706oic.52.2023.05.05.10.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:20:02 -0700 (PDT)
Received: (nullmailer pid 3178151 invoked by uid 1000);
        Fri, 05 May 2023 17:20:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is not present
Date:   Fri,  5 May 2023 12:18:17 -0500
Message-Id: <20230505171816.3175865-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e4ab08be5b49 ("powerpc/isa-bridge: Remove open coded "ranges"
parsing") broke PASemi Nemo board booting. The issue is the ISA I/O
range was not getting mapped as the logic to handle no "ranges" was
inverted. If phb_io_base_phys is non-zero, then the ISA range defaults
to the first 64K of the PCI I/O space. phb_io_base_phys should only be 0
when looking for a non-PCI ISA region.

Fixes: e4ab08be5b49 ("powerpc/isa-bridge: Remove open coded "ranges" parsing")
Link: https://lore.kernel.org/all/301595ad-0edf-2113-b55f-f5b8051ed24c@xenosoft.de/
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Untested, but I think this should fix the issue.

 arch/powerpc/kernel/isa-bridge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 85bdd7d3652f..48e0eaf1ad61 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -93,11 +93,12 @@ static int process_ISA_OF_ranges(struct device_node *isa_node,
 	}
 
 inval_range:
-	if (!phb_io_base_phys) {
+	if (phb_io_base_phys) {
 		pr_err("no ISA IO ranges or unexpected isa range, mapping 64k\n");
 		remap_isa_base(phb_io_base_phys, 0x10000);
+		return 0;
 	}
-	return 0;
+	return -EINVAL;
 }
 
 
-- 
2.39.2

