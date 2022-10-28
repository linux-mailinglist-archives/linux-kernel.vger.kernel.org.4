Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C046113BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJ1N5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJ1N5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B058172681
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E16362893
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47BBC433D6;
        Fri, 28 Oct 2022 13:56:58 +0000 (UTC)
Date:   Fri, 28 Oct 2022 14:56:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
Subject: Re: [RFC PATCH] mm: sort kmemleak object via backtrace
Message-ID: <Y1vfp3JWRX3OYL0h@arm.com>
References: <1664264570-3716-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664264570-3716-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:42:50PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Kmemleak objects are reported each which could produce lot of redundant
> backtrace informations. introduce a set of method to establish a hash
> tree to sort the objects according to backtrace.
> 
> results:
> [  579.075111]c6 [ T5491] kmemleak: unreferenced object 0xffffff80badd9e00 (size 128):
> [  579.082734]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.096837]c6 [ T5491] kmemleak: unreferenced object 0xffffff80badd9d00 (size 128):
> [  579.104435]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.118563]c6 [ T5491] kmemleak: unreferenced object 0xffffff80baddce80 (size 128):
> [  579.126201]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.140303]c6 [ T5491] kmemleak: unreferenced object 0xffffff80baddcb00 (size 128):
> [  579.147906]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.162032]c6 [ T5491] kmemleak: unreferenced object 0xffffff80bae74a80 (size 128):
> [  579.169661]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892470
> [  579.183775]c6 [ T5491] kmemleak: unreferenced object 0xffffff80bae74100 (size 128):
> [  579.191374]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892471
> [  579.205486]c6 [ T5491] kmemleak: unreferenced object 0xffffff80bae75880 (size 128):
> [  579.213127]c6 [ T5491] kmemleak:   comm "swapper/0", pid 1, jiffies 4294892471
> [  579.227743]c6 [ T5491] kmemleak:   backtrace:
> [  579.232109]c6 [ T5491] kmemleak:     [<0000000066492d96>] __kmalloc_track_caller+0x1d4/0x3e0
> [  579.240506]c6 [ T5491] kmemleak:     [<00000000e5400df8>] kstrdup_const+0x6c/0xa4
> [  579.247930]c6 [ T5491] kmemleak:     [<00000000d7843951>] __kernfs_new_node+0x5c/0x1dc
> [  579.255830]c6 [ T5491] kmemleak:     [<0000000073b5a7bd>] kernfs_new_node+0x60/0xc4
> [  579.263436]c6 [ T5491] kmemleak:     [<000000002c7a48d5>] __kernfs_create_file+0x60/0xfc
> [  579.271485]c6 [ T5491] kmemleak:     [<00000000260ae4a1>] cgroup_addrm_files+0x244/0x4b0
> [  579.279534]c6 [ T5491] kmemleak:     [<00000000ec6bce51>] css_populate_dir+0xb4/0x13c
> [  579.287324]c6 [ T5491] kmemleak:     [<000000005913d698>] cgroup_mkdir+0x1e0/0x31c
> [  579.294859]c6 [ T5491] kmemleak:     [<0000000052605ead>] kernfs_iop_mkdir.llvm.8836999160598622324+0xb0/0x168
> [  579.304817]c6 [ T5491] kmemleak:     [<0000000009665bc4>] vfs_mkdir+0xec/0x170
> [  579.311990]c6 [ T5491] kmemleak:     [<000000003c9c94c1>] do_mkdirat+0xa4/0x168
> [  579.319279]c6 [ T5491] kmemleak:     [<000000005dd5be19>] __arm64_sys_mkdirat+0x28/0x38
> [  579.327242]c6 [ T5491] kmemleak:     [<000000005a0b9381>] el0_svc_common+0xb4/0x188
> [  579.334868]c6 [ T5491] kmemleak:     [<0000000063586a51>] el0_svc_handler+0x2c/0x3c
> [  579.342472]c6 [ T5491] kmemleak:     [<00000000edfd67aa>] el0_svc+0x8/0x100

I'm not convinced it's worth the complexity. Yes, it looks nicer, but if
you have so many leaks they'd not go unnoticed and get fixed relatively
quickly.

One thing I liked about the kmemleak traces is that they are shown in
the order they were allocated. On many occasions, one leak (or false
positive) leaks to another, so it's easier to track them down if you
start with the first. Is the order preserved with your patch?

-- 
Catalin
