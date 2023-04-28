Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2416F1D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbjD1RMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjD1RL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B881826B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54A9660F7E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1627BC433A0;
        Fri, 28 Apr 2023 17:11:56 +0000 (UTC)
Date:   Fri, 28 Apr 2023 18:11:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kmemleak-test: drop __init to get better backtrace
Message-ID: <ZEv+Wi3eSD3fw0hR@arm.com>
References: <20230425222446.170486-1-jim.cromie@gmail.com>
 <20230425222446.170486-4-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425222446.170486-4-jim.cromie@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:24:46PM -0600, Jim Cromie wrote:
> Drop the __init on kmemleak_test_init().  With it, the storage is
> reclaimed, but then the symbol isn't available for "%pS" rendering,
> and the backtrace gets a bare pointer where the actual leak happened.
> 
> unreferenced object 0xffff88800a2b0800 (size 1024):
>   comm "modprobe", pid 413, jiffies 4294953430
>   hex dump (first 32 bytes):
>     73 02 00 00 75 01 00 68 02 00 00 01 00 00 00 04  s...u..h........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (ck 603070071):
>     [<00000000fabad728>] kmalloc_trace+0x26/0x90
>     [<00000000ef738764>] 0xffffffffc02350a2
>     [<00000000004e5795>] do_one_initcall+0x43/0x210
>     [<00000000d768905e>] do_init_module+0x4a/0x210
>     [<0000000087135ab5>] __do_sys_finit_module+0x93/0xf0
>     [<000000004fcb1fa2>] do_syscall_64+0x34/0x80
>     [<00000000c73c8d9d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> with __init gone, that trace entry renders like:
> 
>     [<00000000ef738764>] kmemleak_test_init+<offset>/<size>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
