Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4180673535
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjASKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjASKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:13:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DA76AA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9464F61232
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39613C433D2;
        Thu, 19 Jan 2023 10:13:38 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:13:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv4 2/2] mm: use stack_depot_early_init for kmemleak
Message-ID: <Y8kXz63ZmUzc+h7T@arm.com>
References: <1674091345-14799-1-git-send-email-zhaoyang.huang@unisoc.com>
 <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:22:25AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> Solve this by having stackdepot use stack_depot_early_init.
> 
> On 1/4/23 17:08, Mirsad Goran Todorovac wrote:
> I hate to bring bad news again, but there seems to be a problem with the output of /sys/kernel/debug/kmemleak:
> 
> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff951c118568b0 (size 16):
> comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
> hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>     backtrace:
> [root@pc-mtodorov ~]#
> 
> Apparently, backtrace of called functions on the stack is no longer printed with the list of memory leaks.
> This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and BIOS version M22KT49A (11/10/2022)
> and 6.2-rc1 and 6.2-rc2 builds.
> This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU enabled on a vanilla mainstream kernel
> from Mr. Torvalds' tree. I don't know if this is deliberate feature for some reason or a bug.
> Please find attached the config, lshw and kmemleak output.
> 
> reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
