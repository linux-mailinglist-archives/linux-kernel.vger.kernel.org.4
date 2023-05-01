Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFCC6F2CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjEADGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjEADED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4031A2716;
        Sun, 30 Apr 2023 20:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 881D56171B;
        Mon,  1 May 2023 02:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E01C433D2;
        Mon,  1 May 2023 02:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909982;
        bh=UBsBkhAPZ9nSOpcSBYNwAdW4r95T9kwn6DQOckGw4UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/W6ZGO8XhwE+syk3tIk/zl8RgIxTIQyBVlLWSX5eGmlLu0BRE9BHWA2rZ03QJzsJ
         eQ4iTqS291f1VbzWENHc3r4eOoBJgmsr4CC7+F/lce64Rb24rhgWSYTih/LWdouYTE
         Z9VcwF33HpH8FfIZZqGwDGTgiY2Y3ysW+IX+vRS9GnbO9w5QUHsDzY9hJ+VmQe2413
         3SMGRO69oN17QRo4iul9mX7kGSuXRUtfwrOa/oiiA6Z7RraPNNcU8P9dfdrfY8xc/I
         ROso8Lri3Q6pmUTjqBisKF4j9YpnYdDeJxmG8NB8HhoI0q6Iq5Rn7GNuATs5F9TGUt
         SlCPe1fO18EXA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Feng Jiang <jiangfeng@kylinos.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, Shyam-sundar.S-k@amd.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 43/44] platform/x86/amd: pmc: Fix memory leak in amd_pmc_stb_debugfs_open_v2()
Date:   Sun, 30 Apr 2023 22:56:31 -0400
Message-Id: <20230501025632.3253067-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Jiang <jiangfeng@kylinos.cn>

[ Upstream commit f6e7ac4c35a28aef0be93b32c533ae678ad0b9e7 ]

Function amd_pmc_stb_debugfs_open_v2() may be called when the STB
debug mechanism enabled.

When amd_pmc_send_cmd() fails, the 'buf' needs to be released.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Link: https://lore.kernel.org/r/20230412093734.1126410-1-jiangfeng@kylinos.cn
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 2edaae04a6912..91d04e710486e 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -268,6 +268,7 @@ static int amd_pmc_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
 	dev->msg_port = 0;
 	if (ret) {
 		dev_err(dev->dev, "error: S2D_NUM_SAMPLES not supported : %d\n", ret);
+		kfree(buf);
 		return ret;
 	}
 
-- 
2.39.2

