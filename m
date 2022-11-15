Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9912F62A3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKOVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiKOVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:22:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519D205D8;
        Tue, 15 Nov 2022 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XQ4vjzmLft8hrI4vNqpGBBjaeT3aE0jxmG9YPZLO+L4=; b=P+2yQ5JwTL+eWMGWC9ThB3NQSh
        ssYCSSH7CyoT+X2629fu4040V0VFjm4td7W1W2IdxrbsHSiiRKRm1//kxoaWbMFkxU3rsoRxe0/33
        C00rXUNhYEOKVpN1vf4uJfh5UpUWw1XlKmJEesLTJaupDLSoENORSTvps6KB9S2/uRG/9z8ybmuL/
        fX6wkiL0CrVkEh2Q04S0JoiGM/NnCWBjGerkckYJG+T384Rtph48IovpuIp2M4cxRlm1m/ijx+fIi
        ue29hhd84uIA/0NsEdDkdrPzNq2axotIgtQv3nOmgTVoJrnTfGny1DpgBTXnRoQaHDHalX/6/T+4P
        E08SbFBA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov3OD-00F2Gc-7N; Tue, 15 Nov 2022 21:22:41 +0000
Date:   Tue, 15 Nov 2022 13:22:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, thunder.leizhen@huawei.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 3/8] kbuild: generate an address ranges map at vmlinux
 link time
Message-ID: <Y3QDIVy0c01Tie3L@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-4-nick.alcock@oracle.com>
 <Y3BeTbHxj9OmmmIY@bombadil.infradead.org>
 <87v8nhv5vq.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8nhv5vq.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:48:57PM +0000, Nick Alcock wrote:
> [Added Steve Rostedt to Cc:]
> 
> On 13 Nov 2022, Luis Chamberlain stated:
> 
> > On Wed, Nov 09, 2022 at 01:41:27PM +0000, Nick Alcock wrote:
> >> This emits a new file, .tmp_vmlinux.ranges, which maps address
> >> range/size pairs in vmlinux to the object files which make them up,
> >> e.g., in part:
> >> 
> >> 0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
> >> 0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
> >> 0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
> >> 0x0000000000006000 0x5000 arch/x86/kernel/process.o
> >> 0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
> >> 0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
> >> 0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
> >> 0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
> >> [...]
> >
> > This does't say why we'd want this. So either you merge it with its
> > first user or you explain here why anyone might find this useful.
> 
> Uh... the first user is later in this patch series? If you want each
> commit to have a self-contained explanation, I could certainly note why
> it's useful for said first user in this commit message (and adjust other
> messages similarly), but I had previous complaints that commit log
> messages and the cover letter were repeating points, so I was trying to
> reduce that kind of thing.

Commit logs should be self contained. The reason for *why* we want to
add ranges should go here, not the cover letter. You can be terse in the
cover letter over the general solution.

  Luis

