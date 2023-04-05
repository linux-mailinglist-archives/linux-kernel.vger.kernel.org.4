Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173E06D8831
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjDEU0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjDEU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:26:14 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05E94C31;
        Wed,  5 Apr 2023 13:26:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 39C12820ADB;
        Wed,  5 Apr 2023 20:26:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 716FB8213BD;
        Wed,  5 Apr 2023 20:26:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680726372; a=rsa-sha256;
        cv=none;
        b=euTqKO7VgGaow3fcWeYFMcm8F7hVlJk6q6nupsLDg8yg62hOZiMGxG1HZygAbItV51AolQ
        4SEYjf9RR2u3SqGpFiLmKMAJgYA8+Tr6pIm1V49FrkRNfKAbsGFDI6u3nmZMlc3nR/Hqlh
        +adPzsv/W8T9Bnri+v9mBNF6d25bCJUI5BpK9pPbgNOq2JDyxawastDS8gjE6JRoWXUPvP
        JiyrgeQPrQG0C+ya2//Md25n27ZOqDo/+oEs0gajW6alwOUHT7IT/A5+vZipssPV5/1lWt
        UgI7qQyzCRV0PsMv2NvbYxzXh1IXj53/vzPOnL7vy4/JGJPwibmnFcZn4K2vIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680726372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=FuyEMZvmAWDxMJFQh1LL8xxCYlmV+MwfQRYvShWdRo0=;
        b=oZz8Cr/owe3zo+VOtnY88WvoOAvbBpSmTK1zqzbrpHCo7OSfA9WBDoonmZHDC3bTzyW+vd
        XQCt+YUaMuoPSZJlj6wD300xQf5iYG+2/ttKUqlQAI5H8awQWAttqqQAHSFtFNICNbq5i4
        qbSWsigfFTZSalEVDbxMdsR78Vr+2cGo4qPUa/4NHK11Uz8uHnSMzAbknH4Bf0u8ZsLa+4
        0qj4Ui8CD4NYRURj5BN8naml6CehGw26QgxnekTNp3TWxB090zJXD1FpYJ6HD9kaUCMyb+
        dWTqmPw4DxnQayY3HmMEnfBgXFm7i3NnhAj6rlPuynoqhI+6MZIfDG9Mm+rJJw==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-pw7rc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=hussein@unixcat.org
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|hussein@unixcat.org
X-MailChannels-Auth-Id: dreamhost
X-Print-Abortive: 1f83be640e217771_1680726372967_2123184992
X-MC-Loop-Signature: 1680726372967:346014462
X-MC-Ingress-Time: 1680726372967
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.143 (trex/6.7.2);
        Wed, 05 Apr 2023 20:26:12 +0000
Received: from localhost (unknown [175.144.191.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hussein@unixcat.org)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4PsGNz4n7sz8n;
        Wed,  5 Apr 2023 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixcat.org;
        s=dreamhost; t=1680726372;
        bh=FuyEMZvmAWDxMJFQh1LL8xxCYlmV+MwfQRYvShWdRo0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=vanpv/ZSmY1TYV7CZE/rRq7QtFAxqcN7aY3VlWvzv5AMwkBQ7cr1eiO46L98sRxb9
         JAJU4O4q8Sah9l0CaPB/R35ul5u7q/5G20667vx8AYZfTBZj7i6ZPsLNgREgR7ZCB5
         SrH98su2JISRD4RIYqLwD7LSgAgVpj8WfQWWpJU0=
From:   Nur Hussein <hussein@unixcat.org>
To:     thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
        daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>
Subject: [PATCH] drm/tegra : Avoid potential integer overflow of 32 bit int
Date:   Thu,  6 Apr 2023 04:25:59 +0800
Message-Id: <20230405202559.2232430-1-hussein@unixcat.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra_sor_compute_config(), the 32-bit value mode->clock
is multiplied by 1000, and assigned to the u64 variable pclk.
We can avoid a potential 32-bit integer overflow by casting
mode->clock to u64 before we do the arithmetic and assignment.

Signed-off-by: Nur Hussein <hussein@unixcat.org>
---
 drivers/gpu/drm/tegra/sor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index cd25f409979c..8d910695775c 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1153,7 +1153,7 @@ static int tegra_sor_compute_config(struct tegra_sor *sor,
 				    struct drm_dp_link *link)
 {
 	const u64 f = 100000, link_rate = link->rate * 1000;
-	const u64 pclk = mode->clock * 1000;
+	const u64 pclk = (u64)mode->clock * 1000;
 	u64 input, output, watermark, num;
 	struct tegra_sor_params params;
 	u32 num_syms_per_line;
-- 
2.34.1

