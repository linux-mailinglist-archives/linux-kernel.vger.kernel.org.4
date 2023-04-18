Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C9F6E6E94
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjDRVsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDRVsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:48:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257CAD13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:47:50 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id otAtpDm3iuZFDotAtp5a56; Tue, 18 Apr 2023 23:47:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681854468;
        bh=cZSjVGZIUlYLIpCjOhOc0/Sg4X8Jz8GjKGH9/AcwNB8=;
        h=From:To:Cc:Subject:Date;
        b=Q6sEsKrhFoWuQ2stk0aG1FI8wza6+Ha+g2auGJtsu7dzre1BbLJ1BwVUEsdiO3oy8
         hkFnkBWD81hqEJSpcCf/Y3FELHW2dvuqNhnVLBXIJhGCPv1tNlPHMLFh/4Oq7n5oDE
         9Qou5ArgKmLeqQEbtYU4G2HEZLKNBL2GWvX8TjEQeUkcpHgiHOzRVj5ldEWdQUMjM6
         yBVUKNq/3KNbqsbG2n0sayi81o6SuZ+XjpaYKr4yiyrUgA5sFgS3ZogzycHVDT2TpO
         MSqgqgujgmvJ5yGgz9f4CS6HMJRxRg2z6gtQvBnEkLiOfyjiQdFItvFhgOs+U4O/18
         iF95AxOOP6wgA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Apr 2023 23:47:48 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH 1/2] KVM: arm64: Slightly optimize flush_context()
Date:   Tue, 18 Apr 2023 23:47:37 +0200
Message-Id: <97bf2743f3a302b3066aced02218b9da60690dd3.1681854412.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_zero() is faster than bitmap_clear(), so use it to save a few
cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/arm64/kvm/vmid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index 08978d0672e7..bbf0677cfefa 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -47,7 +47,7 @@ static void flush_context(void)
 	int cpu;
 	u64 vmid;
 
-	bitmap_clear(vmid_map, 0, NUM_USER_VMIDS);
+	bitmap_zero(vmid_map, NUM_USER_VMIDS);
 
 	for_each_possible_cpu(cpu) {
 		vmid = atomic64_xchg_relaxed(&per_cpu(active_vmids, cpu), 0);
-- 
2.34.1

