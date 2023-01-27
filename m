Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F3667F21F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjA0XRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA0XQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:16:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DF82402
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:16:55 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 496F71EC0681;
        Sat, 28 Jan 2023 00:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674861413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:references;
        bh=PWpeLnGzL8kAYkey8Z0rbkSYotP9qzH3xxUU/PpcXw0=;
        b=eomULAP184pftBXhkQNhubL3C+3DQrX7Hu0DD17JZsv+Jd9xc88DZOLeqemqWi3rk2HWvT
        11mZnLDNC/fccNF+J0nyUz0KMcyQAfW01SkM+cKv4qPWXT5taKzmAHv5JWIBs7otJ8Ckw+
        R2mwW1MZpWfQv3AUDy4mbrjvkhJN7SE=
Date:   Sat, 28 Jan 2023 00:16:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Potapenko <glider@google.com>,
        ZhaoyangHuang <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "ke.wang" <ke.wang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>
Subject: Re: Failure during Stack Depot allocating hash table of 1048576
 entries with kvcalloc
Message-ID: <Y9RbX9k/zC6+Eg+u@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8GCa2CG2Z7hl/5d@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

was finally able to bisect it. Lemme add everybody to Cc.

This one reverted ontop of latest Linus master fixes the vmalloc error here:

https://lore.kernel.org/r/Y8Fq5m0CLfcFLCOY@zn.tnic

commit 56a61617dd2276cbc56a6c868599716386d70041 (HEAD, refs/bisect/bad)
Author: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Date:   Thu Oct 27 17:50:24 2022 +0800

    mm: use stack_depot for recording kmemleak's backtrace
    
    Using stack_depot to record kmemleak's backtrace which has been
    implemented on slub for reducing redundant information.
    
    [akpm@linux-foundation.org: fix build - remove now-unused __save_stack_trace()]
    [zhaoyang.huang@unisoc.com: v3]
      Link: https://lkml.kernel.org/r/1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com
    [akpm@linux-foundation.org: fix v3 layout oddities]
    [akpm@linux-foundation.org: coding-style cleanups]
    Link: https://lkml.kernel.org/r/1666864224-27541-1-git-send-email-zhaoyang.huang@unisoc.com
    Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
    Acked-by: Catalin Marinas <catalin.marinas@arm.com>
    Cc: ke.wang <ke.wang@unisoc.com>
    Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
    Cc: Vlastimil Babka <vbabka@suse.cz>
    Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
