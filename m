Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69394741892
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjF1TEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjF1TDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:03:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4FE4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lKbs9JhRzstdbx99oJHX0qBzaCBS/X+mzw0gYbz4mlU=; b=lvndEkUm3fql7Ofj7DbD8bacv9
        X4cq4p7Lh0kkTXRji6mISx1LdRN3cFnfgSclqDWM0SJ7xX0mHniZv3NCC7V1FZd6t5fXlPbKZS14J
        ie7qT2Mg2YbBoGPbwpQltkvIVK2U0Ma4RIAGUltXjDf9p/1AEx4a3vnnFYKkkY6qHsjEXPXAJkQaM
        ne5Z0majlk03LAuZbndjx5Xi7SJBROABp/OkdXIWL1zULfiXYPPxv1lI9WfN1FRt3EouN3ywSkp37
        MxDWoQhwlewNYYdk7ksOORrhjiqziaKEt9K1i7uFMtp//V+5p6hUois1DN39gAl7MHsR/72kc9rhP
        4OaXVeGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEaS2-0047pF-7x; Wed, 28 Jun 2023 19:03:38 +0000
Date:   Wed, 28 Jun 2023 20:03:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Reunbreak the MEM_ENCRYPT build
Message-ID: <ZJyECvfrOWhKJj4t@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current top of tree doesn't build for me:

../arch/x86/include/asm/mem_encrypt.h:23:20: error: static declaration of ‘mem_encrypt_init’ follows non-static declaration
   23 | static inline void mem_encrypt_init(void) { }
      |                    ^~~~~~~~~~~~~~~~
In file included from ../include/linux/printk.h:6,
                 from ../include/linux/kernel.h:30,
                 from ../arch/x86/include/asm/percpu.h:27,
                 from ../arch/x86/include/asm/preempt.h:6:
../include/linux/init.h:158:6: note: previous declaration of ‘mem_encrypt_init’ with type ‘void(void)’
  158 | void mem_encrypt_init(void);
      |      ^~~~~~~~~~~~~~~~

I applied this locally:

diff --git a/include/linux/init.h b/include/linux/init.h
index 1200fa99e848..266c3e1640d4 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -155,7 +155,6 @@ void __init init_rootfs(void);

 void init_IRQ(void);
 void time_init(void);
-void mem_encrypt_init(void);
 void poking_init(void);
 void pgtable_cache_init(void);

Probably this is the wrong fix.

