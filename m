Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB226A0194
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjBWDnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjBWDnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:43:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1D23D99;
        Wed, 22 Feb 2023 19:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R7WTQfbxyA/nZ6u/jgi+dMUNGV/ZDn1IV7U0hvkO7zE=; b=X83936MZHL0YWURGBhRB/h+Gu2
        W8/Q8oBTa90i/nwEymp9dQrInHR6M+I8wMM8uPeEQ8C/8S062A8psUpwzcCDzw+f2tspUfo23bCvR
        0gofqM3rlNkYeCqGFblotnnWAVEnL9kkF5DRZ+5lvxELjGJfT+2Xta8FFmnRjYriapgJAJ0Flsr1k
        jNu+0j0jPeoUpZc9/NwEpWkhyNLCK0pPSBKfzcmmw+uKEMlFyRtmydk0DVepdTmXacfbNZXwLlXZs
        cM++gD/euvNDrJ0wQQsmRCUzKnCN7m2xlM7phfrNmTHHP0Bk/LFxSTIwf955xOevyF5PLyD2+phAP
        1z1knf1Q==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV2Vi-00EtNl-33; Thu, 23 Feb 2023 03:43:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: salinfo: placate defined-but-not-used warning
Date:   Wed, 22 Feb 2023 19:43:09 -0800
Message-Id: <20230223034309.13375-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
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

When CONFIG_PROC_FS is not set, proc_salinfo_show() is not used.
Mark the function as __maybe_unused to quieten the warning message.

../arch/ia64/kernel/salinfo.c:584:12: warning: 'proc_salinfo_show' defined but not used [-Wunused-function]
  584 | static int proc_salinfo_show(struct seq_file *m, void *v)
      |            ^~~~~~~~~~~~~~~~~

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-ia64@vger.kernel.org
---
The entire salinfo.c file looks like it should be conditional on
CONFIG_PROC_FS, but I'm just addressing warnings/errors here.

 arch/ia64/kernel/salinfo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/ia64/kernel/salinfo.c b/arch/ia64/kernel/salinfo.c
--- a/arch/ia64/kernel/salinfo.c
+++ b/arch/ia64/kernel/salinfo.c
@@ -581,7 +581,7 @@ static int salinfo_cpu_pre_down(unsigned
  * 'data' contains an integer that corresponds to the feature we're
  * testing
  */
-static int proc_salinfo_show(struct seq_file *m, void *v)
+static int __maybe_unused proc_salinfo_show(struct seq_file *m, void *v)
 {
 	unsigned long data = (unsigned long)v;
 	seq_puts(m, (sal_platform_features & data) ? "1\n" : "0\n");
