Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1664FAED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 17:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiLQQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 11:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLQQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 11:03:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDCF3B9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:58:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ADC7B802C5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 15:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A67C433D2;
        Sat, 17 Dec 2022 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671292723;
        bh=0SWU9xGA4GT0P8n+P8Hu88az0XrllApnKjpIJZPfI6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XnN2aKjICo0GvkdUazSQ2jmJaoJ2C1FSTVpRoP4SN0crKqSmV0v4ZlGh5x2jXYra7
         /t2Qks3AmvR+uri2OMeXWCeiCiQNQWjZCrmb/fuSim9MmgUXt8JgmDgQ0uQYRRSs/T
         aVBOVdzT8Dh411yZ7fKdJxFux0Yo09QLu/rX4dBT4Ur9swiVSYwKY05XfTYhnkKoq5
         E6+MCKwJSb4JNYV/+uxOvQI8oA5Y7IsuoI1AO1UVltLQKNctFGNc97FPDwqUicC37m
         g/XQjEKmj7R/sI79ineVDreqH8+KqgFfTvsgGQDaUqy5OrjzZLlqwaP+FiR89fshjq
         UE1CVe1VNmdag==
Date:   Sat, 17 Dec 2022 09:58:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <20221217155842.GA389338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 05:48:51PM +0800, Baoquan He wrote:
> On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > remove it and just use the generic version.
> 
> I ever posted below patch to do the same thing, Andrew only picked the
> memory leak fixing patch.
> 
> [PATCH v2 2/2] kexec_file: clean up arch_kexec_kernel_image_load
> https://lore.kernel.org/all/20220223113225.63106-3-bhe@redhat.com/T/#u

Indeed!  Sorry, I wasn't aware of your previous work.  If you repost
it, cc me and I'll be glad to help review it.

> > Bjorn Helgaas (2):
> >   x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
> >   kexec: Remove unnecessary arch_kexec_kernel_image_load()
> > 
> >  arch/x86/include/asm/kexec.h       |  3 ---
> >  arch/x86/kernel/machine_kexec_64.c | 11 -----------
> >  include/linux/kexec.h              |  8 --------
> >  kernel/kexec_file.c                |  6 +++---
> >  4 files changed, 3 insertions(+), 25 deletions(-)
