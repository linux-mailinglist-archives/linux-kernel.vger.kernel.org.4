Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE963CD75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiK3Cgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiK3Cgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:36:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB024BEA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:36:42 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMNcd5XrBz67Q9H;
        Wed, 30 Nov 2022 10:36:17 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (7.191.163.9) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 03:36:40 +0100
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 30 Nov 2022 02:36:39 +0000
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <jpoimboe@kernel.org>
CC:     <peterz@infradead.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH] objtool: Fix memory leakage
Date:   Wed, 30 Nov 2022 10:36:35 +0800
Message-ID: <20221130023635.2665668-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes memory leakage in handle_group_alt() function.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 43ec14c29a60..2689098e9bad 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1569,6 +1569,7 @@ static int handle_group_alt(struct objtool_file *file,
 				     sizeof(struct cfi_state *));
 	if (!orig_alt_group->cfi) {
 		WARN("calloc failed");
+		free(orig_alt_group);
 		return -1;
 	}
 
@@ -1603,6 +1604,7 @@ static int handle_group_alt(struct objtool_file *file,
 		nop = malloc(sizeof(*nop));
 		if (!nop) {
 			WARN("malloc failed");
+			free(new_alt_group);
 			return -1;
 		}
 		memset(nop, 0, sizeof(*nop));
-- 
2.25.1

