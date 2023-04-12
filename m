Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2760E6DEBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDLGRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLGRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:17:05 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864040D8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:17:03 -0700 (PDT)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id HAC00055;
        Wed, 12 Apr 2023 14:16:55 +0800
Received: from localhost.localdomain.com (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.21; Wed, 12 Apr 2023 14:16:55 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virt: acrn: Replace obsolete memalign() with posix_memalign()
Date:   Wed, 12 Apr 2023 02:16:53 -0400
Message-ID: <20230412061653.1676-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2023412141655bdafd77d197334c1737fadabc963d849
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memalign() is obsolete according to its manpage.

Replace memalign() with posix_memalign() and remove malloc.h include
that was there for memalign().

As a pointer is passed into posix_memalign(), initialize *p to NULL
to silence a warning about the function's return value being used as
uninitialized (which is not valid anyway because the error is properly
checked before p is returned).

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 samples/acrn/vm-sample.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index 7abd68b20153..2656189093ef 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -13,7 +13,6 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
-#include <malloc.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <signal.h>
@@ -54,8 +53,8 @@ int main(int argc, char **argv)
 	argc = argc;
 	argv = argv;
 
-	guest_memory = memalign(4096, GUEST_MEMORY_SIZE);
-	if (!guest_memory) {
+	ret = posix_memalign(&guest_memory, 4096, GUEST_MEMORY_SIZE)
+	if (ret < 0) {
 		printf("No enough memory!\n");
 		return -1;
 	}
-- 
2.27.0

