Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEB7305A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjFNRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbjFNRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF8E41
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0282638A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92BAC433C9;
        Wed, 14 Jun 2023 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686762386;
        bh=QeH29Idc/6qrLsvNLxNicZ5LF/IoEKjciGzozuHn9t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2rZISm1K8SkX1xOX2TLo7PW3cS1O2+YAR3k8M/A7VHYIwyHqnIYBfZHgFZjoHAcU
         D6TI6td2vGW0/E3u69+d2Zu7PFJ2td8w0NweV8byRIQnpl3T+xRcHQDXzF+Eg/24Kl
         siFAuXe4IaioC/8Z1rh4+OBr2Q9k+zPGamRaR8KE5Q+3kXXjDS44jOvQ+tiTZhqZWo
         YGCtd0MSzQSzdydgVrdgOXvuAO+tZb1xla2qNqdK9DMFnKtUXfHygowqSgjC1PS/4z
         aq3kHPtbo8dEMetGxnDv5izg4t5+r2BOJCxxMQKppXEb7mN2OIBSCx71X/3FFRVeOi
         wbMRbsRj8hzTA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 1/3] riscv: errata: thead: only set cbom size & noncoherent during boot
Date:   Thu, 15 Jun 2023 00:55:02 +0800
Message-Id: <20230614165504.532-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614165504.532-1-jszhang@kernel.org>
References: <20230614165504.532-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CBOM size and whether the HW is noncoherent is known and
determined during booting and won't change after that.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/errata/thead/errata.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index c259dc925ec1..be84b14f0118 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -45,8 +45,11 @@ static bool errata_probe_cmo(unsigned int stage,
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return false;
 
-	riscv_cbom_block_size = L1_CACHE_BYTES;
-	riscv_noncoherent_supported();
+	if (stage == RISCV_ALTERNATIVES_BOOT) {
+		riscv_cbom_block_size = L1_CACHE_BYTES;
+		riscv_noncoherent_supported();
+	}
+
 	return true;
 }
 
-- 
2.40.1

