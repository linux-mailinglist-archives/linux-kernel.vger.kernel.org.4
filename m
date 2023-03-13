Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB936B80AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCMSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjCMSbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:31:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18E848CE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D422DB811DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449EDC433D2;
        Mon, 13 Mar 2023 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732219;
        bh=qGruADsKF1ycq4BqFQi55JPLcBS063gUsHShmvuxofc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVeSIl1uLbrNAG9OvhZVRP5TAC/Be5RiN4cO8MomaHofxtAPI9dr8zvuVEgaovoEZ
         J8KuO0BHfW3R5yOmE4r0ClORCCZUrjZtrbTxI1gDnyvZA3F6XNro0GF4mCCBLFxKFf
         tRbewAXlsh7winx7MpWIV+Phl1DgMYUK7BvK4V5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 10/36] x86/umwait: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:52 +0100
Message-Id: <20230313182918.1312597-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=gregkh@linuxfoundation.org; h=from:subject; bh=qGruADsKF1ycq4BqFQi55JPLcBS063gUsHShmvuxofc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82eWXbG2fTvW7oGJoJ8wVLXSwcOotXR3RhGzPFtbHb y39yio7YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCJnhRjmpwp27xM4ctFKr2Op HOf9lgcxE6SbGRZcqeG93/Lc/NnvjxkftL705Kx7UfIQAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/x86/kernel/cpu/umwait.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index ec8064c0ae03..2293efd6ffa6 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -232,7 +232,11 @@ static int __init umwait_init(void)
 	 * Add umwait control interface. Ignore failure, so at least the
 	 * default values are set up in case the machine manages to boot.
 	 */
-	dev = cpu_subsys.dev_root;
-	return sysfs_create_group(&dev->kobj, &umwait_attr_group);
+	dev = bus_get_dev_root(&cpu_subsys);
+	if (dev) {
+		ret = sysfs_create_group(&dev->kobj, &umwait_attr_group);
+		put_device(dev);
+	}
+	return ret;
 }
 device_initcall(umwait_init);
-- 
2.39.2

