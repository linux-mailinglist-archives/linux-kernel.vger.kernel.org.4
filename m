Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121E25F85C4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJHPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJHPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:12:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D12C12B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:12:36 -0700 (PDT)
Received: from nazgul.tnic (unknown [46.183.103.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DFE01EC05B0;
        Sat,  8 Oct 2022 17:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665241950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DYgRImUlP5sBAB0m+Fi/O5fIFHatVYNoMS9h40YOHco=;
        b=NkOfR/aWMdEV1z9XGZ2/WEYAky35KX2YfStKR//x78sVUpXeyC+sGuu3T9Zh09vBWI1C/X
        A9AOyivIJDLtZgMOzooIcg120y6SnGXYZoWlzlWjzrevFMtmpWkjC/S7u2OSXlig/PKlIe
        DfUmPNUpd3yffSBvtxuHwT3ZtoOVU2E=
Date:   Sat, 8 Oct 2022 17:12:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        jailhouse-dev@googlegroups.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/2] x86: Check return values from early_memremap calls
Message-ID: <Y0GTUg1ACpKZYMHY@nazgul.tnic>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
 <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Xen and Jailhouse people and MLs to Cc.

Folks, thread starts here:

https://lore.kernel.org/r/1650035401-22855-1-git-send-email-ross.philipson@oracle.com

On Fri, Apr 15, 2022 at 11:10:00AM -0400, Ross Philipson wrote:
> There are a number of places where early_memremap is called
> but the return pointer is not checked for NULL. The call
> can result in a NULL being returned so the checks must
> be added.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/devicetree.c | 10 ++++++++++
>  arch/x86/kernel/e820.c       |  5 +++++
>  arch/x86/kernel/jailhouse.c  |  6 ++++++
>  arch/x86/kernel/mpparse.c    | 23 +++++++++++++++++++++++
>  arch/x86/kernel/setup.c      |  5 +++++
>  arch/x86/xen/enlighten_hvm.c |  2 ++
>  arch/x86/xen/mmu_pv.c        |  8 ++++++++
>  arch/x86/xen/setup.c         |  2 ++
>  8 files changed, 61 insertions(+)

Ok, a couple of notes:

1. the pr_*("<prefix>:" ... )

thing is done using pr_fmt() - grep the tree for examples.

2. I think you should not panic() the machine but issue a the
warning/error and let the machine die a painful death anyway. But Xen
folks will know better what would be the optimal thing to do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
