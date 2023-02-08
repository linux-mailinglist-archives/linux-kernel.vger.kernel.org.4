Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6854168F461
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBHRYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjBHRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCFB2594D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eoiAli19PL7azkr1hXVTcWX6t95Td6qRB+S8kh8zJlQ=; b=WoCH/mSdUyVDacdymT8eL3e5cC
        DeZUvZFrS2QMu86mrs8CClkmBdCDkEN6fNNLRePzh+/AUjxnwJo2pRcsvxQVlCplDhHz4rRIAdZxG
        FPQeY76QW/e3AGZwZGsLQob14d7zQPMpCF3yHgHdsXHwyf8Hhb45iA80/joAykRdWNOB/FT4xuk3a
        5yO/zVqy0yd8a4ncKDeJ8vu+aE94Koty8uMs9Glt373GPTDHuuVYn+B1+KSajuvg4P09Yh3LFZ4t0
        l1e/CveedMAAqeScctLnFkrtfKcnO3pQWdkEVWDj/VDDPwXAdKaA5114EbkDYiUQLOGShVBTJfJCb
        5zNYvE8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPoAh-001PYA-HO; Wed, 08 Feb 2023 17:23:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 505683021F5;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2C0E823D8CFB8; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.922980544@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 10/10][HACK] objtool: Shrink reloc
References: <20230208171756.898991570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glorious hack, do not merge. Good for another ~850M of allyesconfig
savings.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/include/objtool/elf.h |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -71,17 +71,23 @@ struct reloc {
 	union {
 		GElf_Rela rela;
 		GElf_Rel  rel;
+		struct {
+			u64 offset;
+			u64 __bar;
+			s64 addend;
+		};
 	};
 	struct section *sec;
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
-	unsigned long offset;
-	unsigned int type;
-	s64 addend;
 	int idx;
+	unsigned short type;
 	bool jump_table_start;
 };
 
+static_assert(offsetof(struct reloc, rela.r_offset) == offsetof(struct reloc, offset));
+static_assert(offsetof(struct reloc, rela.r_addend) == offsetof(struct reloc, addend));
+
 #define ELF_HASH_BITS	20
 
 struct elf {


