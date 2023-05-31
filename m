Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3848971831E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbjEaNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbjEaNqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33321FF5;
        Wed, 31 May 2023 06:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11AD63B4E;
        Wed, 31 May 2023 13:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEABC4339B;
        Wed, 31 May 2023 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540626;
        bh=awNbbUrZKfXcgaKH6JhIK8hfjJtLZGaowOiSziy/Zt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ar4pY7unJHLUqcosybnLa5sNKYyDkm+3YwSzVSsR7EC3Uax/8YJSYnpXjfwQ40Y/M
         WK2T/fuzLFPY80dGSQRztJd/EWmvHHQrl3PsGmJVH1K7OuEdZRDfGtlHN6y9vWS8G6
         KeplUwPdjvu5OebWfrTVHT97YUp+Hx66ItfJ/3vVuXOMjt7bIf0xkkqLXtJGXrVaei
         6Yg3NfwI7QIQCpyZTcX5aUlejNCh4eTuQfyuSocTWw7eiL21Ki2H9HtAgZM4hfeALh
         sImN5/h+VucLipG4Ig5x8ym3awPGbryB3iIou0L51LwGRWvQQ+WkaWQ+97V9ozcy/n
         m9uwGor8I2g9w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, airlied@redhat.com,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 16/24] parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_memory()
Date:   Wed, 31 May 2023 09:43:12 -0400
Message-Id: <20230531134320.3384102-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
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

From: Helge Deller <deller@gmx.de>

[ Upstream commit d703797380c540bbeac03f104ebcfc364eaf47cc ]

Flush caches after changing gatt entries and calculate entry according
to SBA requirements.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/agp/parisc-agp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index d68d05d5d3838..514f9f287a781 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -90,6 +90,9 @@ parisc_agp_tlbflush(struct agp_memory *mem)
 {
 	struct _parisc_agp_info *info = &parisc_agp_info;
 
+	/* force fdc ops to be visible to IOMMU */
+	asm_io_sync();
+
 	writeq(info->gart_base | ilog2(info->gart_size), info->ioc_regs+IOC_PCOM);
 	readq(info->ioc_regs+IOC_PCOM);	/* flush */
 }
@@ -158,6 +161,7 @@ parisc_agp_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 			info->gatt[j] =
 				parisc_agp_mask_memory(agp_bridge,
 					paddr, type);
+			asm_io_fdc(&info->gatt[j]);
 		}
 	}
 
@@ -191,7 +195,16 @@ static unsigned long
 parisc_agp_mask_memory(struct agp_bridge_data *bridge, dma_addr_t addr,
 		       int type)
 {
-	return SBA_PDIR_VALID_BIT | addr;
+	unsigned ci;			/* coherent index */
+	dma_addr_t pa;
+
+	pa = addr & IOVP_MASK;
+	asm("lci 0(%1), %0" : "=r" (ci) : "r" (phys_to_virt(pa)));
+
+	pa |= (ci >> PAGE_SHIFT) & 0xff;/* move CI (8 bits) into lowest byte */
+	pa |= SBA_PDIR_VALID_BIT;	/* set "valid" bit */
+
+	return cpu_to_le64(pa);
 }
 
 static void
-- 
2.39.2

