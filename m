Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6917762FFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKRWWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiKRWVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:21:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7CEB7E80
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62911B82568
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2F7C433D6;
        Fri, 18 Nov 2022 22:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668810068;
        bh=E9ca8QoCrIeSP5fRU5kfdctSssLXX9ouXkKzqOBNjD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RifEh9b/d10HRwrBCx6g393UiIXtOcsAjsOlWfzmYu2iNwN2VuhW2aQqyWMhp0R1t
         ceKq7ZUUcKR/IzGWAGqh/VRoeEi1pTgpSDBi5fqY1iMGNZyHcNjqDfbWuHK8u38zOw
         VwAXmC4x9igXN/1CrbD9uc7A6CnVL9B/2Zly8E48NsfeiY+iNsvktPbaiLjnlhD16f
         rMSEYdSDvZmjaZW1+hywyW5kTwPLG+fj/SMd1c80lSS63qwCY4gFURKonF0EigCyJU
         8suUaTx9TrCQj2hxoUlbvbHRhjK1tScv0OalgK6XDQee3G6feAbwkwQyeQsjatNjLh
         dn+hUA/R1bdQQ==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] soc: microchip: mpfs: handle failed system service requests
Date:   Fri, 18 Nov 2022 22:20:43 +0000
Message-Id: <20221118222043.1214776-2-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118222043.1214776-1-conor@kernel.org>
References: <20221118222043.1214776-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

If a service request fails, a non-zero, per-service error code will be
set. Since the individual service drivers may wish to handle things
differently, there's little point trying to do anything intelligent in
the system controller driver. Let the caller know that things went wrong
& leave the details of handling the error to it.

Fixes: d0054a470c33 ("soc: add microchip polarfire soc system controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 6e20207b5756..539fc24b397d 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -52,6 +52,12 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 
 	mutex_unlock(&transaction_lock);
 
+	if (ret)
+		return ret;
+
+	if (msg->response->resp_status)
+		ret = -EIO;
+
 	return ret;
 }
 EXPORT_SYMBOL(mpfs_blocking_transaction);
-- 
2.37.2

