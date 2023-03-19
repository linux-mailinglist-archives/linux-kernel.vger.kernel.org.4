Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35A6C04C6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCSUW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCSUWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:22:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ABC1C58F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdlv0SXNtbmdh3hXQkVCBEF8uhLOIx9WAai4fYXSUCY=; b=n1bw0KCGCKvHvpqISlp0l5vJ5U
        fckwZDWujN1QUxuKmXI+tJmWx9PtMkvAdhYcsuo3WCRj/CbatUCZIE/LzsAF77miL1KSLTFXS7mss
        XxwOFXGxrrH841R0nwAKarGBtRRK4XAxDAmUaAZ2GGasOn6T8JG2XNjqocnZQTC/slrnYmVEOv3Lk
        9o72SBYL27YOh/FmHSzkU0aXbhrdKld+djZmSna8q5dej9euJWvAG/bT2ree73ix04ASA8vgtZ1d4
        6m+TKxPnvU16f47daf6dQ2s+/sK99WBcVedYyGk++xJ9ecyUB/23ZY1m28jb2gsIJswKltUvRav/I
        dbsGrTLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdzXi-000MkM-Dt; Sun, 19 Mar 2023 20:22:14 +0000
Date:   Sun, 19 Mar 2023 20:22:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: move get_page_from_free_area() to mm/page_alloc.c
Message-ID: <ZBdu9oOyWP+NdO4P@casper.infradead.org>
References: <20230319114214.2133332-1-rppt@kernel.org>
 <0020b728-724d-4206-8768-ec94d5628b34@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0020b728-724d-4206-8768-ec94d5628b34@lucifer.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 12:07:43PM +0000, Lorenzo Stoakes wrote:
> On Sun, Mar 19, 2023 at 01:42:14PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > The get_page_from_free_area() helper is only used in mm/page_alloc.c so
> > move it there to reduce noise in include/linux/mmzone.h

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Good catch, I wonder if there are more functions like this that can be dropped
> from headers?

I don't think anything outside mm/ has any reason to see 'struct
free_area'.  Unfortunately, it's a field in struct zone, so moving
it out of mmzone.h will be hard (unless we can move struct zone out of
mmzone.h?)

free_area_empty() can move to mm/internal.h though
