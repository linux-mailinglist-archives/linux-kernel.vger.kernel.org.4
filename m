Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE36B8092
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjCMSai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCMSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6A521E4;
        Mon, 13 Mar 2023 11:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1637B6147B;
        Mon, 13 Mar 2023 18:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260A8C433D2;
        Mon, 13 Mar 2023 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732191;
        bh=aOxVBk6SUq0AKI+kzrDhXc/isUQsekLwZxFcNjw8eTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/DBZb1+wUdopjALL+oD6cOmayUJHOkCNX2dDoflulo8Ii2EhupwE9KxN9XTUAQ7E
         VERjBKBU34vsEmveqqsY4sOVHu8V8OJhnggiBf0YTbQIYXw6l/GlDn1tDqeSx0NtWM
         UdEf5z35pYIU2FcUzqkSj8wbq1gnp1L3/WjKRkXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 19/36] s390/smp: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:29:01 +0100
Message-Id: <20230313182918.1312597-19-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=gregkh@linuxfoundation.org; h=from:subject; bh=aOxVBk6SUq0AKI+kzrDhXc/isUQsekLwZxFcNjw8eTg=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82ZVst5NlJ+pYXlJZE1H9boH7gh09y/qXyVh+sE8w+ xn96/OZjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIZxzDgjkP5lspMOzkYa/8 Fel299iOdW9O/GdYcPrdLL0n1Y7rftybJPDsZkcWz+orhQA=
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

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/s390/kernel/smp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index d4888453bbf8..4df797ab8ca2 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1227,11 +1227,17 @@ static DEVICE_ATTR_WO(rescan);
 
 static int __init s390_smp_init(void)
 {
+	struct device *dev_root;
 	int cpu, rc = 0;
 
-	rc = device_create_file(cpu_subsys.dev_root, &dev_attr_rescan);
-	if (rc)
-		return rc;
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		rc = device_create_file(dev_root, &dev_attr_rescan);
+		put_device(dev_root);
+		if (rc)
+			return rc;
+	}
+
 	for_each_present_cpu(cpu) {
 		rc = smp_add_present_cpu(cpu);
 		if (rc)
-- 
2.39.2

