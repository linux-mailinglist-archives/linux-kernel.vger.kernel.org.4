Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED96242AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKJM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKJM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:58:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D74970191
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9NaM1NMufepdQVgqeWnc24MtX3wXYVTUR/qlNvATIGE=; b=W9wrUqYbzQp4KVIr45vjEYdiqk
        ItpNdoCbXoP5gh53sJWRM9x5BLXMZXxHxdRUr0VgYx9Nr6qTGpbAAhR//A2SLyQIemeIpco0qCkAx
        +FK7z54Z1NyOT54LHaX5KneOeJ5AnZwF8upljVnnLSrnfALHTklw0K7R1Ly+vSg3KR2bjYPIQfcHv
        z23qkd82LkO2sU94cuik6L3eJGrjCQv6ISbKhx6RexxQ6zk6bB1sF8LG+lCQCSszuyPHmpaxTYMcj
        haWWhiGI/dMjfz+t4IBM9gZRxPcb5EfJ28Ad7eC/JpZ8E3RnA+B8g6BXSBG2uQD5pf9EN35tKWPT7
        6iTdQpFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot78X-00AHCg-9v; Thu, 10 Nov 2022 12:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C728D300348;
        Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9DEE620B231B0; Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Message-ID: <20221110125253.240704966@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 13:52:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, oliver.sang@intel.com
Subject: [PATCH 0/4] x86/mm: Fix set_memory_rox()
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The robot reported fail on commit:

  b38994948567 ("x86/mm: Implement native set_memory_rox()")

which led to some non-obvious code in __change_page_attr_set_clr(). These few
patches attempt to clean that up.

