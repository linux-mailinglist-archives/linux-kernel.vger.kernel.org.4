Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77B467359F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjASKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjASKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:34:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCC26F304
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:33:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D6B76150F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24681C433EF;
        Thu, 19 Jan 2023 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124438;
        bh=VqgceJg75Hacd1k69apbQvo1gXeAWKTPqakfnHa58KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItY3oZXV1fkeUCjnACwJ36ICVtJZnKZbf6zaYjXAilBBcG3XZFGK57g1tKLpV9iSQ
         FfrFQzIMY8LJ5BVASv4kHgfN6C+YoeQHoSwSQ/555AwFLLANFg97OEdJdNVJMnFePU
         d7S76gAX7NPsHaXMFyNxJQsaDa53gpnqLf1CASm4k9PcFE+mLjyKudHBSEtXID0NkE
         /KMd0c1qli4N8FgWapb9f0RYIQ8VE+gT/lUEyLIGiOvzOfIgXlAyBjyUcwSADFREdA
         4x1otMWjOpbNH7kQXyOfh4rILUULOH35uMe2P2W9sSi2dXyiFw3xdLpw4OHIejfB2R
         D3TcAotXt0PBA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 10/10] habanalabs/gaudi2: unsecure tpc kernel_config registers
Date:   Thu, 19 Jan 2023 12:33:39 +0200
Message-Id: <20230119103339.718430-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119103339.718430-1-ogabbay@kernel.org>
References: <20230119103339.718430-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

This is required in order to allow the kernel to control relevant
configuration space via load and store instructions.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2_security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
index b2b528788e39..a212f82e6604 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
@@ -1561,6 +1561,7 @@ static const u32 gaudi2_pb_dcr0_tpc0_unsecured_regs[] = {
 	mmDCORE0_TPC0_CFG_LUT_FUNC128_BASE_ADDR_HI,
 	mmDCORE0_TPC0_CFG_LUT_FUNC256_BASE_ADDR_LO,
 	mmDCORE0_TPC0_CFG_LUT_FUNC256_BASE_ADDR_HI,
+	mmDCORE0_TPC0_CFG_KERNEL_KERNEL_CONFIG,
 	mmDCORE0_TPC0_CFG_KERNEL_SRF_0,
 	mmDCORE0_TPC0_CFG_KERNEL_SRF_1,
 	mmDCORE0_TPC0_CFG_KERNEL_SRF_2,
-- 
2.25.1

