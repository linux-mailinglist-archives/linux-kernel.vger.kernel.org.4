Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC318667F95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjALTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbjALTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:45:44 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76281B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:40:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 36543604F9;
        Thu, 12 Jan 2023 20:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673552399; bh=yHILrvi6nZy2kVD6aE2AeGm4dwv77W6buiiH3ea0usM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=sZ/PgB4nIrachAAuy5MBmLHAI7t7CNnGZ24+AqeHiGfWDhPaHcPb8Ax3x4WYQXvnh
         +Yp3+FRFXdHhSp/wjIBckJ61zqd33tHAoVrof9nUu4/meUOuoG4NP4lBgzxtBF+pzD
         2GVPdhwWC9VJwPGa4FmQoUByWKVs1ptWHvObGEU97cn/R1DvegnhfMgFH+YDYAmcxB
         UIAoP2cc1Is0tnztLj7F6dsK6JAVnM3xVEeMdFRi6uoCOseG9AO4LWxrJEbmsOAnL0
         sykn66KwExmh6R//4dLDpnZSSedC6fNI/WP4SJmDyKa8I9XhvPuzjTT13SK8oQjr8O
         AO7SKWayXYmww==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pPJeUxEX4V1B; Thu, 12 Jan 2023 20:39:56 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id C2D33604F3;
        Thu, 12 Jan 2023 20:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673552396; bh=yHILrvi6nZy2kVD6aE2AeGm4dwv77W6buiiH3ea0usM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=syGQjp8mTIOUFpeRpVwiwWtY/PFcoclR64RPf0nfhr0hlS8rMrjauG3PLhdM8NPgt
         8vwLawldVbRxez34lJlA0KgFVFDm0CL2GhbWcs5spYe2hesRlb01H0N2p3QfiB+ZOn
         b7tpN9rtEW4bFR/gj/RO+ZwMZAxwraDueWQlvPef7xG8dPFOZxV7GkMkRh4K936Kzi
         ADAHEz+aGj0ufUpZ7tulyvOg8lLOxb7qoWT4yJZ5uinZiVhlOQb/9ohCGZiyJcINlK
         EVxhSpX/TGMZTU7UGLXO36sHV8zo34Ahu4LbZMCwtd7+BzEHFKcqHCM3ZpnXZhJ85e
         C0iyKSG/dnLqw==
Message-ID: <4c467851-8080-44d3-d017-b0e283896119@alu.unizg.hr>
Date:   Thu, 12 Jan 2023 20:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [BISECTED] BUG: Regression: A Problem with
 /sys/kernel/debug/kmemleak output: backtrace not printed since 6.2.0-rc1
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>
References: <5272a819-ef74-65ff-be61-4d2d567337de@alu.unizg.hr>
Content-Language: en-US, hr
In-Reply-To: <5272a819-ef74-65ff-be61-4d2d567337de@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 17:08, Mirsad Goran Todorovac wrote:

> I hate to bring bad news again, but there seems to be a problem with the output of /sys/kernel/debug/kmemleak:
> 
> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff951c118568b0 (size 16):
>    comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
>    hex dump (first 16 bytes):
>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>    backtrace:
> [root@pc-mtodorov ~]#
> 
> Apparently, backtrace of called functions on the stack is no longer printed with the list of memory leaks.
> 
> This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and BIOS version M22KT49A (11/10/2022)
> and 6.2-rc1 and 6.2-rc2 builds.
> 
> This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU enabled on a vanilla mainstream kernel
> from Mr. Torvalds' tree. I don't know if this is deliberate feature for some reason or a bug.
> 
> Please find attached the config, lshw and kmemleak output.

Hi all,

The bisection gave this commit as the culprit for the severed stack backtrace print
in /sys/kernel/debug/kmemleak:

mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect good
56a61617dd2276cbc56a6c868599716386d70041 is the first bad commit
commit 56a61617dd2276cbc56a6c868599716386d70041
Author: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Date:   Thu Oct 27 17:50:24 2022 +0800

     mm: use stack_depot for recording kmemleak's backtrace

     Using stack_depot to record kmemleak's backtrace which has been
     implemented on slub for reducing redundant information.

The complete bisect log is:

mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect log
git bisect start '--' 'mm'
# good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
git bisect good 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
# bad: [1b929c02afd37871d5afb9d498426f83432e71c2] Linux 6.2-rc1
git bisect bad 1b929c02afd37871d5afb9d498426f83432e71c2
# good: [8b9ed79c2d587bec5f603d66801478a5af9af842] Merge tag 'x86_asm_for_v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 8b9ed79c2d587bec5f603d66801478a5af9af842
# good: [e83b39d6bbdb6d25bd6f5c258832774635d29b47] mm: make drop_caches keep reclaiming on all nodes
git bisect good e83b39d6bbdb6d25bd6f5c258832774635d29b47
# good: [9997bc017549acd6425e32300eff28424ffeeb6b] zsmalloc: implement writeback mechanism for zsmalloc
git bisect good 9997bc017549acd6425e32300eff28424ffeeb6b
# good: [6287b7dae80944bfa37784a8f9d6861a4facaa6e] mm,thp,rmap: fix races between updates of subpages_mapcount
git bisect good 6287b7dae80944bfa37784a8f9d6861a4facaa6e
# good: [8fa590bf344816c925810331eea8387627bbeb40] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 8fa590bf344816c925810331eea8387627bbeb40
# good: [4f292c4de4f6fb83776c0ff22674121eb6ddfa2f] Merge tag 'x86_mm_for_6.2_v2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 4f292c4de4f6fb83776c0ff22674121eb6ddfa2f
# bad: [1ea9d333ba475041efe43d9d9bc32e64aea2ea2b] Merge tag 'mm-stable-2022-12-17-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 1ea9d333ba475041efe43d9d9bc32e64aea2ea2b
# bad: [56a61617dd2276cbc56a6c868599716386d70041] mm: use stack_depot for recording kmemleak's backtrace
git bisect bad 56a61617dd2276cbc56a6c868599716386d70041
# good: [61b963b52f59524e27692bc1c14bfb2459e32eb3] mm/gup_test: free memory allocated via kvcalloc() using kvfree()
git bisect good 61b963b52f59524e27692bc1c14bfb2459e32eb3
# first bad commit: [56a61617dd2276cbc56a6c868599716386d70041] mm: use stack_depot for recording kmemleak's backtrace
# good: [9102b78b6f6ae6af3557114c265c266b312c1319] maple_tree: update copyright dates for test code
git bisect good 9102b78b6f6ae6af3557114c265c266b312c1319
# first bad commit: [56a61617dd2276cbc56a6c868599716386d70041] mm: use stack_depot for recording kmemleak's backtrace
You have mail in /var/mail/mtodorov
mtodorov@domac:~/linux/kernel/linux_torvalds$

The platform is 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB) running AlmaLinux 8.7
(CentOS clone) and BIOS M22KT49A.

GCC used was:

mtodorov@domac:~/linux/kernel/linux_torvalds$ gcc --version
gcc (Debian 8.3.0-6) 8.3.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
mtodorov@domac:~/linux/kernel/linux_torvalds$

Hope this helps.

I lack the insight to pinpoint the exact fault in the patch.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
