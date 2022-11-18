Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0726062FFC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKRWIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiKRWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:08:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3A5FAE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:08:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C99DCB82560
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 22:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61230C433D7;
        Fri, 18 Nov 2022 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668809304;
        bh=E9ca8QoCrIeSP5fRU5kfdctSssLXX9ouXkKzqOBNjD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmJDD/fw94wmDBhtRUGESqVnEtg2VtA92zVS22hNG2x5zrRKg12JdbzWzxmWB5Ett
         Yv/n+XyUdoOf1P1varf4f0awdReaA9XGTywBt8H1XPKafY+yrCu7QlWDr8NL4Q912F
         oDQBNacyKoxCYtK5bzrAFHg500CIlru4fLj/y8X8t7ppzKE2ny43FbGr4GUDZoA7CO
         +ibAqueuLJpX4V+r3GXdMOBw3apua5h1MYE4GZgOrPBYln8YMC5tTFliyLYxn2hgRA
         DPbHf0Yz70GNl6y77jTngZbXfmJf6PyZOnn4Ees4M+I9GzQtbFjKwAv/4byQ1wjZLT
         BZKDfYCttyuAA==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: microchip: mpfs: handle failed system service requests
Date:   Fri, 18 Nov 2022 22:07:58 +0000
Message-Id: <20221118220758.1101409-2-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118220758.1101409-1-conor@kernel.org>
References: <20221118220758.1101409-1-conor@kernel.org>
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

