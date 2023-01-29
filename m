Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F567FFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjA2PGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjA2PGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:06:13 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24C1E9D8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 07:06:09 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pM9Fp-0005Y7-PE; Sun, 29 Jan 2023 16:06:01 +0100
Message-ID: <633ee51b-7f81-c38a-7543-34df69480f1d@leemhuis.info>
Date:   Sun, 29 Jan 2023 16:06:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: INFO: [BISECTED] Regression: A Problem with
 /sys/kernel/debug/kmemleak output: backtrace not printed since 6.2.0-rc1
Content-Language: en-US, de-DE
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>
References: <5272a819-ef74-65ff-be61-4d2d567337de@alu.unizg.hr>
 <4c467851-8080-44d3-d017-b0e283896119@alu.unizg.hr>
 <53c2d558-c6a1-38e5-5739-28fff023558d@alu.unizg.hr>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
In-Reply-To: <53c2d558-c6a1-38e5-5739-28fff023558d@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675004769;c51ba84b;
X-HE-SMSGID: 1pM9Fp-0005Y7-PE
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 12.01.23 20:50, Mirsad Todorovac wrote:
> Hi all,
> 
> there seems to be a problem with the output of /sys/kernel/debug/kmemleak:
> 
> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff951c118568b0 (size 16):
>   comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>   backtrace:
> [root@pc-mtodorov ~]#
> 
> Apparently, backtrace of called functions on the stack is no longer
> printed with the list of memory leaks.
> [...]

This is already close to being fixed, but I want to have it in this week
report, hence I'm adding it (better late than never):

#regzbot ^introduced 56a61617dd22
#regzbot title mm: stack_depot: Failure during Stack Depot allocating
hash table
#regzbot monitor: https://lore.kernel.org/all/Y8Fq5m0CLfcFLCOY@zn.tnic/
#regzbot fix: mm: use stack_depot_early_init for kmemleak
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
