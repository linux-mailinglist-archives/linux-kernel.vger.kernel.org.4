Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF96678144
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjAWQWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:22:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6549EB5A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:22:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEC81B80DCC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EA8C433EF;
        Mon, 23 Jan 2023 16:22:14 +0000 (UTC)
Date:   Mon, 23 Jan 2023 16:22:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
Message-ID: <Y860MziGHLafTjOU@arm.com>
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-2-joey.gouly@arm.com>
 <4a1faf67-178e-c9ba-0db1-cf90408b0d7d@redhat.com>
 <Y857Uoq7fjO0lZ12@arm.com>
 <8b4e31cf-de20-703c-4b53-ad86d4282a37@redhat.com>
 <Y86wA0s/HRVtqLru@arm.com>
 <e07d958a-1400-3630-8a24-154850f41fb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07d958a-1400-3630-8a24-154850f41fb7@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:10:08PM +0100, David Hildenbrand wrote:
> On 23.01.23 17:04, Catalin Marinas wrote:
> > On Mon, Jan 23, 2023 at 01:53:46PM +0100, David Hildenbrand wrote:
> > > That at least would be then similar to how we handle mmaped files: if the
> > > file is not executable, we clear VM_MAYEXEC. If the file is not writable, we
> > > clear VM_MAYWRITE.
> > 
> > We still allow VM_MAYWRITE for private mappings, though we do clear
> > VM_MAYEXEC if not executable.
> > 
> > It would be nice to use VM_MAY* flags for this logic but we can only
> > emulate MDWE if we change the semantics of 'MAY': only check the 'MAY'
> > flags for permissions being changed (e.g. allow PROT_EXEC if the vma is
> > already VM_EXEC even if !VM_MAYEXEC). Another issue is that we end up
> > with some weird combinations like having VM_EXEC without VM_MAYEXEC
> > (maybe that's fine).
> 
> No, we wouldn't want VM_EXEC if VM_MAYEXEC is not set. I don't immediately
> see how that would happen.

You are right, this shouldn't happen. What I had in mind was the current
MDWE model where after an mmap(PROT_EXEC), any mprotect(PROT_EXEC) is
denied. But this series departs slightly from this since we want to
allow PROT_EXEC if already executable.

-- 
Catalin
