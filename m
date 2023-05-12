Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB6700AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbjELO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbjELO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A518DC58
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A6A86576E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF583C4339B;
        Fri, 12 May 2023 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683903495;
        bh=OlUUIHh8F/ikEn4ruOXdEkA3wElniYzLmKIr7MhQ0Hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcLbHLWxqI2bumvNceUzMAPv+C0Y746k1Jp/7tXA1GgJqday/8MB/23BL0VcKD2EF
         l7sOoE8BAouxMF63X6G55suALJoO0H7hzI5XVSs9OXLwTPoBkriEnruif/KXQ3aW+/
         SFMo23v3zgADZZc+8aPweKC+kX6VdWxTcQh0IOUvIyRD43+WepPIyPmdzGCt6wUJWx
         R49ozGhEMEXMJZEifDbl4mVjzatCqLEVcObGNbLsH/wJ2aox1/STvfILMriazGRm51
         mnOGBU56o6Scmd5rVB7pPYs1z+zlGd1OdAwUcUAL4VkEWtJlONEsexD186+SZnZ1pr
         dXjChETIBrCjA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 6/7] virtio-mem: Enable virtio-mem for RISC-V
Date:   Fri, 12 May 2023 16:57:36 +0200
Message-Id: <20230512145737.985671-7-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512145737.985671-1-bjorn@kernel.org>
References: <20230512145737.985671-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Björn Töpel <bjorn@rivosinc.com>

Now that RISC-V has memory hot add/remove support, virtio-mem can be
used on the platform.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 0a53a61231c2..358e79ece169 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -117,7 +117,7 @@ config VIRTIO_BALLOON
 
 config VIRTIO_MEM
 	tristate "Virtio mem driver"
-	depends on X86_64 || ARM64
+	depends on X86_64 || ARM64 || RISCV
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
-- 
2.39.2

