Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2936551A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiLWOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiLWOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:52:12 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC3332BA8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 06:52:11 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 248447E2AF;
        Fri, 23 Dec 2022 14:52:07 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671807131;
        bh=oJEfdxT5/bQz94HuPnh6KWVv4Q97ynYQ98e0q4+hCvk=;
        h=From:To:Cc:Subject:Date:From;
        b=YygV2RW5JSy8TgXFKoGe+8Pt6f9MiEHg6IF2tCDLhe479MO+TbQsF1/9aX1wZ9o0O
         nY7GFdrGJ/BaUVoVpHhlcUmp8RhOvMZkQ7FsQC6eHKvrVG5qSfB9n1BynklsdNosqr
         DdQ4U+pNKyxtpOot4oyZJ1u6aOpCZ8o5w7oBRmE5HsaMkKFV8BjIeGoiwe7qiEcyr0
         eRj97WcTkCp2t9XAceRnW2Edg3W/uPklIEruJuKhpZDi7DkQ8hNRvyCoRExyfNbrsZ
         7Ui8LJlUu7GLArHNgXo7ZvWsBEkqqvrHZNKVi7P94mE5P/5RVQYygSBmMAjQnbCTXI
         6MfQNp5Rz73bg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        LLVM Mailing List <llvm@lists.linux.dev>
Subject: [PATCH v1] driver core: Silence 'unused-but-set variable' warning
Date:   Fri, 23 Dec 2022 21:51:37 +0700
Message-Id: <20221223145137.3786601-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Compiling with clang-16:

  drivers/base/module.c:36:6: error: variable 'no_warn' set but not \
  used [-Werror,-Wunused-but-set-variable]
          int no_warn;
              ^
  1 error generated.

A reason the @no_warn variable exists is:
sysfs_create_link() return value needs not be ignored to silence
another warning.

So don't remove @no_warn, but add a '(void)no_warn;'.

Cc: LLVM Mailing List <llvm@lists.linux.dev>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 drivers/base/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..42f0b3b9e7f8 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -59,22 +59,23 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 		return;
 
 	/* Don't check return codes; these calls are idempotent */
 	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
 	driver_name = make_driver_name(drv);
 	if (driver_name) {
 		module_create_drivers_dir(mk);
 		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
 					    driver_name);
 		kfree(driver_name);
 	}
+	(void)no_warn;
 }
 
 void module_remove_driver(struct device_driver *drv)
 {
 	struct module_kobject *mk = NULL;
 	char *driver_name;
 
 	if (!drv)
 		return;
 
 	sysfs_remove_link(&drv->p->kobj, "module");

base-commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be
-- 
Ammar Faizi

