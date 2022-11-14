Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28BE627CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiKNLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiKNLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412B821E27
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E32FAB80E77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5DEC43145;
        Mon, 14 Nov 2022 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426270;
        bh=wui7Joclil/1Zhbm3X8SG6joq+UGvmdb9Y11/m4UBYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oDcoRSsaEpF5qFmILR9P2mJ5a8lkQVqMz+gUsBuNicjhyBffTPM5tdA/mPGhAiGic
         b5Wgy7NrKtO74lPiJPFz39XuitjuukIBpJcWmqcaBGCVEmSV9ucqUPWl6gUdl9BQXX
         a+Ju58arWUNE9xg75AuU4gCyovLx/ItgDUgsr1wBwfbwhZkJPO/4/TJI+qMf2UmfoR
         QlFdhFWt8ofWnNOWLzvO8u0t1IFU0YF853oowuhb98g1SDgmNnnzJ48rj2v1CL7+R8
         AWDAd2XOz2ooKCMSPSbZwiKQ8kngNUK18qlmx+FMIcPKRaS9JrURlWmTDeKaFml2Z4
         5lHZGRLILvEUA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/46] x86/xen, lto: Mark xen_vcpu_stolen() as __visible
Date:   Mon, 14 Nov 2022 12:43:13 +0100
Message-Id: <20221114114344.18650-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark xen_vcpu_stolen() as __visible.

Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: <xen-devel@lists.xenproject.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 152dd33bb223..006a04592c8f 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -145,7 +145,7 @@ void xen_get_runstate_snapshot(struct vcpu_runstate_info *res)
 }
 
 /* return true when a vcpu could run but has no real cpu to run on */
-bool xen_vcpu_stolen(int vcpu)
+__visible bool xen_vcpu_stolen(int vcpu)
 {
 	return per_cpu(xen_runstate, vcpu).state == RUNSTATE_runnable;
 }
-- 
2.38.1

