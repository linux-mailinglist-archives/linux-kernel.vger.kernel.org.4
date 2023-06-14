Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD4727C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjFHJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjFHJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:58:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809D026B2;
        Thu,  8 Jun 2023 02:58:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30e4eec95c8so406832f8f.3;
        Thu, 08 Jun 2023 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686218331; x=1688810331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlNe4BUkEg1VajwhQoFVrqBpA5/M9bmxOxMvTziERXM=;
        b=CHgGOkdMkON3E5JAKd2QN6ViPGseP5oGhADmE+HYpyeffAvoy6Muo/jJCSRgGv1I7d
         XyZOwJF11dqKYGhTmSyYFuGOciv9teDQmWdwXxKEgJjUX6MIuEHzNm+RcF/Yn4qTqFpb
         K4mt+7h24tWTOFP2nlbevHmvRaTvtdyrmp//Wi/2BDahsMSogZ1WwuL9ycF+8JKnFfbV
         x8PuB7Qt7lZDZ1a+kzC7B+ksdshKcYM2KF+rJjlln+Ela62lnJX441dmuUPd/tmdhRXy
         TmsqAWvc35OOnOL2XuPH9WTf3uDbxb8ol+5Hb47nPSG3KaV9CIW3ZwQlsvy+XMcIHYoX
         KFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218331; x=1688810331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlNe4BUkEg1VajwhQoFVrqBpA5/M9bmxOxMvTziERXM=;
        b=L8m/lILhXFuhoSohGAZP+mUKPInUPjvW+eGOZJtDLZXOPPld3gEbxpeQwGVxTBK8u2
         IJtneH/YhvhLT9ghx4F9Uscm9BMNN89fliySoSSMTonarN36e+zkW7qIS7Z7hFsDqSGL
         cY1ZLT+d4PYuc3QpKmDHGVmx9/DMfNIVRE/+ZHYv4c9jHVXkTdflXcHfvFwOHlM+IGB9
         soOuAgJ73Ll5uP2xB5b8MzY9/UblmVdJ4PbPJhDCGVHm6pEl0z3L4Yb4IEGRThs66KuY
         0OM1UuW7BbeimHUeUz8vXvFvuwM3L1PNAOo95wcskV0D11yH5lKR+Fp58Tm0cH+zcVLp
         WvLg==
X-Gm-Message-State: AC+VfDycQSo0R+5jFqqkiHeieODkUJuIe/XUGWpY9FnLMNGatX6tJcFm
        4Ms6S1w2hRuaOoAg7oTBR/M=
X-Google-Smtp-Source: ACHHUZ4bwjDbYedllIN1larsf4jSAU4BoOl6EnSlCIw2Dmt/YKIRFssvTbWtdQSg+qKIlIAdWC/90A==
X-Received: by 2002:adf:e78d:0:b0:309:1532:87e with SMTP id n13-20020adfe78d000000b003091532087emr10078608wrm.31.1686218330725;
        Thu, 08 Jun 2023 02:58:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a4-20020adffac4000000b00307c46f4f08sm1091924wrs.79.2023.06.08.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:58:50 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] powerpc/powernv/sriov: perform null check on iov before dereferencing iov
Date:   Thu,  8 Jun 2023 10:58:49 +0100
Message-Id: <20230608095849.1147969-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pointer iov is being dereferenced before the null check of iov
which can lead to null pointer dereference errors. Fix this by moving the
iov null check before the dereferencing.

Detected using cppcheck static analysis:
linux/arch/powerpc/platforms/powernv/pci-sriov.c:597:12: warning: Either
the condition '!iov' is redundant or there is possible null pointer
dereference: iov. [nullPointerRedundantCheck]
 num_vfs = iov->num_vfs;
           ^

Fixes: 052da31d45fc ("powerpc/powernv/sriov: De-indent setup and teardown")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-sriov.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 7195133b26bb..42e1f045199f 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -594,11 +594,10 @@ static void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	struct pnv_iov_data   *iov;
 
 	iov = pnv_iov_get(pdev);
-	num_vfs = iov->num_vfs;
-	base_pe = iov->vf_pe_arr[0].pe_number;
-
 	if (WARN_ON(!iov))
 		return;
+	num_vfs = iov->num_vfs;
+	base_pe = iov->vf_pe_arr[0].pe_number;
 
 	/* Release VF PEs */
 	pnv_ioda_release_vf_PE(pdev);
-- 
2.30.2

