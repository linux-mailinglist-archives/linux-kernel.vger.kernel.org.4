Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620225B4B30
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 03:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIKB0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 21:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIKB0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 21:26:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209B52F66B;
        Sat, 10 Sep 2022 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IER4KzF2ayHuiQhjZmeVzmF5VMyqzFs03MkOV1WvnvU=; b=MlsDs8rgBdTxsvDnnxa/lbhZjF
        xzqfeUdSHRPW39ME8F8nnq7OVjrdfArcCCKdOOGKcKrCwL4tsEwCsGULZAWQmjLJyc4LUenUtcisg
        0dibBqgSwvkQpjZtMR9tncinxw6hX9hfWbjf07F6VzNpvvSm+vyfJ6ZKfnyMp+7qhvDExKNqUUWGd
        1dCcs8lYyli8BYIkdNtovsm6LdEjNLLA7ImKXRHKsjoii3kXDBZrBE87cCQQm/v5ajDmStmvXD1KA
        lXjke0jNabxE6ZXWTk2lMsQK+wNUVHP4bi9B/8XtDot5IU65CattcqilZ4FoHI/UMh0M4URSbfyEC
        bu7HANRQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXBjr-00EXc7-JT; Sun, 11 Sep 2022 01:26:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-ia64@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Keith Mannthey <kmannth@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ia64: export memory_add_physaddr_to_nid to fix cxl build error
Date:   Sat, 10 Sep 2022 18:26:16 -0700
Message-Id: <20220911012616.29948-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cxl_pmem.ko uses memory_add_physaddr_to_nid() but ia64 does not export it,
so this causes a build error:

ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/cxl/cxl_pmem.ko] undefined!

Fix this by exporting that function.

Fixes: 8c2676a5870a ("hot-add-mem x86_64: memory_add_physaddr_to_nid node fixup")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-ia64@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Keith Mannthey <kmannth@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Arnd, can you take this in your one-off fixes arch tree, or would
you prefer for Andrew to take it?

 arch/ia64/mm/numa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/ia64/mm/numa.c
+++ b/arch/ia64/mm/numa.c
@@ -75,5 +75,6 @@ int memory_add_physaddr_to_nid(u64 addr)
 		return 0;
 	return nid;
 }
+EXPORT_SYMBOL(memory_add_physaddr_to_nid);
 #endif
 #endif
