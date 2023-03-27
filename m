Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA26CACD4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjC0SQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjC0SQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:16:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DD03A81
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94BC5B818AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABABC4339B;
        Mon, 27 Mar 2023 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679940971;
        bh=zdL+k3/HodzdiDKsCUqJ/ncG7UqyOUXuharkX+zcLow=;
        h=From:To:Cc:Subject:Date:From;
        b=CvlUsE/ur0tboElKU6eL5mxsD6spgitv88oe/0jq9Kj2Rus+RyRoeHzd2dY5KValB
         YAtfBpPENsPYo6hyXSPyN9gqsNVG6x+aDoI67NJlBB5He3bP6irbz3rZcH7G72FSbF
         MuVLp77uf+hhqMXQTYUMI9EE2Va+g/0U2Srl4gVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/fsl: fix compiler warning in fsl_wakeup_sys_init()
Date:   Mon, 27 Mar 2023 20:16:06 +0200
Message-Id: <20230327181606.1424846-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=gregkh@linuxfoundation.org; h=from:subject; bh=zdL+k3/HodzdiDKsCUqJ/ncG7UqyOUXuharkX+zcLow=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmKd1PEzCpzpPdXvExbrvBGNNHU64CndspJde0le3miT yzd8sK+I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYyZQbDgml9rFfN3XKLl/Bc Unw3z4TruvLSiQwLtp/fVzNN0pfz85+QPf/TlV5UnFrzBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c93bd175414a ("powerpc/fsl: move to use bus_get_dev_root()")
changed to use bus_get_dev_root() but didn't consider that the function
can fail and return an uninitialized value of ret (hint, the function
can never fail, but the compiler doesn't know that.)

Fix this up by setting ret to -EINVAL just in case something really goes
wrong with the call to bus_get_dev_root().

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: c93bd175414a ("powerpc/fsl: move to use bus_get_dev_root()")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303280045.4oaaezcn-lkp@intel.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
index 147b5d8bb904..ce6c739c51e5 100644
--- a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
+++ b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
@@ -117,7 +117,7 @@ static struct device_attribute mpic_attributes = __ATTR(timer_wakeup, 0644,
 static int __init fsl_wakeup_sys_init(void)
 {
 	struct device *dev_root;
-	int ret;
+	int ret = -EINVAL;
 
 	fsl_wakeup = kzalloc(sizeof(struct fsl_mpic_timer_wakeup), GFP_KERNEL);
 	if (!fsl_wakeup)
-- 
2.40.0

