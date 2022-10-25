Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3E60D542
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiJYULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJYULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:11:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD679EC7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=arjjn6azk9uuxv9qRJ+TWeQwrm7jAh/OWTTw4STalbE=; b=SoA0yvjL6GoYB+2zKr2iW2n+CW
        Y00diumhJOcA6Du8eS/vHG6P2v8xueThdNVEx7uS3ftVAkGE38n2+AWibbqKg9wC69ms04V6Et/e3
        Bb0rMCRjSeSnu2ary0XsvmDIzaCrqqIzsAy1m9Rexuzp6GUn1wAKnFk+ALwqsjP/Ox2wKM2JTsk/X
        6kuGM3yL27VqqWJ2hrwHNbpLh9rmr2QBV/ZMEqvaCabyJK5Asf+SjID8CG/2th5wS8OYj2Xph+Ypg
        i6hZjEklqfE7N5K6GEhwAufY6ylbQnVAu7Vv3iqViGmctp9PD+B7yIJE3ssF4MMoeVqdBmHj/i6Rm
        LZ3sIbSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onQGm-00GWF5-EP; Tue, 25 Oct 2022 20:11:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F04A30008D;
        Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8805D2C450286; Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Message-ID: <20221025200656.951281799@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 Oct 2022 22:06:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, rostedt@goodmis.org,
        dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These few patches re-work and re-order boot things enough to avoid ftrace
creating boot time W+X maps.

The patches compile and boot for the one config I tested things on (with
ftrace=function enabled; *slooooow*).

I've pushed them out for the robots to have a go at here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/mm.poke_me

