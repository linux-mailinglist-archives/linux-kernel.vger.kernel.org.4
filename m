Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2631674E9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjGKI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGKI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:59:53 -0400
X-Greylist: delayed 90215 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 01:59:51 PDT
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [IPv6:2001:41d0:203:375::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D0E6A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:59:51 -0700 (PDT)
Date:   Tue, 11 Jul 2023 17:59:40 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689065989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3olRG28fHuMVdScfXTk+VChhHoKMcs08gOMMym6Knco=;
        b=eG1uW4BNj7Ebz5WBJY4Z7nnNtP2AUxH00bRUZcf20kWdXqy7D0O5EuqtQ/XKewGpVfgrlE
        FgTol6C228VEUzZH8rWzoVu9Bw3uOLh2vUmN+5lyQ0dsZb6qUIpT5wKZSujYU/CMm6LOil
        YxytCRH3T7fSHaju40ijdpmgyscymlQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-ID: <20230711085940.GA2220255@ik1-406-35019.vs.sakura.ne.jp>
References: <20230707201904.953262-1-jiaqiyan@google.com>
 <20230707201904.953262-3-jiaqiyan@google.com>
 <ZKh2K7ObVtlXHkTk@casper.infradead.org>
 <20230710002116.GA1578139@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F533yhafvtaEvnk568CnzvOhMFPeDTGtY4eMR=tW3DSL_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F533yhafvtaEvnk568CnzvOhMFPeDTGtY4eMR=tW3DSL_Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 08:11:48AM -0700, Jiaqi Yan wrote:
> On Sun, Jul 9, 2023 at 5:21 PM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
> >
> > On Fri, Jul 07, 2023 at 09:31:39PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jul 07, 2023 at 08:19:02PM +0000, Jiaqi Yan wrote:
> > > > Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
> > >
> > > This is incorrect naming.  "subpage" was needed before we had the
> > > folio concept, but it should not be used any more.  We have folios
> > > and pages now.
> >
> 
> Thanks for your comment, Matthew.
> 
> > I think we can address the raw hwpoison page by the offset in folio/hugepage
> > to eliminate the concept of "subpage".
> >
> > >
> > > Also, abbreviating "hwpoison" as "hwp" seems like a bad idea to me.
> > > hwp is already used as an acronym by acpi, intel_pstate, some clock
> > > drivers, an ethernet driver, and a scsi driver.
> >
> > I originally introduced the abbreviation "hwp" to avoid using a lengthy
> > function name such as "folio_test_hugetlb_raw_hwpoison_unreliable()."
> > Therefore, I prefer using "rawhwp" instead of a longer form like
> > "raw_hwpoison," although I don't expect any confusion between "hwp" and
> > "rawhwp."
> 
> These are names in my mind, what do you think?
> * is_rawhwp_page_in_hugepage
> * is_raw_hwpoison_page_in_hugepage // I prefer this one

This one is fine to me.

> * folio_test_hugetlb_raw_hwpoison_page
> 
> > As for "hwp_walk", another user of "hwp" in in mm/memory-failure.c,
> > we can easily substitute it with "hwpoison_walk."
> 
> In this "hwp_walk" case, I also prefer "hwpoison" than "hwp". I can
> create a separate renaming patch.

Great, thank you.

- Naoya Horiguchi
