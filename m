Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B58A6C354B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjCUPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjCUPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:14:33 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 497A11C5A7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=a7ZVP
        /FLuYuClNR6fMgfk7qkk35oVO5BdkRdx0+jTpQ=; b=opxLq1udYwAbmGFUnqAtZ
        DInRpIqBHSgwTOmZSacS+T6walQ5WJbcPq5urX8Pq9iToKEVGmwNBcPt1zCBtFHI
        coqW319DD7j94Oao4BMGVKiBeVX6iMx1lRJpNdeq+3O9dr6rL89QTB7SLEJK63Rz
        hvVw/Xft8CPzxKsC3LYIAU=
Received: from localhost.localdomain (unknown [222.64.154.88])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wAH_tG4yRlkaIElAA--.19336S4;
        Tue, 21 Mar 2023 23:14:07 +0800 (CST)
From:   David Wang <00107082@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     masahiroy@kernel.org, bagasdotme@gmail.com,
        David Wang <00107082@163.com>
Subject: [PATCH] scripts/package: add back 'version' for builddeb
Date:   Tue, 21 Mar 2023 23:13:42 +0800
Message-Id: <20230321151342.4260-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAH_tG4yRlkaIElAA--.19336S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw17Xw1rtr1xKr45JrWrXwb_yoWxZFcEvF
        9Fqr1Yqan7X3y8Ar40kan3GryY9r15tr4rt3WYqrZ8Zr1kCF4qgFsrCry8JF43CF4UKrWf
        KrWFg34UWF4UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRleH93UUUUU==
X-Originating-IP: [222.64.154.88]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiOwM5qmC5k-iQZAAAst
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know enabled packages")
The 'version' variable is still needed for building
debian 'linux-headers' packages, add it back.

Signed-off-by: David Wang <00107082@163.com>
---
 scripts/package/builddeb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index c5ae57167d7c..5102d0903f9c 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -215,6 +215,7 @@ install_libc_headers () {
 
 rm -f debian/files
 
+version=$KERNELRELEASE
 packages_enabled=$(dh_listpackages)
 
 for package in ${packages_enabled}
-- 
2.20.1

