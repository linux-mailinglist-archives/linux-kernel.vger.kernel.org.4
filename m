Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE36F1D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbjD1RZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345589AbjD1RZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A84497
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3EF644CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F16BC4339B;
        Fri, 28 Apr 2023 17:25:07 +0000 (UTC)
Date:   Fri, 28 Apr 2023 18:25:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 0/3] kmemleak report format changes
Message-ID: <ZEwBcOdV1br94T5N@arm.com>
References: <20230425222446.170486-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425222446.170486-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:24:43PM -0600, Jim Cromie wrote:
> If format changes are not /sys/** ABI violating, heres 3 minor ones:
> 
> 1st strips "age <increasing>" from output.  This makes the output
> idempotent; unchanging until a new leak is reported.
> 
> 2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
> user see repeats without actually reading the whole backtrace.  So now
> the backtrace line looks like this:
> 
>   backtrace (ck 603070071):  # also see below
> 
> Q: should ck be spelled crc ? it feels more communicative.

These all would make sense (and 'crc' sounds better) if they were done
from the start. I know there are test scripts out there parsing the
kmemleak sysfs file. I can't tell whether these changes would break
them.

Cc'ing Dmitry, I think syzbot was regularly checking kmemleak (not sure
it still does).

> NB: with ck exposed, it becomes possible to do a "selective clear",
> something like:
> 
>   echo drop 603070071 > /sys/kernel/debug/kmemleak
> 
> The 3rd patch takes __init off of kmemleak_test_init().  This fixes a
> bare-pointer in the 2nd line of the backtrace below, which previously
> looked like:
> 
>     [<00000000ef738764>] 0xffffffffc02350a2
> 
> NB: this happens still/again, after rmmod kmemleak-test.
> 
> unreferenced object 0xffff888005d9ca40 (size 32):
>   comm "modprobe", pid 412, jiffies 4294703300
>   hex dump (first 32 bytes):
>     00 cd d9 05 80 88 ff ff 40 cf d9 05 80 88 ff ff  ........@.......
>     14 a7 c4 f6 7d f9 87 10 00 00 00 00 00 00 00 00  ....}...........
>   backtrace (ck 1354775490):
>     [<000000002c474f61>] kmalloc_trace+0x26/0x90
>     [<00000000b26599c1>] kmemleak_test_init+0x58/0x2d0 [kmemleak_test]
>     [<0000000044d13990>] do_one_initcall+0x43/0x210
>     [<00000000131bc505>] do_init_module+0x4a/0x210
>     [<00000000b2902890>] __do_sys_finit_module+0x93/0xf0
>     [<00000000673fdce2>] do_syscall_64+0x34/0x80
>     [<00000000357a2d80>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

-- 
Catalin
