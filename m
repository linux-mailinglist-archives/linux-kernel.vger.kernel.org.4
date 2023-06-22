Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D551973A397
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFVOup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjFVOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:50:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01FA10F4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3zCtZL++1WgaB4Gv5cJATiTI7lJGqHZ+IYowywDRpSk=; b=O4SvgdVGwj7hPJaGkYWRVMgtlw
        0ifE1Cd9WhEuurwxhb/wAJlcJNvPj9G0YAayahj6B7TG5I47WLWdKDyekkzzI1uz9jRM4pkk6innx
        CP/FU8qzHPJasyY/u55C0cmwD54I+z83lN8Dax9M1+3pppIsFQgjQXq2eEFgRX6WijxJ3hHdFgDPi
        HqEbFU0PgyK7m4DaT3IwnuFpXnci9B1p6k/aontkyBkGIpSp2xkRTU2+E3IF+drXScOfX/MxmEoLr
        7BkfKQrNcezqjKvfrsmoqRqtFUDYqeUSFLfjaABL10G3A0yxhFbdHyPeKeRnaMybCXUk1WSOOy8wk
        Z8dlVIwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCLdh-00FgfD-Ru; Thu, 22 Jun 2023 14:50:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29F5B3002F0;
        Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 11127209D8B3A; Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Message-ID: <20230622144218.860926475@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 16:42:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com
Subject: [PATCH v2 0/6] x86/cfi: Fix FineIBT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alyssa reported a FineIBT issue (patch 6) which led to the discovery of
a kCFI issue (patch 5) and a bunch of cleanups and enhancements (the
rest).

Backports can probably suffice with just the last two.

Much thanks to Brian for the better ret_from_fork() cleanup.

Tested using llvm-16 on an Alderlake with both FineIBT and kCFI.

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/urgent

(I'm aiming for the merge window, not this cycle)

v1: https://lkml.kernel.org/r/20230615193546.949657149@infradead.org

---
 arch/um/kernel/um_arch.c             |  2 +-
 arch/x86/entry/entry_32.S            | 54 +++++++---------------------
 arch/x86/entry/entry_64.S            | 35 ++++++------------
 arch/x86/include/asm/alternative.h   |  2 +-
 arch/x86/include/asm/ibt.h           |  2 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/include/asm/switch_to.h     |  4 ++-
 arch/x86/kernel/alternative.c        | 69 +++++++++++++++++++++++++++++++++---
 arch/x86/kernel/module.c             |  2 +-
 arch/x86/kernel/process.c            | 22 +++++++++++-
 10 files changed, 120 insertions(+), 76 deletions(-)

