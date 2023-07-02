Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18718745089
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGBTj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGBTjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581B1702;
        Sun,  2 Jul 2023 12:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E680660C7F;
        Sun,  2 Jul 2023 19:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6922EC433C8;
        Sun,  2 Jul 2023 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326719;
        bh=/Qqz4dUp4wsBntlOoQfXIpx5VavkXnEUbx5TRl/0dhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaB9k9uVT8e5wqaZSkAcnpvVO7Z8f+DHw1iQSS9MvMpm3l60X0+1AoPZ8y7nJr1UY
         leN6QooPkVKJkpo/4lzZDL2HqsflkO1/pm5Hgk3jnAKvoPk61TvH/JBQJCsigMiQoK
         LvekIACFo+PoKTYNVpfH6LIvPT4FPaDjOk6wFW84HxQKj/w6BN36WcqyMRIoOfZSVH
         Vvcyjxoo6VGYbbU4yRi54JREumGRAvtDQIb2QO4LTAb17QymrhzJSdQY7415/AVfmK
         0XxMuFYIBwzNsc7qOFu9I9dY2jcsGEX9TgNvWXbEzoLsLD/blDREYAH9JzguOoYXVd
         qqM2CAoTLbKLQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        gor@linux.ibm.com, viro@zeniv.linux.org.uk,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 09/16] s390/crash: use the correct type for memory allocation
Date:   Sun,  2 Jul 2023 15:38:08 -0400
Message-Id: <20230702193815.1775684-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit f471c6585c7f2f168b8eb2d19e2d6e5f22a6645f ]

get_elfcorehdr_size() returns a size_t, so there is no real point to
store it in a u32.

Turn 'alloc_size' into a size_t.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/0756118c9058338f3040edb91971d0bfd100027b.1686688212.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 8a617be28bb48..7af69948b290a 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -568,9 +568,9 @@ static size_t get_elfcorehdr_size(int mem_chunk_cnt)
 int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
 {
 	Elf64_Phdr *phdr_notes, *phdr_loads;
+	size_t alloc_size;
 	int mem_chunk_cnt;
 	void *ptr, *hdr;
-	u32 alloc_size;
 	u64 hdr_off;
 
 	/* If we are not in kdump or zfcp/nvme dump mode return */
-- 
2.39.2

