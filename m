Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB6D66A115
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAMRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjAMRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:48:24 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E084618;
        Fri, 13 Jan 2023 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cy2F0NK90EWaw0M5GPoEQP9ffyepR3s0fUS7pZNqVNM=; b=mgsygI+GVpRKAc6PqndPLE/EGN
        RBXy4FaTuRYaN2huyWrOk+neGZ1ufgqmyi0yXaCxDKbFxKLUFjjgGati04nsAxMUVMX6F93HAT5MV
        jCcjeKcAKc8BuBDKNvpyU4OjSZ3Cz+FrSGYf7cnR14hsABQZhPfPnMdvz6HtQe9qMx/+pGJhPDPZF
        /qyCY0jr74qxGY8j5oRSoOBymBNR8AWbho08oGYqS/eKId6CpeqD2QoBShcQEl28G2ynMmhKfr3vd
        JwyOoMKWaS5EaZC4VS2qmXffZvRjoZ/Ill46hfsEaDEG4akgzhKR6ntCiBFX87m79qo6FBnSd5kkP
        88vn84dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36094)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pGO0i-0008DZ-DC; Fri, 13 Jan 2023 17:38:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pGO0d-0003KS-Da; Fri, 13 Jan 2023 17:38:31 +0000
Date:   Fri, 13 Jan 2023 17:38:31 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH mm-unstable v1 04/26] arm/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Message-ID: <Y8GXF/AgLKgWQW5p@shell.armlinux.org.uk>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113171026.582290-5-david@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 06:10:04PM +0100, David Hildenbrand wrote:
> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
> offset. This reduces the maximum swap space per file to 64 GiB (was 128
> GiB).
> 
> While at it drop the PTE_TYPE_FAULT from __swp_entry_to_pte() which is
> defined to be 0 and is rather confusing because we should be dealing
> with "Linux PTEs" not "hardware PTEs". Also, properly mask the type in
> __swp_entry().
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
