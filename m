Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64986C1066
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCTLMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCTLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:12:12 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3F871BAEE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=v1p6G
        bPOhVK5LbPZ3ZzlsTIAEYWxCR9FILzpzCfknSg=; b=ZJpS1PhJoRAnkY2RB4fGF
        d/A8Y4yw8bjd2pRgcLdusvdR26Dpxd1gLOJwyLPYaKGfcWanqXaDGZ0IJEDUo+h8
        eOviuy0p+OLVjHmr5rpM5kx4/xQGvzp+3bOHxo4fKEL1FyrU1/W5GqXw3mRYPNH5
        lhlFKMJCwJVqbyFi9jhrnY=
Received: from localhost.localdomain (unknown [222.64.154.88])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wAn0jikPhhk4O9iAg--.27766S4;
        Mon, 20 Mar 2023 19:08:23 +0800 (CST)
From:   David Wang <00107082@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     masahiroy@kernel.org, bagasdotme@gmail.com,
        David Wang <00107082@163.com>
Subject: [PATCH] scripts/package: add back 'version' for builddeb
Date:   Mon, 20 Mar 2023 19:08:19 +0800
Message-Id: <20230320110819.23668-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAn0jikPhhk4O9iAg--.27766S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrury3ZF4ftr4DKF47JFyxKrg_yoWxZrXEvF
        9Fqr1Yqan7X3y8Ar40kan3JryY9r15tr4rt3Z0qrZ8Zr1kCF4qgFsrCry8JF43CF4UKrWf
        tr4Fg34UWF4UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRkucKtUUUUU==
X-Originating-IP: [222.64.154.88]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEgw4qmI0WeENdQAAsa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 36862e14e316 (kbuild: deb-pkg: use dh_listpackages to know
enabled packages)
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

