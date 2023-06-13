Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D315272ECEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjFMUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFMUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:30:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FE1E6C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:30:33 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 9AerqraEQonlZ9Aerq7ZeS; Tue, 13 Jun 2023 22:30:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686688231;
        bh=gWx9lNWZs+VxigmD+IrP8JxF8ho5EBghnkwdwYGkl54=;
        h=From:To:Cc:Subject:Date;
        b=UC+22lxX0DOrviCCQcjxhM7OOu7QPNPXEZWdw363cJ/ooNvnlqq4QRmir2o8DCaM9
         d1H6AhbBRhZN0inpeqmFy+E8zMrUwDwKm2BagID2B0fTywz9jOlhB0HzJ75RMh6gx2
         LBs1ezgO25PKQzyo31mtp0wqGdbiaNQxKmwn1A3us4E6ZV2V7B2QiAYkSKyhMpABV6
         ijQfljeLEOmI7ZM4AGYeeKYN5PD65eLjjY/CAbAuq5Bn/ySPftmZQwjrGDFlS8gFbL
         Nt/oLacGbpS6l6rNV+mSFV/8q0Y3n37XAd1U04unVn2mul/37yJxjVqF+mpRtF5ezH
         V140+EjLYbtNg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Jun 2023 22:30:31 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/crash: Use the correct type for memory allocation
Date:   Tue, 13 Jun 2023 22:30:28 +0200
Message-Id: <0756118c9058338f3040edb91971d0bfd100027b.1686688212.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_elfcorehdr_size() returns a size_t, so there is no real point to
store it in a u32.

Turn 'alloc_size' into a size_t.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure if 'alloc_size' can overflow in real life application, but using
the correct type looks harmless.

Should it be a real fix, either:
Fixes: 8cce437fbb5c ("s390/kdump: Fix elfcorehdr size calculation")
or
Fixes: 60a0c68df263 ("[S390] kdump backend code")
---
 arch/s390/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 8a617be28bb4..7af69948b290 100644
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
2.34.1

