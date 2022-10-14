Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932055FE8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJNGim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:38:40 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3445717FD45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:38:39 -0700 (PDT)
Date:   Fri, 14 Oct 2022 15:38:26 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665729517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GVx51+wEeaxhdduiJJ9u4pDxyncQhwvaEYATQ2iOVl4=;
        b=XxMiNss66OkyEkiqhCvkHcicecVDn8I/Wd2LSvel1BD3vZB5t6hP2H+++JBgPiFuUZ0az2
        yP1VYVFpmrcLF2Ym+5DnSN2mrBSL/xVMZjRe/N/UjKTxlaJuYL9PSi2ht/AvvVIW30XAU0
        g+aQWXry5Plax1EuEkBwZrUff5cKMQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] mm/hwpoison: move definitions of
 num_poisoned_pages_* to memory-failure.c
Message-ID: <20221014063826.GA1711843@u2004>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-3-naoya.horiguchi@linux.dev>
 <Y0ghWfP4n5XNWDg/@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0ghWfP4n5XNWDg/@localhost.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 04:31:53PM +0200, Oscar Salvador wrote:
> On Fri, Oct 07, 2022 at 10:07:04AM +0900, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > These interfaces will be used by drivers/base/memory.c by later patch, so as a
> > preparatory work move them to more common header file visible to the file.
> > 
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> > ChangeLog v3 -> v6:
> > - remove static in definition of num_poisoned_pages_inc() to fix build error.
> > 
> > ChangeLog v2 -> v3:
> > - added declaration of num_poisoned_pages_inc() in #ifdef CONFIG_MEMORY_FAILURE
> > ---
> >  arch/parisc/kernel/pdt.c |  3 +--
> >  include/linux/mm.h       |  5 +++++
> >  include/linux/swapops.h  | 24 ++----------------------
> >  mm/memory-failure.c      | 10 ++++++++++
> >  4 files changed, 18 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
> > index e391b175f5ec..fdc880e2575a 100644
> > --- a/arch/parisc/kernel/pdt.c
> > +++ b/arch/parisc/kernel/pdt.c
> > @@ -18,8 +18,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/initrd.h>
> >  #include <linux/pgtable.h>
> > -#include <linux/swap.h>
> > -#include <linux/swapops.h>
> > +#include <linux/mm.h>
> 
> I am probably missing something.
> num_poisoned_pages_* functions are in swapops.h, but why are you removing swap.h as well?

This file included swap.h and swapops.h together to use num_poisoned_pages_inc()
by commit 0e5a7ff6e36a ("parisc: Report bad pages as HardwareCorrupted"),
so I thought these may be updated together.

> 
> Also, reading the changelog it sounded like both functions would be in mm.h,
> but actually only the _inc part is.

> > ChangeLog v2 -> v3:
> > - added declaration of num_poisoned_pages_inc() in #ifdef CONFIG_MEMORY_FAILURE

Yeah, important part of this log is "in #ifdef CONFIG_MEMORY_FAILURE", but
this might not be clear from my writing.  Sorry about that, I'll care about
making change log clearer from now.  This change log will not included when
merged to mainline, so this hopefully will not confuse anyone.

> 
> The rest looks good to me.

Thank you.

- Naoya Horiguchi
