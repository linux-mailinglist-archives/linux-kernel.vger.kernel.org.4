Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4B55BBDA3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIRLhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIRLha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8FEE1D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E503614B1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475CDC433D6;
        Sun, 18 Sep 2022 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663501049;
        bh=OMEph7KJGxnN58uqgZzaTAYbBc/YjxMWmh8tPUqvdDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4skBAFZSjBRoEoAjgNPj0dEtVaKMCK/Vgp/mCJsmS/hQlsyF7M7N7ohBimhzG2u0
         R5OPNGqzGwZOOibm1FMlZKzjeWUEOuMs/WZTH4SAo21BTdzqqhb4ZJc5xi5Q1Oc4Ss
         6zUI3vM7jbaBLk6R+yBUVdAqEHhaHT7XAMrZXW53taeBJUt9kKOVMxPK5xGSOkW/yc
         jTptOat41Kn7ci/SmdSnuAw4it7Wjxx4stSn3AEJ275hFNTjl/lI1Jm1YJ6AxvfyqV
         hC3jNxAPBoCsURhFBYrQnt4m6hVXYwjpkUbSMD6yW9qXV6GSWPcQ/Rj6MQ3Ij+cUxR
         dfL9WwyD57zqQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 6/7] habanalabs/gaudi2: add handling to pmmu events in eqe handler
Date:   Sun, 18 Sep 2022 14:37:16 +0300
Message-Id: <20220918113717.2637094-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220918113717.2637094-1-ogabbay@kernel.org>
References: <20220918113717.2637094-1-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

In order to get the error cause and the captured address in case of
page fault, added pmmu events to eqe handler.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index b95eab4c237c..b8b8b2dc2095 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8756,6 +8756,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 	case GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM ... GAUDI2_EVENT_HMMU12_SECURITY_ERROR:
 	case GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_12_AXI_ERR_RSP:
+	case GAUDI2_EVENT_PMMU0_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_PMMU0_SECURITY_ERROR:
 	case GAUDI2_EVENT_PMMU_AXI_ERR_RSP_0:
 		gaudi2_handle_mmu_spi_sei_err(hdev, event_type);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-- 
2.25.1

