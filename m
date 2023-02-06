Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7D68B43D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBFCv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFCv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:51:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB119F01;
        Sun,  5 Feb 2023 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a68BFUw2BpHHhbBBpKoKjQxP6DmREgGnYtbae7m3l1Q=; b=aYT+QrxDV/CJmRjX3L9wcJRC5m
        CZlCqoXCfhO/WEJsGuKY1Z9qXzdXkMZ3Xua+ucsm1J14JHSdLYjToJbnmkCK4mONdNLiLdxXLm0ci
        qqPox4IGi7FK7DKbSb2j2GLLwxpoh5M+Hc99CNpXotONm6MCOj/RziZRIcXaDWf8qr77OD2zm0diF
        0y/g3Guz8DA09pVrGCQ61UsKYxNWJ+zPNggySjJz/vWgmOVwUQTpL57PWzMLwNrtE4lhOBIU9NGs+
        TBXzcoW3ezmVKVlFqEqfWqj5yiOqTOQk4nxLG6Zm0cr4qA0cFi0k9AUhoqmvMo9OMsE/Pj2iOSF2C
        1egmrvew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOrbC-00GPQT-HK; Mon, 06 Feb 2023 02:51:18 +0000
Date:   Mon, 6 Feb 2023 02:51:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+BrJhxeJbAp49QE@casper.infradead.org>
References: <20230205231704.909536-1-peterx@redhat.com>
 <Y+BFjQDBIFq5ih+t@casper.infradead.org>
 <Y+BPy3jFcHqOnWL0@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+BPy3jFcHqOnWL0@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 07:54:35PM -0500, Peter Xu wrote:
> On Mon, Feb 06, 2023 at 12:10:53AM +0000, Matthew Wilcox wrote:
> > On Sun, Feb 05, 2023 at 06:17:01PM -0500, Peter Xu wrote:
> > > I noticed a few collision usage on VM_FAULT_* definition in the page fault
> > > path on arm/arm64/s390 where the VM_FAULT_* can overlap with the generic
> > > definition of vm_fault_reason.
> > > 
> > > The major overlapped part being VM_FAULT_HINDEX_MASK which is used only by
> > > the hugetlb hwpoisoning.
> > > 
> > > I'm not sure whether any of them can have a real impact, but that does not
> > > look like to be expected.  I didn't copy stable, if anyone thinks it should
> > > please shoot.  Nor did I test them in any form - I just changed the
> > > allocations from top bits and added a comment for each of them.
> > 
> > This seems like a bad way to do it.  Why not just put these VM_FAULT_*
> > definitions in linux/mm_types.h?  Then we'll see them when adding new
> > VM_FAULT codes.  Sure, they won't be used by every architecture, but
> > so what?
> 
> My initial version actually contains a few VM_FAULT_PRIVATE_N there, but I

That wasn't what I meant.  I meant putting VM_FAULT_BADMAP and
VM_FAULT_SIGSEGV in mm_types.h.  Not having "Here is a range of reserved
arch private ones".

