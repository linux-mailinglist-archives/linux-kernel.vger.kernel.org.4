Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED70A73ED2A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFZVuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFZVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EDA10DA;
        Mon, 26 Jun 2023 14:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A18C60F7F;
        Mon, 26 Jun 2023 21:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBECC433C8;
        Mon, 26 Jun 2023 21:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816199;
        bh=7za3I3AAMC1MXB+6NLirqnu2IknXMW6JjTr9xOxreP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMdY9PJF7VfySQu5CHRdUTtZ2v+uhrzmFme3UWpc5qUvYcbpgaO8rjVBhgSIpKglm
         ho00BtkAxmV78iYevGUZV+4BMPXQHwcbbGM4s+votkvaoH/PFd1qkkTF6QiHPrRaVp
         GFOIgtH3xxMzge9BakMh4/Ss3hVGc9fNWDvx4ay5xisylq76dBf375NmMPD+JWmcqu
         6vzKJvAvo/q5hiv2gjEcJIguwq1jWqISa4gd6dQLsnoe05Q2x+2bnIUX3KTcTfqamt
         qvgf/qvqVtn62uwpDPvyuSpqK8NxvIewyMQnSFBX4jvsOKYYY8Af1fwfm4gRYch7bM
         NOZCKLVc6/UlA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Mastykin <dmastykin@astralinux.ru>,
        Paul Moore <paul@paul-moore.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 03/16] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date:   Mon, 26 Jun 2023 17:49:43 -0400
Message-Id: <20230626214956.178942-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626214956.178942-1-sashal@kernel.org>
References: <20230626214956.178942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Mastykin <dmastykin@astralinux.ru>

[ Upstream commit b403643d154d15176b060b82f7fc605210033edd ]

There is a shift wrapping bug in this code on 32-bit architectures.
NETLBL_CATMAP_MAPTYPE is u64, bitmap is unsigned long.
Every second 32-bit word of catmap becomes corrupted.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlabel/netlabel_kapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 54c0830039470..27511c90a26f4 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -857,7 +857,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
-- 
2.39.2

