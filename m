Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30E62E17B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiKQQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiKQQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55751B781
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1E0621A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D0C433D7;
        Thu, 17 Nov 2022 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702011;
        bh=2wErdCeNkaNdVedR35HXhehReifMfZjL5HunWURqqww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/iqHQwg8HhZNokac+QmuPk/zLNrD+A281k23LFtZfzsWMutPnllhqa2J2fI6EMbL
         L8u6zayvcnu4BNnyyPefGdBK1tkEj1vKfv6THbz6hGqnIY44e3MFqTwQMcpZWfIGbS
         wr0HPnd0IrwYhmlTz1tp3ijEOjHAS+/trVoFQCdkNdXq1WF4QNpgR/DtCczhfdCGat
         7kywp3GncQzjEtteZbVUeuo2zAlKD3FwhgOaEVODUqf6UMR4CDMDpVTqPeESygQuAj
         OtSVyB6uaROMzMDygU1npGQO8h2xUnsKU2wuWZSvSUa0PF2+T/3zAfV0Ke++yxrAuk
         mv0S4xKpwOjag==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 12/20] habanalabs/gaudi: fix print for firmware-alive event
Date:   Thu, 17 Nov 2022 18:19:43 +0200
Message-Id: <20221117161951.845454-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

Add missing le{32,64}_to_cpu conversions.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7b93f0d26dd0..9f5e208701ba 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7356,9 +7356,10 @@ static void gaudi_print_fw_alive_info(struct hl_device *hdev,
 {
 	dev_err(hdev->dev,
 		"FW alive report: severity=%s, process_id=%u, thread_id=%u, uptime=%llu seconds\n",
-		(fw_alive->severity == FW_ALIVE_SEVERITY_MINOR) ?
-		"Minor" : "Critical", fw_alive->process_id,
-		fw_alive->thread_id, fw_alive->uptime_seconds);
+		(fw_alive->severity == FW_ALIVE_SEVERITY_MINOR) ? "Minor" : "Critical",
+		le32_to_cpu(fw_alive->process_id),
+		le32_to_cpu(fw_alive->thread_id),
+		le64_to_cpu(fw_alive->uptime_seconds));
 }
 
 static void gaudi_print_nic_axi_irq_info(struct hl_device *hdev, u16 event_type,
-- 
2.25.1

