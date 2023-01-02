Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2724A65B756
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 22:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjABVQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 16:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjABVQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 16:16:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3607A459;
        Mon,  2 Jan 2023 13:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NHmSI4BAP2aEJ9CMtBuxh4gyI63+HnFkQnS+v2zXqr4=; b=Kje9jnEnCrSwN7EQt+D4Dekx5Q
        AoxmtlHmh1kilCx/QP7qHnh4H1v7Cu+Gloa1BLUNHyHTrPfIy8dU6Hl0/NygcYHrx3EhOQZZC2Lra
        fDscfwNgRdxJgpgNp8pEi+KF+tyHa3lTSDCrz2c+8he01kfFThMvlLFn92LDPuneyITRzO4seJB9y
        oOz/t1TuaVcU8egRUyRVNmlYuPeot8pndJRkgEX5UN+ICvrMBpdYEsID9SRRnZnsG+cnl+jnGPyNI
        YpEAYInd7enpXKKqZTJVgv9xGKtYNCSgt0PKsKo4NfXLN9MWalxyXa2xmtncu5Y0gK4fbnDnLiEY3
        DzevHOog==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCSAA-00EIqL-FI; Mon, 02 Jan 2023 21:16:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: [PATCH] test_kmod: stop kernel-doc warnings
Date:   Mon,  2 Jan 2023 13:16:05 -0800
Message-Id: <20230102211605.26058-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel-doc notation to prevent warnings:

lib/test_kmod.c:58: warning: contents before sections
lib/test_kmod.c:94: warning: cannot understand function prototype: 'struct kmod_test_device_info '
lib/test_kmod.c:119: warning: cannot understand function prototype: 'struct kmod_test_device '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
---
 lib/test_kmod.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff -- a/lib/test_kmod.c b/lib/test_kmod.c
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -51,12 +51,11 @@ static int num_test_devs;
 
 /**
  * enum kmod_test_case - linker table test case
- *
- * If you add a  test case, please be sure to review if you need to se
- * @need_mod_put for your tests case.
- *
  * @TEST_KMOD_DRIVER: stress tests request_module()
  * @TEST_KMOD_FS_TYPE: stress tests get_fs_type()
+ *
+ * If you add a  test case, please be sure to review if you need to set
+ * @need_mod_put for your tests case.
  */
 enum kmod_test_case {
 	__TEST_KMOD_INVALID = 0,
@@ -78,7 +77,7 @@ struct test_config {
 struct kmod_test_device;
 
 /**
- * kmod_test_device_info - thread info
+ * struct kmod_test_device_info - thread info
  *
  * @ret_sync: return value if request_module() is used, sync request for
  * 	@TEST_KMOD_DRIVER
@@ -101,7 +100,7 @@ struct kmod_test_device_info {
 };
 
 /**
- * kmod_test_device - test device to help test kmod
+ * struct kmod_test_device - test device to help test kmod
  *
  * @dev_idx: unique ID for test device
  * @config: configuration for the test
