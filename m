Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCD67F81E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjA1Ng1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjA1Ng0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:36:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FB1C30D
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FE72B803F2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A9BC433EF;
        Sat, 28 Jan 2023 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674912982;
        bh=RvsXLt3jtOi+fa454bVDIfyl7OhqRvd7dFiGrnsbL88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV/K6ZyPDiJg1yvjjD69N06b3ko1lwcuHxYuiXMGknLOrx4L0rpdAr4QmEhj8GBPF
         P5avS8/vy9cl4xnTm3utMeFEKm5YUlScbzpMnGyIhXRcmNTOFlM9kiIKTtzGAHrERa
         o+OIA55VM3cEz5IoL9gv4UMmE3Bv7g1IF4n6Uu8BNzHLCZDjBLgO6GOXuwPiUj1Uo+
         vAh/pZ+u7/HW0Q0Viqo+KrnhZlSHJoZ/YT8htH8aUsWLSNX+wz+IQL002nlkRmLVib
         L0I5Njz/x+5S0XZ86UTFLxllh83kNgJ0JzkOtnRGrUUfB3a5x0ywlpSmzVPNpeIFYi
         CkElJW47Mqyvg==
Received: by pali.im (Postfix)
        id 1CEDC639; Sat, 28 Jan 2023 14:36:20 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc/pci: Enable PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT by default
Date:   Sat, 28 Jan 2023 14:34:58 +0100
Message-Id: <20230128133459.32123-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817163927.24453-1-pali@kernel.org>
References: <20220817163927.24453-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to enable CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT by default
(when possible by dependencies) to take advantages of all 256 PCI buses on
each PCI domain, like it is already on all other kernel architectures.

Fixes: 566356813082 ("powerpc/pci: Add config option for using all 256 PCI buses")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b8c4ac56bddc..fad25aa602c8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -392,6 +392,7 @@ config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 	depends on PPC32
 	depends on !PPC_PMAC && !PPC_CHRP
 	bool "Assign PCI bus numbers from zero individually for each PCI domain"
+	default y
 	help
 	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
 	  So system could have only 256 PCI buses independently of available
-- 
2.20.1

