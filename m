Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149EC73ED45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFZVvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjFZVui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578342709;
        Mon, 26 Jun 2023 14:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F0960F7E;
        Mon, 26 Jun 2023 21:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFB1C433C8;
        Mon, 26 Jun 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816222;
        bh=OkSO7IKhJ5FBVBTfwIS93RRlPadpC+yJMd5i0eAyalI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQq+xz4eLDeVVvoI+qeQOsmUB7PbNCq+MCMvlBPnEqnmiDJAuHqu3SJkFbrYZLDtB
         4K8lVW3pTkGIgUDr91reL5q4JIEe8Z6wp2pVc+OrndIHsD2utUqAmeRL6q85oAtnB6
         y1luyuhpH3sNsnRnCKSxmBQ+BO4HEFipJmUGAA5/lvw5Ky1wyB9Ud2JU7UjqiA0ezA
         qcPhAW+X8U7ZrZALeTfpY5rUHsbG5vRgyHbylJiFRqk1Y1vlOF9jKctw6GShp/58J8
         T4MULl69JrCzneb9VBr3ePcXxRHmgDOt7tMsJtmksya6AEwZutXGXmvQ31euaHTbag
         Er6CzSTD3CFnQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qi Hu <huqi@loongson.cn>, Miao HAO <haomiao19@mails.ucas.ac.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        git@xen0n.name, zhangqing@loongson.cn, lienze@kylinos.cn,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 14/16] LoongArch: Fix the write_fcsr() macro
Date:   Mon, 26 Jun 2023 17:49:54 -0400
Message-Id: <20230626214956.178942-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626214956.178942-1-sashal@kernel.org>
References: <20230626214956.178942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
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

From: Qi Hu <huqi@loongson.cn>

[ Upstream commit 346dc929623cef70ff7832a4fa0ffd1b696e312a ]

The "write_fcsr()" macro uses wrong the positions for val and dest in
asm. Fix it!

Reported-by: Miao HAO <haomiao19@mails.ucas.ac.cn>
Signed-off-by: Qi Hu <huqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/loongarch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 83da5d29e2d17..f0d32112dafd9 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1491,7 +1491,7 @@ __BUILD_CSR_OP(tlbidx)
 #define write_fcsr(dest, val) \
 do {	\
 	__asm__ __volatile__(	\
-	"	movgr2fcsr	%0, "__stringify(dest)"	\n"	\
+	"	movgr2fcsr	"__stringify(dest)", %0	\n"	\
 	: : "r" (val));	\
 } while (0)
 
-- 
2.39.2

